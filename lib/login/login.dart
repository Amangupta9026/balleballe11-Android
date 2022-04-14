import 'dart:convert';
import 'dart:developer';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:balleballe11/constance/global.dart' as global;

class LoginPage extends StatefulWidget {
  const LoginPage({Key key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isProgressRunning = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  auth.User googleLoginUser;
  final auth.FirebaseAuth _auth = auth.FirebaseAuth.instance;
  LoginModel loginResp = LoginModel();
  String LOGIN_TYPE_GMAIL = "googleAuth"; // --- check 0 & 1
  bool _isProgressRunning = false;
  final _formKey = GlobalKey<FormState>();
  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  RegExp regex;
  bool _obscureText = true;
  MyCompletedMatchesModel _matchCompleteeData = MyCompletedMatchesModel();
  List<Completed> _completedMatchLists = <Completed>[];

  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration.zero, () {
    //   _apiLogin(LOGIN_TYPE_GMAIL, "");
    // });

    // if (SharedPreference.getValue(PrefConstants.USER_ID) != null) {
    //   Future.delayed(Duration.zero, () {
    //     APIServices.getMyCompletedMatches("completed");
    //   });
    // }
    // log("user login id ${SharedPreference.getValue(PrefConstants.USER_ID)}");
  }

  Future<void> _getCompletedMatches() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _matchCompleteeData =
          await APIServices.getMyCompletedMatches("completed");
      _completedMatchLists.clear();
      if (_matchCompleteeData != null &&
          _matchCompleteeData.response.matchdata.length > 0)
        //  if (_matchCompleteeData.response.matchdata.length > 0)
        //   {
        _completedMatchLists
            .addAll(_matchCompleteeData.response.matchdata[0].completed);
      // }

      log("${_completedMatchLists.length}", name: "length");
    } catch (error) {
      // log("$error", name: "error");
      // showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      if (mounted)
        setState(() {
          _isProgressRunning = false;
        });
    }
  }

