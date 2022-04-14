import 'dart:developer';

import 'package:balleballe11/balance/verify_document.dart';
import 'package:balleballe11/balance/withdrawal_page.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/get_mywallet_model.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';

import 'addcash.dart';

class MyBalance extends StatefulWidget {
  const MyBalance({Key key}) : super(key: key);

  @override
  _MyBalanceState createState() => _MyBalanceState();
}

class _MyBalanceState extends State<MyBalance> {
  WalletInfo _myWalletData = WalletInfo();
  bool _isProgressRunning = false;
  //bool isloading = true;
  num totalAmount = 0;

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

          // SharedPreference.setValue(PrefConstants.VERIFY_PAN_CARD,
          //     _myWalletData.userModel.verifyDocument);
          // if (_myWalletData.userModel.panDocumentUploaded != null) {
          //   Documents documents = _myWalletData.userModel.panDocumentUploaded;
          //
          //   SharedPreference.setValue(
          //       PrefConstants.PAN_CARD_DOCUMENT, jsonEncode(documents));
          //   SharedPreference.setValue(
          //       PrefConstants.PAN_CARD_DOCUMENT_REVIEW_STATUS,
          //       documents.status);
          // }

          // SharedPreference.setValue(PrefConstants.VERIFY_BANK_ACCOUNT,
          //     _myWalletData.userModel.verifyBankAccounts);
          // if (_myWalletData.userModel.bankDocumentUploaded != null) {
          //   bankAccountDocuments = _myWalletData.userModel.bankDocumentUploaded;
          //
          //   SharedPreference.setValue(PrefConstants.BANK_ACCOUNT_DOCUMENT,
          //       jsonEncode(bankAccountDocuments));
          //   SharedPreference.setValue(
          //       PrefConstants.BANK_ACCOUNT_DOCUMENT_REVIEW_STATUS,
          //       bankAccountDocuments.status);
          // }
          // totalAmount = _getTotalBalance();
          if (_myWalletData != null &&
              // _myWalletData.bonusAmount != null &&
              _myWalletData.prizeAmount != null &&
              _myWalletData.depositAmount != null &&
              _myWalletData.bonusAmount != null) {
            totalAmount = (_myWalletData.depositAmount +
                _myWalletData.prizeAmount
               );
            SharedPreference.setValue(PrefConstants.TOTAL_AMOUNT, totalAmount);
          }
        });
      }
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   isloading = false;
    // });
    getWalletData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          "Wallet",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: _isProgressRunning
          ? ShimmerProgressWidget(
              count: 8, isProgressRunning: _isProgressRunning)
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),

                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Column(
                                children: [
                                  Image.asset(
                                    ImgConstants.GIFT,
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    "Bonus",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "₹${_myWalletData.bonusAmount ?? 0}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    ImgConstants.WALLET3,
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    "Extra Cash",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "₹${_myWalletData.extraCash ?? 0}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                              Column(
                                children: [
                                  Image.asset(
                                    ImgConstants.DEPOSIT,
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    height: 1,
                                  ),
                                  Text(
                                    "Deposit",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 3,
                                  ),
                                  Text(
                                    "₹${_myWalletData.depositAmount ?? 0}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ],
                          ),

                          // Padding(
                          //   padding:
                          //       const EdgeInsets.only(top: 10.0, bottom: 10),
                          //   child: Text(
                          //     "${(SharedPreference.getValue(PrefConstants.TOTAL_AMOUNT)) ?? "0.0"}",
                          //     textAlign: TextAlign.center,
                          //     style: Theme.of(context)
                          //         .textTheme
                          //         .bodyText2
                          //         .copyWith(
                          //           color: ColorConstant.COLOR_BLUE,
                          //           fontWeight: FontWeight.w500,
                          //         ),
                          //   ),
                          // ),
                          // ElevatedButton(
                          //     style: ElevatedButton.styleFrom(
                          //       primary:
                          //           ColorConstant.COLOR_BUTTON2, // background
                          //       onPrimary:
                          //           ColorConstant.COLOR_WHITE, // foreground
                          //     ),
                          //     onPressed: () async {
                          //       Navigator.push(
                          //           context,
                          //           MaterialPageRoute(
                          //             builder: (context) => AddCash(
                          // totalbalance:
                          //     SharedPreference.getValue(
                          //         PrefConstants.TOTAL_AMOUNT)),
                          //           ));
                          //     },
                          //     child: Text(
                          //       "ADD CASH",
                          //       style: Theme.of(context)
                          //           .textTheme
                          //           .bodyText2
                          //           .copyWith(
                          //             fontWeight: FontWeight.w500,
                          //             color: ColorConstant.COLOR_WHITE,
                          //           ),
                          //     )),
                          const SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 2, 10, 10),
                    child: Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          borderRadius: BorderRadius.all(Radius.circular(5))),
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 15.0, right: 15, top: 3, bottom: 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  ImgConstants.WALLET_DOLLAR,
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 3,
                                ),
                                Text(
                                  "Winnings",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                            Text(
                              "₹${_myWalletData.prizeAmount ?? 0}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => AddCash(
                                      walletbalance: SharedPreference.getValue(
                                          PrefConstants.WALLET_AMOUNT),
                                      prizeAmount: SharedPreference.getValue(
                                          PrefConstants.PRIZE_AMOUNT),
                                    ),
                                  ));
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  ImgConstants.WALLET3,
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Add Money",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.COLOR_TEXT,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () async {
                              if (_myWalletData.prizeAmount >= 200) {
                                // bool success = await
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return WithdrawPage(
                                    bankName: _myWalletData.bankName,
                                    bankNumber: _myWalletData.bankAccountNumber,
                                  );
                                }));
                                // if (success != null && success) {
                                //   _getUserWallet();
                                // }
                              } else {
                                UtilsFlushBar.showDefaultSnackbar(
                                    context, "Amount is less than 200INR");
                              }

                              print('Pressed');
                            },
                            child: Column(
                              children: [
                                Image.asset(
                                  ImgConstants.WALLET4,
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(height: 5),
                                Text(
                                  "Withdraw Money",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontWeight: FontWeight.w500,
                                        color: ColorConstant.COLOR_TEXT,
                                      ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => VerifyDocument(
                                      verifyBankAccount:
                                          _myWalletData.bankAccountVerified,
                                    )),
                          );
                        },
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Image.asset(
                              ImgConstants.VERIFY_TICK,
                              height: 40,
                              width: 40,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              "VERIFY NOW",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.COLOR_TEXT,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 2, 10, 10),
                    child: Column(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RecentTransaction()),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorConstant.COLOR_WHITE,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 3, bottom: 3),
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImgConstants.WALLET_DOLLAR,
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "MY RECENT TRANSACTION",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ReferEarn()),
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: ColorConstant.COLOR_WHITE,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(5))),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 15.0, right: 15, top: 3, bottom: 3),
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImgConstants.WALLET_DOLLAR,
                                    height: 40,
                                    width: 40,
                                  ),
                                  const SizedBox(
                                    width: 3,
                                  ),
                                  Text(
                                    "REFER & EARN",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 2, 10, 10),
                    child: Container(
                      padding: EdgeInsets.all(12),
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          borderRadius: BorderRadius.all(Radius.circular(10))),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Note:",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorConstant.COLOR_TEXT_HEADLINE,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5),
                              child: Text(
                                "[1]. Paytm min: ₹200 and Maximum ₹1200",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "[2]. Bank Withdrawal KYC Required bank proofs i.e Bank statement",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorConstant.COLOR_TEXT_HEADLINE,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5),
                              child: Text(
                                "[3]. Tamil Nadu, Andhra Pradesh, Odisha and Telangana users are not allowed to play or withdraw money",
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorConstant.COLOR_TEXT_HEADLINE,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5),
                              child: Text(
                                "[4]. Withdrawal Timming 10 am to 5pm",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Container(
                            width: double.infinity,
                            color: ColorConstant.COLOR_TEXT_HEADLINE,
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(top: 5.0, bottom: 5),
                              child: Text(
                                "[5]. Minimum Deposit 25 Rs.",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
