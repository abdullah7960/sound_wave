import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
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
    final getSongPro = Provider.of<ProviderHomeScreen>(context);
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
          decoration: const BoxDecoration(
            gradient: AppThemes.primaryGradient,
          ),
          width: double.infinity,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: width * .02),
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
                            offset: Offset(0, 2), // changes position of shadow
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
                            prefixIcon: Icon(Icons.search, color: Colors.grey),
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
                    Consumer<ProviderHomeScreen>(
                      builder: (context, value, child) {
                        return !getSongPro.hasPermissionToGetAudios
                            ? PermissionRequiredMessage(
                                height: height,
                              )
                            : Container(
                                height: height * .5,
                                child: listOfSongs(height, width, value));
                      },
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget listOfSongs(
      double height, double width, ProviderHomeScreen songsListProvider) {
    return songsListProvider.filteredSongsList.isEmpty
        ? Container(
            height: 30,
            child: Center(
              child: Text(
                "No Data Found",
                style: TextStyle(
                    fontSize: height * .02, fontWeight: FontWeight.w700),
              ),
            ),
          )
        : ListView.builder(
            padding: const EdgeInsets.only(top: 10),
            itemCount: songsListProvider.filteredSongsList.length,
            itemBuilder: (context, index) {
              final song = songsListProvider.filteredSongsList[index];
              // final isFavorite = songsListProvider.isFavorite(song.id);

              return InkWell(
                onTap: () {
                  _focusNode.unfocus();
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
                          song.displayName,
                          style: TextStyle(
                            fontSize: height * .02,
                            color: AppColors.white,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          // await songsListProvider.toggleFavorite(song.id);
                        },
                        icon: Icon(
                            // isFavorite
                            //     ? Icons.favorite
                            // :
                            Icons.favorite_border_outlined,
                            color:
                                //  isFavorite ?
                                Colors.red
                            // : AppColors.white,
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
