import 'dart:convert';
import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/widget/utils.dart';
import 'package:firebase_auth/firebase_auth.dart' as auth;
import 'package:firebase_auth/firebase_auth.dart';

class RegisterPage extends StatefulWidget {
  auth.User googleLoginUser;
  bool isFromGoogle = false;
  String keyEmail = "email_id";
  String name = "user_name";
  String photo = "photo_user";
  String loginType = "login_type";
  bool isNavigatorGoogle = false;

  RegisterPage(
      {this.keyEmail,
      this.name,
      this.photo,
      this.loginType,
      this.isNavigatorGoogle}) {
    this.keyEmail = keyEmail;
    this.name = name;
    this.photo = photo;
    this.loginType = loginType;
    this.isNavigatorGoogle;
  }

  //  Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController _teamNameController = TextEditingController();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _referralController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _otpController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isProgressRunning = false;
  final GoogleSignIn googleSignIn = GoogleSignIn();
  bool _isChecking = true;

  Future<void> google() async {
    final googlename = await FirebaseAuth.instance.currentUser.displayName;
    final String googleemail = await FirebaseAuth.instance.currentUser.email;
    _emailController.text = googleemail;
    _nameController.text = googlename;
    log(" google email ${_emailController.text}");
    _isChecking = false;
  }

  @override
  void initState() {
    super.initState();
    if (widget.isNavigatorGoogle ?? false) {
      google();
    }
  }

