import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:share_plus/share_plus.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({Key key}) : super(key: key);

  @override
  _ReferEarnState createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.COLOR_WHITE,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_TEXT,
          ),
        ),
        title: Text(
          "Share & Earn",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorConstant.COLOR_RED,
              ),
              child: Column(
                children: [
                  Image.asset(
                    ImgConstants.REFER_EARN,
                    height: height1 * 0.20,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 25.0, bottom: 20, left: 25, right: 25),
                    child: Text(
                      "Refer to your friend and Get ₹100 and 20% Affiliate lifetime comission on refer.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.only(left: 10, right: 10, bottom: 15),
                    child: Text(
                      "Refer to your friend and Get ₹100 and 20% Affiliate lifetime comission on refer.",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w500,
                          ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 35.0, bottom: 15),
              child: Text(
                "Referral Code:",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            Container(
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.yellow, // background
                  onPrimary: ColorConstant.COLOR_TEXT, // foreground
                ),
                onPressed: () async {
                  await Share.share(
                      "Register on balleballe11 application with referral code " +
                          "${SharedPreference.getValue(PrefConstants.USER_REFERAL)}" +
                          " and get Rs 100 Bonus on Joining. \n Click on https://balleballe11.in/upload/apk/balleballe11.apk",
                      subject: "Refer and Earn Rs 100");
                  print("print share");
                },
                child: Padding(
                  padding: const EdgeInsets.only(top: 20.0, bottom: 20),
                  child: Row(
                    children: [
                      Spacer(),
                      Center(
                        child: Text(
                          "${SharedPreference.getValue(PrefConstants.USER_REFERAL)}",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      Spacer(),
                      Icon(
                        Icons.copy,
                        color: ColorConstant.COLOR_WHITE,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 40.0, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 25.0),
                    child: Text(
                      "How does it work?",
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage:
                          AssetImage(ImgConstants.SHARE_ALL_MOBILE),
                    ),
                    title: Text(
                      "Invite Your Friends",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      "Just Share your referral code",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: ColorConstant.COLOR_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  // Signup & Deposit

                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(ImgConstants.REFER_EARN3),
                    ),
                    title: Text(
                      "Signup & deposit",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      "Refer your friends for signup & deposit",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: ColorConstant.COLOR_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  //Earn

                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(ImgConstants.REFER_EARN4),
                    ),
                    title: Text(
                      "Earn ₹100",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      "You will get ₹100 and your friend will get ₹100",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: ColorConstant.COLOR_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),

                  // You get life time

                  ListTile(
                    leading: CircleAvatar(
                      backgroundImage: AssetImage(ImgConstants.REFER_EARN5),
                    ),
                    title: Text(
                      "You Get 20% lifetime",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                    subtitle: Text(
                      "You get 20% lifetime commission on refer",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: ColorConstant.COLOR_GREY,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(left: 10.0, right: 10.0),
                    width: double.infinity,
                    color: ColorConstant.COLOR_GREEN2,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 12.0, bottom: 12),
                      child: Text(
                        "REFER FRIENDS",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.subtitle2.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
