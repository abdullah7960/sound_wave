import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:sound_wave/screens/playing_screen/playing_song_screen.dart';
import '../../utils/theme.dart';
import '../../widgets/permissionreq_widget.dart';
import '../homescreen/provider_home_screen.dart';

class AllSongsScreen extends StatefulWidget {
  const AllSongsScreen({super.key});

  @override
  State<AllSongsScreen> createState() => _AllSongsScreenState();
}

class _AllSongsScreenState extends State<AllSongsScreen> {
  late TextEditingController _controller;
  FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = TextEditingController();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      final getSongsPro =
          Provider.of<ProviderHomeScreen>(context, listen: false);
      getSongsPro.getSongsFromExterStorg();
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
    _focusNode.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.sizeOf(context).height;
    var width = MediaQuery.sizeOf(context).width;

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragUpdate: (details) {
          if (details.primaryDelta != null &&
              details.primaryDelta!.abs() > 10) {
            _focusNode.unfocus();
          }
        },
        onTap: () {
          _focusNode.unfocus();
        },
        child: Container(
          width: double.infinity,
          decoration: const BoxDecoration(
            gradient: AppThemes.primaryGradient,
          ),
          child: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: width * .04),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: height * .05,
                      ),
                      Text(
                        "All Songs",
                        style: TextStyle(
                            fontSize: height * .028,
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.0),
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.3),
                              spreadRadius: 1,
                              blurRadius: 2,
                              offset:
                                  Offset(0, 2), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Material(
                          borderRadius: BorderRadius.circular(15.0),
                          child: TextField(
                            controller: _controller,
                            focusNode: _focusNode,
                            onChanged: (query) {
                              Provider.of<ProviderHomeScreen>(context,
                                      listen: false)
                                  .filterSongs(query);
                            },
                            decoration: const InputDecoration(
                              hintText: 'Search songs...',
                              hintStyle: TextStyle(color: Colors.grey),
                              prefixIcon:
                                  Icon(Icons.search, color: Colors.grey),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                  horizontal: 16.0, vertical: 14.0),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Image.asset(
                        'assets/songs_top/screen_top.png',
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                      Expanded(
                        child: Consumer<ProviderHomeScreen>(
                          builder: (context, value, child) {
                            return !value.hasPermissionToGetAudios
                                ? PermissionRequiredMessage(
                                    height: height,
                                  )
                                : value.filteredSongsList.isEmpty
                                    ? Center(
                                        child: Text(
                                          "No Songs Found",
                                          style: TextStyle(
                                              fontSize: height * .02,
                                              fontWeight: FontWeight.w600,
                                              color: AppColors.white),
                                        ),
                                      )
                                    : widgetListOfSongs(height, width, value);
                          },
                        ),
                      ),
                      SizedBox(
                        height: height * .01,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget widgetListOfSongs(
      double height, double width, ProviderHomeScreen songsListProvider) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10),
      itemCount: songsListProvider.filteredSongsList.length,
      itemBuilder: (context, index) {
        final filterSongs = songsListProvider.filteredSongsList[index];
        final isSavedAsFavourite = songsListProvider.isFavorite(filterSongs.id);

        return InkWell(
          onTap: () {
            _focusNode.unfocus();
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const PlayingSongScreen(),
                ));
          },
          child: Container(
            margin: EdgeInsets.only(top: height * .012),
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.topRight,
                colors: [Colors.black12, Colors.black.withAlpha(80)],
              ),
            ),
            child: Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      const AssetImage('assets/item_song_img/song2.png'),
                  radius: height * .03,
                ),
                SizedBox(
                  width: width * .02,
                ),
                Expanded(
                  child: Text(
                    filterSongs.displayName,
                    style: TextStyle(
                      fontSize: height * .02,
                      color: AppColors.white,
                    ),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                IconButton(
                  onPressed: () async {
                    await songsListProvider.toggleFavorite(filterSongs.id);
                  },
                  icon: Icon(
                    isSavedAsFavourite
                        ? Icons.favorite
                        : Icons.favorite_border_outlined,
                    color: isSavedAsFavourite ? Colors.red : AppColors.white,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
