// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/favoriteButton/favoriteButton.dart';
import 'package:spotify/domain/entities/song/songEntity.dart';
import 'package:spotify/presentation/song_player/bloc/song_player1.dart';
import 'package:spotify/presentation/song_player/bloc/song_player2.dart';

import '../../../core/config/constants/app_url.dart';
import '../../../core/config/theme/app_colors.dart';

class SongPlayerPage extends StatelessWidget {
  final SongEntity songEntity ;
  const SongPlayerPage({
    required this.songEntity,
    super.key
  });

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: BasicAppbar(
        
        title: const Text(
          'Now Playing',
          style: TextStyle(
            fontSize: 25,
          ),
        ),
        action: IconButton(
          onPressed: (){

          }, 
          icon: const Icon(Icons.more_vert_rounded)
        ),
      ),
      body: BlocProvider(
        create: (_) => SongPlayerCubit()..loadSong(
          //https://firebasestorage.googleapis.com/v0/b/spotify-f199a.appspot.com/o/songs%2FEd%20Sheeran%20%E2%80%93%20Photograph.mp3?alt=media
          //https://firebasestorage.googleapis.com/v0/b/spotify-f199a.appspot.com/o/songs%2FJustin%20Bieber%20%E2%80%93%20Ghost.mp3?alt=media
          //https://firebasestorage.googleapis.com/v0/b/spotify-f199a.appspot.com/o/songs%2FShawn%20Mendes%20%E2%80%93%20Theres%20Nothing%20Holdin%20Me%20Back.mp3?alt=media&
         AppURL.songfirestorage + songEntity.artist.split(" ").join("%20") +
         "%20%E2%80%93%20"+ songEntity.title.split(" ").join("%20") +'.mp3?'+
         AppURL.mediaAlt 
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16
          ),
          child: Column(
            children: [
              _songCover(context),
              const SizedBox(height: 20,),
              _songDetail(),
              const SizedBox(height: 20,),
              _songPlayer(context)
            ],
          ),
        ),
      ),
    );
  }
  Widget _songCover (BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2.3,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        image: DecorationImage(
          fit: BoxFit.cover,
          image: NetworkImage(
            AppURL.coverfirestorage + songEntity.title.split(" ").join("%20") +
            "%20-%20"+ songEntity.artist.split(" ").join("%20") +'.jpg?'+
             AppURL.mediaAlt
          )
        )
      ),
    );
  }

  Widget _songDetail (){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                songEntity.title,
                style: const TextStyle(
                  fontWeight:FontWeight.bold,
                  fontSize: 25, 
                ),
              ),
              const SizedBox(height: 5,),
              Text(
                songEntity.artist,
                style: const TextStyle(
                  fontWeight:FontWeight.w400,
                  fontSize: 20, 
                ),
              ),
            ],
        ),
        FavoriteButton(
          songEntity: songEntity,
        ) 
      ],
    );
  }
  Widget _songPlayer(BuildContext context){
    return BlocBuilder<SongPlayerCubit,SongPlayerState>(
      builder: (context,state) {
        if (state is SongPlayerLoading) {
          return const CircularProgressIndicator();
        }
        if(state is SongPlayerLoaded){
          print("Hello harshit");
          return  Column(
            children: [
             
              Slider(
                
                value: context.read<SongPlayerCubit>().songPosition.inSeconds.toDouble(),
                min: 0.0,
                max: context.read<SongPlayerCubit>().songDuration.inSeconds.toDouble(), 
                onChanged: (value){}
              ),
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songPosition
                    ),
                  ),
                  Text(
                    formatDuration(
                      context.read<SongPlayerCubit>().songDuration
                    )
                  )
                ],
              ),
              const SizedBox(height: 20,),
              GestureDetector(
                onTap: (){
                  context.read<SongPlayerCubit>().playOrPauseSong();
                },
                child: Container(
                  height: 60,
                  width: 60,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.primary 
                  ),
                  child: Icon(
                    context.read<SongPlayerCubit>().audioPlayer.playing ? Icons.pause : Icons.play_arrow
                  ),
                ),
              )
            ],
          );
        }
        return Container();
      }
    );
  }
  String formatDuration(Duration duration){
    final minutes = duration.inMinutes.remainder(60);
    final seconds = duration.inSeconds.remainder(60);
    return '${minutes.toString().padLeft(2,'0')}:${seconds.toString().padLeft(2,'0')}';
  }
}