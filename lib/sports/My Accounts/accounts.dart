import 'package:balleballe11/balance/verify_document.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/sports/My%20Accounts/playing_history.dart';
import 'package:balleballe11/sports/My%20Accounts/transaction.dart';
import 'package:balleballe11/sports/more_page.dart/more_page.dart';
import 'package:balleballe11/sports/myMatches/Upcoming/upcoming_matches.dart';
import 'package:balleballe11/sports/myMatches/my_matches.dart';

import 'balance.dart';

class MyAccounts extends StatefulWidget {
  const MyAccounts({Key key}) : super(key: key);

  @override
  _MyAccountsState createState() => _MyAccountsState();
}

class _MyAccountsState extends State<MyAccounts>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.COLOR_WHITE,
      child: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          child: Scaffold(
            backgroundColor: ColorConstant.BACKGROUND_COLOR,
            appBar: AppBar(
              backgroundColor: ColorConstant.COLOR_WHITE,
              leading: Padding(
                padding: const EdgeInsets.only(top: 10, left: 20.0),
                child: Text(
                  "Accounts",
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w500,
                      ),
                ),
              ),
              leadingWidth: 100,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, right: 10.0),
                  child: Icon(
                    Icons.notifications,
                    color: ColorConstant.COLOR_TEXT,
                    size: 25,
                  ),
                ),
              ],
              bottom: PreferredSize(
                preferredSize: Size.fromHeight(170),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 15.0, right: 15, top: 15, bottom: 0),
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  ImgConstants.DEFAULT_PLAYER,
                                  height: 40,
                                  width: 40,
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Text(
                                  "${SharedPreference.getValue(PrefConstants.USER_NAME)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 15,
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                UpdateProfile(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'EDIT PROFILE',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0,
                                            color: ColorConstant.COLOR_TEXT),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 15,
                                ),
                                Expanded(
                                  child: Container(
                                    width:
                                        MediaQuery.of(context).size.width / 2.5,
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                VerifyDocument(),
                                          ),
                                        );
                                      },
                                      child: Text(
                                        'APPROVAL PENDING',
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      style: OutlinedButton.styleFrom(
                                        side: BorderSide(
                                            width: 1.0, color: Colors.blue),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Container(
                              color: ColorConstant.COLOR_WHITE,
                              child: Container(
                                child: TabBar(
                                    indicatorColor: ColorConstant.COLOR_TEXT,
                                    indicatorWeight: 2.0,
                                    labelPadding: EdgeInsets.symmetric(
                                      vertical: 10.0,
                                    ),
                                    indicatorSize: TabBarIndicatorSize.tab,
                                    labelColor: ColorConstant.COLOR_BLUE3,
                                    labelStyle: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                    unselectedLabelColor:
                                        ColorConstant.COLOR_TEXT,
                                    unselectedLabelStyle: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.w500,
                                        ),
                                    controller: _tabController,

                                    //tabs: _tabList != null ? _tabList : [],
                                    tabs: [
                                      Text(
                                        "BALANCE",
                                      ),
                                      Text(
                                        "PLAYING HISTORY",
                                      ),
                                      Text(
                                        "TRANSACTION",
                                      ),
                                    ]),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              controller: _tabController,
              children: [
                Balance(),
                PlayingHistory(),
                Transaction(),
              ],
            ),
            bottomNavigationBar: BottomAppBar(
              shape: CircularNotchedRectangle(),
              notchMargin: 10,
              child: Container(
                height: 60,
                child: Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      BottomAppBarWidget(
                        assetImage: ImgConstants.HOME_LOGO,
                        text: AppLocalizations.of('Home'),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        color: ColorConstant.COLOR_TEXT,
                      ),
                      BottomAppBarWidget(
                        assetImage: ImgConstants.MATCHES_ICON,
                        text: AppLocalizations.of('My Matches'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyMatchesPage(),
                            ),
                          );
                        },
                        color: ColorConstant.COLOR_TEXT,
                      ),
                      BottomAppBarWidget(
                        assetImage: ImgConstants.PERSON_ICON,
                        text: AppLocalizations.of('My Account'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MyAccounts(),
                            ),
                          );
                        },
                        color: ColorConstant.COLOR_TEXT,
                      ),
                      BottomAppBarWidget(
                        assetImage: ImgConstants.MENU_ICON,
                        text: AppLocalizations.of('More'),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MorePage(),
                            ),
                          );
                        },
                        color: ColorConstant.COLOR_TEXT,
                        // color: objIsSelect.group
                        //     ? ColorConstant.COLOR_TEXT
                        //     : Theme.of(context).disabledColor,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
