import 'package:flutter/material.dart';
import 'package:quicksale/services/database.dart';
import 'package:quicksale/models/product.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/views/profile_views_sceen/update.views.dart';
import 'package:quicksale/views/profile_views_sceen/upload.views.dart';

class ManageSale extends StatelessWidget {
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
            title: Text('Manage Sales',
                style: TextStyle(color: Colors.grey, fontFamily: 'MartelSans')),
          ),
          floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xFF9BA9FF),
              onPressed: () async {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => UploadItem()));
              },
              child: Icon(Icons.add)),
          body: Container(
            margin: EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              children: [SalesList()],
            ),
          ),
        ));
  }
}

class SalesList extends StatefulWidget {
  @override
  _SalesListState createState() => _SalesListState();
}

class _SalesListState extends State<SalesList> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return StreamProvider<UserSale>.value(
        value: DatabaseService(documentId: user.uid).userSales,
        initialData: UserSale([]),
        child: Sales());
  }
}

class Sales extends StatefulWidget {
  @override
  _SalesState createState() => _SalesState();
}

class _SalesState extends State<Sales> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];
    final userSales = Provider.of<UserSale>(context);

    bool isEmpty = false;

    if (userSales.sales.length == 0) {
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
                if (userSales.sales.contains(products[i].id))
                  ItemSale(product: products[i]),
            ],
          );
  }
}

class ItemSale extends StatelessWidget {
  final Product product;

  ItemSale({this.product});

  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return Container(
      width: 400,
      height: 150,
      margin: EdgeInsets.only(bottom: 15),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[200]),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 120,
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
                    Text('\$6.25',
                        style: TextStyle(
                            fontWeight: FontWeight.w700,
                            fontFamily: 'MartelSans')),
                  ],
                ),
                Row(children: [
                  SizedBox(
                    width: 60,
                    height: 30,
                    child: FlatButton(
                        padding: EdgeInsets.all(5),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        color: Colors.red[400],
                        onPressed: () async {
                          DatabaseService(documentId: product.id)
                              .removeProductData();

                          DatabaseService(documentId: product.id)
                              .removeFromSales(product.id);

                          DatabaseService(documentId: user.uid)
                              .removeFromFavorites(product.id);

                          DatabaseService(documentId: user.uid)
                              .removeFromCart(product.id);

                          final snackBar = SnackBar(
                            content: Text('Removed from Sales'),
                            action: SnackBarAction(
                              label: 'Undo',
                              textColor: Color(0xFF9BA9FF),
                              onPressed: () async {
                                final String id = product.id;
                                final String title = product.title;
                                final String price = product.price;
                                final String priceDelivery =
                                    product.priceDelivery;
                                final String vendorUID = product.vendorUID;
                                final String vendorName = product.vendorName;
                                final String description = product.description;
                                final String photoURL = product.photoURL;

                                DatabaseService(documentId: id)
                                    .updateProductData(
                                        title,
                                        price,
                                        photoURL,
                                        priceDelivery,
                                        vendorUID,
                                        vendorName,
                                        description);

                                DatabaseService(documentId: id).addToSales(id);
                              },
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackBar);
                        },
                        child: Text('Remove',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10))),
                  ),
                  SizedBox(width: 10),
                  SizedBox(
                    width: 60,
                    height: 30,
                    child: FlatButton(
                        padding: EdgeInsets.all(5),
                        shape: new RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(5.0),
                        ),
                        color: Colors.green[300],
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UpdateItem(product)));
                        },
                        child: Text('Update',
                            style:
                                TextStyle(color: Colors.white, fontSize: 10))),
                  ),
                ])
              ],
            ),
          )
        ],
      ),
    );
  }
}
