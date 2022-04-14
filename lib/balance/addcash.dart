import 'dart:convert';
import 'dart:developer' as log;
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/add_money_model.dart' as addmoneyModel;
import 'package:balleballe11/model/checksum.Model.dart';
import 'package:balleballe11/model/get_mywallet_model.dart';
import 'package:balleballe11/model/razorpay_order_id.dart';
import 'package:balleballe11/widget/appException.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class AddCash extends StatefulWidget {
  num walletbalance;
  num prizeAmount;

  AddCash({
    Key key,
    this.walletbalance,
    this.prizeAmount,
  }) : super(key: key);

  @override
  _AddCashState createState() => _AddCashState();
}

class _AddCashState extends State<AddCash> {
  WalletInfo _myWalletData = WalletInfo();
  bool _isProgressRunning = false;
  String OrderNumber6 = '';
  String transactionTokenNumber = '';
  Razorpay _razorPayGateWay;
  bool is100Selected = false,
      is200Selected = false,
      is300Selected = false,
      is500Selected = false;
  TextEditingController _amountController = TextEditingController();
  bool isProgressRunning = false;
  String orderId, paymentId, signature;
  final String razorMid = "rzp_live_3ixnSFQ94q8DFZ";
  // orderId,

  // Paytm

  String result = '';

  final String _mid = "xmHOCa32667710380797";
  //final String _mKey = "yTLERZNH&SQd2@cu";
  final String _website =
      "DEFAULT"; // "DEFAULT" , "WEBSTAGING" or "WEBSTAGING" in Testing
  final String _url =
      'https://developer.balleballe11.in/paytm/generateChecksum.php'; // Add your own backend URL

  String get mid => _mid;
//  String get mKey => _mKey;
  String get website => _website;
  String get url => _url;

  String getMap(double amount, String callbackUrl, String orderId) {
    return json.encode({
      "mid": mid,
      "ORDER_ID": orderId,
      //    "key_secret": mKey,
      "website": website,
      // "amount": amount.toString(),
      "callbackUrl": callbackUrl,
      "CHANNEL_ID": "WAP",
      "CUST_ID": "CUST_00OBQDUYUM",
      "EMAIL": "amangupta723@gmail.com",
      "INDUSTRY_TYPE_ID": "Retail",
      "MOBILE_NO": "9026888006",
      "TXN_AMOUNT": amount,
    });
  }

  // Generate Order Id 6 Digit Random Number

  String get6DigitNumber() {
    Random random = Random();
    String number = '';

    for (int i = 0; i < 6; i++) {
      number = number + random.nextInt(9).toString();
      OrderNumber6 = number;
    }
    return OrderNumber6;
  }

  String get6TransactionTokenNumber() {
    Random random = Random();
    String transactionNumber = '';

    for (int i = 0; i < 6; i++) {
      transactionNumber = transactionNumber + random.nextInt(9).toString();
      transactionTokenNumber = transactionNumber;
    }
    return transactionTokenNumber;
  }

