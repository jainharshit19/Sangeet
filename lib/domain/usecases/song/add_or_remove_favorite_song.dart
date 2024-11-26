import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase.dart';
import 'package:spotify/data/repository/songimpl.dart';
import 'package:spotify/service_locator.dart';

class AddOrRemoveFavoriteSongUsecase implements Usecase<Either,String>{
  @override
  Future<Either> call({String ?params}) async{
    print("harsh5");
    // SongImpl songImpl = new SongImpl();
    return await s1<SongImpl>().addOrRemoveFavoriteSongs(params!);
  }
}