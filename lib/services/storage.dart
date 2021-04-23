import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:path/path.dart';
import 'package:quicksale/services/database.dart';

class Storage {
  String documentID;

  Storage({this.documentID});

  Future uploadImageUserToFirebase(File imageFile) async {
    String fileName = basename(imageFile.path);
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('users/$documentID/$fileName');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(imageFile);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    if (taskSnapshot.state == firebase_storage.TaskState.success) {
      taskSnapshot.ref.getDownloadURL().then(
            (value) =>
                DatabaseService(documentId: documentID).updatePhotoURL(value),
          );
    }
  }

  Future uploadImageProductToFirebase(File imageFile) async {
    String fileName = basename(imageFile.path);
    firebase_storage.Reference firebaseStorageRef = firebase_storage
        .FirebaseStorage.instance
        .ref()
        .child('products/$documentID/$fileName');
    firebase_storage.UploadTask uploadTask =
        firebaseStorageRef.putFile(imageFile);
    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;
    if (taskSnapshot.state == firebase_storage.TaskState.success) {
      taskSnapshot.ref.getDownloadURL().then(
            (value) => DatabaseService(documentId: documentID)
                .updateProductPhotoURL(value, documentID),
          );
    }
  }
}
