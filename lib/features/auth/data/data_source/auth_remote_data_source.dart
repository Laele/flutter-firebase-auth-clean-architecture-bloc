import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_rate_products/core/error/exceptions.dart';
import 'package:flutter_rate_products/features/auth/data/models/user_model.dart';

abstract interface class AuthRemoteDataSource {

  User? get currentUserSession;

  Future<UserModel> signUpWithEmailPassword({
    required String username,
    required String email,
    required String password,
  });

  Future<UserModel> logInWithEmailPassword({
    required String email,
    required String password
  });

  Future<UserModel?> createUserCollection({
    required String email,
    required String username
  });

  Future<UserModel?> getCurrentUserData();

  Future<void> signOutUser();
}


class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {

  final FirebaseAuth _auth;
  final FirebaseFirestore _firebaseFirestore;
  AuthRemoteDataSourceImpl(this._auth, this._firebaseFirestore);

  @override
  User? get currentUserSession => _auth.currentUser;

  @override
  Future<UserModel> logInWithEmailPassword({required String email, required String password}) async {
    try{
      final response = await _auth.signInWithEmailAndPassword(email: email, password: password);
      
      if(response.user == null){
        throw ServerException(message: 'User is null');
      }

      final Map<String, dynamic>  map = {
        'uid': response.user!.uid ?? '',
        'email': response.user!.email ?? '',
      };

      return UserModel.fromJson(map);
      
    } catch(e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel> signUpWithEmailPassword({required String username, required String email, required String password}) async {
    try{
      final response = await _auth.createUserWithEmailAndPassword(email: email, password: password);
      
      if(response.user == null){
        throw ServerException(message: 'User is null');
      }

      final Map<String, dynamic>  map = {
        'uid': response.user!.uid ?? '',
        'email': response.user!.email ?? '',
      };

      return UserModel.fromJson(map);
      
    } catch(e) {
      throw ServerException(message: e.toString());
    }
  }

  @override
  Future<UserModel?> createUserCollection({
    required String username,
    required String email,
  }) async {
    try{
      final userCollection = _firebaseFirestore.collection('users');
      final uid = await getCurrentUid();
      userCollection.doc(uid).get().then((userDoc) async {

        final newUser = UserModel(
          uid: uid, 
          email: email, 
          username: username
        ).toMap();
        if(!userDoc.exists){
          userCollection.doc(uid).set(newUser);
          //final user = await userCollection.doc(uid).get();
        }else{
          throw ServerException(message: 'User already exists');
        }
        
      }).catchError((e){
        throw ServerException(message: e.toString());
      });
      
      return await getCurrentUserData();
      //return false;
    }catch(e){
      
       throw ServerException(message: e.toString());
    }

  }

  Future<String> getCurrentUid() async => _auth.currentUser!.uid;
  
  @override
  Future<UserModel?> getCurrentUserData() async {
    try {
      if(currentUserSession != null){
        final uid = await getCurrentUid();
        final userData = await _firebaseFirestore.collection('users').doc(uid).get();

        /*final userData2 = await _firebaseFirestore.collection('users').where('uid', isEqualTo: uid).get();
        final data = userData2.docs.first.data();
        final model2 = UserModel.fromSnapshot(userData2.docs.first);*/
        
        return UserModel.fromSnapshot( userData );
      }
      return null;
    } catch (e) {
      throw ServerException(message: e.toString());
    }
  }
  
  @override
  Future<void> signOutUser() async {
    await _auth.signOut();
  }

}