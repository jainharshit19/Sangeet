// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:spotify/common/helipers/mode.dart';
import 'package:spotify/common/widgets/appbar/app_bar.dart';
import 'package:spotify/common/widgets/favoriteButton/favoriteButton.dart';
import 'package:spotify/core/config/assets/app_images.dart';
import 'package:spotify/core/config/constants/app_url.dart';
import 'package:spotify/core/config/theme/app_colors.dart';
import 'package:spotify/presentation/auth/pages/signup_or_signin.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_cubit.dart';
import 'package:spotify/presentation/profile/bloc/favorite_songs_state.dart';
//import 'package:spotify/presentation/profile/bloc/favorite_song1.dart';
//import 'package:spotify/presentation/profile/bloc/favorite_song2.dart';
import 'package:spotify/presentation/profile/bloc/profile_info1.dart';
import 'package:spotify/presentation/profile/bloc/profile_info2.dart';
import 'package:spotify/presentation/song_player/pages/song_player.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: BasicAppbar(
        backgroundColor: context.isDarkmode ? Color(0xff2C2B2B) : Colors.white,
        action: IconButton(
          onPressed: () {
            auth.signOut().then((value) => {
                  Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(builder: (context) => SignupSignin(flag: true,)),
                      (route) => false)
                });
          },
          icon: Icon(Icons.logout_sharp),
        ),
        title: const Text('Profile'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          profileInfo(context),
          const SizedBox(
            height: 20,
          ),
          _favoriteSongs(),
          // const SizedBox(width:  20,),
          //_logout(context),
        ],
      ),
    );
  }

  Widget profileInfo(BuildContext context) {
    print("halli");
    return BlocProvider(
      create: (context) => ProfileInfoCubit()..getUser(),
      child: Container(
        height: MediaQuery.of(context).size.height / 3.5,
        width: double.infinity,
        decoration: BoxDecoration(
            color: context.isDarkmode ? Color(0xff2C2B2B) : Colors.white,
            borderRadius: const BorderRadius.only(
                bottomRight: Radius.circular(50),
                bottomLeft: Radius.circular(50))),
        child: BlocBuilder<ProfileInfoCubit, ProfileInfoState>(
          builder: (context, state) {
            if (state is ProfileInfoLoading) {
              return Container(
                  alignment: Alignment.center,
                  child: const CircularProgressIndicator());
            }
            if (state is ProfileInfoLoaded) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 90,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                      image: AssetImage(
                        AppImages.profilePhoto,
                      ),
                    )),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    state.userEntity.email!,
                    style: const TextStyle(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 08,
                  ),
                  Text(
                    state.userEntity.fullName!,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  )
                ],
              );
            }
            if (state is ProfileInfoFailure) {
              return const Text("Please Try Again");
            }
            return Container();
          },
        ),
      ),
    );
  }

  Widget _favoriteSongs() {
    return BlocProvider(
      create: (context) => FavoriteSongsCubit()..getFavoriteSongs(),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text('FAVORITE SONGS'),
            const SizedBox(
              height: 20,
            ),
            BlocBuilder<FavoriteSongsCubit, FavoriteSongsState>(
              builder: (context, state) {
                if (state is FavoriteSongsLoading) {
                  return const CircularProgressIndicator();
                }
                if (state is FavoriteSongsLoaded) {
                  return ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                        SongPlayerPage(
                                          songEntity:
                                              state.favoriteSongs[index],
                                        )));
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 75,
                                    width: 75,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        image: DecorationImage(
                                            image: NetworkImage(AppURL
                                                    .coverfirestorage +
                                                state.favoriteSongs[index].title
                                                    .split(" ")
                                                    .join("%20") +
                                                "%20-%20" +
                                                state
                                                    .favoriteSongs[index].artist
                                                    .split(" ")
                                                    .join("%20") +
                                                '.jpg?' +
                                                AppURL.mediaAlt))),
                                  ),
                                  const SizedBox(width: 10),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        state.favoriteSongs[index].title,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 14,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(
                                        state.favoriteSongs[index].artist,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w400,
                                          fontSize: 10,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              Row(
                                children: [
                                  Text(state.favoriteSongs[index].duration
                                      .toString()
                                      .replaceAll('.', ':')),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  FavoriteButton(
                                    songEntity: state.favoriteSongs[index],
                                    key: UniqueKey(),
                                    function: () {
                                      context
                                          .read<FavoriteSongsCubit>()
                                          .removeSong(index);
                                    },
                                  )
                                ],
                              )
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) =>
                          const SizedBox(height: 20),
                      itemCount: state.favoriteSongs.length);
                }
                if (state is FavoriteSongsFailure) {
                  return const Text('Please Try again');
                }
                return Container();
              },
            )
          ],
        ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    final auth = FirebaseAuth.instance;
    return Scaffold(
      appBar: BasicAppbar(
        title: Text('Log Out'),
        action: IconButton(
          onPressed: () {
            auth.signOut().then((value) => Navigator.push(context,
                MaterialPageRoute(builder: (context) => SignupSignin())));
          },
          icon: Icon(Icons.logout_sharp),
        ),
      ),
    );
  }
}
