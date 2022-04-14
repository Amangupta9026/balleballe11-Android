import 'package:balleballe11/Document/verify_pancard_document.dart';
import 'package:balleballe11/Document/verifybank_account.dart';
import 'package:balleballe11/constance/packages.dart';

class VerifyDocument extends StatefulWidget {
  final int verifyBankAccount;
  const VerifyDocument({Key key, this.verifyBankAccount}) : super(key: key);

  @override
  _VerifyDocumentState createState() => _VerifyDocumentState();
}

class _VerifyDocumentState extends State<VerifyDocument> {
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
          "Verify Documents",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                decoration:
                    BoxDecoration(color: ColorConstant.COLOR_LINEAR_TEXT),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 5, 10, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            "Get Verified",
                            style:
                                Theme.of(context).textTheme.subtitle1.copyWith(
                                      color: ColorConstant.COLOR_RED,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            "Withdraw winning to your bank account in 2hrs",
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.bold,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Image.asset(
                            ImgConstants.NOTE_IMAGE,
                            width: 60,
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(color: ColorConstant.COLOR_WHITE),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile Number",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400,
                            letterSpacing: 1.2),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "+91-${SharedPreference.getValue(PrefConstants.USER_MOB_NO)}",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: ColorConstant.COLOR_WHITE),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "Email Address",
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2
                                .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 1.2),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20),
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20),
                                ),
                                color: ColorConstant.COLOR_GREEN),
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.fromLTRB(7.0, 5, 7, 5),
                              child: Text(
                                "verified",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            )),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        "${SharedPreference.getValue(PrefConstants.USER_EMAIL)}",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: ColorConstant.COLOR_WHITE),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "PAN CARD",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  .copyWith(
                                    fontWeight: FontWeight.w400,
                                    color: ColorConstant.COLOR_TEXT,
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                "For safety and security of all transactions",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: ColorConstant.COLOR_TEXT,
                                side: BorderSide(
                                    width: 1.2,
                                    color: ColorConstant.COLOR_TEXT),
                              ),
                              child: Text('VERIFY'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VerifyPanCardDocument()),
                                );
                              },
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                decoration: BoxDecoration(color: ColorConstant.COLOR_WHITE),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text(
                                  "BANK ACCOUNT",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        fontWeight: FontWeight.w400,
                                        color: ColorConstant.COLOR_TEXT,
                                      ),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                    color: ColorConstant.COLOR_LINEAR_TEXT,
                                  ),
                                  child: Center(
                                      child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(7.0, 5, 7, 5),
                                    child: Text(
                                      "pending",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: ColorConstant.COLOR_WHITE,
                                            fontWeight: FontWeight.w500,
                                          ),
                                    ),
                                  )),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 10.0),
                              child: Text(
                                "For quick withdrawals to your bank account",
                                textAlign: TextAlign.start,
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText2
                                    .copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400,
                                    ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      //    if (widget.verifyBankAccount == 1)
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width * 0.22,
                            child: OutlinedButton(
                              style: OutlinedButton.styleFrom(
                                primary: ColorConstant.COLOR_TEXT,
                                side: BorderSide(
                                    width: 1.2,
                                    color: ColorConstant.COLOR_TEXT),
                              ),
                              child: Text('VERIFY'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          VerifyBankAccount()),
                                );
                              },
                            ),
                          )
                        ],
                      )
                      // else
                      //       const SizedBox(),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 8,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
