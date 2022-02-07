// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// updateShare()
// {
//   final uid=FirebaseAuth.instance.currentUser!.uid;
// CollectionReference share = FirebaseFirestore.instance
// .collection('User')
// .doc(uid)
// .collection(UpdateShare)
// ;

// Future<void> updateUser() {
//   return share
//     .doc(uid)
//     .update({'qty': ['qty'] + })
//     .then((value) => print("User Updated"))
//     .catchError((error) => print("Failed to update user: $error"));
// }
// }