import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase.dart';
import 'package:spotify/data/repository/songimpl.dart';
import 'package:spotify/service_locator.dart';

class GetPlayListUsecase implements Usecase<Either,dynamic>{
  @override
  Future<Either> call({params}) async{
    print("harshit");
    // SongImpl songImpl = new SongImpl();
    return await s1<SongImpl>().getsPlayList();
  }
  
  

}