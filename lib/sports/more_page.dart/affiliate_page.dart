import 'dart:math';

import 'package:balleballe11/constance/packages.dart';
import 'package:intl/intl.dart';

import 'affiliate_detail_page.dart';

class AffiliatePage extends StatefulWidget {
  const AffiliatePage({Key key}) : super(key: key);

  @override
  _AffiliatePageState createState() => _AffiliatePageState();
}

class _AffiliatePageState extends State<AffiliatePage> {
  DateTime _selectedDate;
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _textEndController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorConstant.COLOR_WHITE,
          title: Text(
            'Show Affiliate Commission',
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: ColorConstant.COLOR_TEXT,
                  fontWeight: FontWeight.bold,
                ),
          ),
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
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(10.0, 30, 10, 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Want to know custom Affiliation ?",
                  style: Theme.of(context).textTheme.headline5.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.bold,
                      ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Enter start date and last date and get custom affiliation details by pressing get detail button.",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.calendar_today,
                          color: ColorConstant.COLOR_RED2,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: TextField(
                            controller: _textEditingController,
                            onTap: () {
                              _selectDate(context);
                            },
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintStyle: new TextStyle(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w500),
                              hintText: "Start Date".toLowerCase(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(6.0),
                        child: Icon(
                          Icons.calendar_today,
                          color: ColorConstant.COLOR_RED2,
                        ),
                      ),
                      Flexible(
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                          child: TextField(
                            controller: _textEndController,
                            onTap: () {
                              _selectEndDate(context);
                            },
                            decoration: new InputDecoration(
                              border: InputBorder.none,
                              hintStyle: new TextStyle(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w500),
                              hintText: "End Date".toLowerCase(),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Center(
                  child: InkWell(
                    onTap: () {
                      if (_textEditingController.text.isEmpty &&
                          _textEndController.text.isEmpty) {
                        UtilsFlushBar.showDefaultSnackbar(
                            context, "Please enter start date and end date");
                      } else if (_textEditingController.text.isEmpty) {
                        UtilsFlushBar.showDefaultSnackbar(
                            context, "Please enter start date and end date");
                      } else if (_textEndController.text.isEmpty) {
                        UtilsFlushBar.showDefaultSnackbar(
                            context, "Please enter start date and end date");
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AffiliateDetailPage()),
                        );
                      }
                    },
                    child: Container(
                        width: MediaQuery.of(context).size.width * 0.4,
                        color: ColorConstant.COLOR_GREEN2,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 13.0, bottom: 13),
                          child: Text("SHOW REPORT",
                              textAlign: TextAlign.center,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: ColorConstant.COLOR_WHITE,
                                    fontWeight: FontWeight.w500,
                                  )),
                        )),
                  ),
                ),
                SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Row(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("DEPOSIT",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "₹${SharedPreference.getValue(PrefConstants.DEPOSIT_AMOUNT ?? 0.00)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  )),
                        ],
                      ),
                      const SizedBox(
                        width: 80,
                      ),
                      Column(
                        children: [
                          Text("WINNING",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  )),
                          SizedBox(
                            height: 20,
                          ),
                          Text(
                              "₹${SharedPreference.getValue(PrefConstants.WINNING_AMOUNT ?? 0.00)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  )),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20.0),
                  child: Wrap(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("Affiliate Earned",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  )),
                          SizedBox(
                            height: 20,
                          ),
                          Text("0.0",
                              //"₹${SharedPreference.getValue(PrefConstants.DEPOSIT_AMOUNT ?? 0.00)}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  )),
                        ],
                      ),
                      const SizedBox(
                        width: 40,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AffiliateDetailPage()),
                          );
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Get Details >>".toUpperCase(),
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5
                                    .copyWith(
                                      color: ColorConstant.COLOR_GREEN2,
                                      fontWeight: FontWeight.w900,
                                    )),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ));
  }

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  _selectEndDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEndController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEndController.text.length,
            affinity: TextAffinity.upstream));
    }
  }
}
