import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:spotify/domain/entities/song/songEntity.dart';

class SongModel{
  String ? title;
  String ? artist;
  num ? duration;
  Timestamp ? releaseDates;
  bool ? isFavorite;
  String ? songId;

  SongModel({
    required this.title, 
    required this.artist, 
    required this.duration, 
    required this.releaseDates,
    required this.isFavorite,
    required this.songId
  });

  SongModel.fromJson(Map<String,dynamic> data){
    title = data['title'];
    artist = data['artist'];
    duration = data['duration'];
    releaseDates = data['releaseDate'];
  }
}

extension SongModelx on SongModel {
  SongEntity toEntity() {
    return SongEntity(
      title: title !,
      artist: artist !,
      duration: duration !,
      releaseDates: releaseDates !,
      isFavorite: isFavorite !,
      songId: songId !,
    );
  }
}