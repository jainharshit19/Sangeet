import 'dart:math';

import 'package:spotify/domain/entities/auth/user.dart';

class UserModel{

  
  String ? email;
  String ? fullName;
  String ? imageURl;
  
  UserModel(
    {
      this.email,
      this.fullName,
      this.imageURl,
    }
  );

  UserModel.fromJson(Map<String,dynamic> data){
    fullName = data['name'];
    email = data['email'];
    
  }
  
}

extension UserModelx on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      email: email,
      fullName: fullName,
      imageURl: imageURl,
    );
  }
}