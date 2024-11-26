import 'package:dartz/dartz.dart';
import 'package:spotify/data/models/signin_user_req.dart';
import 'package:spotify/data/models/user_req.dart';

abstract class AuthRepository{

  Future<Either> signup(UserReq userReq);

  Future<Either> signin(SignINUserReq signINUserReq);
  
  Future<Either> getUser();

}