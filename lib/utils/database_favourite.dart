import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'toast_message.dart';

class DatabaseHelper {
  static Database? _database;
  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDatabase();
    return _database!;
  }

  static const String dbName = 'database_playlist.db';
  static const String tableNameAllPlaylist = 'all_playlists';
  static const String favoritesTableDatabase = 'all_favourite';
  static Future<Database> initDatabase() async {
    final String path = join(await getDatabasesPath(), dbName);
    return openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE $tableNameAllPlaylist(id INTEGER PRIMARY KEY, name TEXT, songId INTEGER)',
        );
        await db.execute(
          'CREATE TABLE $favoritesTableDatabase(songId INTEGER PRIMARY KEY)',
        );
      },
    );
  }

  static Future<void> insertPlaylist(
    String name,
    List<int> songIds,
  ) async {
    final Database db = await database;
    try {
      for (int songId in songIds) {
        await db.insert(tableNameAllPlaylist, {'name': name, 'songId': songId});
      }
      customToast(message: 'Playlist saved');
    } catch (e) {
      customToast(message: 'Save failed');
    }
  }

  static Future<List<Map<String, dynamic>>> getPlaylists() async {
    final Database db = await database;
    return db.query(tableNameAllPlaylist);
  }

  static Future<void> deletePlaylist(String playListName) async {
    final db = await database;
    await db.delete(
      'playlists',
      where: 'name = ?',
      whereArgs: [playListName],
    );
  }

  //For Favourite
  // Method to retrieve the list of favorite song IDs
  static Future<List<int>> getFavoriteSongIds() async {
    final Database db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query(favoritesTableDatabase);

    // Generate a list of song IDs from the query results
    return List.generate(maps.length, (i) {
      return maps[i]['songId'] as int;
    });
  }

  // Method to remove a song from favorites
  static Future<void> removeFavoriteFromDatabase(int songId) async {
    final Database db = await database;
    try {
      await db.delete(
        favoritesTableDatabase,
        where: 'songId = ?',
        whereArgs: [songId],
      );
      customToast(message: 'Removed from favorites'); // Success message
    } catch (e) {
      customToast(
          message: 'Could not remove from favorites'); // Failure message
    }
  }

  // Method to insert the favouitee songs id to localdatabase
  static Future<void> insertFavoriteSongId(int songId) async {
    final Database db = await database;
    try {
      await db.insert(favoritesTableDatabase, {'songId': songId});
      customToast(message: 'Song added to favorites');
    } catch (e) {
      customToast(message: 'Failed to add song to favorites');
    }
  }
}
