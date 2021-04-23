import 'package:flutter/material.dart';

class ResetCode extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          constraints: BoxConstraints(maxHeight: 500),
          height: 500,
          child: Image.asset("assets/images/authrec.png", fit: BoxFit.cover),
        ),
        Container(
          child: Column(
            children: [
              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                  padding: EdgeInsets.only(top: 250),
                  child: Text(
                    'Forgot your password',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'MartelSans'),
                  ),
                ),
              ]),
              Container(
                  padding: EdgeInsets.only(top: 10, left: 25, right: 25),
                  child: SizedBox(
                    child: Text(
                        "A notification email with a password reset code will then be sent to you within the next minutes",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'MartelSans',
                          color: Colors.white,
                        )),
                  )),

              Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                Container(
                    padding: EdgeInsets.only(top: 190),
                    child: SizedBox(
                      width: 320,
                      child: ResetCodeForm(),
                    )),
              ]),
            ],
          ),
        )
      ],
    ));
  }
}

class ResetCodeForm extends StatefulWidget {
  @override
  ResetCodeFormState createState() {
    return ResetCodeFormState();
  }
}

// Create a corresponding State class.
// This class holds data related to the form.
class ResetCodeFormState extends State<ResetCodeForm> {
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // Build a Form widget using the _formKey created above.
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextFormField(
            style: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w300,
                fontFamily: 'MartelSans'),
            decoration: InputDecoration(
              labelText: 'Reset Code',
              labelStyle: TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                fontFamily: 'MartelSans',
            
              )
            ),
          ),
          // The validator receives the text that the user has entered.

          Row(children: [
            Container(
              width: 320,
              padding: EdgeInsets.only(top: 25),
              child: ElevatedButton(
                child: Text("Reset Password"),
                style: ButtonStyle(
                  backgroundColor:
                      MaterialStateProperty.all<Color>(Color(0xFF9BA9FF)),
                  padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 12, vertical: 12)),
                ),
                onPressed: () {},
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