  void _togglePassword() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  Future<String> _signInWithGoogle() async {
    setState(() {
      isProgressRunning = true;
    });
    try {
      if (_auth.currentUser != null) {
        _signOutGoogle();
      }
      GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            await googleSignInAccount.authentication;
        final auth.AuthCredential credential =
            auth.GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );
        if (credential != null) {
          final auth.UserCredential authResult =
              await _auth.signInWithCredential(credential);
          googleLoginUser = authResult.user;
          if (googleLoginUser != null) {
            assert(!googleLoginUser.isAnonymous);
            assert(await googleLoginUser.getIdToken() != null);
            final auth.User currentUser = _auth.currentUser;
            assert(googleLoginUser.uid == currentUser.uid);

            currentUser.getIdToken().then((value) {
              print("currentUserToken ::$value");
            });
            print("login email ${googleLoginUser.email}");
            print("name ${googleLoginUser.displayName}");
            print("id ${googleLoginUser.uid}");
            print("photo ${googleLoginUser.photoURL}");
            final idToken = await googleLoginUser.getIdToken();
            print("idToken :: $idToken");
          }
          setState(() {
            isProgressRunning = false;
          });
          if (googleLoginUser != null) {
            // log(googleLoginUser.email);
            // log(googleLoginUser.displayName);
          }
          return '$googleLoginUser';
        }
      } else {
        setState(() {
          isProgressRunning = false;
        });
      }
    } catch (error) {
      setState(() {
        isProgressRunning = false;
      });
      //  Fluttertoast.showToast(msg: error);
      print("google login error che  $error");
    }
    return null;
  }

  Future<void> _signOutGoogle() async {
    try {
      await googleSignIn.signOut();
      //await googleSignIn.disconnect();
    } catch (e) {
      print("error in _signOutGoogle $e");
    }
  }

  Future<void> _apiLogin(String loginType, String profilePic) async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      if (loginType == LOGIN_TYPE_GMAIL) {
        loginResp = await APIServices.getLoginApi(googleLoginUser.email, "",
            loginType, profilePic, googleLoginUser.displayName);
        log("login ${loginResp}");
      }

      // else {
      //   loginResp = await APIServices.getLoginApi(
      //
      // _userNameController.text.toLowerCase(),
      //       _passwordController.text,
      //       loginType,
      //       profilePic);
      // }

      if (loginResp != null || loginResp.status != null) {
        if (loginResp.status != null && loginResp.status != "") {
          if (loginResp.status != null && loginResp.status == false) {
            if (loginType == LOGIN_TYPE_GMAIL) {
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => RegisterPage(
                    keyEmail: googleLoginUser.email,
                    name: googleLoginUser.displayName,
                    photo: googleLoginUser.photoURL,
                    loginType: LOGIN_TYPE_GMAIL,
                    isNavigatorGoogle: true,
                  ),
                ),
                (route) => false,
              );
            }
          } else {
            if (loginResp.status != null && loginResp.status == true) {
              SharedPreference.setValue(
                  PrefConstants.USER_ID, loginResp.data.userId);
              SharedPreference.setValue(
                  PrefConstants.USER_EMAIL, loginResp.data?.email ?? "Email");
              SharedPreference.setValue(
                  PrefConstants.USER_NAME, loginResp.data?.name ?? "Name");
              SharedPreference.setValue(PrefConstants.USER_MOB_NO,
                  loginResp.data?.mobileNumber ?? "");

              SharedPreference.setValue(
                  PrefConstants.TEAM_NAME, loginResp.data?.teamName ?? "");
              SharedPreference.setValue(
                  PrefConstants.APK_URL, loginResp.data?.apkUrl ?? "");
              SharedPreference.setValue(
                  PrefConstants.GPAY, loginResp.data?.gPay ?? "");
              SharedPreference.setValue(
                  PrefConstants.CALL_URL, loginResp.data?.callUrl ?? "");

              log("${SharedPreference.getValue(PrefConstants.USER_ID)}");

              print(json.encode(loginResp));
              SharedPreference.setValue(PrefConstants.USER_REFERAL,
                  loginResp.data?.referalCode ?? "");
              SharedPreference.setValue(PrefConstants.IS_LOGIN, true);
              //       global.currentUser = loginResp.data;
              Navigator.pushAndRemoveUntil<dynamic>(
                context,
                MaterialPageRoute<dynamic>(
                  builder: (BuildContext context) => HomeScreen(),
                ),
                (route) => false,
              );
            } else {
              showCommonMessageDialog(context, loginResp.message);
            }
          }
        }
      } else {
        showCommonMessageDialog(context, loginResp.message);
      }
    } catch (e) {
      showErrorDialog(context, e);
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    double height1 = MediaQuery.of(context).size.height;

    return Container(
      color: ColorConstant.COLOR_WHITE,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: ColorConstant.COLOR_WHITE,
          //  bottomSheet:
          body: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 30, right: 30, top: 30),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      AppLocalizations.of(
                          "INDIA'S BIGGEST FANTASY SPORTS PLATFORM"),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 20, bottom: 30),
                      child: Text(
                        AppLocalizations.of("Login With"),
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline6.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),

                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(6.0)),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              ImgConstants.LOGIN_LOGO,
                              width: 28.0,
                              height: 28.0,
                            ),
                          ),
                          Container(height: 50, color: Colors.grey, width: 0.5),
                          Flexible(
                            child: Form(
                              key: _formKey,
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(
                                  6,
                                  0,
                                  0,
                                  0,
                                ),
                                child: TextFormField(
                                  controller: _userNameController,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: ColorConstant.COLOR_BLACK,
                                  ),
                                  textInputAction: TextInputAction.next,
                                  validator: (input) {
                                    if (input != null && input.isNotEmpty) {
                                      if (!(regex.hasMatch(input))) {
                                        return AppLocalizations.of(
                                            "Please add valid email address");
                                        //"Please add valid email address";
                                      }
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: AppLocalizations.of("Email"),
                                    // "Email",
                                    hintStyle: TextStyle(
                                      fontSize: 16.0,
                                      color: ColorConstant.COLOR_GREY,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Password

                    SizedBox(height: 15.0),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(
                          Radius.circular(6.0),
                        ),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(6.0),
                            child: Image.asset(
                              ImgConstants.IC_PASSWORD,
                              width: 28.0,
                              height: 28.0,
                            ),
                          ),
                          Container(
                            height: 50,
                            color: Colors.grey,
                            width: 0.5,
                          ),
                          Flexible(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(
                                6,
                                0,
                                0,
                                0,
                              ),
                              child: TextFormField(
                                controller: _passwordController,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  color: ColorConstant.COLOR_BLACK,
                                ),
                                onFieldSubmitted: (_) => node.unfocus(),
                                textInputAction: TextInputAction.done,
                                validator: (pwd) {
                                  if (pwd.length < 6) {
                                    return AppLocalizations.of(
                                        "Password should be 6 character long");
                                  }
                                  return null;
                                },
                                obscureText: _obscureText,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintText: AppLocalizations.of("Password"),
                                  hintStyle: new TextStyle(
                                    color: Colors.grey,
                                    fontSize: 16.0,
                                  ),
                                  suffixIcon: InkWell(
                                    onTap: () => _togglePassword(),
                                    child: _obscureText
                                        ? Image.asset(ImgConstants.OPEN_EYE)
                                        : Image.asset(ImgConstants.CLOSED_EYE),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Login Button
                    SizedBox(height: 20.0),

                    Material(
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: ColorConstant.COLOR_BUTTON2, width: 0.8),
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      color: ColorConstant.COLOR_BUTTON2,
                      child: MaterialButton(
                        minWidth: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
                        onPressed: () async {
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => HomeScreen()),
                          // );
                          print("login button");
                          node.unfocus();

                          if (_userNameController.text.isEmpty &&
                              _passwordController.text.isEmpty) {
                            // UtilsFlushBar.showDefaultSnackbar(
                            //     context, "Email and Password is required");
                          } else if (_userNameController.text.isEmpty) {
                            // UtilsFlushBar.showDefaultSnackbar(
                            //     context, "Email is required");
                          } else if (_passwordController.text.isEmpty) {
                            // UtilsFlushBar.showDefaultSnackbar(
                            //     context, "Password is required");
                          }
                          //  else {
                          //   if (Utils.isValidEmail(_userNameController.text)) {
                          //     await _apiLogin(LOGIN_TYPE_MANUAL, "");
                          //   }
                          //   else {
                          //     UtilsFlushBar.showDefaultSnackbar(
                          //         context, "Invalid email found!");
                          //   }
                          // }
                        },
                        child: Text(
                          AppLocalizations.of("Login"),
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_WHITE, fontSize: 18.0),
                        ),
                      ),
                    ),

                    SizedBox(height: 30.0),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Flexible(
                          flex: 1,
                          child: Container(color: Colors.grey, height: 0.5),
                        ),
                        SizedBox(width: 4.0),
                        Text(
                          AppLocalizations.of("OR"),
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(width: 4.0),
                        Flexible(
                          flex: 1,
                          child: Container(
                            color: Colors.grey,
                            height: 0.5,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 30.0),

                    // Google
                    InkWell(
                      onTap: () async {
                        var resp = await _signInWithGoogle();

                        if (resp != null &&
                            googleLoginUser.email != null &&
                            googleLoginUser.email.isNotEmpty &&
                            googleLoginUser.displayName != null &&
                            googleLoginUser.displayName.isNotEmpty) {
                          print("resp ${resp.toString()}");
                          await Fluttertoast.showToast(
                            msg: AppLocalizations.of("Google Login Success"),
                          );

                          await _apiLogin(LOGIN_TYPE_GMAIL, "");
                        }
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          border: Border(
                            left: BorderSide(
                              color: ColorConstant.COLOR_BUTTON,
                              width: 1.0,
                            ),
                            top: BorderSide(
                              color: ColorConstant.COLOR_BUTTON,
                              width: 1.0,
                            ),
                            bottom: BorderSide(
                              color: ColorConstant.COLOR_BUTTON,
                              width: 1.0,
                            ),
                            right: BorderSide(
                              color: ColorConstant.COLOR_BUTTON,
                              width: 1.0,
                            ),
                          ),
                        ),
                        child: Row(
                          children: [
                            Container(
                                padding: EdgeInsets.all(5),
                                child: Image.asset(
                                  ImgConstants.GOOGLE_LOGO,
                                  height: height1 * 0.03,
                                )),
                            Expanded(
                              child: Container(
                                color: ColorConstant.COLOR_BUTTON,
                                padding: EdgeInsets.only(top: 13, bottom: 13),
                                child: Text(
                                  AppLocalizations.of("Sign in with Google"),
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: ColorConstant.COLOR_WHITE,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: AppLocalizations.of(
                            "By loggin in, you accept you are 18+ and agree to our "),
                        style: Theme.of(context).textTheme.caption.copyWith(
                            height: 1.5, color: ColorConstant.COLOR_TEXT),
                        children: <TextSpan>[
                          TextSpan(
                            text: AppLocalizations.of("T&C"),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500,
                                height: 1.5,
                                decoration: TextDecoration.underline),
                          ),
                          TextSpan(
                            text: AppLocalizations.of("  &  "),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500,
                                height: 1.5),
                          ),
                          TextSpan(
                            text: AppLocalizations.of("Privacy Policy"),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500,
                                decoration: TextDecoration.underline,
                                height: 1.5),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 40,
                    ),

                    Container(
                      height: height1 * 0.24,
                      color: ColorConstant.COLOR_WHITE,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30.0, right: 30, bottom: 20),
                        child: Column(
                          children: [
                            Image.asset(
                              ImgConstants.APP_LOGO,
                              height: height1 * 0.12,
                            ),
                            SizedBox(
                              height: height1 * 0.02,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                  text: AppLocalizations.of(
                                      'By creating an account or logging in, you agree to balleballe11 '),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w400,
                                      ),
                                  children: <TextSpan>[
                                    TextSpan(
                                      text: AppLocalizations.of(
                                          'Condition of Use and Privacy Policy'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w400,
                                              height: 1.5),
                                    ),
                                  ]),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}
