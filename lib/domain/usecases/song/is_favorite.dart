import 'package:spotify/core/usecase.dart';
import 'package:spotify/data/repository/songimpl.dart';
import 'package:spotify/service_locator.dart';

class IsFavoriteSongUsecase implements Usecase<bool,String>{
  @override
  Future<bool> call({String ?params}) async{
    print("harsh6");
    // SongImpl songImpl = new SongImpl();
    return await s1<SongImpl>().isFavoriteSong(params!);
  }
}