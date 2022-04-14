import 'dart:developer';

import 'package:balleballe11/Language/appLocalizations.dart';
import 'package:balleballe11/apiService/apiServices.dart';
import 'package:balleballe11/apiService/dioClient.dart';
import 'package:balleballe11/constance/color_constant.dart';
import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/model/contest_type_model.dart';
import 'package:balleballe11/model/joinnew_contest_status.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_contest_model.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'allcontest.dart';
import 'contest.dart';
import 'createTeam/create_team.dart';
import 'join_contest/select_team_join_contest.dart';
import 'myMatches/mycontest_live_page.dart';

class MyContestsPage extends StatefulWidget {
  Upcomingmatch selectedMatchData;
  bool isFromView = false;
  String pageFromMatch = "";
  VoidCallback onClickJoinContest;

  MyContestsPage(
    Upcomingmatch selectedMatchData, {
    bool isFromView,
    String pageFromMatch,
    onClickJoinContest,
  }) {
    this.selectedMatchData = selectedMatchData;
    this.isFromView = isFromView;
    this.pageFromMatch = pageFromMatch;
    this.onClickJoinContest = onClickJoinContest;
  }

  @override
  _MyContestsPageState createState() => _MyContestsPageState();
}

class _MyContestsPageState extends State<MyContestsPage> {
  bool isProgressRunning = true;
  bool _isProgressRunning = true;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  MyContestModel myContestModel = MyContestModel();
  List<MyJoinedContest> getMyContestList = <MyJoinedContest>[];
  ContestTypeModel contestTypeModel = ContestTypeModel();

  @override
  void initState() {
    super.initState();
    getDefaultContestByType();
    getMyContest();
  }

  Future<void> getDefaultContestByType() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      //    contestTypeModel.response.myjoinedContest[index],
      
        contestTypeModel = await APIServices.getDefaultContestByType(
            widget.selectedMatchData?.matchId);

      setState(() {
        contestTypeModel = contestTypeModel;
      });
      
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

