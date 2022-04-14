import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/model/my_contest_model.dart';
import 'package:balleballe11/sports/myMatches/Upcoming/upcoming_matches.dart';
import 'package:balleballe11/sports/my_contest.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'Completed/completed_match_detail_page.dart';
import 'Completed/completed_match_myteam.dart';
import 'my_contest_live.dart';

class MatchContestByLiveCompleted extends StatefulWidget {
  String pageFromMatch = "";
  Completed selectedMatchData;
  String teama;
  String teamb;
  String status;
//  int matchId;

  // ScoreData selectedData;

  MatchContestByLiveCompleted({
    this.selectedMatchData,
    this.pageFromMatch,
    this.teama,
    this.teamb,
    this.status,
    //   this.matchId

    //    this.selectedData
  }) {
    this.pageFromMatch = pageFromMatch;
    this.selectedMatchData = selectedMatchData;
    // this.selectedData = selectedData;
  }

  @override
  _MatchContestByLiveCompletedState createState() =>
      _MatchContestByLiveCompletedState();
}

class _MatchContestByLiveCompletedState
    extends State<MatchContestByLiveCompleted>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  // GetMatchScoreBoardRespModel matchScoreBoard = GetMatchScoreBoardRespModel();
  bool isProgressRunning = false;
  int myTeamCount = 0;
  int contestCount = 0;
  bool isloading = false;
  MyCompletedMatchesModel _matchCompleteeData = MyCompletedMatchesModel();
  List<Completed> _completedMatchLists = <Completed>[];
  bool _isProgressRunning = false;
  MyContestModel myContestModel = MyContestModel();
  List<MyJoinedContest> getMyContestList = <MyJoinedContest>[];
  GetMyTeamByIdResponseModel _getMyTeamResponseModel =
      GetMyTeamByIdResponseModel();

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    //  CheckApiData();
    _getCompletedMatches();
    getMyContest();
    getMyTeamList();
    _tabController = TabController(length: 2, vsync: this);
    // Future.delayed(Duration.zero, () {
    //   isloading = false;
    // });
  }

  Future<void> _getCompletedMatches() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _matchCompleteeData =
          await APIServices.getMyCompletedMatches("completed");
      _completedMatchLists.clear();
      if (_matchCompleteeData != null)
        //  if (_matchCompleteeData.response.matchdata.length > 0)
        //   {
        _completedMatchLists
            .addAll(_matchCompleteeData.response.matchdata[0].completed);
      // }

      //   log("${_completedMatchLists.length}", name: "length");
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      if (mounted)
        setState(() {
          _isProgressRunning = false;
        });
    }
  }

  // Future<void> CheckApiData() async {
  //   if (_matchCompleteeData == null) {

  //     setState(() {
  //       isloading = true;
  //     });
  //     _getCompletedMatches();
  //   }
  // }

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

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstant.COLOR_WHITE,
      // transparent status bar
    ));
    return SafeArea(
      child: DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          backgroundColor: ColorConstant.BACKGROUND_COLOR,
          appBar: _buildAppBar(),
          body: isloading
              ? ShimmerProgressWidget(
                  count: 8, isProgressRunning: isProgressRunning)
              : TabBarView(
                  controller: _tabController,
                  children: [
                    CompletedMatchDetailPage(
                      widget.selectedMatchData,
                      //  widget.matchId,
                      isFromView: true, pageFromMatch: widget.pageFromMatch,
                      //  onClickJoinContest: ,
                    ),
                    CompletedMyTeamPage(
                      widget.selectedMatchData,
                      //  widget.matchId,
                      isFromView: true,
                      //    pageFromMatch: widget.pageFromMatch,
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      centerTitle: true,
      backgroundColor: ColorConstant.COLOR_WHITE,
      title: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "${widget?.selectedMatchData?.teama?.shortName ?? widget.teama} vs ${widget?.selectedMatchData?.teamb?.shortName ?? widget.teamb}",
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: ColorConstant.COLOR_TEXT,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
                ),
          ),
          Spacer(),
          Text(
            "${widget?.selectedMatchData?.statusStr?.toUpperCase() ?? widget.status.toUpperCase()}",
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: ColorConstant.COLOR_PINK,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
          ),
        ],
      ),
      leading: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Icon(
          Icons.arrow_back,
          color: ColorConstant.COLOR_TEXT,
        ),
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: ColorConstant.BACKGROUND_COLOR,
              child: Container(
                child: TabBar(
                    indicatorColor: ColorConstant.COLOR_TEXT,
                    indicatorWeight: 2.0,
                    labelPadding: EdgeInsets.symmetric(
                      vertical: 10.0,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: ColorConstant.COLOR_RED,
                    labelStyle: Theme.of(context).textTheme.caption.copyWith(
                          fontSize: 14.0,
                          fontWeight: FontWeight.bold,
                        ),
                    unselectedLabelColor: ColorConstant.COLOR_TEXT,
                    unselectedLabelStyle:
                        Theme.of(context).textTheme.caption.copyWith(
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400,
                            ),
                    controller: _tabController,

                    //tabs: _tabList != null ? _tabList : [],
                    tabs: [
                      Text(
                        "CONTEST(${getMyContestList?.length ?? 0})",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        "Teams (${_getMyTeamResponseModel?.response?.myteam?.length ?? 0})",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
