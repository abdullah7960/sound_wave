import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

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
}
