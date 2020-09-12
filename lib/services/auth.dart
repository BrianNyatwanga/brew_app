import 'package:brew_app/models/user.dart';
import 'package:brew_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

 class AuthService{

  final FirebaseAuth _auth = FirebaseAuth.instance;
// create user object based on UserCredentials
    UserModel _userFromFirebaseUser(User user){
    return user != null ? UserModel(uid: user.uid) : null;
  }
//Auth change user stream
  Stream<UserModel> get user{
      return _auth.authStateChanges()
      //.map((User user) => _userFromFirebaseUser(user));
      .map(_userFromFirebaseUser);
}



//sign in anon
  Future signInAnon() async {
    try{
      UserCredential result =  await _auth.signInAnonymously();
      User user = result.user;
      return _userFromFirebaseUser(user);
    } catch(e){
      print(e.toString());
      return null;
    }
  }


//SIGN IN WITH EMAIL AND PASSWORD
   Future signInWithEmailAndPassword(String email, String password) async {
     try {
       UserCredential result = await _auth.signInWithEmailAndPassword(
         email: email,
         password: password,);
       User user = result.user;
       return _userFromFirebaseUser(user);
     }catch (e) {
       print(e.toString());
       return null;
     }
   }

// REGISTER WITH EMAIL AND PASSWORD
   Future registerWithEmailAndPassword(String email, String password) async {
     try {
       UserCredential result = await _auth.createUserWithEmailAndPassword(
         email: email,
         password: password,);
       User user = result.user;

       //creating a new doc for the user with uid
       await DatabaseService(uid: user.uid).updateUserData('0', 'new crew member', 100);
       return _userFromFirebaseUser(user);
     }catch (e) {
       print(e.toString());
       return null;
     }
   }

//SIGN OUT
     Future signOut() async {
       try {
         return await _auth.signOut();
       } catch (e) {
         print(e.toString());
         return null;
       }
     }
   }