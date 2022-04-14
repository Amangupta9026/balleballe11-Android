import 'package:balleballe11/constance/packages.dart';

class AffiliateDetailPage extends StatefulWidget {
  const AffiliateDetailPage({Key key}) : super(key: key);

  @override
  _AffiliateDetailPageState createState() => _AffiliateDetailPageState();
}

class _AffiliateDetailPageState extends State<AffiliateDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.COLOR_WHITE,
      appBar: AppBar(
        backgroundColor: ColorConstant.COLOR_WHITE,
        title: Text(
          'Affiliate Commission',
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
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(top: 15.0, left: 10, right: 10, bottom: 20),
          child: Column(
            children: [
              Text(
                "No AFFILIATE Commission Found",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
