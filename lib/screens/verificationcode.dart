import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:littardo/services/api_services.dart';
import 'package:littardo/utils/codeinput.dart';
import 'home.dart';
import 'package:littardo/utils/progressdialog.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNumber;
  VerificationScreen({this.phoneNumber});
  @override
  _VerificationScreenState createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  ProgressDialog pr;
  @override
  Widget build(BuildContext context) {
    pr = new ProgressDialog(context, ProgressDialogType.Normal);
    pr.setMessage('Verifying account...');
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 96.0),
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Text("Phone Verification",
                      style: Theme.of(context).textTheme.title),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 16.0, right: 16.0, bottom: 48.0),
                  child: Text(
                    "Enter your code here",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                FittedBox(
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 32),
                    padding: EdgeInsets.only(bottom: 64.0),
                    child: CodeInput(
                      length: 6,
                      keyboardType: TextInputType.number,
                      builder: CodeInputBuilders.darkCircle(),
                      onFilled: (value) async {
                        print('Your input is $value.');
                        pr.show();
                        var request = MultipartRequest(
                            "POST", Uri.parse(api_url + "verify_otp"));
                        request.fields['phone'] = widget.phoneNumber;
                        request.fields['otp'] = value;
                        commonMethod(request).then((onResponse) {
                          onResponse.stream
                              .transform(utf8.decoder)
                              .listen((value) {
                            print(value);
                          });
                        });
                        // Future.delayed(const Duration(milliseconds: 1500), () {
                        //   setState(() {
                        //     pr.hide(context);
                        //     Navigator.pushReplacement(
                        //       context,
                        //       MaterialPageRoute(builder: (context) => Home()),
                        //     );
                        //   });
                        // });
                      },
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    "Didn't you received any code?",
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                GestureDetector(
                  onTap: () => {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    ),
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    child: Text(
                      "Resend new code",
                      style: TextStyle(
                        fontSize: 19,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
