// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helipers/mode.dart';
import 'package:spotify/core/config/constants/app_url.dart';
import 'package:spotify/core/config/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/songEntity.dart';
import 'package:spotify/presentation/home/bloc/news_song1.dart';
import 'package:spotify/presentation/home/bloc/news_songs2.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class NewsSongs extends StatelessWidget {
  const NewsSongs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(_) => NewsSongsCubit()..getNewsSongs(),
      child: SizedBox(
        height: 200,
        child: BlocBuilder<NewsSongsCubit,NewsSongsState>(
          builder:(context,state) {
            if (state is NewsSongsLoading){
              return Container(
                alignment: Alignment.center,
                child: const CircularProgressIndicator()
              );
            }
            if (state is NewsSongsLoaded){
              return _songs(
                state.songs
              );
            }
            return Container();
          } ,
        ) 
        
      ),
    );
  }
  Widget _songs(List<SongEntity> songs){
    return ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemBuilder: (context,index){
            print(index);
            return GestureDetector(
              onTap: (){
                Navigator.push(
                  context, 
                  MaterialPageRoute(
                    builder: (BuildContext context) 
                    =>  SongPlayerPage(
                      songEntity: songs[index],
                    )
                  )
                );
              },
              child: SizedBox(
                width: 160,
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 190,
                          width: 200,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(30),
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(
                                //https://firebasestorage.googleapis.com/v0/b/spotify-f199a.appspot.com/o/covers%2FTheres%20Nothing%20Holdin%20Me%20Back%20-%20Shawn%20Mendes.jpg?alt=media&token=811f400a-3e5e-48f6-970a-282dcc8beb1e
                                //https://firebasestorage.googleapis.com/v0/b/spotify-f199a.appspot.com/o/covers%2FPhotograph%20-%20Ed%20sheeran.jpg?alt=media&token=4eaf4753-354c-4edf-b67e-da8ac862c928
                                AppURL.coverfirestorage + songs[index].title.split(" ").join("%20") +"%20-%20"+ songs[index].artist.split(" ").join("%20") +'.jpg?'+ AppURL.mediaAlt
                              )
                            )
                          ),
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              height: 30,
                              width: 30,
                              transform: Matrix4.translationValues(10, 10, 0),
                              child:  Icon(
                                Icons.play_arrow_rounded,
                                color:context.isDarkmode? Color(0xff959595):const Color(0xff555555) ,
                              ),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: context.isDarkmode? AppColors.darkgrey: const Color(0xffE6E6E6)
                               ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10,),
                    Text(
                      songs[index].title,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3,),
                    Text(
                      songs[index].artist,
                      style: const TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                      ),
                    )
                  ],
                ),
              ),
            );
          }, 
          separatorBuilder: (context,index) => const SizedBox(width: 14,), 
          itemCount: songs.length
        );

  }
}