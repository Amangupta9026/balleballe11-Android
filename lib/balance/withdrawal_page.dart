import 'package:balleballe11/constance/packages.dart';
import 'package:flutter/material.dart';

import '../model/withdrawal_model.dart';

class WithdrawPage extends StatefulWidget {
  String bankNumber;
  String bankName;
  WithdrawPage({this.bankNumber, this.bankName});

  // final BankAccountDocuments bankAccountDocuments;

  // const WithdrawPage({this.bankAccountDocuments});

  _WithdrawPageState createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  TextEditingController _amountController = TextEditingController();
  bool paytm = true, bank = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isProgressRunning = false;

  TextEditingController paytmController = TextEditingController();
  String paytmNumber = '';
  bool Visibilepaytm = false;

  WithDrawalModel commonResponseModel;

  @override
  void initState() {
    super.initState();
  }

  Future<void> _apiWithdrawalAmount(BuildContext context) async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      double withdrawalAmount = double.parse(_amountController.text);
      commonResponseModel = await APIServices.getwithDraw(
        paytm ? "paytm" : "bank_account",
        withdrawalAmount,
        paytmController.text,
      );
      if (commonResponseModel.status) {
        UtilsFlushBar.showDefaultSnackbar(context, commonResponseModel.message);

        setState(() {
          paytm = true;
          bank = false;
        });
        _amountController.text = "";
        Navigator.pop(context, true);
      } else {
        showCommonMessageDialog(context, commonResponseModel.message);
      }
    } catch (e) {
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: ColorConstant.COLOR_WHITE,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: false,
        backgroundColor: ColorConstant.COLOR_WHITE,
        title: Text(
          AppLocalizations.of('Withdraw'),
          style: Theme.of(context).textTheme.caption.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontSize: 18.0,
                fontWeight: FontWeight.w700,
              ),
        ),
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_TEXT,
          ),
        ),
      ),
      body: ProgressContainerView(
        isProgressRunning: isProgressRunning,
        child: SingleChildScrollView(
          physics: ClampingScrollPhysics(),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [_otherDetailsCard()],
            ),
          ),
        ),
      ),
      bottomNavigationBar: InkWell(
        onTap: () async {
          if (paytmController.text.isEmpty &&
              paytmController.text.length != 10) {
            UtilsFlushBar.showDefaultSnackbar(
                context, "Please Enter Paytm Number.");
            return;
          }
          if (_amountController.text.isEmpty) {
            UtilsFlushBar.showDefaultSnackbar(
                context, "Please enter the withdrawal amount.");

            return;
          }
          double withdrawalAmount = double.parse(_amountController.text);

          if (paytm) {
            if (withdrawalAmount < 200) {
              UtilsFlushBar.showDefaultSnackbar(
                  context, "Withdrawal Amount cannot be less than 200 RS.");
            } else if (SharedPreference.getValue(
                        PrefConstants.WINNING_AMOUNT) >=
                    200 &&
                SharedPreference.getValue(PrefConstants.WINNING_AMOUNT) >=
                    withdrawalAmount &&
                withdrawalAmount >= 200) {
              await _apiWithdrawalAmount(context);
              showAlertDialog(context, commonResponseModel.message);
            } else if (withdrawalAmount > 5000) {
              UtilsFlushBar.showDefaultSnackbar(
                  context, "Withdrawal Amount cannot be grater than 5000 RS.");
            } else {
              await _apiWithdrawalAmount(context);
            }
          } else if (bank) {
            if (withdrawalAmount < 1000) {
              UtilsFlushBar.showDefaultSnackbar(context,
                  "Withdrawal Amount cannot be less than 1000 RS for bank Account.");
            } else if (SharedPreference.getValue(
                        PrefConstants.WINNING_AMOUNT) >=
                    1000 &&
                SharedPreference.getValue(PrefConstants.WINNING_AMOUNT) >=
                    withdrawalAmount &&
                withdrawalAmount >= 1000) {
              await _apiWithdrawalAmount(context);
              showAlertDialog(context, commonResponseModel.message);
            } else if (withdrawalAmount > 25000) {
              UtilsFlushBar.showDefaultSnackbar(context,
                  "Withdrawal Amount cannot be grater than 25,000 RS for bank Account.");
            } else {
              await _apiWithdrawalAmount(context);
            }
          }
        },
        child: Card(
          elevation: 0.0,
          child: Container(
            height: 50.0,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: ColorConstant.COLOR_GREEN2,
            ),
            child: Center(
              child: Text(
                AppLocalizations.of('WITHDRAWAL'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: ColorConstant.COLOR_WHITE,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _otherDetailsCard() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                AppLocalizations.of('Your Winnings Amount'),
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontSize: 16.0,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  "₹ ${SharedPreference.getValue(PrefConstants.WINNING_AMOUNT)}",
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _amountController,
            maxLength: 10,
            keyboardType:
                TextInputType.numberWithOptions(signed: true, decimal: true),
            decoration: new InputDecoration(
              filled: true,
              counterText: "",
              focusedBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstant.COLOR_TEXT, width: 1.2),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide:
                    BorderSide(color: ColorConstant.COLOR_TEXT, width: 1.2),
              ),
              disabledBorder: InputBorder.none,
              hintText: "₹ 0.0",
              hintStyle: TextStyle(
                  color: ColorConstant.COLOR_GREY,
                  fontSize: 18.0,
                  fontWeight: FontWeight.w600),
              fillColor: ColorConstant.COLOR_WHITE,
            ),
          ),
          SizedBox(height: 8.0),
          Text(
            "Min Withdrawal ₹200",
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: ColorConstant.COLOR_PINK,
                  fontSize: 16.0,
                  fontWeight: FontWeight.w500,
                ),
          ),
          SizedBox(height: 8.0),
          Container(
            width: double.infinity,
            color: Color(0xfff5f5f5),
            child: Padding(
              padding: const EdgeInsets.only(top: 5.0, bottom: 5),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        paytm = true;
                      });
                    },
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: paytm,
                      activeColor: ColorConstant.COLOR_TEXT,
                      onChanged: (bool value) {
                        setState(() {
                          paytm = value;
                          bank = false;

                          //  bank = false;
                        });
                      },
                    ),
                  ),
                  Text(
                    "PayTm",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                  SizedBox(width: 30.0),
                  InkWell(
                    onTap: () {
                      setState(() {
                        bank = true;
                      });
                    },
                    child: Checkbox(
                      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      value: bank,
                      activeColor: ColorConstant.COLOR_TEXT,
                      onChanged: (bool value) {
                        setState(() {
                          bank = value;
                          paytm = false;
                        });
                      },
                    ),
                  ),
                  Text(
                    "Bank",
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w500,
                        ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 14.0),

          // Paytm Click Visibility

          Visibility(
              visible: paytm == true,
              child: Container(
                width: double.infinity,
                color: Color(0xfff5f5f5),
                child: Padding(
                  padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                  child: Row(
                    children: [
                      Text(
                        "Paytm No: ",
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      if (paytmController.text.isNotEmpty &&
                          paytmController.text.length == 10)
                        Text(
                          paytmController.text,
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500,
                              ),
                        )
                      else
                        Text(""),

                      // Visibility(
                      //   visible:
                      //   child: child)

                      SizedBox(width: 14.0),
                      InkWell(
                        onTap: () {
                          showPaytmAlertDialog(context);
                        },
                        child: Icon(
                          Icons.edit,
                          color: ColorConstant.COLOR_TEXT,
                          size: 24,
                        ),
                      ),
                    ],
                  ),
                ),
              )),

          // Bank Click Visibility

          Visibility(
              visible: bank == true,
              child: Container(
                width: double.infinity,
                color: Color(0xfff5f5f5),
                child: Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, top: 10, bottom: 5),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Account No:",
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: ColorConstant.COLOR_GREY,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "${widget.bankNumber ?? ""}",
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w900,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Row(
                        children: [
                          Text(
                            "Bank Name:",
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: ColorConstant.COLOR_GREY,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(width: 10.0),
                          Text(
                            "${widget.bankName ?? ""}",
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w900,
                                    ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )),

          SizedBox(height: 14.0),
          Container(
            decoration: BoxDecoration(
              color: ColorConstant.COLOR_WHITE,
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 8, top: 5.0, bottom: 1),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    color: ColorConstant.COLOR_BLUE3,
                    width: double.infinity,
                    child: Padding(
                      padding:
                          const EdgeInsets.only(left: 8, top: 8.0, bottom: 8),
                      child: Text(
                        "NOTE: ",
                        style: TextStyle(
                          letterSpacing: 0.2,
                          fontWeight: FontWeight.w800,
                          fontSize: 14.0,
                          color: ColorConstant.COLOR_WHITE,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10.0),
                  Container(
                    width: double.infinity,
                    color: Color(0xfff5f5f5),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: Text(
                        "[1]. Paytm min : 200 and Maximum : 5000",
                        style: TextStyle(
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: ColorConstant.COLOR_TEXT),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "[2]. Bank min : 1000 and Maximum : 25,000",
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: ColorConstant.COLOR_TEXT),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    color: Color(0xfff5f5f5),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: Text(
                        "[3]. NO KYC for PAYTM withdrawal",
                        style: TextStyle(
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: ColorConstant.COLOR_TEXT),
                      ),
                    ),
                  ),
                  SizedBox(height: 8.0),
                  Text(
                    "[4]. Bank Withdrawal KYC Required bank proofs",
                    style: TextStyle(
                        letterSpacing: 0.2,
                        fontWeight: FontWeight.w400,
                        fontSize: 14.0,
                        color: ColorConstant.COLOR_TEXT),
                  ),
                  SizedBox(height: 8.0),
                  Container(
                    width: double.infinity,
                    color: Color(0xfff5f5f5),
                    child: Padding(
                      padding: const EdgeInsets.only(top: 5.0, bottom: 5),
                      child: Text(
                        "[5]. Tamil NAdu, Andhra Pradesh, Odisha and Telangana users are not allowed to play or withdraw money",
                        style: TextStyle(
                            letterSpacing: 0.2,
                            fontWeight: FontWeight.w400,
                            fontSize: 14.0,
                            color: ColorConstant.COLOR_TEXT),
                      ),
                    ),
                  ),
                  SizedBox(height: 5.0),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _getBankDetailsCard() {
    //  String bankAccountNumber = widget.bankAccountDocuments.bankAccountNumber;
    //  String secure = bankAccountNumber.replaceAll(RegExp(r'.(?=.{4})'), '*');

    return Card(
      elevation: 2.0,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            // widget.bankAccountDocuments.ifscCode ? "dd" :
            // if (widget.bankAccountDocuments.ifscCode != null &&
            //     widget.bankAccountDocuments.ifscCode.contains('SBI'))
            //   Image.asset(
            //     IconImgConstants.SBI_LOGO,
            //     height: 40.0,
            //     width: 40.0,
            //   )

            // else if (widget.bankAccountDocuments.ifscCode != null &&
            //     widget.bankAccountDocuments.ifscCode.contains('ORBC'))
            //   Image.asset(
            //     IconImgConstants.ORIENTAL_LOGO,
            //     height: 40.0,
            //     width: 40.0,
            //   )
            // else if (widget.bankAccountDocuments.ifscCode != null &&
            //     widget.bankAccountDocuments.ifscCode.contains('PUNB'))
            //   Image.asset(
            //     IconImgConstants.PNB_LOGO,
            //     height: 40.0,
            //     width: 40.0,
            //   )
            // else if (widget.bankAccountDocuments.ifscCode != null &&
            //     widget.bankAccountDocuments.ifscCode.contains('HDFC'))
            //   Image.asset(
            //     IconImgConstants.HDFC_LOGO,
            //     height: 40.0,
            //     width: 40.0,
            //   )
            // else if (widget.bankAccountDocuments.ifscCode != null &&
            //     widget.bankAccountDocuments.ifscCode.contains('ICIC'))
            //   Image.asset(
            //     IconImgConstants.ICICI_LOGO,
            //     height: 40.0,
            //     width: 40.0,
            //   )
            // else if (widget.bankAccountDocuments.ifscCode != null &&
            //     widget.bankAccountDocuments.ifscCode.contains('UTI'))
            //   Image.asset(
            //     IconImgConstants.AXIS_LOGO,
            //     height: 40.0,
            //     width: 40.0,
            //   )
            // else
            //   Image.asset(
            //     IconImgConstants.IC_BANK_IMAGE,
            //     height: 40.0,
            //     width: 40.0,
            //   ),
            SizedBox(width: 20.0),
          ],
        ),
      ),
    );
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

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  showPaytmAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.subtitle1.copyWith(
              color: ColorConstant.COLOR_TEXT,
              fontWeight: FontWeight.w400,
            ),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget OKButton = TextButton(
        child: Text(
          "OK",
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w400,
              ),
        ),
        onPressed: () {
          if (paytmController.text.isEmpty) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Please enter your Paytm number",
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          } else if (paytmController.text.isNotEmpty &&
              paytmController.text.length < 10) {
            Navigator.pop(context);
            Fluttertoast.showToast(
                msg: "Please enter valid Paytm number",
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1);
          } else {
            Navigator.pop(context);
            // Navigator.pushReplacement(
            //     context,
            //     MaterialPageRoute(
            //         builder: (BuildContext context) =>
            //             WithdrawalSuccessScreen(
            //               amount: _amountController.text,
            //               paymentType: "Paytm",
            //               paytmNumber: paytmController.text,
            //             )));
          }
          {}
        });

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      contentPadding: EdgeInsets.only(left: 10.0),
      titlePadding: EdgeInsets.all(0.0),
      // insetPadding: EdgeInsets.all(0.0),
      title: Padding(
        padding: const EdgeInsets.only(left: 15.0, top: 15),
        child: Text(
          "Enter Paytm Number",
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w400,
              ),
        ),
      ),
      content: Container(
        width: double.infinity,
        child: TextField(
          controller: paytmController,
          decoration: InputDecoration(
            // border: OutlineInputBorder(),
            hintText: '10 Digit Paytm Number',
            hintStyle: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: ColorConstant.COLOR_GREY,
                  fontWeight: FontWeight.w400,
                ),
          ),
          onChanged: (text) {
            setState(() {
              paytmNumber = text;
            });
          },
        ),
      ),
      actions: [
        cancelButton,
        OKButton,
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
