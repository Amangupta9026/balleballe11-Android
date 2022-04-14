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
import 'package:balleballe11/sports/contest.dart';
import 'package:balleballe11/sports/contest/myTeam.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'package:fbroadcast/fbroadcast.dart';

import '1_player_game.dart';

class ContestTab extends StatefulWidget {
  String remainingTime = "";
  Upcomingmatch selectedMatchData;
  // Upcomingmatch selectedUpcomingMatchData;
  String isFrom = "";
  int guru = 0;

  ContestTab(
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
  _ContestTabState createState() => _ContestTabState();
}

class _ContestTabState extends State<ContestTab>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  bool isProgressRunning = true;

  FBroadcast b1, b2;
  var selectedUpcomingData;
  bool _isProgressRunning = false;
  GetMyTeamByIdResponseModel _getMyTeamResponseModel =
      GetMyTeamByIdResponseModel();
  MyContestModel myContestModel = MyContestModel();
  List<MyJoinedContest> getMyContestList = <MyJoinedContest>[];
  CountdownTimerController controller;
  bool selectedIndex = true;
  int selectedIndex2;
  // num teamcount;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    selectedUpcomingData = widget.selectedMatchData;

    // getMyTeamList();
    // getMyContest();
  }

  Future<void> _handleTabs() async {
    // setState(() {
    //   if (global.totalTeamCount != null && global.totalTeamCount != "0") {
    //     global.totalTeamCount = 0;
    //   } else {
    //     global.totalTeamCount = 0;
    //   }
    //   if (global.totalMyContestCount != null &&
    //       global.totalMyContestCount != 0) {
    //     global.totalMyContestCount = 0;
    //   }
    // });
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
                ContestPage(
                  selectedMatchData: selectedUpcomingData,
                ),
                Player1Game(
                  selectedMatchData: selectedUpcomingData,
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
        backgroundColor: ColorConstant.COLOR_WHITE,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 28,
            color: ColorConstant.COLOR_TEXT,
          ),
        ),
        title: Column(
          children: [
            Row(
              children: [
                RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    text: "${selectedUpcomingData?.teama?.shortName ?? ""}",
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.bold,
                        ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '  VS  ',
                        style: Theme.of(context).textTheme.overline.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      TextSpan(
                        text: "${selectedUpcomingData?.teamb?.shortName ?? ""}",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ],
                  ),
                ),
                Spacer(),
                CountdownTimer(
                  controller: controller,
                  endTime: widget.selectedMatchData.timestampStart * 1000,
                  textStyle: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 12.0, color: ColorConstant.COLOR_PINK),
                  onEnd: () {
                    showAlertDialog(context);
                  },
                  widgetBuilder: (_, CurrentRemainingTime time) {
                    if (time != null) {
                      return time.days != null
                          ? Text(
                              '${time.days}d ${time.hours}h ${time.min}m ${time.sec}s left',
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      fontSize: 12.0,
                                      color: ColorConstant.COLOR_PINK),
                            )
                          : time.hours != null
                              ? Text(
                                  '${time.hours}h ${time.min}m ${time.sec}s left',
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                          fontSize: 12.0,
                                          color: ColorConstant.COLOR_PINK),
                                )
                              : time.min != null
                                  ? Text('${time.min}m ${time.sec}s left',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              fontSize: 12.0,
                                              color: ColorConstant.COLOR_PINK))
                                  : Text('${time.sec}s left',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              fontSize: 12.0,
                                              color: ColorConstant.COLOR_PINK));
                    }

                    return Text("");
                  },
                ),
              ],
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: Size.fromHeight(35),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorConstant.COLOR_WHITE,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 10.0, right: 10),
                      child: Container(
                        color: ColorConstant.COLOR_WHITE,
                        child: TabBar(
                            indicatorPadding: EdgeInsets.zero,
                            indicatorColor: Colors.transparent,
                            labelPadding: EdgeInsets.symmetric(vertical: 0.0),
                            // indicatorPadding:
                            //     EdgeInsets.only(left: 0, right: 0),
                            // indicatorColor: ColorConstant.COLOR_TEXT,

                            //    indicatorSize: TabBarIndicatorSize.tab,
                            labelColor: ColorConstant.COLOR_WHITE,
                            labelStyle:
                                Theme.of(context).textTheme.caption.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.bold,
                                    ),
                            unselectedLabelColor: selectedIndex2 == 1
                                ? ColorConstant.COLOR_TEXT
                                : ColorConstant.COLOR_WHITE,
                            controller: _tabController,
                            tabs: [
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selectedIndex
                                      ? ColorConstant.COLOR_GREEN2
                                      : ColorConstant.COLOR_GREY2,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 9.0,
                                    bottom: 9,
                                  ),
                                  child: Text(
                                    "FANTASY",
                                    textAlign: TextAlign.center,
                                    // style: Theme.of(context)
                                    //     .textTheme
                                    //     .caption
                                    //     .copyWith(
                                    //       color: ColorConstant.COLOR_WHITE,
                                    //       fontWeight: FontWeight.w500,
                                    //     ),
                                  ),
                                ),
                              ),
                              Container(
                                width: MediaQuery.of(context).size.width / 2,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: selectedIndex
                                      ? ColorConstant.COLOR_GREY2
                                      : ColorConstant.COLOR_GREEN2,
                                  shape: BoxShape.rectangle,
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                    top: 1.0,
                                    bottom: 1,
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Image.asset(
                                        ImgConstants.FRIEND,
                                        width: 30,
                                      ),
                                      Flexible(
                                        child: Text(
                                          "1 PLAYER GAME",
                                          textAlign: TextAlign.center,
                                          // style: Theme.of(context)
                                          //     .textTheme
                                          //     .caption
                                          //     .copyWith(
                                          //       color:
                                          //           ColorConstant.COLOR_WHITE,
                                          //       fontWeight: FontWeight.w500,
                                          //     ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
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
