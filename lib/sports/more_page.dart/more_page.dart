import 'dart:developer';

import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/login/login.dart';
import 'package:balleballe11/sharedPreference/sharedPreference.dart';
import 'package:balleballe11/sports/My%20Accounts/accounts.dart';
import 'package:balleballe11/sports/more_page.dart/fan11_supportteam.dart';
import 'package:balleballe11/sports/myMatches/my_matches.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../model/getUserModel.dart';
import 'affiliate_page.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:url_launcher/url_launcher.dart';

class MorePage extends StatefulWidget {
  _MorePageState createState() => _MorePageState();
}

class _MorePageState extends State<MorePage> {
  // String aboutUSUrl = "https://www.my11choice.com/about-us.php";
  String howToPlayUrl = "https://balleballe11.in/how-to-play";
  String fantasyPointSystemUrl =
      "https://balleballe11.in/fantasy-points-system/";
  String termsUrl = "https://balleballe11.in/terms-and-conditions";
  // String privacyPolicyUrl = "https://www.my11choice.com/privacy-policy.php";
  // String helpAndSupportUrl = "http://my11choice.com/contact-us";

  bool isLoading = false;
  bool _isProgressRunning = false;
  // AccessToken _accessToken;
  // Map<String, dynamic> _userData;

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

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
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstant.COLOR_WHITE,
      // transparent status bar
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.COLOR_WHITE,
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
              // fit: BoxFit.fill,
              // color: ColorConstant.COLOR_TEXT,
            ),
            const SizedBox(
              width: 15,
            ),
          ],
        ),
        body: _getMoreItems(),
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
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  // void _redirectToWebView(String urlToLoad, String screenName) {
  //   Navigator.push(
  //     context,
  //     MaterialPageRoute(
  //       builder: (context) => WebViewPage(
  //         urlToLoad: urlToLoad,
  //         screenName: screenName,
  //       ),
  //     ),
  //   );
  // }

  // void _launchAboutUs() async => await canLaunch(aboutUSUrl)
  //     ? await launch(aboutUSUrl)
  //     : throw 'Could not launch $aboutUSUrl';

  void _launchHowPlay() async => await canLaunch(howToPlayUrl)
      ? await launch(howToPlayUrl)
      : throw 'Could not launch $howToPlayUrl';

  void _launchFantasyPoint() async => await canLaunch(fantasyPointSystemUrl)
      ? await launch(fantasyPointSystemUrl)
      : throw 'Could not launch $fantasyPointSystemUrl';

  void _launchTermsUrl() async => await canLaunch(termsUrl)
      ? await launch(termsUrl)
      : throw 'Could not launch $termsUrl';

  // void _launchPrivacyUrl() async => await canLaunch(privacyPolicyUrl)
  //     ? await launch(privacyPolicyUrl)
  //     : throw 'Could not launch $privacyPolicyUrl';

  // void _launchHelpUrl() async => await canLaunch(helpAndSupportUrl)
  //     ? await launch(helpAndSupportUrl)
  //     : throw 'Could not launch $helpAndSupportUrl';

  Widget _getMoreItems() {
    return ListView(
      physics: BouncingScrollPhysics(),
      padding: EdgeInsets.all(12.0),
      children: [
        _getCardItem(
            title: "Show My Affiliate",
            assetImage: ImgConstants.BELL,
            onTapPerform: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AffiliatePage(),
                ),
              );
            }),
        _getCardItem(
            title: "Refer & Earn",
            assetImage: ImgConstants.REFEREARN,
            onTapPerform: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => ReferEarn()));
            }),
        _getCardItem(
            title: "balleballe11 Support Team",
            assetImage: ImgConstants.SUPPORTTEAM,
            onTapPerform: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => balleballe11SupportTeam()));
            }),
        _getCardItem(
            title: "Fantasy Point System",
            assetImage: ImgConstants.POINTSYSTEM,
            onTapPerform: () {
              _launchFantasyPoint();
            }),
        _getCardItem(
            title: "How to Play",
            assetImage: ImgConstants.HOWPLAY,
            onTapPerform: () {
              _launchHowPlay();
            }),
        _getCardItem(
            title: "About Us",
            assetImage: ImgConstants.PERSON_ICON,
            onTapPerform: () {
              //    _launchHelpUrl();
            }),
        _getCardItem(
            title: "Legality",
            assetImage: ImgConstants.LEGALITY,
            onTapPerform: () {
              //    _launchHelpUrl();
            }),
        _getCardItem(
            title: "Terms & conditions",
            assetImage: ImgConstants.TERMSCONDITION,
            onTapPerform: () {
              _launchTermsUrl();
            }),
        _getCardItem(
            title: "Logout",
            assetImage: ImgConstants.LOGOUT,
            onTapPerform: () {
              //   _logOut();
              // SharedPreference.clearPrefs();
              //   log("logout ${_logOut}");

              showAlertDialog(context);
            }),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getCardItem(
      {String title, String assetImage, Function onTapPerform}) {
    return Column(
      children: [
        InkWell(
          onTap: () {
            onTapPerform();
          },
          child: Padding(
            padding: const EdgeInsets.all(6.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                    // height: 60.0,
                    // width: 60.0,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: ColorConstant.COLOR_GREY,
                        width: 1.2,
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(4.0),
                      child: Image.asset(
                        assetImage,
                        width: 20.0,
                      ),
                    )),
                SizedBox(width: 10.0),
                Text(
                  title ?? "",
                  style: Theme.of(context).textTheme.caption.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontSize: 14.0,
                      fontWeight: FontWeight.bold),
                ),
                Spacer(),
                Icon(
                  Icons.arrow_forward_ios,
                  color: ColorConstant.COLOR_TEXT,
                  size: 14,
                ),
              ],
            ),
          ),
        ),
        Divider(
          thickness: 0.5,
          color: ColorConstant.COLOR_GREY,
        )
      ],
    );
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text(
        "OK",
        style: Theme.of(context).textTheme.subtitle2.copyWith(
              color: ColorConstant.COLOR_TEXT,
              fontWeight: FontWeight.w500,
            ),
      ),
      onPressed: () {
        SharedPreference.clearPrefs();
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => LoginPage(),
          ),
          (route) => false,
        );
      },
    );

    Widget okCancel = TextButton(
      child: Text(
        "Cancel",
        style: Theme.of(context).textTheme.subtitle2.copyWith(
              color: ColorConstant.COLOR_TEXT,
              fontWeight: FontWeight.w500,
            ),
      ),
      onPressed: () {
        Navigator.of(context).pop();
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Are you sure you want to Logout ?"),
      actions: [okCancel, okButton],
    );

    // show the dialog
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return WillPopScope(onWillPop: () => Future.value(false), child: alert);
      },
    );
  }
}
