import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:spotify/core/config/assets/app_images.dart';
import 'package:spotify/core/config/constants/app_url.dart';
import 'package:spotify/data/models/signin_user_req.dart';
import 'package:spotify/data/models/userModel.dart';
import 'package:spotify/data/models/user_req.dart';
import 'package:spotify/domain/entities/auth/user.dart';

abstract class AuthFirebase{

  Future<Either> signup(UserReq userReq);

  Future<Either> signin(SignINUserReq signINUserReq);
  Future<Either> getUser();
}

class AuthFirebaseImp extends AuthFirebase{
  @override
  Future<Either> signin(SignINUserReq signINUserReq) async{
    try{
      print("Hello3");
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: signINUserReq.email, 
        password: signINUserReq.password
      );
      print('hello5');

     
      print("hello4");
       return const Right('Signin was Successfull');

    } on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == 'invalid-email'){
        message = "Not user found for that email";
      } else if(e.code == 'invalid-credential'){
        message ='Wrong password provided for that user';
      }
      return Left(message);
    }
   
  }

  @override
  Future<Either> signup(UserReq userReq) async{
    try{
      print("Hello3");
      var data =await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: userReq.email, 
        password: userReq.password
      );
      
      FirebaseFirestore.instance.collection('Users').doc(data.user?.uid)
      .set(
        {
          'name' : userReq.fullName,
          'email': data.user?.email
        }
      );
      print("hello4");
       return const Right('Signup was Successfull');

    } on FirebaseAuthException catch(e){
      String message = '';
      if(e.code == 'weak password'){
        message = "The password provided is too weak";
      } else if(e.code == 'email-already-used'){
        message ='An account already exists with that email';
      }
      return Left(message);
    }
    
  }
  
  @override
  Future<Either> getUser() async{
    try{
    FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    FirebaseFirestore firebaseFirestore =FirebaseFirestore.instance;
    var user = await firebaseFirestore.collection('Users').doc(
      firebaseAuth.currentUser ?.uid
    ).get();

    UserModel userModel =UserModel.fromJson(user.data()!);
    userModel.imageURl = firebaseAuth.currentUser?.photoURL ?? AppImages.profilePhoto;
    UserEntity userEntity = userModel.toEntity();
    return Right(userEntity);
    }
    catch(e){
      return  const Left('An error occured');
    }
  }

}