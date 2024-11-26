import 'package:dartz/dartz.dart';

abstract class SongRepository {
  Future<Either> getsNewsSong();
  Future<Either> getsPlayList();
  Future<Either> addOrRemoveFavoriteSongs(String songId);
  Future<bool> isFavoriteSong(String songId);
  Future<Either> getUserFavoriteSongs();

}