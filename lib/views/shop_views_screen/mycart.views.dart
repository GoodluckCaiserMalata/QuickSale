import 'package:flutter/material.dart';
import 'package:quicksale/services/database.dart';
import 'package:quicksale/models/product.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/views/shop_views_screen/checkout.views.dart';

class MyCart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<List<Product>>.value(
        value: DatabaseService().productList,
        initialData: [],
        child: Scaffold(
          body: Stack(
            children: [
              Container(
                height: 150.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/itemBack.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Center(
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 85),
                    CartList(),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

class CartList extends StatefulWidget {
  @override
  _CartListState createState() => _CartListState();
}

class _CartListState extends State<CartList> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return StreamProvider<UserCart>.value(
        value: DatabaseService(documentId: user.uid).userCart,
        initialData: UserCart([]),
        child: Carts());
  }
}

class Carts extends StatefulWidget {
  @override
  _CartsState createState() => _CartsState();
}

class _CartsState extends State<Carts> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];
    final userCart = Provider.of<UserCart>(context);

    bool isEmpty = false;

    if (userCart.cart.length == 0) {
      setState(() {
        isEmpty = true;
      });
    }

    return isEmpty
        ? Center(
            widthFactor: MediaQuery.of(context).size.width * 0.65,
            heightFactor: MediaQuery.of(context).size.height / 32,
            child: Text('Nothing to show',
                style: TextStyle(color: Colors.grey, fontFamily: 'MartelSans')))
        : Column(
            children: [
              for (var i = 0; i < products.length; i++)
                if (userCart.cart.contains(products[i].id))
                  Cart(product: products[i]),
              Container(
                width: 300,
                child: ElevatedButton(
                  child: Text("Proceed to Checkout"),
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Color(0xFF9BA9FF)),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => Checkout()));
                  },
                ),
              )
            ],
          );
  }
}

class Cart extends StatelessWidget {
  final Product product;

  Cart({this.product});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return Container(
      width: 350,
      height: 150,
      margin: EdgeInsets.only(left: 20, right: 20, top: 15, bottom: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
          border: Border.all(color: Colors.white54),
          borderRadius: BorderRadius.circular(5),
          color: Colors.white54),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Image(
              image: NetworkImage(product.photoURL),
              fit: BoxFit.contain,
            ),
          ),
          Expanded(
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
                        style: TextStyle(fontWeight: FontWeight.w700)),
                  ],
                ),
                Row(children: [
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    width: 70,
                    height: 30,
                    child: FlatButton(
                        padding: EdgeInsets.all(5),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        color: Colors.red[400],
                        onPressed: () async {
                          DatabaseService(documentId: user.uid)
                              .removeFromCart(product.id);
                          final snackBar = SnackBar(
                            content: Text('Removed from Cart'),
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: Color(0xFF9BA9FF),
                              onPressed: () async {
                                DatabaseService(documentId: user.uid)
                                    .addToCart(product.id);
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text('Remove',
                            style:
                                TextStyle(color: Colors.white, fontSize: 13))),
                  )
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
