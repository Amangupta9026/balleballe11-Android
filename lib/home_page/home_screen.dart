import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/home_page/offers.dart';
import 'package:balleballe11/model/get_mywallet_model.dart';
import 'package:balleballe11/sports/My%20Accounts/accounts.dart';
import 'package:balleballe11/sports/more_page.dart/more_page.dart';
import 'package:balleballe11/sports/myMatches/my_matches.dart';

import '../model/getUserModel.dart';

class HomeScreen extends StatefulWidget {
  var completematchIndex;
  HomeScreen({Key key, completematchIndex}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final IsSelect objIsSelect = new IsSelect();
  WalletInfo _myWalletData = WalletInfo();
  bool _isProgressRunning = false;
  num totalAmount = 0;
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

  int selectedIndex = 1;

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
              PrefConstants.WALLET_AMOUNT, _myWalletData.walletAmount);
          SharedPreference.setValue(
              PrefConstants.BONUS_AMOUNT, _myWalletData.bonusAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.WINNING_AMOUNT, _myWalletData.prizeAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.DEPOSIT_AMOUNT, _myWalletData.depositAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.PRIZE_AMOUNT, _myWalletData.prizeAmount ?? 0);
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
            totalAmount =
                (_myWalletData.depositAmount + _myWalletData.prizeAmount);
            SharedPreference.setValue(PrefConstants.TOTAL_AMOUNT, totalAmount);
          }
        });
      }
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, error);
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    if (SharedPreference.getValue(PrefConstants.USER_ID) != null) {
      Future.delayed(Duration.zero, () {
        APIServices.getMyCompletedMatches("completed");
      });
    }
    getWalletData();
    _getUserData();
    log("completed home id ${SharedPreference.getValue(PrefConstants.USER_ID)}");
  }

  @override
  void dispose() {
    //  _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.BACKGROUND_COLOR,
      appBar: AppBar(
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
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
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
              ).then((value) => setState(() => {}));
            },
            child: Image.asset(
              ImgConstants.WALLET2,
              width: 30,
              //   fit: BoxFit.fill,
            ),
          ),
          const SizedBox(
            width: 12,
          ),
          Image.asset(
            ImgConstants.LEADERBOARD_LOGO,
            // fit: BoxFit.fill,
            width: 30,

            //   color: ColorConstant.COLOR_TEXT,
          ),
          const SizedBox(
            width: 15,
          ),
        ],
      ),
      body: CricketPage(),
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
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => HomeScreen()));
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
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IsSelect {
  bool home;
  bool match;
  bool win;
  bool group;
  bool feed;

  IsSelect({
    this.home = true,
    this.match = false,
    this.win = false,
    this.group = false,
    this.feed = false,
  });
}

class BottomAppBarWidget extends StatelessWidget {
  final String assetImage;
  final String text;
  final VoidCallback onTap;
  final Color color;

  const BottomAppBarWidget(
      {Key key, this.assetImage, this.text, this.onTap, this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        onTap();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Image.asset(assetImage, height: 20.0, width: 18.0, color: color),
          SizedBox(
            height: 5.0,
          ),
          Text(
            text,
            style: TextStyle(
                color: color, fontSize: 12.0, fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
