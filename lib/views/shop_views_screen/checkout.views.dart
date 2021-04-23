import 'package:flutter/material.dart';
import 'package:quicksale/views/shop_views_screen/payment.views.dart';
import 'package:quicksale/services/database.dart';
import 'package:quicksale/models/product.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';

enum PaymentType { cash, card }

class Checkout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();
    return StreamProvider<List<Product>>.value(
        value: DatabaseService().productList,
        initialData: [],
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Color(0xFF9BA9FF),
            title: Text('Checkout'),
            centerTitle: true,
          ),
          body: Stack(
            children: [
              Container(
                height: 100.0,
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/images/itemBack.png'),
                      fit: BoxFit.cover),
                ),
              ),
              Center(
                  child: Container(
                      width: 350,
                      margin: EdgeInsets.only(
                          left: 20, right: 20, top: 50, bottom: 20),
                      padding: EdgeInsets.all(20),
                      decoration: BoxDecoration(
                          border: Border.all(color: Colors.white54),
                          borderRadius: BorderRadius.circular(5),
                          color: Colors.white54),
                      child: Column(children: [
                        SizedBox(
                          height: 5,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Your Order',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'View All',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Color(0xFF9BA9FF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                          ],
                        ),
                        OrderList(),
                        SizedBox(
                          height: 10,
                        ),
                        TotalList(),
                        SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Text(
                                'Your Address',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'Edit Address',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Color(0xFF9BA9FF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            SizedBox(
                              child: Text(
                                'Street Name: 1150  Late Avenue, Kingfisher, Oklahoma',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                'Zip Code: 73750',
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                'Contact: 580-770-8809',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w400,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              child: Text(
                                'Payment Methods',
                                style: TextStyle(
                                    fontSize: 17,
                                    fontWeight: FontWeight.w700,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                            Expanded(
                              child: Text(
                                'View All',
                                textAlign: TextAlign.end,
                                style: TextStyle(
                                    color: Color(0xFF9BA9FF),
                                    fontSize: 12,
                                    fontWeight: FontWeight.w300,
                                    fontFamily: 'MartelSans'),
                              ),
                            ),
                          ],
                        ),
                        Container(
                          child: Expanded(
                              child: StreamProvider<UserCart>.value(
                                  value: DatabaseService(documentId: user.uid)
                                      .userCart,
                                  initialData: UserCart([]),
                                  child: MyStatefulWidget())),
                        )
                      ])))
            ],
          ),
        ));
  }
}

class OrderList extends StatefulWidget {
  @override
  _OrderListState createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return StreamProvider<UserCart>.value(
        value: DatabaseService(documentId: user.uid).userCart,
        initialData: UserCart([]),
        child: Orders());
  }
}

class Orders extends StatefulWidget {
  @override
  _OrdersState createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  @override
  Widget build(BuildContext context) {
    final products = Provider.of<List<Product>>(context) ?? [];
    final userCart = Provider.of<UserCart>(context);

    return Column(
      children: [
        for (var i = 0; i < products.length; i++)
          if (userCart.cart.contains(products[i].id))
            Order(product: products[i]),
      ],
    );
  }
}

class Order extends StatelessWidget {
  final Product product;

  Order({this.product});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          child: Text(
            '1x  ${product.title}',
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w400,
                fontFamily: 'MartelSans'),
          ),
        ),
        Expanded(
          child: Text(
            '\$${product.price}',
            textAlign: TextAlign.end,
            style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w300,
                fontFamily: 'MartelSans'),
          ),
        ),
      ],
    );
  }
}

class TotalList extends StatefulWidget {
  @override
  _TotalListState createState() => _TotalListState();
}

class _TotalListState extends State<TotalList> {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return StreamProvider<UserCart>.value(
        value: DatabaseService(documentId: user.uid).userCart,
        initialData: UserCart([]),
        child: Totals());
  }
}

class Totals extends StatefulWidget {
  @override
  _TotalsState createState() => _TotalsState();
}

class _TotalsState extends State<Totals> {
  String total, order, delivery;
  double tempTotal = 0;
  double tempOrder = 0;
  double tempDelivery = 0;

