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
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'contest/myTeam.dart';
import 'package:balleballe11/constance/global.dart' as global;
import 'package:fbroadcast/fbroadcast.dart';

import 'guru_tab/guru_ui.dart';
import 'my_contest.dart';

class ContestPage extends StatefulWidget {
  String remainingTime = "";
  Upcomingmatch selectedMatchData;
  // Upcomingmatch selectedUpcomingMatchData;
  String isFrom = "";

  ContestPage(
      {this.selectedMatchData,
      this.remainingTime,
      this.isFrom,
      //   this.selectedUpcomingMatchData,
    }) {
    this.remainingTime = remainingTime;
    this.selectedMatchData = selectedMatchData;
    //   this.selectedUpcomingMatchData;
    this.isFrom = isFrom;
   
  }

  @override
  _ContestPageState createState() => _ContestPageState();
}

class _ContestPageState extends State<ContestPage>
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

  Future<void> getMyTeamList() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _getMyTeamResponseModel = await APIServices.getMyTeamByPlayerId(
          widget.selectedMatchData.matchId);

      //   await getMyTeamListDetails();
      //  _getMyTeamLists.addAll(_getMyTeamResponseModel.data);
      //    log("${_getMyTeamLists.length}", name: "getMyTeamLists");

      // setState(() {
      //   global.totalTeamCount = _getMyTeamResponseModel?.teamCount ?? 0;
      // });
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, error);
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  Future<void> getMyContest() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      myContestModel =
          await APIServices.getMyContestData(widget.selectedMatchData?.matchId);

      if (myContestModel != null &&
          myContestModel.response.myJoinedContest != null &&
          myContestModel.response.myJoinedContest.length > 0) {
        setState(() {
          getMyContestList.addAll(myContestModel.response.myJoinedContest);
        });
      }
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, error);
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }
  

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
    //  : widget.selectedUpcomingMatchData;
    getMyTeamList();
    getMyContest();

    //   Future.delayed(Duration.zero, () {
    //   _handleTabs();
    // });

    // FBroadcast.instance().register("totalMyContestCount", (value, callback) {
    //   setState(() {
    //     global.totalMyContestCount = value;
    //   });
    // });
    // FBroadcast.instance().register("totalTeamCount", (value, callback) {
    //   setState(() {
    //     global.totalTeamCount = value;
    //   });
    // });
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
    _tabController =
        TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: ColorConstant.COLOR_WHITE,
      child: SafeArea(
        child: DefaultTabController(
          initialIndex: 0,
          length: 3,
          //selectedUpcomingData[index].totalGuru
          //  4,
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
                MyContestsPage(
                  selectedUpcomingData,
                  isFromView: false,
                  pageFromMatch: widget.isFrom,
                  onClickJoinContest: () {
                    _tabController.index = 0;
                  },
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
        // titleSpacing: 0,
        // leadingWidth: 0,
        backgroundColor: Color(0xfff2f3f5),
        //ColorConstant.COLOR_WHITE,
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
          preferredSize: Size.fromHeight(40),
          child: Column(
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
                          "CONTEST(${getMyContestList?.length ?? 0})",
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        
                        Text(
                          "Teams (${_getMyTeamResponseModel?.response?.myteam?.length ?? 0})",
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
