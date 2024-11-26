import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase.dart';
import 'package:spotify/domain/repository/auth.dart';
import 'package:spotify/service_locator.dart';

class GetUserUsecase implements Usecase<Either,dynamic>{
  @override
  Future<Either> call({params})async {
    print("Hello 9");
    return await s1<AuthRepository>().getUser(); 
  }

}