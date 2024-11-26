import 'package:dartz/dartz.dart';
import 'package:spotify/core/usecase.dart';
import 'package:spotify/data/models/signin_user_req.dart';
import 'package:spotify/domain/repository/auth.dart';
import 'package:spotify/service_locator.dart';

class SigninUsecase implements Usecase<Either,SignINUserReq>{
  @override
  Future<Either> call({SignINUserReq ? params})async {
    print("Hello2");
    return s1<AuthRepository>().signin(params!); 
  }

}