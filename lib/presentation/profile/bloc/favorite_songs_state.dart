import 'package:spotify/domain/entities/song/songEntity.dart';

abstract class FavoriteSongsState {}

class FavoriteSongsLoading extends FavoriteSongsState{}

class FavoriteSongsLoaded extends FavoriteSongsState{
  final List<SongEntity> favoriteSongs;

  FavoriteSongsLoaded({required this.favoriteSongs});
}

class FavoriteSongsFailure extends FavoriteSongsState{}