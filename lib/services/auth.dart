import 'package:quicksale/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quicksale/models/user.dart';

class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;

  UserModel _userFromFirebaseUser(User user) {
    return user != null
        ? UserModel(
            uid: user.uid,
            email: user.email,
            name: user.displayName,
            photoURL: user.photoURL)
        : null;
  }

  Stream<UserModel> get user {
    return auth
        .authStateChanges()
        // .map((User user) => _userFromFirebaseUser(user));
        .map(_userFromFirebaseUser);
  }

  Future registerWithEmailAndPassword(
      String email, String password, String name) async {
    String photoURL = 'https://t4.ftcdn.net/jpg/04/10/43/77/360_F_410437733_hdq4Q3QOH9uwh0mcqAhRFzOKfrCR24Ta.jpg';
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      User user = userCredential.user;
      await user.updateProfile(
          displayName: name, photoURL: photoURL);
      await user.reload();
      User currentUser = user;

      await DatabaseService(documentId: user.uid).updateUserData(
          name,
          email,
          photoURL,
          'dd/mm/yyyy',
          'not defined',
          'not defined',
          'not defined');

      return _userFromFirebaseUser(currentUser);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }

  Future signInWithEmailAndPassword(String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      User user = userCredential.user;
      return _userFromFirebaseUser(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }

  Future signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
