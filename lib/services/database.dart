import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:quicksale/models/product.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:quicksale/models/user.dart';

class DatabaseService {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final FirebaseAuth auth = FirebaseAuth.instance;

  final String documentId;
  DatabaseService({this.documentId});

  CollectionReference users = FirebaseFirestore.instance.collection('users');
  CollectionReference products =
      FirebaseFirestore.instance.collection('products');
  CollectionReference favorites =
      FirebaseFirestore.instance.collection('favorites');
  CollectionReference history =
      FirebaseFirestore.instance.collection('history');
  CollectionReference cart = FirebaseFirestore.instance.collection('cart');
  CollectionReference sales = FirebaseFirestore.instance.collection('sales');

  Future updateUserData(
      String name,
      String email,
      String photoURL,
      String dateofbirth,
      String occupation,
      String phonenumber,
      String gender) async {
    return await users
        .doc(documentId)
        .set({
          'uid': documentId,
          'name': name,
          'email': email,
          'photoURL': photoURL,
          'dateofbirth': dateofbirth,
          'occupation': occupation,
          'phonenumber': phonenumber,
          'gender': gender,
        })
        .then((value) => print("Updated Successfully"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future updatePhotoURL(String photoURL) async {
    await auth.currentUser.updateProfile(photoURL: photoURL);
    return await users
        .doc(documentId)
        .update({'photoURL': photoURL})
        .then((value) => print("Updated Successfully"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  Future addProductData(
      String title,
      String photoURL,
      String price,
      String priceDelivery,
      String vendorUID,
      String vendorName,
      String description) async {
    final docId = products.doc().id;
    await addToSales(docId);

    return await products
        .doc(docId)
        .set({
          'id': docId,
          'title': title,
          'price': price,
          'photoURL': photoURL,
          'priceDelivery': priceDelivery,
          'vendorUID': vendorUID,
          'vendorName': vendorName,
          'description': description,
        })
        .then((value) => print('Added Successfully'))
        .catchError((error) => print("Failed to add product: $error"));
  }

  Future updateProductData(
      String title,
      String price,
      String photoURL,
      String priceDelivery,
      String vendorUID,
      String vendorName,
      String description) async {
    return await products
        .doc(documentId)
        .set({
          'id': documentId,
          'title': title,
          'price': price,
          'photoURL': photoURL,
          'priceDelivery': priceDelivery,
          'vendorUID': vendorUID,
          'vendorName': vendorName,
          'description': description,
        })
        .then((value) => print("Updated Successfully"))
        .catchError((error) => print("Failed to update product: $error"));
  }

  Future removeProductData() async {
    return await products
        .doc(documentId)
        .delete()
        .then((value) => print("Removed Successfully"))
        .catchError((error) => print("Failed to remove product: $error"));
  }

  Future updateProductPhotoURL(String photoURL, String id) async {
    await auth.currentUser.updateProfile(photoURL: photoURL);
    return await products
        .doc(id)
        .update({'photoURL': photoURL})
        .then((value) => print("Updated Successfully"))
        .catchError((error) => print("Failed to update user: $error"));
  }

  UserData _userDataFromSnapshot(DocumentSnapshot snapshot) {
    return UserData(
        snapshot.data()['uid'],
        snapshot.data()['name'],
        snapshot.data()['email'],
        snapshot.data()['photoURL'],
        snapshot.data()['dateofbirth'],
        snapshot.data()['occupation'],
        snapshot.data()['phonenumber'],
        snapshot.data()['gender']);
  }

  Stream<UserData> get userData {
    return users.doc(documentId).snapshots().map(_userDataFromSnapshot);
  }

  List<Product> _productListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs
        .map((doc) => Product(
            id: doc.data()['id'],
            photoURL: doc.data()['photoURL'],
            title: doc.data()['title'],
            price: doc.data()['price'],
            priceDelivery: doc.data()['priceDelivery'],
            vendorUID: doc.data()['vendorUID'],
            vendorName: doc.data()['vendorName'],
            description: doc.data()['description']))
        .toList();
  }

  Stream<List<Product>> get productList {
    return products.snapshots().map(_productListFromSnapshot);
  }

  Future<void> addToFavorites(String id) async {
    return favorites
        .doc(documentId)
        .set({
          'productID': FieldValue.arrayUnion([id])
        }, SetOptions(merge: true))
        .then((value) => print("Added successfully to Favorites"))
        .catchError((error) => print("Failed to update favorites: $error"));
  }

  Future<void> removeFromFavorites(String id) async {
    return favorites
        .doc(documentId)
        .set({
          'productID': FieldValue.arrayRemove([id])
        }, SetOptions(merge: true))
        .then((value) => print("Removed successfully from Favorites"))
        .catchError((error) => print("Failed to remove: $error"));
  }

  Future<void> addToCart(String id) async {
    return cart
        .doc(documentId)
        .set({
          'productID': FieldValue.arrayUnion([id])
        }, SetOptions(merge: true))
        .then((value) => print("Added successfully to Cart"))
        .catchError((error) => print("Failed to update cart: $error"));
  }

  Future<void> removeFromCart(String id) async {
    return cart
        .doc(documentId)
        .set({
          'productID': FieldValue.arrayRemove([id])
        }, SetOptions(merge: true))
        .then((value) => print("Removed successfully to Cart"))
        .catchError((error) => print("Failed to remove: $error"));
  }

    Future<void> removeCart() async {
    return cart
        .doc(documentId)
        .delete()
        .then((value) => print("Cart Removed Sucessfully"))
        .catchError((error) => print("Failed to remove: $error"));
  }

  UserFavorites _userFavoritesFromSnapshot(DocumentSnapshot snapshot) {
    return UserFavorites(snapshot.data()['productID']);
  }

  Stream<UserFavorites> get userFavorites {
    return favorites
        .doc(documentId)
        .snapshots()
        .map(_userFavoritesFromSnapshot);
  }

  UserCart _userCartFromSnapshot(DocumentSnapshot snapshot) {
    return UserCart(snapshot.data()['productID']);
  }

  Stream<UserCart> get userCart {
    return cart.doc(documentId).snapshots().map(_userCartFromSnapshot);
  }

  UserSale _userSalesFromSnapshot(DocumentSnapshot snapshot) {
    return UserSale(snapshot.data()['productID']);
  }

  Stream<UserSale> get userSales {
    return sales.doc(documentId).snapshots().map(_userSalesFromSnapshot);
  }

  Future<void> addToSales(String id) async {
    return sales
        .doc(documentId)
        .set({
          'productID': FieldValue.arrayUnion([id])
        }, SetOptions(merge: true))
        .then((value) => print("Added successfully to Sales"))
        .catchError((error) => print("Failed to update sales: $error"));
  }

  Future<void> removeFromSales(String id) async {
    return sales
        .doc(documentId)
        .set({
          'productID': FieldValue.arrayRemove([id])
        }, SetOptions(merge: true))
        .then((value) => print("Removed successfully from Sales"))
        .catchError((error) => print("Failed to remove: $error"));
  }

  UserHistory _userHistoryFromSnapshot(DocumentSnapshot snapshot) {
    return UserHistory(snapshot.data()['orders']);
  }

  Stream<UserHistory> get userHistory {
    return history.doc(documentId).snapshots().map(_userHistoryFromSnapshot);
  }

  Future<void> addToHistory(List cart, String price, String orderID) async {
    return history
        .doc(documentId)
        .set({
          'orders': FieldValue.arrayUnion([{'orderID': orderID, 'price': price, 'cart': cart}])
        }, SetOptions(merge: true))
        .then((value) => print("Added successfully to Sales"))
        .catchError((error) => print("Failed to update sales: $error"));
  }
}