  Widget _noAnyJoinContest() {
    return Center(
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
            visible: widget.isFromView != null && !widget.isFromView,
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
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ContestPage(
                                  selectedMatchData:
                                      widget.selectedMatchData ?? null,
                                )),
                      );
                    },

                    //  widget.onClickJoinContest,
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
    );
  }

  Widget _getLeaguesList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return _getLeaguesItem(context, index);
      },
      itemCount: getMyContestList?.length ?? 0,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget _getLeaguesItem(BuildContext context, int index) {
    return Padding(
      padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: InkWell(
        onTap: () async {
          // Defaultcontest myContestData = Defaultcontest();
          // myContestData = myContestData.clone(
          //     getMyContestList[index],
          //     getMyContestList[index].prizeBreakup,
          //     getMyContestList[index].myJoinedTeams);

          //  await  getDefaultContestByType();

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyContestLivePage(
                  contestDetails: getMyContestList[index],
                  selectedMatchData: widget.selectedMatchData,
                  selectedContestData:
                      contestTypeModel.response?.myjoinedContest[index],
                  isFromView: widget.isFromView,
                  pageFromMatch: widget.pageFromMatch),
            ),
          );
        },
        child: Card(
          elevation: 2.0,
          color: ColorConstant.COLOR_WHITE,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.COLOR_GREY, width: 0.8),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: ColorConstant.COLOR_GREY, width: 0.8),
              ),
            ),
            child: Flex(
              direction: Axis.vertical,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Flex(
                          direction: Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: team(context, index),
                        ),
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 1.0,
                  color: ColorConstant.COLOR_LIGHT_GREY,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> team(BuildContext context, int contestindex) {
    return [
      Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Prize Pool",
                style: Theme.of(context).textTheme.subtitle2.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
              ),
              SizedBox(height: 5.0),
              Text(
                "₹${getMyContestList[contestindex].totalWinningPrize ?? ""}",
                style: TextStyle(
                    color: ColorConstant.COLOR_TEXT,
                    fontWeight: FontWeight.bold,
                    fontSize: 14.0),
              ),
            ],
          ),
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Flex(
                direction: Axis.vertical,
                children: [
                  Text(
                    "Entry",
                    style: TextStyle(
                      color: ColorConstant.COLOR_GREY,
                      fontSize: 12.0,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 25,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstant.COLOR_TEXT, // background
                        onPrimary: ColorConstant.COLOR_WHITE, // foreground
                      ),
                      onPressed: () async {
                        JoinNewContestStatusModel joinResp =
                            await APIServices.joinNewContestStatus(
                                getMyContestList[contestindex].contestId,
                                widget.selectedMatchData.matchId);
                        if (joinResp.teamList == null) {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => CreateTeamPage(
                                  selectedMatchData: widget?.selectedMatchData,
                                  remainingTime: "")));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SelectTeamForJoinContest2(
                                  selectedMatchData: widget.selectedMatchData,
                                  contestId:
                                      getMyContestList[contestindex].contestId,
                                  selectedContestData: contestTypeModel
                                      .response.myjoinedContest[contestindex],
                                  i: getMyContestList[contestindex]
                                          .maxAllowedTeam ??
                                      0,
                                ),
                              ));
                        }
                      },
                      child: Text(
                          '₹${getMyContestList[contestindex].entryFees ?? ""}'),
                    ),
                  )
                ],
              ),
            ],
          )
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      LinearPercentIndicator(
        padding: EdgeInsets.all(3.0),
        lineHeight: 9.0,
        percent: getMyContestList[contestindex].filledSpots != null &&
                getMyContestList[contestindex].filledSpots > 0
            ? (getMyContestList[contestindex].filledSpots /
                    getMyContestList[contestindex].totalSpots *
                    100) /
                100
            : 0.0,
        linearStrokeCap: LinearStrokeCap.roundAll,
        backgroundColor: ColorConstant.COLOR_CONTEST_BACKGROUND,
        progressColor: ColorConstant.COLOR_YELLOW,
      ),
      SizedBox(height: 6.0),
      Flex(
        direction: Axis.horizontal,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Visibility(
            visible: getMyContestList[contestindex].filledSpots != null &&
                getMyContestList[contestindex].filledSpots > 0,
            child: RichText(
              text: TextSpan(
                children: [
                  if (getMyContestList[contestindex].totalSpots ==
                      getMyContestList[contestindex].filledSpots)
                    TextSpan(
                      text: "Contest Full",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xffec9f83),
                          fontWeight: FontWeight.w800),
                    )
                  else
                    TextSpan(
                      text: (getMyContestList[contestindex].totalSpots ==
                              getMyContestList[contestindex].filledSpots)
                          ? ""
                          : "${(getMyContestList[contestindex].totalSpots - getMyContestList[contestindex].filledSpots)} Spots Left",
                      style: TextStyle(
                          fontSize: 12.0,
                          color: Color(0xffec9f83),
                          fontWeight: FontWeight.w800),
                    ),
                  // TextSpan(
                  //   text: " Spots Left",
                  //   style: TextStyle(
                  //       fontSize: 12.0,
                  //       color: Color(0xffec9f83),
                  //       fontWeight: FontWeight.w800),
                  // ),
                ],
              ),
            ),
          ),
          RichText(
            text: TextSpan(
              children: [
                TextSpan(
                  text: "${getMyContestList[contestindex].totalSpots ?? ""}",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xffec9f83),
                      fontWeight: FontWeight.w800),
                ),
                TextSpan(
                  text: " Spots",
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Color(0xffec9f83),
                      fontWeight: FontWeight.w800),
                ),
              ],
            ),
          ),
        ],
      ),
      const SizedBox(
        height: 10,
      ),
      Container(
        color: ColorConstant.COLOR_LIGHT_PINK2,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 8.0, bottom: 8, left: 10, right: 10),
          child: Row(
            children: [
              Image.asset(
                ImgConstants.CUP,
                height: 18,
                width: 18,
                color: ColorConstant.COLOR_BLACK,
              ),
              const SizedBox(
                width: 8,
              ),
              Text("₹${getMyContestList[contestindex].firstPrice ?? ""}"),
            ],
          ),
        ),
      ),
      ListView.builder(
        padding: EdgeInsets.zero,
        itemBuilder: (context, index) {
          return teamjoin(contestindex, index);
        },
        itemCount: getMyContestList[contestindex].joinedTeams?.length,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
      ),
    ];
  }

  Widget teamjoin(int contestindex, int index) {
    return Column(
      children: [
        Container(
          color: ColorConstant.COLOR_LIGHT_BLUE2,
          child: Padding(
            padding: const EdgeInsets.only(
                top: 10.0, bottom: 10, left: 10, right: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "${getMyContestList[contestindex].joinedTeams[index].teamName ?? ""}",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                Text(
                  "${getMyContestList[contestindex].joinedTeams[index].points ?? ""}",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400,
                      ),
                ),
                Text(
                  "#${getMyContestList[contestindex].joinedTeams[index].rank ?? ""}",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.w400,
                      ),
                ),
              ],
            ),
          ),
        ),
        Divider(
          color: ColorConstant.COLOR_BLACK,
          height: 0,
        )
      ],
    );
  }

  void _onRefresh() async {
    setState(() {
      myContestModel = null;
      getMyContestList.clear();
    });
    await getMyContest();
    _refreshController.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isProgressRunning
          ? ColorConstant.COLOR_WHITE
          : ColorConstant.BACKGROUND_COLOR,
      body: isProgressRunning || _isProgressRunning
          ? ShimmerProgressWidget(
              count: 8, isProgressRunning: isProgressRunning || _isProgressRunning)
          : getMyContestList != null && getMyContestList.length > 0
              ? SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: false,
                  onRefresh: _onRefresh,
                  controller: _refreshController,
                  header: MaterialClassicHeader(
                      color: ColorConstant.COLOR_TEXT,
                      backgroundColor: ColorConstant.COLOR_WHITE),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    scrollDirection: Axis.vertical,
                    children: [_getLeaguesList()],
                  ),
                )
              : _noAnyJoinContest(),
    );
  }
}
