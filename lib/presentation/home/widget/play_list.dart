import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helipers/mode.dart';
import 'package:spotify/common/widgets/favoriteButton/favoriteButton.dart';
import 'package:spotify/core/config/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/songEntity.dart';
import 'package:spotify/presentation/home/bloc/playlist1.dart';

import '../../song_player/pages/song_player.dart';
import '../bloc/playlist2.dart';

class PlayList extends StatelessWidget {
  const PlayList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:(_) => PlayListCubit()..getsPlayList(),
      child: BlocBuilder<PlayListCubit,PlayListState>(
        builder:(context,state) {
          if(state is PlayListLoading){
            return Container(
              alignment: Alignment.center,
              child: const CircularProgressIndicator(),
            );
          }
          if(state is PlayListLoaded){
            return  Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 40,
                horizontal: 16,
              ),
              child: Column(
                children: [
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Playlist',style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18
                      ),),
                      Text('See More',style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 12,
                        color: Color(0xffC6C6C6)
                      ))
                    ],
                  ),
                  const SizedBox(height: 20,),
                  _songs(state.songs)
                ],
              ),
            );
          }
          return Container();
        },
      )
    );
  }
  Widget _songs(List<SongEntity> songs) {
   return ListView.separated(
    shrinkWrap: true,
    itemBuilder: (context,index){
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
        
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  height: 45,
                  width: 45,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: context.isDarkmode ? AppColors.darkgrey : Color(0xffE6E6E6)
                  ),
                  child: Icon(Icons.play_arrow_rounded,
                  color: context.isDarkmode ? const Color(0xff959595): const Color(0xff555555),
                  ),
                  
                ),
                const SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      songs[index].title,
                      style: const TextStyle(
                        fontWeight:FontWeight.bold,
                        fontSize: 14, 
                      ),
                    ),
                    const SizedBox(height: 5,),
                    Text(
                      songs[index].artist,
                      style: const TextStyle(
                        fontWeight:FontWeight.w400,
                        fontSize: 10, 
                      ),
                    ),
                  ],
                )
              ],
            ),
            Row(
              children: [
                Text(
                  songs[index].duration.toString().replaceAll('.', ':')
                ),
                const SizedBox(width: 10,),
                FavoriteButton(
                  songEntity: songs[index],
                )
              ],
            )
          ],
        ),
      );
    },
    separatorBuilder: (context,index) => const SizedBox(height: 18,), 
    itemCount: songs.length
    ); 
  }

}