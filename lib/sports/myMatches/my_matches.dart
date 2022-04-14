import 'package:balleballe11/Language/appLocalizations.dart';
import 'package:balleballe11/constance/color_constant.dart';
import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/sports/My%20Accounts/accounts.dart';
import 'package:balleballe11/sports/more_page.dart/more_page.dart';
import 'package:balleballe11/sports/myMatches/Upcoming/upcoming_matches.dart';
import 'package:flutter/material.dart';

import '../../model/getUserModel.dart';
import 'Completed/completed_match.dart';
import 'Live/live_matches.dart';

class MyMatchesPage extends StatefulWidget {
  @override
  _MyMatchesPageState createState() => _MyMatchesPageState();
}

class _MyMatchesPageState extends State<MyMatchesPage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  final IsSelect objIsSelect = new IsSelect();
//  WalletInfo _myWalletData = WalletInfo();
  bool _isProgressRunning = false;

  GetUserModel userData = GetUserModel();

  Future<void> _getUserData() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      GetUserModel getDataModel = await APIServices.getUserData();
      if (getDataModel.status != null && getDataModel.data != null) {
        userData = getDataModel;

        print(userData.data.name);
      }
    } catch (e) {
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      if (mounted) {
        setState(() {
          _isProgressRunning = false;
        });
      }
    }
  }



  @override
  void initState() {
    super.initState();
    _getUserData();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  Widget _buildAppBar() {
    return AppBar(
      titleSpacing: 2,
      backgroundColor: ColorConstant.COLOR_WHITE,
      leading: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UpdateProfile()),
          );
        },
        child: Padding(
          padding: const EdgeInsets.only(top: 5, bottom: 5, left: 10.0),
          child: new Container(
            width: 40.0,
            height: 40.0,
            decoration: new BoxDecoration(
              shape: BoxShape.circle,
              color: ColorConstant.COLOR_WHITE,
              image: new DecorationImage(
                  fit: BoxFit.fill,
                  image: userData.data?.profileImage != null &&
                          userData.data?.profileImage != ''
                      ? Image.network(
                          userData?.data?.profileImage,
                          width: 40.0,
                          height: 40.0,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace stackTrace) {
                            return Image.asset(ImgConstants.DEFAULT_PLAYER);
                          },
                        ).image
                      : AssetImage(ImgConstants.DEFAULT_PLAYER)),
            ),
          ),
        ),
      ),
      title: Padding(
         padding: const EdgeInsets.only(left: 6.0),
        child: Text(
          "Balleballe11",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      actions: [
        Center(
          child: Text(
            "₹${SharedPreference.getValue(PrefConstants.WALLET_AMOUNT) ?? 0.00}",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: ColorConstant.COLOR_TEXT,
                  fontWeight: FontWeight.bold,
                ),
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyBalance()),
            );
          },
          child: Image.asset(
            ImgConstants.WALLET2,
            width: 30,
            //   fit: BoxFit.fill,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Image.asset(
          ImgConstants.LEADERBOARD_LOGO,
          width: 30,
        ),
        const SizedBox(
          width: 15,
        ),
      ],
      bottom: PreferredSize(
        preferredSize: TabBar(
          tabs: [],
        ).preferredSize,
        child: Container(
          color: ColorConstant.COLOR_WHITE,
          child: TabBar(
            indicatorColor: ColorConstant.COLOR_TEXT,
            labelPadding: EdgeInsets.symmetric(vertical: 10.0),
            indicatorSize: TabBarIndicatorSize.tab,
            labelColor: ColorConstant.COLOR_BLUE3,
            labelStyle: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w600,
                ),
            unselectedLabelColor: ColorConstant.COLOR_TEXT,
            unselectedLabelStyle: Theme.of(context).textTheme.caption.copyWith(
                  fontSize: 14.0,
                  fontWeight: FontWeight.w400,
                ),
            controller: _tabController,
            tabs: [
              Text(
                AppLocalizations.of(
                  'Upcoming',
                ),
              ),
              Text(
                AppLocalizations.of('Live'),
              ),
              Text(
                AppLocalizations.of('Completed'),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: 1,
      length: 3,
      child: Scaffold(
        backgroundColor: ColorConstant.BACKGROUND_COLOR,
        appBar: _buildAppBar(),
        body: TabBarView(
          controller: _tabController,
          children: [UpComingPage(), LivePage(), CompletedPage()],
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
                    // color: objIsSelect.match
                    //     ? ColorConstant.COLOR_TEXT
                    //     : Theme.of(context).disabledColor,
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
                    // color: objIsSelect.win
                    //     ? ColorConstant.COLOR_TEXT
                    //     : Theme.of(context).disabledColor,
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
    );
  }
}
