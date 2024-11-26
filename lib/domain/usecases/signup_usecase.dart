import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase.dart';
import 'package:spotify/data/models/user_req.dart';
import 'package:spotify/domain/repository/auth.dart';
import 'package:spotify/service_locator.dart';

class SignupUsecase implements Usecase<Either,UserReq>{
  @override
  Future<Either> call({UserReq ? params})async {
    print("Hello2");
    return s1<AuthRepository>().signup(params!); 
  }

}