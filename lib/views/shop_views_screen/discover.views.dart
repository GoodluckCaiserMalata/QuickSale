import 'package:flutter/material.dart';
import 'package:quicksale/services/database.dart';
import 'package:quicksale/views/profile_views_sceen/drawer.views.dart';
import 'package:quicksale/models/product.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/views/shop_views_screen/item.views.dart';
import 'package:quicksale/models/user.dart';

class Discover extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
        value: DatabaseService().productList,
        initialData: [],
        child: MaterialApp(
          home: Scaffold(
            appBar: AppBar(
              backgroundColor: Color(0xFF9BA9FF),
              actions: [
                IconButton(
                    icon: Icon(Icons.shopping_cart_outlined), 
                    onPressed: () {}),
              ],
            ),
            drawer: CustomDrawer(),
            body: Container(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        Container(
                          height: 211.0,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/images/discover.png'),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ],
                    ),
                    Container(
                      margin: EdgeInsets.all(20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 15),
                            child: SizedBox(
                              width: 250,
                              // height: 100
                              child: TextFormField(
                                style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'MartelSans'),
                                decoration: InputDecoration(
                                  prefixIcon: Icon(Icons.search, size: 25),
                                  hintText: 'Search',
                                  filled: true,
                                  fillColor: Colors.grey[100],
                                  contentPadding: EdgeInsets.symmetric(
                                      horizontal: 10, vertical: 10),
                                  focusedBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300], width: 0.5),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                        color: Colors.grey[300], width: 0.5),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            width: 50,
                            child: ElevatedButton(
                              child: Icon(Icons.tune),
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color(0xFF9BA9FF)),
                                padding: MaterialStateProperty.all<EdgeInsets>(
                                    EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 12)),
                              ),
                              onPressed: () {},
                            ),
                          )
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 5, right: 30, left: 40),
                      child: Text('Categories',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'MartelSans')),
                    ),
                    Container(
                      margin: EdgeInsets.only(left: 20, right: 20, top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(right: 2),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      // height: 100
                                      child: FlatButton(
                                        child: Icon(Icons.checkroom_outlined,
                                            size: 25, color: Color(0xFF9BA9FF)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                        ),
                                        color: Colors.grey[100],
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 50,
                                      child: Text('Clothing & Shoes',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF9BA9FF),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'MartelSans')),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(right: 2),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      // height: 100
                                      child: FlatButton(
                                        child: Icon(Icons.spa_outlined,
                                            size: 25, color: Color(0xFF9BA9FF)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                        ),
                                        color: Colors.grey[100],
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 50,
                                      child: Text('Health & Beauty',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF9BA9FF),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'MartelSans')),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(right: 2),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      // height: 100
                                      child: FlatButton(
                                        child: Icon(Icons.phonelink,
                                            size: 25, color: Color(0xFF9BA9FF)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                        ),
                                        color: Colors.grey[100],
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 50,
                                      child: Text('Computer & Phone',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF9BA9FF),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'MartelSans')),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(right: 2),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      // height: 100
                                      child: FlatButton(
                                        child: Icon(Icons.child_friendly,
                                            size: 25, color: Color(0xFF9BA9FF)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(25.0),
                                        ),
                                        color: Colors.grey[100],
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 50,
                                      child: Text('Baby & Toddler',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF9BA9FF),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'MartelSans')),
                                    ),
                                  ],
                                )),
                          ),
                          Expanded(
                            child: Padding(
                                padding: EdgeInsets.only(right: 2),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      width: 50,
                                      height: 50,
                                      // height: 100
                                      child: FlatButton(
                                        child: Icon(Icons.house,
                                            size: 25, color: Color(0xFF9BA9FF)),
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10),
                                        shape: new RoundedRectangleBorder(
                                          borderRadius:
                                              new BorderRadius.circular(35.0),
                                        ),
                                        color: Colors.grey[100],
                                        onPressed: () {},
                                      ),
                                    ),
                                    SizedBox(height: 10),
                                    SizedBox(
                                      width: 50,
                                      child: Text('Home & Garden',
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              color: Color(0xFF9BA9FF),
                                              fontSize: 10,
                                              fontWeight: FontWeight.w400,
                                              fontFamily: 'MartelSans')),
                                    ),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(top: 20, right: 30, left: 40),
                      child: Text('Discover',
                          style: TextStyle(
                              color: Colors.grey[600],
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'MartelSans')),
                    ),
                    Container(
                      width: 500,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 10, bottom: 20),
                      child: Column(children: [ProductList()]),
                    )
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}

class ProductList extends StatefulWidget {
  @override
  _ProductListState createState() => _ProductListState();
}

class _ProductListState extends State<ProductList> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];
    final user = context.watch<UserModel>();

    return StreamProvider<UserFavorites>.value(
        value: DatabaseService(documentId: user.uid).userFavorites,
        initialData: UserFavorites([]),
        child: Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            alignment: WrapAlignment.start,
            runSpacing: 5.0,
            spacing: 5.0,
            children: [
              for (var i = 0; i < products.length; i++)
                (ProductWidget(product: products[i]))
            ]));
  }
}



class ProductWidget extends StatelessWidget {
  final Product product;

  ProductWidget({this.product});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();
    final userFavorites = Provider.of<UserFavorites>(context);
    bool isPressed = false;

    return InkWell(
      child: Container(
          width: 170,
          // margin: const EdgeInsets.all(15.0),
          padding: EdgeInsets.all(8),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[200]),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 150,
                    width: 200,
                    child: Image(
                      image: NetworkImage(product.photoURL),
                      fit: BoxFit.contain,
                    ),
                  ),
                  Positioned(
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: FlatButton(
                        child:
                            Icon(Icons.add, size: 20, color: Color(0xFF9BA9FF)),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15),
                        ),
                        color: Colors.white,
                        onPressed: () async {
                          DatabaseService(documentId: user.uid)
                              .addToCart(product.id);

                          final snackBar = SnackBar(
                            content: Text('Added to Cart'),
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: Color(0xFF9BA9FF),
                              onPressed: () async {
                                DatabaseService(documentId: user.uid)
                                 .removeFromCart(product.id);
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    child: SizedBox(
                      width: 35,
                      height: 35,
                      child: FlatButton(
                        child: isPressed ? Icon(Icons.favorite_rounded, size: 20, color: Colors.grey[300]) : Icon(
                          Icons.favorite_outline,
                          size: 20,
                          color: Colors.grey[300],
                        ),
                        padding:
                            EdgeInsets.symmetric(horizontal: 5, vertical: 7),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        onPressed: () async {
                          DatabaseService(documentId: user.uid)
                              .addToFavorites(product.id);

                          if (userFavorites.favorites.contains(product.id)) {
                            isPressed = true;
                          }

                          final snackBar = SnackBar(
                            content: Text('Added to Favorites'),
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: Color(0xFF9BA9FF),
                              onPressed: () async {
                                // Some code to undo the change.
                                DatabaseService(documentId: user.uid)
                                 .removeFromFavorites(product.id);
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              SizedBox(
                child: Text(product.title,
                    style: TextStyle(
                        fontSize: 11,
                        fontWeight: FontWeight.w400,
                        fontFamily: 'MartelSans')),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Expanded(
                      child: Text('\$${product.price}',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w700,
                              fontFamily: 'MartelSans'))),
                  Expanded(
                      child: Text(product.vendorName,
                          textAlign: TextAlign.end,
                          style: TextStyle(
                              color: Color(0xFF9BA9FF),
                              fontSize: 10,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'MartelSans')))
                ],
              )
            ],
          )),
      onTap: () {
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => Item(product: product)));
      },
    );
  }
}
