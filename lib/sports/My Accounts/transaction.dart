import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/transaction_history_model.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';

class Transaction extends StatefulWidget {
  const Transaction({Key key}) : super(key: key);

  @override
  _TransactionState createState() => _TransactionState();
}

class _TransactionState extends State<Transaction> {
  bool _isProgressRunning = false;
  TransactionHistoryModel _transactionhistorydata = TransactionHistoryModel();
  TransactionHistory transactionHistory;
  bool isloading = true;

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   isloading = false;
    // });

    _getTransactionHistory();
  }

  Future<void> _getTransactionHistory() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _transactionhistorydata = await APIServices.getTransactionHistory();
      setState(() {
        transactionHistory = _transactionhistorydata.transactionHistory;
      });
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      if (mounted)
        setState(() {
          _isProgressRunning = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isProgressRunning
        ? ShimmerProgressWidget(count: 8, isProgressRunning: _isProgressRunning)
        : transactionHistory?.transaction?.length != null &&
                transactionHistory.transaction.length > 0
            ? Container(
                color: ColorConstant.COLOR_WHITE,
                height: MediaQuery.of(context).size.height,
                child: Padding(
                    padding:
                        const EdgeInsets.only(left: 15.0, right: 15, top: 20),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      child: ListView.builder(
                          physics: ClampingScrollPhysics(),
                          itemCount:
                              transactionHistory?.transaction?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return transactionCard(context, index);
                          }),
                    )),
              )
            : _noTransactionFound();
  }

  Widget transactionCard(BuildContext context, int index) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "${transactionHistory.transaction[index].paymentType ?? ""}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          children: [
            Text(
              "${transactionHistory.transaction[index].transactionId ?? ""}",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: ColorConstant.COLOR_TEXT,
                    fontWeight: FontWeight.w400,
                  ),
            ),
            Spacer(),
            if (transactionHistory.transaction[index].debitCreditStatus ==
                DebitCreditStatus.DEBIT_CREDIT_STATUS)
              Text(
                "+₹${transactionHistory.transaction[index].amount ?? ""}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: ColorConstant.COLOR_GREEN,
                      fontWeight: FontWeight.w500,
                    ),
              )
            else
              Text(
                "-₹${transactionHistory.transaction[index].amount ?? ""}",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      // color: transactionHistory
                      //             .transaction[index].debitCreditStatus ==
                      //         "-"
                      //     ? ColorConstant.COLOR_RED
                      //     : ColorConstant.COLOR_GREEN,

                      color: ColorConstant.COLOR_RED2,
                      fontWeight: FontWeight.w500,
                    ),
              ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          "${transactionHistory.transaction[index].date ?? ""}",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: ColorConstant.COLOR_GREY,
                fontWeight: FontWeight.w500,
              ),
        ),
        const SizedBox(
          height: 8,
        ),
        Divider(
          thickness: 1,
          color: ColorConstant.COLOR_GREY,
        ),
      ],
    );
  }

  Widget _noTransactionFound() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Text(
                "No Transaction History",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline6.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
