import 'package:brew_app/models/brew.dart';
import 'package:brew_app/models/user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService{

  final String uid;
  DatabaseService({this.uid});

  //collection reference
  final CollectionReference brewCollection =
  FirebaseFirestore.instance.collection('brews');

  Future updateUserData(String sugars, String name, int strength ) async{
    return await brewCollection.doc(uid).set({
      'sugars': sugars,
      'name' : name,
      'strength': strength,
    });
  }

  //Brew list from snapshot
  List<Brew> _brewlistFromSnapshot(QuerySnapshot snapshot){
    return snapshot.docs.map((doc) => Brew(
      name: doc.data()['name'] ?? '',
      strength: doc.data()['strength'] ?? 0,
      sugars: doc.data()['sugars'] ?? '0',
    )).toList();
  }
//USER DATA FROM SNAPSHOT
  UserData _userDataFromSnapshot(DocumentSnapshot snapshot){
    return UserData(
      uid: uid,
      name: snapshot.data()['name'],
      sugars: snapshot.data()['sugars'],
      strength: snapshot.data()['strength'],
    );
  }

  //Get brews stream
  Stream<List<Brew>> get brews {
    return brewCollection.snapshots().map(_brewlistFromSnapshot);
  }
//GET USER DOC STREAM
  Stream<UserData> get userData{
    return brewCollection.doc(uid).snapshots()
    .map(_userDataFromSnapshot);
  }

}
