import 'package:balleballe11/constance/packages.dart';
import 'package:share_plus/share_plus.dart';

class RefferalPage extends StatefulWidget {
  const RefferalPage({Key key}) : super(key: key);

  @override
  _RefferalPageState createState() => _RefferalPageState();
}

class _RefferalPageState extends State<RefferalPage> {
  String text = '';
  String subject = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConstant.COLOR_WHITE,
        title: Text(
          'My Refferals Friends',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w700,
              ),
        ),
        leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back, color: ColorConstant.COLOR_TEXT)),
      ),
      body: Stack(
        children: [
          Image.asset(
            ImgConstants.SPLASH_BG,
            fit: BoxFit.fill,
            width: double.infinity,
            height: double.infinity,
          ),
          Positioned(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(color: ColorConstant.COLOR_BLUE3),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Text(
                      "You Have not reffered with any friend".toUpperCase(),
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.subtitle1.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.w600,
                          ),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () async {
                    await Share.share(
                        "Register on balleballe11 application with referral code " +
                            "${SharedPreference.getValue(PrefConstants.USER_REFERAL)}" +
                            " and get Rs 100 Bonus on Joining. \n Click on https://balleballe11.in/upload/apk/balleballe11.apk",
                        subject: "Refer and Earn Rs 100");
                    print("print share");
                  },
                  child: Center(
                    child: Container(
                      color: ColorConstant.COLOR_GREEN2,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 18.0, right: 18.0, top: 18.0, bottom: 18.0),
                        child: Text(
                          "SHARE NOW",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: ColorConstant.COLOR_WHITE,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
              ],
            ),
            left: 0,
            right: 0,
            bottom: 0,
          ),
        ],
      ),
    );
  }
}
