import 'package:dartz/dartz.dart';
import 'package:spotify/data/sources/song_firebase.dart';
import 'package:spotify/domain/repository/song.dart';
import 'package:spotify/service_locator.dart';

class SongImpl extends SongRepository{
  @override
  Future<Either> getsNewsSong() async{
    print("Pankaj");
    return await s1<SongFirebase>().getsNewsSong();
  }
  
  @override
  Future<Either> getsPlayList() async{
    return await s1<SongFirebase>().getsPlayList();
  }
  
  @override
  Future<Either> addOrRemoveFavoriteSongs(String songId) async{
    return await s1<SongFirebase>().addOrRemoveFavoriteSongs(songId);
  }
  
  @override
  Future<bool> isFavoriteSong(String songId) async{
    return await s1<SongFirebase>().isFavoriteSong(songId);
  }
  
  @override
  Future<Either> getUserFavoriteSongs() async {
    return await s1<SongFirebase>().getUserFavoriteSongs();
  }

}