  Future<void> _apiRequestOfRegister() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      LoginModel loginResp = await APIServices.getRegisterApi(
          _teamNameController.text,
          _nameController.text,
          _mobileController.text,
          _emailController.text,
          _referralController.text);
      if (loginResp.status == true) {
        SharedPreference.setValue(PrefConstants.USER_ID, loginResp.data.userId);
        SharedPreference.setValue(
            PrefConstants.USER_EMAIL, loginResp.data?.email ?? "Email");
        SharedPreference.setValue(
            PrefConstants.USER_NAME, loginResp.data?.name ?? "Name");
        SharedPreference.setValue(
            PrefConstants.USER_MOB_NO, loginResp.data?.mobileNumber ?? "");

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
        SharedPreference.setValue(
            PrefConstants.USER_REFERAL, loginResp.data?.referalCode ?? "");
        SharedPreference.setValue(PrefConstants.IS_LOGIN, true);
        //showCommonMessageDialog(context, loginResp.message);

        //  if (widget.isFromGoogle != null && widget.isFromGoogle) {
        Navigator.pushAndRemoveUntil<dynamic>(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => HomeScreen(),
          ),
          (route) => false,
        );
        //  } else {
        //  _showOTPDialog(context);
        //  }
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
  Widget build(BuildContext context) {
    final node = FocusScope.of(context);
    double height1 = MediaQuery.of(context).size.height;

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
          "Register",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      bottomSheet: Container(
        height: height1 * 0.20,
        color: ColorConstant.BACKGROUND_COLOR,
        child: Padding(
          padding: const EdgeInsets.only(left: 30.0, right: 30, bottom: 10),
          child: Column(
            children: [
              Image.asset(
                ImgConstants.APP_LOGO,
                height: height1 * 0.10,
              ),
              SizedBox(
                height: height1 * 0.02,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                    text: AppLocalizations.of(
                        'By creating an account or logging in, you agree to balleballe11 '),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w400,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: AppLocalizations.of(
                            'Condition of Use and Privacy Policy'),
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w500,
                            height: 1.5),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12.0, 20, 12, 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Team Name",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 38,
                decoration: BoxDecoration(
                    color: ColorConstant.COLOR_WHITE,
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 5, 0, 5),
                        child: TextFormField(
                          cursorColor: ColorConstant.COLOR_TEXT,
                          textInputAction: TextInputAction.next,
                          controller: _teamNameController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT, fontSize: 16.0),
                          // validator: (fullName) {
                          //   if (fullName.isEmpty) {
                          //     return "Fullname is required";
                          //   }
                          //   return null;
                          // },
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Enter Name

              const SizedBox(
                height: 10,
              ),

              Text(
                "Enter Name",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 38,
                decoration: BoxDecoration(
                    color: ColorConstant.COLOR_WHITE,
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 5, 0, 5),
                        child: TextFormField(
                          cursorColor: ColorConstant.COLOR_TEXT,
                          textInputAction: TextInputAction.next,
                          controller: _nameController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT, fontSize: 16.0),
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Mobile Number

              const SizedBox(
                height: 10,
              ),

              Text(
                "Mobile Number",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 38,
                decoration: BoxDecoration(
                    color: ColorConstant.COLOR_WHITE,
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 5, 0, 5),
                        child: TextFormField(
                          cursorColor: ColorConstant.COLOR_TEXT,
                          keyboardType: TextInputType.number,
                          textInputAction: TextInputAction.next,
                          controller: _mobileController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT, fontSize: 16.0),
                          validator: (mobileNum) {
                            if (mobileNum.isEmpty && mobileNum.length < 10) {
                              return "Valid mobile number is required";
                            }
                            return null;
                          },
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Email Id

              const SizedBox(
                height: 10,
              ),

              Text(
                "Email",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 38,
                decoration: BoxDecoration(
                    color: ColorConstant.COLOR_WHITE,
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 5, 0, 5),
                        child: TextFormField(
                          enabled: false,
                          cursorColor: ColorConstant.COLOR_TEXT,
                          textInputAction: TextInputAction.next,
                          controller: _emailController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT, fontSize: 16.0),
                          // validator: (fullName) {
                          //   if (fullName.isEmpty) {
                          //     return "Fullname is required";
                          //   }
                          //   return null;
                          // },
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Referral Code

              const SizedBox(
                height: 10,
              ),

              Text(
                "Referral Code",
                style: Theme.of(context).textTheme.bodyText2.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w400,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                height: 38,
                decoration: BoxDecoration(
                    color: ColorConstant.COLOR_WHITE,
                    border: Border.all(color: Colors.grey)),
                child: Row(
                  children: [
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(6, 5, 0, 5),
                        child: TextFormField(
                          cursorColor: ColorConstant.COLOR_TEXT,
                          textInputAction: TextInputAction.next,
                          controller: _referralController,
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT, fontSize: 16.0),
                          // validator: (fullName) {
                          //   if (fullName.isEmpty) {
                          //     return "Fullname is required";
                          //   }
                          //   return null;
                          // },
                          keyboardType: TextInputType.text,
                          decoration: new InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Action Button Upload Profile

              const SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    primary: ColorConstant.COLOR_TEXT, // background
                  ),
                  onPressed: () async {
                    node.unfocus();
                    if (_teamNameController.text.isEmpty &&
                        _nameController.text.isEmpty &&
                        _mobileController.text.isEmpty &&
                        _emailController.text.isEmpty) {
                      UtilsFlushBar.showDefaultSnackbar(
                          context, "Please fill all the fields");
                    } else if (_teamNameController.text.isEmpty) {
                      UtilsFlushBar.showDefaultSnackbar(
                          context, "Please fill Team Name");
                    } else if (_nameController.text.isEmpty) {
                      UtilsFlushBar.showDefaultSnackbar(
                          context, "Please fill Full Name");
                    } else if (_mobileController.text.isEmpty) {
                      UtilsFlushBar.showDefaultSnackbar(
                          context, "Please fill Mobile Number");
                    } else if (_mobileController.text.length != 10) {
                      UtilsFlushBar.showDefaultSnackbar(
                          context, "Please fill Correct Mobile Number");
                    } else if (_emailController.text.isEmpty) {
                      UtilsFlushBar.showDefaultSnackbar(
                          context, "Please fill Email");
                    } else {
                      if (Utils.isValidEmail(
                          _emailController.text.toString())) {
                        await _apiRequestOfRegister();
                      } else {
                        UtilsFlushBar.showDefaultSnackbar(
                            context, "Invalid email address");
                      }
                    }
                  },
                  child: Text(
                    'Register',
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
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
    );
  }
}
