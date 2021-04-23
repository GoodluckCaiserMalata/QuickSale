class UserModel {
  final String uid;
  final String email;
  final String name;
  final String photoURL;

  UserModel({this.uid, this.email, this.name, this.photoURL});
}

class UserData extends UserModel {
  final String dateofbirth;
  final String occupation;
  final String phonenumber;
  final String gender;

  UserData(String uid, String name, String email, String photoURL,
      this.dateofbirth, this.occupation, this.phonenumber, this.gender)
      : super(uid: uid, name: name, email: email, photoURL: photoURL);
}

class UserHistory {
  final List orders;

  UserHistory(this.orders);
}

class UserFavorites {
  final List favorites;

  UserFavorites(this.favorites);
}

class UserCart {
  final List cart;

  UserCart(this.cart);
}

class UserSale {
  final List sales;

  UserSale(this.sales);
}
