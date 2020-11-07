import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class DatabaseMethods {
  final String userId;

  DatabaseMethods({this.userId});

  final CollectionReference col = Firestore.instance.collection("farmers");

  getUserByUsername(String username) async {
    return await Firestore.instance
        .collection("farmers")
        .where("id", isEqualTo: userId)
        .getDocuments();
  }

  getUserByUserEmail(String userEmail) async {
    return await Firestore.instance
        .collection(userId)
        .where("email", isEqualTo: userEmail)
        .getDocuments();
  }

  getFarmerRecordsByEmail() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    return await Firestore.instance
        .collection("farmers")
        .where("email", isEqualTo: user.email)
        .getDocuments();
  }

  getFarmerLoanRecord() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    return await Firestore.instance
        .collection("users")
        .where("email", isEqualTo: user.email)
        .getDocuments();
  }

  getFarmerLoanState() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    return await Firestore.instance
        .collection("loans")
        .where("email", isEqualTo: user.email)
        .getDocuments();
  }

  getAllUsers() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    return await Firestore.instance.collection("users").getDocuments();
  }

  getAllUserLoans() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();
    return await Firestore.instance.collection("loans").getDocuments();
  }

  // Future uploadUserInfo(
  //     String userId, String name, String date, int kilograms) async {
  //   return await col.document(userId).setData({
  //     'id': userId,
  //     'name': name,
  //     'date': date,
  //     'kilograms': kilograms
  //   }).catchError((e) {
  //     print(e.toString());
  //   });
  // }

  uploadUserInfo(userMap) {
    Firestore.instance.collection("users").add(userMap).catchError((e) {
      print(e.toString());
    });
  }

  Future uploadPostInfo(
      String userId, String name, String date, int kilograms) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final Firestore _firestore = Firestore.instance;
    FirebaseUser user = await _auth.currentUser();

    return await col.document(userId).setData({
      'id': user.uid,
      'email': user.email,
      'date': date,
      'kilograms': kilograms
    }).catchError((e) {
      print(e.toString());
    });
  }

  createChatRoom(String chatRoomId, chatRoomMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .setData(chatRoomMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  addConversationMessages(String chatRoomId, messageMap) {
    Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap)
        .catchError((e) {
      print(e.toString());
    });
  }

  getConversationMessages(String chatRoomId) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  getChatRooms(String userName) async {
    return await Firestore.instance
        .collection("ChatRoom")
        .where("users", arrayContains: userName)
        .snapshots();
  }
}
