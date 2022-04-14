import 'package:balleballe11/constance/packages.dart';

class LiveMatchNoContestPage extends StatelessWidget {
  const LiveMatchNoContestPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 100,
            ),
            Text(
              AppLocalizations.of("You haven't join any contest yet!"),
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: ColorConstant.COLOR_TEXT,
                    fontWeight: FontWeight.w600,
                    fontSize: 18.0,
                  ),
            ),
            SizedBox(
              height: 10.0,
            ),
            Visibility(
              visible: true,
              //widget.isFromView != null && !widget.isFromView,
              child: Column(
                children: [
                  Text(
                    AppLocalizations.of('What are you waiting for?'),
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontSize: 14.0,
                        ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(6.0),
                    ),
                    child: InkWell(
                      //  onTap: widget.onClickJoinContest,
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          color: ColorConstant.COLOR_RED,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of('Join Contest'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.white,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
