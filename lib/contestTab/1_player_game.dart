import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/contest_type_model.dart'
    as contestTypeModelResponse;
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_contest_model.dart';
//import 'package:balleballe11/model/my_joined_upcomingmatches.dart';
//import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/sports/allcontest.dart';
import 'package:balleballe11/sports/contest/myTeam.dart';
import 'package:balleballe11/sports/my_contest.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:balleballe11/constance/global.dart' as global;
import 'package:fbroadcast/fbroadcast.dart';

class Player1Game extends StatefulWidget {
  String remainingTime = "";
  Upcomingmatch selectedMatchData;
  // Upcomingmatch selectedUpcomingMatchData;
  String isFrom = "";
  int guru = 0;

  Player1Game(
      {this.selectedMatchData,
      this.remainingTime,
      this.isFrom,
      //   this.selectedUpcomingMatchData,
      this.guru}) {
    this.remainingTime = remainingTime;
    this.selectedMatchData = selectedMatchData;
    //   this.selectedUpcomingMatchData;
    this.isFrom = isFrom;
    // this.guru = guru;
  }

  @override
  _Player1GameState createState() => _Player1GameState();
}

class _Player1GameState extends State<Player1Game>
    with SingleTickerProviderStateMixin {
  contestTypeModelResponse.ContestTypeModel contestTypeModel =
      contestTypeModelResponse.ContestTypeModel();
  TabController _tabController;
  bool isProgressRunning = true;
  List<contestTypeModelResponse.Response> contestTypeDataList =
      <contestTypeModelResponse.Response>[];
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);

  FBroadcast b1, b2;
  var selectedUpcomingData;
  bool _isProgressRunning = false;
  GetMyTeamByIdResponseModel _getMyTeamResponseModel =
      GetMyTeamByIdResponseModel();
  MyContestModel myContestModel = MyContestModel();
  List<MyJoinedContest> getMyContestList = <MyJoinedContest>[];
  CountdownTimerController controller;
  // num teamcount;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedUpcomingData =
        //widget?.selectedMatchData != null
        //  ?
        widget.selectedMatchData;
  }

  Future<void> _handleTabs() async {
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.COLOR_WHITE,
      child: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 2,
          child: Scaffold(
            appBar: buildAppBar(),
            backgroundColor: ColorConstant.BACKGROUND_COLOR,
            body: TabBarView(
              //  physics: AlwaysScrollableScrollPhysics(),
              controller: _tabController,
              children: [
                ALLContest(
                  selectedMatchData: selectedUpcomingData,
                ),
                MyTeamPage(
                  selectedUpcomingData,
                  isFromView: false,
                  pageFromMatch: StringConstant.UPCOMING_MATCHES,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  buildAppBar() {
    return AppBar(
        titleSpacing: 0,
        leadingWidth: 0,
        backgroundColor: Color(0xfff2f3f5),
        title: Column(
          children: [
            Container(
              color: Color(0xfff2f3f5),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 0.0, right: 0, top: 10, bottom: 0),
                child: TabBar(
                    indicatorPadding: EdgeInsets.only(left: 0, right: 0),
                    indicatorColor: ColorConstant.COLOR_TEXT,
                    labelPadding:
                        EdgeInsets.symmetric(vertical: 15.0, horizontal: 0),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: ColorConstant.COLOR_TEXT,
                    labelStyle: Theme.of(context).textTheme.overline.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.bold,
                        ),
                    unselectedLabelColor: ColorConstant.COLOR_TEXT,
                    // unselectedLabelStyle:
                    //     Theme.of(context).textTheme.caption.copyWith(
                    //           fontSize: 14.0,
                    //           fontWeight: FontWeight.w400,
                    //         ),
                    controller: _tabController,
                    tabs: [
                      Text(
                        "ALL CONTESTS",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        "JOINED CONTEST",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ]),
              ),
            ),
          ],
        ));
  }

  void showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget okButton = TextButton(
      child: Text("OK", style: TextStyle(fontSize: 18)),
      onPressed: () {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) => HomeScreen()),
            (Route<dynamic> route) => false);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      content: Text("Time is Over , Please Go to Upcoming Matches?"),
      actions: [
        okButton,
      ],
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
