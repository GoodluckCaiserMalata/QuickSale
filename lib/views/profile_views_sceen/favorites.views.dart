import 'package:flutter/material.dart';
import 'package:quicksale/models/user.dart';
import 'package:quicksale/models/product.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/services/database.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
        value: DatabaseService().productList,
        initialData: [],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            iconTheme: IconThemeData(color: Colors.grey),
            elevation: 1,
            centerTitle: true,
            title: Text('Favorites',
                style: TextStyle(color: Colors.grey, fontFamily: 'MartelSans')),
          ),
          body: Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              children: [FavoriteList()],
            ),
          ),
        ));
  }
}

class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return StreamProvider<UserFavorites>.value(
        value: DatabaseService(documentId: user.uid).userFavorites,
        initialData: UserFavorites([]),
        child: Favorite());
  }
}

class Favorite extends StatefulWidget {
  @override
  _FavoriteState createState() => _FavoriteState();
}

class _FavoriteState extends State<Favorite> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];
    final userFavorites = Provider.of<UserFavorites>(context);

    bool isEmpty = false;

    if (userFavorites.favorites.length == 0) {
      setState(() {
        isEmpty = true;
      });
    }

    return isEmpty ? Center(
        widthFactor: MediaQuery.of(context).size.width * 0.65,
        heightFactor: MediaQuery.of(context).size.height / 35,
        child: Text('Nothing to show', style: TextStyle(color: Colors.grey, fontFamily: 'MartelSans'))
      ) : Column(
      children: [
        for (var i = 0; i < products.length; i++)
          if (userFavorites.favorites.contains(products[i].id))
            ItemFavorite(products[i]),
      ],
    );
  }
}

class ItemFavorite extends StatelessWidget {
  final Product product;

  ItemFavorite(this.product);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 400,
      height: 150,
      margin: EdgeInsets.only(bottom: 15),
      // margin: EdgeInsets.only(
      //     left: 20, right: 20, top: 100, bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 150,
            child: Image(
              image: NetworkImage(product.photoURL),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(width: 10),
          Expanded(
            flex: 2,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                    child: Text(
                  product.title,
                  style: TextStyle(
                      fontWeight: FontWeight.w400, fontFamily: 'MartelSans'),
                )),
                Row(
                  children: [
                    Text('\$${product.price}',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'MartelSans')),
                  ],
                ),
                Row(children: [
                  Text('Vendor | ${product.vendorName}',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'MartelSans'))
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