  void calculation(BuildContext context) async {
    tempTotal = 0;
    tempOrder = 0;
    tempDelivery = 0;
    final products = Provider.of<List<Product>>(context) ?? [];
    final userCart = Provider.of<UserCart>(context);

    for (var i = 0; i < products.length; i++) {
      if (userCart.cart.contains(products[i].id)) {
        tempOrder += double.parse(products[i].price.toString());
        tempDelivery += double.parse(products[i].priceDelivery.toString());
      }
    }
    tempTotal += (tempOrder + tempDelivery);
    total = tempTotal.toStringAsFixed(2).toString();
    order = tempOrder.toStringAsFixed(2).toString();
    delivery = tempDelivery.toStringAsFixed(2).toString();
  }

  @override
  Widget build(BuildContext context) {
    calculation(context);

    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Row(
          children: [
            SizedBox(
              child: Text(
                'Total',
                style: TextStyle(
                    color: Color(0xFF9BA9FF),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'MartelSans'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              child: Text(
                'Total order amount',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'MartelSans'),
              ),
            ),
            Expanded(
              child: Text(
                '\$$order',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'MartelSans'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              child: Text(
                'Delivery charge',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w400,
                    fontFamily: 'MartelSans'),
              ),
            ),
            Expanded(
              child: Text(
                '\$$delivery',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w300,
                    fontFamily: 'MartelSans'),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              child: Text(
                'Total Amount',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'MartelSans'),
              ),
            ),
            Expanded(
              child: Text(
                '\$$total',
                textAlign: TextAlign.end,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w700,
                    fontFamily: 'MartelSans'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  MyStatefulWidgetState createState() => MyStatefulWidgetState();
}

class MyStatefulWidgetState extends State<MyStatefulWidget> {
  PaymentType _type = PaymentType.cash;
  String total, order, delivery;
  double tempTotal = 0;
  double tempOrder = 0;
  double tempDelivery = 0;

  void calculation(BuildContext context) async {
    tempTotal = 0;
    tempOrder = 0;
    tempDelivery = 0;
    final products = Provider.of<List<Product>>(context) ?? [];
    final userCart = Provider.of<UserCart>(context);

    for (var i = 0; i < products.length; i++) {
      if (userCart.cart.contains(products[i].id)) {
        tempOrder += double.parse(products[i].price.toString());
        tempDelivery += double.parse(products[i].priceDelivery.toString());
      }
    }
    tempTotal += (tempOrder + tempDelivery);
    total = tempTotal.toStringAsFixed(2).toString();
    order = tempOrder.toStringAsFixed(2).toString();
    delivery = tempDelivery.toStringAsFixed(2).toString();
  }

  @override
  Widget build(BuildContext context) {
    calculation(context);
    return Column(
      children: <Widget>[
        ListTile(
          title: const Text(
            'Cash on Delivery',
            style: TextStyle(fontSize: 12),
          ),
          trailing: Icon(Icons.payments_outlined),
          dense: true,
          contentPadding: EdgeInsets.zero,
          leading: Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Color(0xFF9BA9FF),
            value: PaymentType.cash,
            groupValue: _type,
            onChanged: (PaymentType value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
        ListTile(
          title:
              const Text('Visa or Mastercard', style: TextStyle(fontSize: 12)),
          trailing: Icon(Icons.payment_outlined),
          contentPadding: EdgeInsets.zero,
          dense: true,
          leading: Radio(
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            activeColor: Color(0xFF9BA9FF),
            value: PaymentType.card,
            groupValue: _type,
            onChanged: (PaymentType value) {
              setState(() {
                _type = value;
              });
            },
          ),
        ),
        Container(
          width: 300,
          child: ElevatedButton(
            child: Text("Proceed to Payment"),
            style: ButtonStyle(
              backgroundColor:
                  MaterialStateProperty.all<Color>(Color(0xFF9BA9FF)),
              padding: MaterialStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => Payment(total)));
            },
          ),
        )
      ],
    );
  }
}