  @override
  void initState() {
    super.initState();
    get6DigitNumber();
    get6TransactionTokenNumber();

    _razorPayGateWay = Razorpay();
    _razorPayGateWay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorPayGateWay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorPayGateWay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print("Response Success ${response}");

    orderId = response.orderId;
    paymentId = response.paymentId;
    signature = response.signature;
    print("ORDERID :: ${response.orderId}");
    print("PAYMENT ID :: ${response.paymentId}");
    print("SIGNATURE :: ${response.signature}");
    Future.delayed(Duration.zero, () {
      _addMoneyIntoWallet();
    });
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    UtilsFlushBar.showDefaultSnackbar(context, "Transaction Failed");
    print(response.message);
    print("Error code :: ${response.code}");
    print("Error Message :: ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print("External wallet name :: ${response.walletName}");
  }

  Future<void> _createNewOrder() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      Razorpayorderid myOrderDetails = await APIServices.razorPayOrderId(
          num.parse(_amountController.text) * 100);
      if (myOrderDetails != null &&
          myOrderDetails.orderId != null &&
          myOrderDetails.status) {
        log.log("${myOrderDetails.orderId} ", name: "orderId");
        await openPaymentOption(myOrderDetails.orderId);
      }
    } catch (e) {
      showErrorDialog(context, e);
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  Future<void> openPaymentOption(String orderId) async {
    var options = {
      "key": razorMid,
      "order_id": orderId,
      "amount": (num.parse(_amountController.text) * 100),
      "name": "balleballe11",
      "description": "Adding amount to play balleballe11",
      "currency": "INR",
      "prefill": {
        "contact": SharedPreference.getValue(PrefConstants.USER_MOB_NO),
        "email": SharedPreference.getValue(PrefConstants.USER_EMAIL)
      },
      'external': {
        'wallets': ['paytm']
      },
      "theme.colors": "#FCF7FE",
    };
    try {
      _razorPayGateWay.open(options);
    } catch (e) {
      print(e);
    }
  }

  @override
  void dispose() {
    super.dispose();
    _razorPayGateWay.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.COLOR_WHITE,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.BACKGROUND_COLOR,
          appBar: AppBar(
            backgroundColor: ColorConstant.COLOR_WHITE,
            leading: InkWell(
              onTap: () {
                Navigator.pop(context);
              },
              child: Icon(
                Icons.arrow_back,
                size: 25,
                color: ColorConstant.COLOR_TEXT,
              ),
            ),
            title: Text(
              "Add Cash",
              style: Theme.of(context).textTheme.headline6.copyWith(
                    color: ColorConstant.COLOR_TEXT,
                    fontWeight: FontWeight.w500,
                  ),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(30),
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 10.0, right: 10, bottom: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Current Balance",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                    Text(
                      "₹${widget.walletbalance ?? 0}",
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          bottomNavigationBar: Padding(
            padding: const EdgeInsets.only(left: 5.0, right: 5),
            child: MaterialButton(
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      'ADD CASH',
                      style: TextStyle(
                          fontSize: 18.0,
                          color: ColorConstant.COLOR_WHITE,
                          fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
              onPressed: () async {
                if (_amountController.text.isEmpty) {
                  UtilsFlushBar.showDefaultSnackbar(
                      context, "Please enter Amount");
                } else {
                  await _createNewOrder();
                }
              },
              color: ColorConstant.COLOR_TEXT,
            ),
          ),
          // bottomSheet: Container(
          //   height: MediaQuery.of(context).size.height * 0.2,
          //   child: Column(
          //     children: [
          //       Container(
          //         width: double.infinity,
          //         decoration: BoxDecoration(
          //             borderRadius: BorderRadius.all(Radius.circular(10))),
          //         child: ElevatedButton(
          //           style: ElevatedButton.styleFrom(
          //             primary: ColorConstant.COLOR_TEXT, // background
          //             onPrimary: ColorConstant.COLOR_WHITE, // foreground
          //           ),
          //           onPressed: () async {
          //             await _createNewOrder();
          //           },
          //           child: Padding(
          //             padding: const EdgeInsets.only(top: 15.0, bottom: 15),
          //             child: Text(
          //               'ADD CASH',
          //               style: Theme.of(context).textTheme.subtitle1.copyWith(
          //                     color: ColorConstant.COLOR_WHITE,
          //                     fontWeight: FontWeight.bold,
          //                   ),
          //             ),
          //           ),
          //         ),
          //       ),
          //       const SizedBox(height: 20),
          //       Text(
          //         "We do not allow players from Telangana, Orissa, Sikkim, Nagaland and Assam to play cash games. You must be 18+ years to play real money skill games",
          //         style: Theme.of(context).textTheme.caption.copyWith(
          //               color: ColorConstant.COLOR_TEXT,
          //               fontWeight: FontWeight.w400,
          //             ),
          //       )
          //     ],
          //   ),
          // ),
          body: SingleChildScrollView(
            child: Container(
              color: ColorConstant.BACKGROUND_COLOR,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                          color: ColorConstant.COLOR_WHITE),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 10.0, right: 10, top: 10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              AppLocalizations.of("Amount to Add"),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              height: 50,
                              child: TextFormField(
                                controller: _amountController,
                                //  maxLength: 10,
                                keyboardType: TextInputType.numberWithOptions(
                                    signed: true, decimal: true),
                                decoration: new InputDecoration(
                                    filled: true,
                                    focusedBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConstant.COLOR_BLUE3,
                                          width: 1.5),
                                    ),
                                    enabledBorder: const OutlineInputBorder(
                                      borderSide: const BorderSide(
                                          color: ColorConstant.COLOR_BLUE3,
                                          width: 1),
                                    ),
                                    errorBorder: InputBorder.none,
                                    disabledBorder: InputBorder.none,
                                    hintText: "Amount",
                                    hintStyle: TextStyle(
                                        color: ColorConstant.COLOR_BLACK,
                                        fontSize: 14.0),
                                    fillColor: ColorConstant.COLOR_WHITE),
                              ),
                            ),
                            const SizedBox(
                              height: 13,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Flexible(
                                  child: MaterialButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '100',
                                          // style: Theme.of(context).textTheme.bodyText1,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                              color: is100Selected
                                                  ? ColorConstant.COLOR_WHITE
                                                  : ColorConstant.COLOR_TEXT),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        is100Selected = !is100Selected;
                                        if (is100Selected) {
                                          _amountController.text = "100";
                                        } else {
                                          _amountController.text = "";
                                        }
                                        is200Selected = false;
                                        is300Selected = false;
                                        is500Selected = false;
                                      });
                                      // Navigator.pushNamed(context, '/accept');
                                    },
                                    // color: Theme.of(context).buttonColor,
                                    color: is100Selected
                                        ? ColorConstant.COLOR_TEXT
                                        : ColorConstant.COLOR_WHITE,
                                    shape: new RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: is100Selected
                                              ? ColorConstant.COLOR_WHITE
                                              : ColorConstant.COLOR_TEXT),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: MaterialButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '200',
                                          // style: Theme.of(context).textTheme.bodyText1,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                              color: is200Selected
                                                  ? ColorConstant.COLOR_WHITE
                                                  : ColorConstant.COLOR_TEXT),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      setState(() {
                                        is200Selected = !is200Selected;
                                        if (is200Selected) {
                                          _amountController.text = "200";
                                        } else {
                                          _amountController.text = "";
                                        }
                                        is100Selected = false;
                                        is300Selected = false;
                                        is500Selected = false;
                                      });
                                      // Navigator.pushNamed(context, '/accept');
                                    },
                                    // color: Theme.of(context).buttonColor,
                                    color: is200Selected
                                        ? ColorConstant.COLOR_TEXT
                                        : ColorConstant.COLOR_WHITE,
                                    shape: new RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: is200Selected
                                              ? ColorConstant.COLOR_WHITE
                                              : ColorConstant.COLOR_TEXT),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: MaterialButton(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '300',
                                          // style: Theme.of(context).textTheme.bodyText1,
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                              color: is300Selected
                                                  ? ColorConstant.COLOR_WHITE
                                                  : ColorConstant.COLOR_TEXT),
                                        ),
                                        //Icon(Icons.arrow_forward_sharp)
                                      ],
                                    ),
                                    onPressed: () {
                                      //Navigator.pushNamed(context, '/accept');
                                      setState(() {
                                        is300Selected = !is300Selected;
                                        if (is300Selected) {
                                          _amountController.text = "300";
                                        } else {
                                          _amountController.text = "";
                                        }
                                        is200Selected = false;
                                        is100Selected = false;
                                        is500Selected = false;
                                      });
                                    },
                                    color: is300Selected
                                        ? ColorConstant.COLOR_TEXT
                                        : ColorConstant.COLOR_WHITE,
                                    shape: new RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: is300Selected
                                              ? ColorConstant.COLOR_WHITE
                                              : ColorConstant.COLOR_TEXT),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: MaterialButton(
                                    minWidth: 20,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          '500',
                                          style: TextStyle(
                                              fontSize: 16.0,
                                              fontWeight: FontWeight.w700,
                                              color: is500Selected
                                                  ? ColorConstant.COLOR_WHITE
                                                  : ColorConstant.COLOR_TEXT),
                                        ),
                                      ],
                                    ),
                                    onPressed: () {
                                      // Navigator.pushNamed(context, '/accept');
                                      setState(() {
                                        is500Selected = !is500Selected;
                                        if (is500Selected) {
                                          _amountController.text = "500";
                                        } else {
                                          _amountController.text = "";
                                        }
                                        is200Selected = false;
                                        is100Selected = false;
                                        is300Selected = false;
                                      });
                                    },
                                    color: is500Selected
                                        ? ColorConstant.COLOR_TEXT
                                        : ColorConstant.COLOR_WHITE,
                                    shape: new RoundedRectangleBorder(
                                      side: BorderSide(
                                          color: is500Selected
                                              ? ColorConstant.COLOR_WHITE
                                              : ColorConstant.COLOR_TEXT),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                    //
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _addMoneyIntoWallet() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      addmoneyModel.AddMoneyModel commonResponse =
          await APIServices.addMoneyIntoWallet(
        num.parse(_amountController.text),
        orderId,
        paymentId,
        signature,
      );
      showAlertDialog(context, commonResponse.message);
      if (commonResponse.status != null && commonResponse.status) {
        await getWalletData();
      }
    } catch (e) {
      showErrorDialog(context, e);
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  // Get Wallet Api Method

  Future<void> getWalletData() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      GetWalletModel myWalletResp = await APIServices.getWallet();

      if (myWalletResp.status != null && myWalletResp.walletInfo != null) {
        setState(() {
          _myWalletData = myWalletResp.walletInfo;

          SharedPreference.setValue(
              PrefConstants.WALLET_AMOUNT, _myWalletData.walletAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.BONUS_AMOUNT, _myWalletData.bonusAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.WINNING_AMOUNT, _myWalletData.prizeAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.DEPOSIT_AMOUNT, _myWalletData.depositAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.PRIZE_AMOUNT, _myWalletData.prizeAmount ?? 0);
          SharedPreference.setValue(PrefConstants.VERIFY_EMAIL_ADDRESS,
              _myWalletData.isAccountVerified.emailVerified);

          SharedPreference.setValue(
              PrefConstants.BankName, _myWalletData.bankName);
          SharedPreference.setValue(
              PrefConstants.BankAccontNumber, _myWalletData.bankAccountNumber);
          SharedPreference.setValue(PrefConstants.AFFILIATE_COMMISSION,
              _myWalletData.affiliateCommission ?? 0);
          SharedPreference.setValue(PrefConstants.REFFERAL_COUNT,
              _myWalletData.refferalFriendsCount ?? 0);
          SharedPreference.setValue(
              PrefConstants.EXTRA_AMOUNT, _myWalletData.extraCash ?? 0);

          if (_myWalletData != null &&
              // _myWalletData.bonusAmount != null &&
              _myWalletData.prizeAmount != null &&
              _myWalletData.depositAmount != null &&
              _myWalletData.bonusAmount != null) {
            // totalAmount = (_myWalletData.depositAmount +
            //     _myWalletData.prizeAmount +
            //     _myWalletData.bonusAmount);
            // SharedPreference.setValue(PrefConstants.TOTAL_AMOUNT, totalAmount);
          }
        });
      }
    } catch (error) {
      showErrorDialog(context, error);
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  showAlertDialog(BuildContext context, String message) {
    //  set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => HomeScreen()));
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
