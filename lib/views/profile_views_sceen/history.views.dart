import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:quicksale/models/user.dart';
import 'package:provider/provider.dart';
import 'package:quicksale/services/database.dart';

class History extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = context.watch<UserModel>();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.grey),
        elevation: 1,
        centerTitle: true,
        title: Text('Order History',
            style: TextStyle(color: Colors.grey, fontFamily: 'MartelSans')),
      ),
      body: Container(
          margin: EdgeInsets.only(top: 20, right: 20, left: 20),
          child: StreamProvider<UserHistory>.value(
              value: DatabaseService(documentId: user.uid).userHistory,
              initialData: UserHistory([]),
              child: HistoryList())),
    );
  }
}

class HistoryList extends StatefulWidget {
  @override
  _HistoryListState createState() => _HistoryListState();
}

class _HistoryListState extends State<HistoryList> {
  @override
  Widget build(BuildContext context) {
    final userHistory = Provider.of<UserHistory>(context);

    return ListView.builder(
        itemCount: userHistory.orders.length,
        itemBuilder: (BuildContext context, int index) {
          return HistoryTile(userHistory.orders[index]);
        });
  }
}

class HistoryTile extends StatefulWidget {
  final Map<String, dynamic> history;

  HistoryTile(this.history);

  @override
  _HistoryTileState createState() => _HistoryTileState();
}

class _HistoryTileState extends State<HistoryTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ListTile(
          title: Text("Order ID: #${widget.history['orderID']}",
              style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w400,
                  fontFamily: 'MartelSans')),
          subtitle: Text('Total: \$${widget.history['price']}',
              style: TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'MartelSans')),
          leading: Container(
            width: 50,
            child: FlatButton(
              child: Icon(Icons.shopping_cart_outlined,
                  size: 20, color: Colors.grey),
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 15),
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(5.0),
              ),
              color: Colors.grey[100],
              onPressed: () {},
            ),
          ),
          trailing: Icon(Icons.navigate_next, color: Colors.grey),
        ),
        Divider(),
      ],
    );
  }
}
