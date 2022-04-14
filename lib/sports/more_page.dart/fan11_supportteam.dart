import 'package:balleballe11/constance/packages.dart';
import 'package:url_launcher/url_launcher.dart';

class balleballe11SupportTeam extends StatefulWidget {
  const balleballe11SupportTeam({Key key}) : super(key: key);

  @override
  _balleballe11SupportTeamState createState() =>
      _balleballe11SupportTeamState();
}

class _balleballe11SupportTeamState extends State<balleballe11SupportTeam> {
  @override
  Widget build(BuildContext context) {
    String uri = "https://gmail.com/";
    String launchtelegram = "https://t.me/balleballe11Live";

    _sendMail() async {
      // Android and iOS
      const uri = 'mailto:info@balleballe11.in';
      if (await canLaunch(uri)) {
        await launch(uri);
      } else {
        throw 'Could not launch $uri';
      }
    }

    void _launchTelegram() async => await canLaunch(launchtelegram)
        ? await launch(launchtelegram)
        : throw 'Could not launch $launchtelegram';

    return Scaffold(
      backgroundColor: Color(0xfffafafa),
      appBar: AppBar(
        backgroundColor: ColorConstant.COLOR_WHITE,
        title: Text(
          'Support Team',
          style: Theme.of(context).textTheme.subtitle1.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.bold,
              ),
        ),
        leading: InkWell(
          onTap: () => Navigator.pop(context),
          child: Icon(
            Icons.arrow_back,
            color: ColorConstant.COLOR_TEXT,
            size: 25,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10.0, 18, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Get in Touch",
                style: Theme.of(context).textTheme.headline5.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.bold,
                    ),
              ),
              const SizedBox(
                height: 6,
              ),
              Container(
                color: ColorConstant.COLOR_TEXT,
                width: MediaQuery.of(context).size.width * 0.36,
                height: 2,
              ),
              const SizedBox(
                height: 30,
              ),
              Text(
                "Our support team available on given WhatsApp, Call, Email & SMS.",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                      height: 1.2,
                    ),
              ),
              const SizedBox(
                height: 10,
              ),
              Text(
                "Please feel free to contact us",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w300,
                    ),
              ),
              const SizedBox(
                height: 20,
              ),
              Center(
                child: Text(
                  "CONNECT WITH",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  InkWell(
                    onTap: () {
                      _sendMail();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstant.COLOR_WHITE,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            ImgConstants.GMAIL,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Email",
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  InkWell(
                    onTap: () {
                      _launchTelegram();
                    },
                    child: Container(
                      width: MediaQuery.of(context).size.width / 2.3,
                      padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: ColorConstant.COLOR_WHITE,
                      ),
                      child: Column(
                        children: [
                          Image.asset(
                            ImgConstants.TELEGRAM,
                            height: 50,
                            width: 50,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Telegram",
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  launch("https://wa.me/919302512306");
                },
                child: Center(
                  child: Container(
                    width: MediaQuery.of(context).size.width / 2.3,
                    padding: EdgeInsets.fromLTRB(0, 8, 0, 8),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: ColorConstant.COLOR_WHITE,
                    ),
                    child: Column(
                      children: [
                        Image.asset(
                          ImgConstants.WHATSAPP,
                          height: 50,
                          width: 50,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(
                          "WhatsApp",
                          style: Theme.of(context).textTheme.subtitle2.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
