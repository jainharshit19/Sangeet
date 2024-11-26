import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/signin_user_req.dart';
import 'package:spotify/data/models/user_req.dart';
import 'package:spotify/data/sources/auth_firebase.dart';
import 'package:spotify/domain/repository/auth.dart';
import 'package:spotify/service_locator.dart';

class AuthImp extends AuthRepository {
  @override
  Future<Either> signin(SignINUserReq signINUserReq) async {
    return await s1<AuthFirebase>().signin(signINUserReq);
  }

  @override
  Future<Either> signup(UserReq userReq) async {
    return await s1<AuthFirebase>().signup(userReq);
  }
  
  @override
  Future<Either> getUser() async{
    return await s1<AuthFirebase>().getUser(); 
  }

}