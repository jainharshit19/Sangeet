//import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/foundation.dart';
import 'package:spotify/data/models/songModel.dart';
import 'package:spotify/domain/entities/song/songEntity.dart';
import 'package:spotify/domain/usecases/song/is_favorite.dart';
import 'package:spotify/service_locator.dart';

abstract class SongFirebase {
  Future<Either> getsNewsSong();
  Future<Either> getsPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();
}

class SongFirebaseImp extends SongFirebase {
  @override
  Future<Either> getsNewsSong() async {
    try {
      print("Hello");
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .limit(6)
          .get();
      print("Hello2");
      print(data.docs);
      for (var element in data .docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await s1<IsFavoriteSongUsecase>().call(
          params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      print(songs);
      return Right(songs);
    } catch (e) {
      print(e.toString());
      return const Left('An error occured Please try again.');
    }
  }
  
  @override
  Future<Either> getsPlayList() async{
    try {
      print("Hello");
      List<SongEntity> songs = [];
      var data = await FirebaseFirestore.instance
          .collection('Songs')
          .orderBy('releaseDate', descending: true)
          .get();
      print("Hello2");
      print(data.docs);
      for (var element in data .docs) {
        var songModel = SongModel.fromJson(element.data());
        bool isFavorite = await s1<IsFavoriteSongUsecase>().call(
          params: element.reference.id
        );
        songModel.isFavorite = isFavorite;
        songModel.songId = element.reference.id;
        songs.add(songModel.toEntity());
      }
      print(songs);
      return Right(songs);
    } catch (e) {
      print(e.toString());
      return const Left('An error occured Please try again.');
    }
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async {

    try{
    final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    
    late bool isFavorite;
    var user = firebaseAuth.currentUser;
    String uId = user!.uid;
    QuerySnapshot favoriteSongs = await firebaseFirestore.collection('Users')
    .doc(uId)
    .collection('Favorites')
    .where(
      'songId',isEqualTo: songId
    ).get();

    if(favoriteSongs.docs.isNotEmpty){
      await favoriteSongs.docs.first.reference.delete();
      isFavorite = false;
    }
    else{
       await firebaseFirestore.collection('Users')
      .doc(uId)
      .collection('Favorites')
      .add(
        {
          'songId' : songId,
          'addedDate' : Timestamp.now()
        }
      );
      isFavorite = true;
    }
    return Right(isFavorite);
  }
    catch (e){
    return const Left('An error is occurred');
    }
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async{
    try{
    final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
    final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    
    
    var user = firebaseAuth.currentUser;
    String uId = user!.uid;
    QuerySnapshot favoriteSongs = await firebaseFirestore.collection('Users')
    .doc(uId)
    .collection('Favorites')
    .where(
      'songId',isEqualTo: songId
    ).get();

    if(favoriteSongs.docs.isNotEmpty){
      return true;
    }
    else{
       return false;
    }
  }
    catch (e){
    return false;
    }
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async{
    try{
      final FirebaseAuth firebaseAuth =FirebaseAuth.instance;
      final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    
    
      var user = firebaseAuth.currentUser;
      List<SongEntity> favoriteSongs =[];
      String uId = user!.uid;
      QuerySnapshot favoritesSnapshot = await firebaseFirestore.collection(
        'Users'
      ).doc(uId)
       .collection('Favorites')
       .get();

       for (var element in favoritesSnapshot.docs) {
        String songId = element ['songId'];
        var song = await firebaseFirestore.collection('Songs').doc(songId).get();
        SongModel songModel = SongModel.fromJson(song.data()!);
        songModel.isFavorite = true;
        songModel.songId = songId;
        favoriteSongs.add(
          songModel.toEntity()
        );
      }

      return Right(favoriteSongs);
    }
    catch (e){
      print(e);
      return const Left(
        'An error occured'
      );
    }
  }
  
  
}
