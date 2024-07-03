import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

import '../../utils/database_favourite.dart';
import '../../utils/toast_message.dart';

class ProviderHomeScreen extends ChangeNotifier {
  final OnAudioQuery audioQuery = OnAudioQuery();

  bool _hasPermissionToGetAudios = false;
  bool get hasPermissionToGetAudios => _hasPermissionToGetAudios;

  void updatePermissionToGetAudios(bool isPermission) {
    _hasPermissionToGetAudios = isPermission;
    if (isPermission) {
      getSongsFromExterStorg();
    }
    notifyListeners();
  }

  ProviderHomeScreen() {
    final logConfig = LogConfig(logType: LogType.DEBUG);
    audioQuery.setLogConfig(logConfig);
    _initialize();
  }

  Future<void> _initialize() async {
    await checkAndRequestPermissions();
  }

  Future<void> checkAndRequestPermissions({bool retry = false}) async {
    try {
      _hasPermissionToGetAudios = await audioQuery.checkAndRequest(
        retryRequest: retry,
      );
    } catch (e) {
      // Handle the error, e.g., log it
      print(e);
      updatePermissionToGetAudios(_hasPermissionToGetAudios);
    } finally {
      updatePermissionToGetAudios(_hasPermissionToGetAudios);
    }
  }

  List<SongModel> _allSongsFromExtStorg = [];
  List<SongModel> get allSongsFromExtStorg => _allSongsFromExtStorg;

  bool _isLoading = false;
  bool get isLoading => _isLoading;
  Future<void> getSongsFromExterStorg() async {
    if (_hasPermissionToGetAudios) {
      _isLoading = true;
      notifyListeners();
      try {
        List<SongModel> allSongs = await audioQuery.querySongs(
          orderType: OrderType.ASC_OR_SMALLER,
          uriType: UriType.EXTERNAL,
          ignoreCase: true,
        );

        _allSongsFromExtStorg = allSongs
            .where(
                (song) => song.fileExtension == 'mp3' && song.duration != null)
            .toList();

        notifyListeners();
        filteredSongsList = _allSongsFromExtStorg;
      } catch (e) {
        customToast(message: "Unable to fetch songs. Please try again later.");
      } finally {
        _isLoading = false;
        notifyListeners();
      }
    } else {
      checkAndRequestPermissions();
    }
  }

  //Forsearch all songs from screen
  List<SongModel> filteredSongsList = [];
  void filterSongs(String query) {
    if (query.isEmpty) {
      filteredSongsList = allSongsFromExtStorg;
    } else {
      filteredSongsList = allSongsFromExtStorg
          .where((song) =>
              song.displayName.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    notifyListeners();
  }

  //For adding to favourite

  Future<void> addFavoriteId(int songId) async {
    await DatabaseHelper.insertFavoriteSongId(songId);
    _favoriteSongIdsFromLocalDatabase.add(songId);
    await loadFavoriteSongs();
    notifyListeners();
  }

  Set<int> _favoriteSongIdsFromLocalDatabase = {};

  Future<void> loadFavoriteSongIds() async {
    _favoriteSongIdsFromLocalDatabase =
        Set<int>.from(await DatabaseHelper.getFavoriteSongIds());
    await loadFavoriteSongs();
    notifyListeners();
  }

  bool isFavorite(int songId) {
    return _favoriteSongIdsFromLocalDatabase.contains(songId);
  }

  Future<void> removeFavorite(int songId) async {
    await DatabaseHelper.removeFavoriteFromDatabase(songId);
    _favoriteSongIdsFromLocalDatabase.remove(songId);
    await loadFavoriteSongs();
    notifyListeners();
  }

  Future<void> toggleFavorite(int songIdToSave) async {
    if (isFavorite(songIdToSave)) {
      await removeFavorite(songIdToSave);
    } else {
      await addFavoriteId(songIdToSave);
    }
  }

  List<SongModel> favoriteSongsList = [];
  Future<void> loadFavoriteSongs() async {
    favoriteSongsList = _allSongsFromExtStorg
        .where((song) => _favoriteSongIdsFromLocalDatabase.contains(song.id))
        .toList();
  }
}
