// import 'dart:convert';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;
// import 'package:paytm/paytm.dart';

// class PaytmSDK extends StatefulWidget {
//   @override
//   _PaytmSDKState createState() => _PaytmSDKState();
// }

// class _PaytmSDKState extends State<PaytmSDK> {
//   String OrderNumber6 = '';
//   String payment_response;

//   //Live
//   String mid = "xmHOCa32667710380797";
//   // String PAYTM_MERCHANT_KEY = "LIVE_KEY_HERE";
//   String website = "DEFAULT";
//   bool testing = false;

//   //Testing
//   // String mid = "TEST_MID_HERE";
//   // String PAYTM_MERCHANT_KEY = "TEST_KEY_HERE";
//   // String website = "WEBSTAGING";
//   // bool testing = true;

//   double amount = 1;
//   bool loading = false;

//   @override
//   void initState() {
//     super.initState();
//     get6DigitNumber();
//   }

//   String get6DigitNumber() {
//     Random random = Random();
//     String number = '';

//     for (int i = 0; i < 6; i++) {
//       number = number + random.nextInt(9).toString();
//       OrderNumber6 = number;
//     }
//     return OrderNumber6;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Paytm example app'),
//         ),
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.all(10.0),
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.stretch,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: <Widget>[
//                 Text(
//                     'For Testing Credentials make sure appInvokeEnabled set to FALSE or Paytm APP is not installed on the device.'),

//                 SizedBox(
//                   height: 10,
//                 ),

//                 TextField(
//                   onChanged: (value) {
//                     mid = value;
//                   },
//                   decoration: InputDecoration(hintText: "Enter MID here"),
//                   keyboardType: TextInputType.text,
//                 ),
//                 // TextField(
//                 //   onChanged: (value) {
//                 // //    PAYTM_MERCHANT_KEY = value;
//                 //   },
//                 //   decoration:
//                 //       InputDecoration(hintText: "Enter Merchant Key here"),
//                 //   keyboardType: TextInputType.text,
//                 // ),
//                 TextField(
//                   onChanged: (value) {
//                     website = value;
//                   },
//                   decoration: InputDecoration(
//                       hintText: "Enter Website here (Probably DEFAULT)"),
//                   keyboardType: TextInputType.text,
//                 ),
//                 TextField(
//                   onChanged: (value) {
//                     try {
//                       amount = double.tryParse(value);
//                     } catch (e) {
//                       print(e);
//                     }
//                   },
//                   decoration: InputDecoration(hintText: "Enter Amount here"),
//                   keyboardType: TextInputType.number,
//                 ),
//                 SizedBox(
//                   height: 10,
//                 ),
//                 payment_response != null
//                     ? Text('Response: $payment_response\n')
//                     : Container(),
// //                loading
// //                    ? Center(
// //                        child: Container(
// //                            width: 50,
// //                            height: 50,
// //                            child: CircularProgressIndicator()),
// //                      )
// //                    : Container(),
//                 RaisedButton(
//                   onPressed: () {
//                     //Firstly Generate CheckSum bcoz Paytm Require this
//                     generateTxnToken(0);
//                   },
//                   color: Colors.blue,
//                   child: Text(
//                     "Pay using Wallet",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 RaisedButton(
//                   onPressed: () {
//                     //Firstly Generate CheckSum bcoz Paytm Require this
//                     generateTxnToken(1);
//                   },
//                   color: Colors.blue,
//                   child: Text(
//                     "Pay using Net Banking",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 RaisedButton(
//                   onPressed: () {
//                     //Firstly Generate CheckSum bcoz Paytm Require this
//                     generateTxnToken(2);
//                   },
//                   color: Colors.blue,
//                   child: Text(
//                     "Pay using UPI",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//                 RaisedButton(
//                   onPressed: () {
//                     //Firstly Generate CheckSum bcoz Paytm Require this
//                     generateTxnToken(3);
//                   },
//                   color: Colors.blue,
//                   child: Text(
//                     "Pay using Credit Card",
//                     style: TextStyle(color: Colors.white),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   void generateTxnToken(int mode) async {
//     setState(() {
//       loading = true;
//     });
//     String orderId = "ORDERID_423562";
//     //DateTime.now().millisecondsSinceEpoch.toString();

//     String callBackUrl =
//         'https://securegw.paytm.in/theia/paytmCallback?ORDER_ID=ORDERID_423562';
//     // (testing
//     //         ? 'https://securegw-stage.paytm.in'
//     //         : 'https://securegw.paytm.in') +
//     //     '/theia/paytmCallback?ORDER_ID=' +
//     //     "ORDERID_423562";

//     //Host the Server Side Code on your Server and use your URL here. The following URL may or may not work. Because hosted on free server.
//     //Server Side code url: https://github.com/mrdishant/Paytm-Plugin-Server

//     var url = 'https://developer.balleballe11.in/paytm/generateChecksum.php';

//     // var body = json.encode({
//     //   "mid": mid,
//     //   // "key_secret": PAYTM_MERCHANT_KEY,
//     //   "website": website,
//     //   "orderId": "ORDERID_423562",
//     //   "amount": amount.toString(),
//     //   "callbackUrl": callBackUrl,
//     //   "custId": "122",
//     //   "mode": mode.toString(),
//     //   "testing": testing ? 0 : 1
//     // });

//     String getMap(double amount, String callbackUrl, String orderId) {
//       return json.encode({
//         "mid": mid,
//         "ORDER_ID": "ORDERID_423562",
//         //    "key_secret": mKey,
//         "website": website,
//         // "amount": amount.toString(),
//         "callbackUrl": callbackUrl,
//         "CHANNEL_ID": "WAP",
//         "CUST_ID": "CUST_00OBQDUYUM",
//         "EMAIL": "amangupta723@gmail.com",
//         "INDUSTRY_TYPE_ID": "Retail",
//         "MOBILE_NO": "9026888006",
//         "TXN_AMOUNT": amount,
//       });
//     }

//     try {
//       final response = await http.post(
//         Uri.parse(url),
//         body: getMap(amount, callBackUrl, "ORDERID_423562"),
//         headers: {'Content-type': "application/json"},
//       );

//       print("Response is");
//       print(response.body);
//       String txnToken = response.body;
//       setState(() {
//         payment_response = txnToken;
//       });

//       var paytmResponse = Paytm.payWithPaytm(
//           mId: mid,
//           orderId: "ORDERID_423562",
//           txnToken: "txnToken",
//           txnAmount: amount.toString(),
//           callBackUrl: callBackUrl,
//           staging: testing,
//           appInvokeEnabled: false);

//       paytmResponse.then((value) {
//         print(value);
//         setState(() {
//           loading = false;
//           print("Value is ");
//           print(value);
//           if (value['error']) {
//             payment_response = value['errorMessage'];
//           } else {
//             if (value['response'] != null) {
//               payment_response = value['response']['STATUS'];
//             }
//           }
//           payment_response += "\n" + value.toString();
//         });
//       });
//     } catch (e) {
//       print(e);
//     }
//   }
// }



// // import 'dart:async';
// // import 'dart:convert' as convert;
// // import 'dart:math';

// // import 'package:balleballe11/apiService/dioClient.dart';
// // import 'package:balleballe11/model/checksum.Model.dart';
// // import 'package:flutter/material.dart';
// // import 'package:flutter/services.dart';
// // //import 'package:http/http.dart' as http;
// // import 'package:paytm_allinonesdk/paytm_allinonesdk.dart';
// // import 'package:http/http.dart' as http;

// // class payScreen extends StatefulWidget {
// //   @override
// //   State<StatefulWidget> createState() {
// //     return _payScreenState();
// //   }
// // }

// // class _payScreenState extends State<payScreen> {
// //   String mid = "xmHOCa32667710380797", orderId = "404012", amount = "300";
// //   String result = "";
// //   bool isStaging = true;
// //   bool isApiCallInProgress = false;
// //   String callbackUrl = '';
// //   //  "securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=404012';
// //   bool restrictAppInvoke = false;
// //   String OrderNumber6 = '';
// //   String transactionTokenNumber = '';

// //   @override
// //   void initState() {
// //     print("initState");
// //     super.initState();
// //      get6DigitNumber();
// //     get6TransactionTokenNumber();
// //   }

// //   //below function used to generate txnToken calling api
// //   Future<String> fetchCheckSum() async {
// //     String txnToken = "";
// //     final response = await DioClient.getMyDioClient().post(
// //       "https://desolate-anchorage-29312.herokuapp.com/generateTxnToken",
// //       //  "https://developer.balleballe11.in/paytm/generateChecksum.php",
// //         data: {'ORDER_ID': '$orderId'});

// //     if (response.statusCode == 200) {
// //       var jsonResponse = CheckSumModel.fromJson(response.data);
// //       txnToken = jsonResponse.checksumhash;
// //     } else {
// //       print('Request failed with status: ${response.statusCode}.');
// //       txnToken = "";
// //     }
// //     print(txnToken);
// //     return txnToken;
// //   }

// //   String get6DigitNumber() {
// //     Random random = Random();
// //     String number = '';

// //     for (int i = 0; i < 6; i++) {
// //       number = number + random.nextInt(9).toString();
// //       OrderNumber6 = number;
// //     }
// //     return OrderNumber6;
// //   }

// //   String get6TransactionTokenNumber() {
// //     Random random = Random();
// //     String transactionNumber = '';

// //     for (int i = 0; i < 6; i++) {
// //       transactionNumber = transactionNumber + random.nextInt(9).toString();
// //       transactionTokenNumber = transactionNumber;
// //     }
// //     return transactionTokenNumber;
// //   }


// //   @override
// //   Widget build(BuildContext context) {
// //     return Card(
// //       child: SingleChildScrollView(
// //         child: Container(
// //           margin: EdgeInsets.all(8),
// //           child: Column(
// //             children: <Widget>[
// //               EditText('Merchant ID', mid, onChange: (val) => mid = val),
// //               EditText('Order ID', orderId, onChange: (val) => orderId = val),
// //               EditText('Amount', amount, onChange: (val) => amount = val),
// //               Row(
// //                 children: <Widget>[
// //                   Checkbox(
// //                       activeColor: Theme.of(context).buttonColor,
// //                       value: isStaging,
// //                       onChanged: (bool val) {
// //                         setState(() {
// //                           isStaging = val;
// //                         });
// //                       }),
// //                   Text("Staging")
// //                 ],
// //               ),
// //               Row(
// //                 children: <Widget>[
// //                   Checkbox(
// //                       activeColor: Theme.of(context).buttonColor,
// //                       value: restrictAppInvoke,
// //                       onChanged: (bool val) {
// //                         setState(() {
// //                           restrictAppInvoke = val;
// //                         });
// //                       }),
// //                   Text("Restrict AppInvoke")
// //                 ],
// //               ),
// //               Container(
// //                 margin: EdgeInsets.all(16),
// //                 child: RaisedButton(
// //                   onPressed: isApiCallInProgress
// //                       ? null
// //                       : () {
// //                           _startTransaction(mid, "145035", "300","securegw-stage.paytm.in/theia/paytmCallback?ORDER_ID=404012", true, false);
// //                         },
// //                   child: Text('Start Transcation'),
// //                 ),
// //               ),
// //               Container(
// //                 alignment: Alignment.bottomLeft,
// //                 child: Text("Message : "),
// //               ),
// //               Container(
// //                 child: Text(result),
// //               ),
// //             ],
// //           ),
// //         ),
// //       ),
// //     );
// //   }

// //   Future<void> _startTransaction(String mid, String orderId, String amount, String callbackUrl, bool isStaging, bool restrickAppInvoke) async {
// //     var txnToken = await fetchCheckSum();
// //     print("MyTokenIS: $txnToken");
// //     if (txnToken.isEmpty) {
// //       return;
// //     }
// //     try {
// //       //amOZIA74653507854205
// //       var response = AllInOneSdk.startTransaction(
// //           mid, orderId, amount, txnToken, callbackUrl, isStaging, restrictAppInvoke);
// //       response.then((value) {
// //         print(value);
// //         setState(() {
// //           result = value.toString();
// //         });
// //       }).catchError((onError) {
// //         if (onError is PlatformException) {
// //           setState(() {
// //             result = onError.message + " \n  " + onError.details.toString();
// //           });
// //         } else {
// //           setState(() {
// //             result = onError.toString();
// //           });
// //         }
// //       });
// //     } catch (err) {
// //       result = err.message;
// //     }
// //   }
// // }

// // class EditText extends StatelessWidget {
// //   final String text, value;
// //   final Function onChange;
// //   EditText(this.text, this.value, {this.onChange});

// //   @override
// //   Widget build(BuildContext context) {
// //     return Column(
// //       children: <Widget>[
// //         Container(
// //           child: Text(
// //             text,
// //             style: TextStyle(fontSize: 18),
// //           ),
// //           alignment: Alignment.bottomLeft,
// //           margin: EdgeInsets.fromLTRB(12, 8, 0, 0),
// //         ),
// //         Container(
// //           margin: EdgeInsets.fromLTRB(12, 8, 12, 8),
// //           child: TextField(
// //             controller: TextEditingController(text: value),
// //             onChanged: onChange,
// //             decoration: InputDecoration(
// //               hintText: 'Enter ${text}',
// //               fillColor: Colors.white,
// //               contentPadding: EdgeInsets.fromLTRB(8, 0, 8, 0),
// //               border: OutlineInputBorder(
// //                 borderRadius: BorderRadius.circular(3),
// //               ),
// //             ),
// //           ),
// //         ),
// //       ],
// //     );
// //   }
// // }
