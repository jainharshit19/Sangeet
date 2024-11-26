import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/bloc/favorite_button1.dart';
import 'package:spotify/common/bloc/favorite_button2.dart';
import 'package:spotify/core/config/theme/app_colors.dart';
import 'package:spotify/domain/entities/song/songEntity.dart';

class FavoriteButton extends StatelessWidget {
  final SongEntity songEntity;
  final Function? function;
  const FavoriteButton({
    required this.songEntity,
    this.function,
    super.key 
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => FavoriteButtonCubit(),
      child: BlocBuilder<FavoriteButtonCubit,FavoriteButtonState>(
        builder: (context,state) {
          if(state is FavoriteButtonInitial){
            return IconButton(
                  onPressed: () async{
                    await context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                      songEntity.songId
                    );
                    if(function != null){
                      function !();
                    }
                  }, 
                  icon: Icon(
                    songEntity.isFavorite ? Icons.favorite: Icons.favorite_border_outlined,
                    color: AppColors.darkgrey,
                    size: 25,
                  )
                );
          }

          if(state is FavoriteButtonUpdated){
            return IconButton(
                  onPressed: (){
                    context.read<FavoriteButtonCubit>().favoriteButtonUpdated(
                      songEntity.songId
                    );
                  }, 
                  icon: Icon(
                    state.isFavorite ? Icons.favorite: Icons.favorite_border_outlined,
                    color: AppColors.darkgrey,
                    size: 25,
                  )
                );
          }
          return  Container();
        },
      ),
    );
  }
}