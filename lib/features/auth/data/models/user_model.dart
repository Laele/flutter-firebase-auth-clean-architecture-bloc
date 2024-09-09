import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_rate_products/core/shared/entities/user_entity.dart';

class UserModel extends UserEntity{
  
  UserModel({
    required super.uid, 
    required super.email, 
    required super.username
  });

  Map<String, dynamic> toMap(){
    return {
      'uid' :      uid,
      'email':     email,
      'username' : username
    };
  }

  factory UserModel.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> snapshot){
    return UserModel(
      uid:      snapshot.get('uid') ?? '', 
      email:    snapshot.get('email') ?? '', 
      username: snapshot.get('username') ?? ''
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> map){
    return UserModel(
      uid:      map['uid'] ?? '', 
      email:    map['email'] ?? '', 
      username: map['username'] ?? ''
    );
  }
}