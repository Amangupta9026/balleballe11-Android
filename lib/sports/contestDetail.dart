import 'dart:developer';
import 'dart:math';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/contest_type_model.dart';
import 'package:balleballe11/model/getMyTeamList.dart';
import 'package:balleballe11/model/joinnew_contest_status.dart';
import 'package:balleballe11/model/leaderboard_model.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/prizebreakUpModel.dart';
import 'package:balleballe11/widget/progressContainerView.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'contest/getmyteam_detail_list.dart';
import 'createTeam/create_team.dart';
import 'join_contest/select_team_join_contest.dart';

class ContestDetail extends StatefulWidget {
  Upcomingmatch selectedMatchData;
  Contest contestDetails;
  int contestId;
  Contest selectedContestData;
  int maxAllowedTeam;

  bool isFromView;
  String pageFromMatch = "";
  ContestDetail(
      {Key key,
      this.selectedMatchData,
      this.contestDetails,
      this.contestId,
      this.isFromView,
      this.selectedContestData,
      this.maxAllowedTeam,
      this.pageFromMatch})
      : super(key: key);

  @override
  _ContestDetailState createState() => _ContestDetailState();
}

class _ContestDetailState extends State<ContestDetail> {
  bool isWinningBreakUp = true, isLeaderBoard = false;
  bool isContestClicked = true;
  bool isProgressRunning = false;

  int get contextIndex => null;

  int get index => null;
  String pageFromMatch = "";
  List<LeaderBoard> myLeaderBoardList = <LeaderBoard>[];
  List<PrizeBreakup> prizebreakup = <PrizeBreakup>[];

  bool _isProgressRunning = false;
  GetMyTeam _getmyteamdetailslist = GetMyTeam();

  List<PlayerPoint> _wkList = <PlayerPoint>[];
  List<PlayerPoint> _batsList = <PlayerPoint>[];
  List<PlayerPoint> _arList = <PlayerPoint>[];
  List<PlayerPoint> _bowlersList = <PlayerPoint>[];

  CountdownTimerController controller;

  Future<void> _getLeaderBoardAPI() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      LeaderboardModel modelResp = await APIServices.getLeaderBoardData(
          widget.contestDetails.contestId, widget.selectedMatchData.matchId);
      if (modelResp != null &&
          modelResp.leaderBoard != null &&
          modelResp.leaderBoard.length > 0) {
        setState(() {
          myLeaderBoardList.clear();
          myLeaderBoardList.addAll(modelResp.leaderBoard);
          //   log("${myLeaderBoardList.length}", name: "leaderBoardList");
        });
      }
    } catch (e) {
      showErrorDialog(context, e);
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  Future<void> _getPrizeBreakUpAPI() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      PrizeBreakUpModel prizeResp = await APIServices.prizeBreakUP(
          widget.contestDetails.contestId, widget.selectedMatchData.matchId);

      if (prizeResp != null &&
          prizeResp.response.prizeBreakup != null &&
          prizeResp.response.prizeBreakup.length > 0) {
        setState(() {
          prizebreakup.clear();
          prizebreakup.addAll(prizeResp.response.prizeBreakup);
          //   log("${myLeaderBoardList.length}", name: "leaderBoardList");
        });
      }
    } catch (e) {
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);

  @override
  void initState() {
    super.initState();
    _getLeaderBoardAPI();
    _getPrizeBreakUpAPI();
  }

  Future<void> _onRefresh1() async {
    await _getLeaderBoardAPI();
    _refreshController1.refreshCompleted();
  }

  // View Player Team

  Future<void> getMyTeamListDetails(
      int match, int teamId, String userId) async {
    try {
      setState(() {
        _isProgressRunning = true;
      });

      _getmyteamdetailslist =
          await APIServices.getMyTeamViewDetailList(match, teamId, userId);
      _wkList.clear();
      _bowlersList.clear();
      _arList.clear();
      _batsList.clear();

      _getmyteamdetailslist.response.playerPoints.map((wkteamdetail) {
        if (wkteamdetail.role == "wk") {
          setState(() {
            _wkList.add(wkteamdetail);
          });
        }
        if (wkteamdetail.role == "bat") {
          setState(() {
            _batsList.add(wkteamdetail);
          });
        }
        if (wkteamdetail.role == "all") {
          setState(() {
            _arList.add(wkteamdetail);
          });
        }
        if (wkteamdetail.role == "bowl") {
          setState(() {
            _bowlersList.add(wkteamdetail);
          });
        }
      }).toList();
    } catch (error) {
      //  log("$error", name: "error");
      showErrorDialog(context, error);
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: ColorConstant.BACKGROUND_COLOR,
      appBar: AppBar(
          backgroundColor: ColorConstant.COLOR_WHITE,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorConstant.COLOR_TEXT,
              size: 28,
            ),
          ),
          title: Text(
            AppLocalizations.of("Contests"),
            style: Theme.of(context).textTheme.subtitle1.copyWith(
                  color: ColorConstant.COLOR_TEXT,
                  fontWeight: FontWeight.w500,
                ),
          ),
          actions: [
            Image.asset(
              ImgConstants.LEADERBOARD_LOGO,
              width: 35,

              //  fit: BoxFit.fill,
            ),
            SizedBox(
              width: 10,
            ),
          ],
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(60),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 15, right: 15, bottom: 30.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "${widget.selectedMatchData.teama.shortName}",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500,
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '  VS  ',
                              style:
                                  Theme.of(context).textTheme.overline.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                            TextSpan(
                              text:
                                  "${widget.selectedMatchData.teamb.shortName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          // Image.asset(
                          //   ImgConstants.GOOGLE_LOGO,
                          //   height: 12,
                          // ),
                          const SizedBox(width: 5),
                          CountdownTimer(
                            controller: controller,
                            endTime: int.parse(widget
                                    .selectedMatchData.timestampStart
                                    .toString()) *
                                1000,
                            textStyle: Theme.of(context)
                                .textTheme
                                .caption
                                .copyWith(
                                    fontSize: 14.0,
                                    fontWeight: FontWeight.w500,
                                    color: ColorConstant.COLOR_TEXT),
                            onEnd: () {},
                            widgetBuilder: (_, CurrentRemainingTime time) {
                              if (time != null) {
                                return time.days != null
                                    ? Text(
                                        '${time.days}d ${time.hours}h ${time.min}m ${time.sec}s left',
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                                fontSize: 14.0,
                                                letterSpacing: 0.6,
                                                color:
                                                    ColorConstant.COLOR_TEXT),
                                      )
                                    : time.hours != null
                                        ? Text(
                                            '${time.hours}h ${time.min}m ${time.sec}s left',
                                            style: Theme.of(context)
                                                .textTheme
                                                .caption
                                                .copyWith(
                                                    fontSize: 14.0,
                                                    letterSpacing: 0.6,
                                                    color: ColorConstant
                                                        .COLOR_TEXT),
                                          )
                                        : time.min != null
                                            ? Text(
                                                '${time.min}m ${time.sec}s left',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .copyWith(
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.6,
                                                        color: ColorConstant
                                                            .COLOR_TEXT),
                                              )
                                            : Text(
                                                '${time.sec}s left',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption
                                                    .copyWith(
                                                        fontSize: 14.0,
                                                        letterSpacing: 0.6,
                                                        color: ColorConstant
                                                            .COLOR_TEXT),
                                              );
                              }
                              return Text("");
                            },
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          )),
      body: Column(
        children: [
          contestCard(context),
          const SizedBox(height: 10),
          Container(
            padding:
                EdgeInsets.only(left: 10.0, top: 10, right: 10, bottom: 10),
            color: ColorConstant.COLOR_WHITE,
            child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                mainAxisSize: MainAxisSize.max,
                children: [
                  InkWell(
                    onTap: () {
                      setState(() {
                        isWinningBreakUp = true;
                        isLeaderBoard = false;
                        isContestClicked = true;
                      });
                    },
                    child: Text(
                      AppLocalizations.of('PRIZE BREAKUP'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: isWinningBreakUp
                                ? ColorConstant.COLOR_BLUE3
                                : ColorConstant.COLOR_TEXT,
                            fontSize: 14.0,
                            fontWeight: isWinningBreakUp
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      setState(() {
                        isWinningBreakUp = false;
                        isLeaderBoard = true;
                        isContestClicked = false;
                      });
                      await _getLeaderBoardAPI();
                    },
                    child: Text(
                      AppLocalizations.of('LEADERBOARD'),
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: isLeaderBoard
                                ? ColorConstant.COLOR_BLUE3
                                : ColorConstant.COLOR_TEXT,
                            fontSize: 14.0,
                            fontWeight: isLeaderBoard
                                ? FontWeight.w700
                                : FontWeight.w500,
                          ),
                    ),
                  )
                ]),
          ),
          // SizedBox(
          //   height: 10,
          // ),
          isWinningBreakUp ? _prizeBreakUpHeader() : _leaderBoardHeader(),
          isWinningBreakUp ? _prizeBreakUpList() : _leaderBoardList(),
        ],
      ),
    );
  }

  Padding contestCard(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 5.0, right: 5),
      child: Card(
        elevation: 5.0,
        color: ColorConstant.COLOR_WHITE,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Container(
          decoration: BoxDecoration(),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IntrinsicHeight(
                child: Flex(
                  direction: Axis.horizontal,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: ColorConstant.COLOR_WHITE,
                        padding: EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: Flex(
                          direction: Axis.vertical,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Prize Pool",
                                  style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "Winner ${widget.contestDetails.winnerCount ?? ""}",
                                      style: TextStyle(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                    Icon(Icons.arrow_drop_up)
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      bottom: 5, right: 20.0),
                                  child: Text(
                                    "Entry",
                                    style: TextStyle(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "₹ ${widget.contestDetails.totalWinningPrize ?? ""}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                InkWell(
                                  onTap: () async {
                                    JoinNewContestStatusModel joinResp =
                                        await APIServices.joinNewContestStatus(
                                            widget.contestId,
                                            widget.selectedMatchData.matchId);
                                    if (joinResp.teamList == null) {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  CreateTeamPage(
                                                      selectedMatchData: widget
                                                          ?.selectedMatchData,
                                                      remainingTime: "")));
                                    } else {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                SelectTeamForJoinContest2(
                                              selectedMatchData:
                                                  widget.selectedMatchData,
                                              contestId: widget.contestId,
                                              selectedContestData:
                                                  widget.selectedContestData,
                                              // contestTypeModel
                                              //     .response
                                              //     .matchcontests[
                                              //         contestIndex]
                                              //     .contests[index],
                                              i: widget.maxAllowedTeam,
                                            ),
                                          ));
                                      //     .then((value) {
                                      //   getDefaultContestByType();
                                      //   setState(() {});
                                      // });
                                    }
                                  },
                                  child: Container(
                                    width: 70,
                                    height: 27,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        color: ColorConstant.COLOR_BUTTON2),
                                    child: Center(
                                      child: Text(
                                        "₹ ${widget.contestDetails.entryFees ?? ""}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .subtitle1
                                            .copyWith(
                                              color: ColorConstant.COLOR_WHITE,
                                              fontWeight: FontWeight.bold,
                                            ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(height: 10.0),
                            LinearPercentIndicator(
                              padding: EdgeInsets.all(3.0),
                              lineHeight: 10.0,
                              percent: widget.contestDetails.filledSpots !=
                                          null &&
                                      (widget.contestDetails.filledSpots) > 0
                                  ? (widget.contestDetails.filledSpots /
                                          widget.contestDetails.totalSpots *
                                          100) /
                                      100
                                  : 0.0,
                              linearStrokeCap: LinearStrokeCap.roundAll,
                              backgroundColor: ColorConstant.COLOR_LIGHT_GREY,
                              progressColor: ColorConstant.COLOR_YELLOW,
                            ),
                            SizedBox(height: 6.0),
                            Flex(
                              direction: Axis.horizontal,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Visibility(
                                  visible: true,
                                  // visible: contestTypeDataList[parentIndex]
                                  //             .defaultcontest[index]
                                  //             .filledSpots !=
                                  //         null &&
                                  //     contestTypeDataList[parentIndex]
                                  //             .defaultcontest[index]
                                  //             .filledSpots >
                                  //         0,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        if (widget.contestDetails.totalSpots ==
                                            widget.contestDetails.filledSpots)
                                          TextSpan(
                                            text: "Contest Full",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color(0xffec9f83),
                                                fontWeight: FontWeight.w800),
                                          )
                                        else
                                          TextSpan(
                                            text:
                                                "${((widget.contestDetails.totalSpots) - widget.contestDetails.filledSpots)}",
                                            style: TextStyle(
                                                fontSize: 12.0,
                                                color: Color(0xffec9f83),
                                                fontWeight: FontWeight.w800),
                                          ),
                                        TextSpan(
                                          text: " Spots Left",
                                          style: TextStyle(
                                              fontSize: 12.0,
                                              color: Color(0xffec9f83),
                                              fontWeight: FontWeight.w800),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text:
                                            "${widget.contestDetails.totalSpots}",
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
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                height: 1.0,
                color: ColorConstant.COLOR_LIGHT_GREY,
              ),
              IntrinsicHeight(
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Expanded(
                      flex: 3,
                      child: Container(
                        color: ColorConstant.COLOR_LIGHT_GREY_2,
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: Flex(
                          direction: Axis.horizontal,
                          children: [
                            Image.asset(
                              ImgConstants.CUP,
                              width: 18.0,
                              height: 18.0,
                            ),
                            SizedBox(width: 6.0),

                            Text(
                              "₹ ${widget.contestDetails.firstPrice ?? ""}",
                              style: TextStyle(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15.0),
                            ),

                            Spacer(),

                            /*
                                ! fff
                                ? ddd

                                 */

                            // Confirmed Contest

                            Visibility(
                                visible: !widget.contestDetails.cancellation ??
                                    false,
                                // visible: !contestTypeDataList[parentIndex]
                                //         .defaultcontest[index]
                                //         .cancelled ??
                                //     false,
                                child: Container(
                                  padding: const EdgeInsets.all(7.0),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    shape: BoxShape.circle,
                                  ),
                                  child: Text(
                                    "C",
                                    style: TextStyle(
                                      fontSize: 10.0,
                                      color: Colors.white,
                                    ),
                                  ),
                                )),

                            const SizedBox(
                              width: 4,
                            ),
                            Container(
                              padding: EdgeInsets.only(
                                  left: 4, right: 2, top: 2, bottom: 2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Row(
                                children: [
                                  widget.contestDetails.maxAllowedTeam !=
                                              null &&
                                          widget.contestDetails.maxAllowedTeam >
                                              1
                                      ? Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: 2,
                                                    right: 2,
                                                    top: 2,
                                                    bottom: 2),
                                                decoration: BoxDecoration(
                                                  //  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  "M",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            const SizedBox(width: 4),
                                            Container(
                                                color: Colors.white,
                                                padding: EdgeInsets.only(
                                                    left: 4,
                                                    right: 4,
                                                    top: 2,
                                                    bottom: 2),
                                                child: Text(
                                                    "${widget.contestDetails.maxAllowedTeam ?? "0"}",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ))),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Container(
                                                padding: EdgeInsets.only(
                                                    left: 2,
                                                    right: 2,
                                                    top: 2,
                                                    bottom: 2),
                                                decoration: BoxDecoration(
                                                  //  color: Colors.red,
                                                  borderRadius:
                                                      BorderRadius.circular(4),
                                                ),
                                                child: Text(
                                                  "S",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                    color: Colors.white,
                                                  ),
                                                )),
                                            const SizedBox(width: 4),
                                            Container(
                                                color: Colors.white,
                                                padding: EdgeInsets.only(
                                                    left: 4,
                                                    right: 4,
                                                    top: 2,
                                                    bottom: 2),
                                                child: Text(
                                                    "${widget.contestDetails.maxAllowedTeam ?? "0"}",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                    ))),
                                          ],
                                        ),
                                ],
                              ),
                            ),

                            SizedBox(width: 4),
                            if (widget.contestDetails.usableBonus > 0)
                              Container(
                                padding: EdgeInsets.only(
                                    left: 4, right: 2, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: ColorConstant.COLOR_YELLOW,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    // contestTypeDataList[parentIndex].maxEntry !=
                                    //             null &&
                                    //         contestTypeDataList[parentIndex]
                                    //                 .maxEntry >
                                    // 1
                                    //    ?
                                    Row(
                                      children: [
                                        Container(
                                            padding: EdgeInsets.only(
                                                left: 2,
                                                right: 2,
                                                top: 2,
                                                bottom: 2),
                                            decoration: BoxDecoration(
                                              //    color: Colors.green,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                            ),
                                            child: Text(
                                              "B",

                                              //${contestTypeDataList[parentIndex].maxEntry ?? "0"}",
                                              style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                              ),
                                            )),
                                        const SizedBox(width: 4),
                                        Container(
                                            color: Colors.white,
                                            padding: EdgeInsets.only(
                                                left: 2,
                                                right: 2,
                                                top: 2,
                                                bottom: 2),
                                            child: Text(
                                                "${widget.contestDetails.usableBonus}%",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                ))),
                                      ],
                                    )
                                    // : Row(
                                    //     children: [
                                    //       Container(
                                    //           padding: EdgeInsets.only(
                                    //               left: 2,
                                    //               right: 2,
                                    //               top: 2,
                                    //               bottom: 2),
                                    //           decoration: BoxDecoration(
                                    //             //  color: Colors.red,
                                    //             borderRadius:
                                    //                 BorderRadius.circular(
                                    //                     4),
                                    //           ),
                                    //           child: Text(
                                    //             "B",
                                    //             style: TextStyle(
                                    //               fontSize: 10,
                                    //               color: Colors.white,
                                    //             ),
                                    //           )),
                                    //       const SizedBox(width: 4),
                                    //       Container(
                                    //           color: Colors.white,
                                    //           padding: EdgeInsets.only(
                                    //               left: 2,
                                    //               right: 2,
                                    //               top: 2,
                                    //               bottom: 2),
                                    //           child: Text(
                                    //               "${contestTypeDataList[parentIndex].defaultcontest[index]?.totalUsableBonus}%",
                                    //               style: TextStyle(
                                    //                 fontSize: 10,
                                    //               ))),
                                    //     ],
                                    //   ),
                                  ],
                                ),
                              )
                            // else
                            //   Container(),
                          ],
                        ),
                      ),
                    ),
                    // Container(
                    //   height: 1.0,
                    //   color: ColorConstant.COLOR_LIGHT_GREY,
                    // ),
                    // Container(
                    //   width: MediaQuery.of(context).size.width * 0.20,
                    //   child: InkWell(
                    //     onTap: () {
                    //       if (contestTypeDataList[parentIndex].defaultcontest !=
                    //               null &&
                    //           contestTypeDataList[parentIndex]
                    //                   .defaultcontest
                    //                   .length >
                    //               0)
                    //                {
                    //         // Navigator.pop(context);
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) =>
                    //                   SelectTeamForJoinContest(
                    //                 selectedMatchData: widget.selectedMatchData,
                    //                 selectedContestData:
                    //                     contestTypeDataList[parentIndex]
                    //                         .defaultcontest[index],
                    //                 i: contestTypeDataList[parentIndex]
                    //                         .maxEntry ??
                    //                     0,
                    //               ),
                    //             )).then((value) => getDefaultContestByType());
                    //       }
                    //     },
                    //     child: Container(
                    //       alignment: Alignment.center,
                    //       decoration: BoxDecoration(
                    //         color: ColorConstant.COLOR_THEME_PURPLE,
                    //         borderRadius: BorderRadius.only(
                    //           bottomRight: Radius.circular(8.0),
                    //         ),
                    //       ),
                    //       child: Text(
                    //         contestTypeDataList[parentIndex]
                    //                     .defaultcontest[index]
                    //                     .entryFees ==
                    //                 0
                    //             ? "FREE"
                    //             : "JOIN",
                    //         style: TextStyle(
                    //             color: ColorConstant.COLOR_WHITE,
                    //             fontSize: 14.0,
                    //             fontWeight: FontWeight.bold),
                    //       ),
                    //     ),
                    //   ),
                    // )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _prizeBreakUpHeader() {
    return Container();
  }

  Widget _leaderBoardHeader() {
    return Container(
      color: ColorConstant.COLOR_WHITE,
      child: Padding(
        padding: EdgeInsets.only(left: 30, right: 30.0, top: 8, bottom: 8),
        child: Row(
          //   crossAxisAlignment: CrossAxisAlignment.center,
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 4,
              child: Text(
                "ALL TEAMS",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.start,
              ),
            ),
            // Spacer(),
            Expanded(
              flex: 2,
              child: Text(
                "Points",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.center,
              ),
            ),
            //  SizedBox(width: 30.0),
            Expanded(
              flex: 2,
              child: Text(
                "RANK",
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
                textAlign: TextAlign.end,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _prizeBreakUpList() {
    double height1 = MediaQuery.of(context).size.height;
    //  if (prizebreakup != null && prizebreakup.length > 0) {
    return Expanded(
      child: Container(
        height: height1,
        color: ColorConstant.COLOR_WHITE,
        child: ListView.builder(
            itemCount: prizebreakup?.length ?? 0,
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 16.0, horizontal: 10.0),
                child: Row(
                  children: [
                    //  if (prizeBreakupList[index].rangeUpto == "1")
                    Text(
                      "# ${prizebreakup[index].range}",
                      style: TextStyle(
                        color: ColorConstant.COLOR_TEXT,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    // else
                    //   Text(
                    //       "# ${prizeBreakupList[index].rangeFrom} - ${prizeBreakupList[index].rangeUpto}"),

                    Spacer(),
                    Text(
                      "# ${prizebreakup[index].price}",
                      style: TextStyle(
                        color: ColorConstant.COLOR_TEXT,
                        fontSize: 13.0,
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
    // } else {
    //   Container();
    // }
  }

  Widget _leaderBoardList() {
    double height1 = MediaQuery.of(context).size.height;
    if (myLeaderBoardList != null && myLeaderBoardList.length <= 0) {
      return Container();
    }
    return Expanded(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: _onRefresh1,
        controller: _refreshController1,
        header: MaterialClassicHeader(
          color: ColorConstant.COLOR_TEXT,
          backgroundColor: ColorConstant.COLOR_WHITE,
        ),
        child: ListView.builder(
            itemCount: myLeaderBoardList?.length ?? 0,
            scrollDirection: Axis.vertical,
            physics: AlwaysScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Container(
                color: myLeaderBoardList[index].userId ==
                        SharedPreference.getValue(PrefConstants.USER_ID)
                    ? Color(0xffd8e8f7)
                    : ColorConstant.COLOR_WHITE,
                child: Column(
                  children: [
                    InkWell(
                      onTap: () async {
                        // if (myLeaderBoardList[index].userId ==
                        //     SharedPreference.getValue(PrefConstants.USER_ID)) {
                        await getMyTeamListDetails(
                            myLeaderBoardList[index].matchId,
                            myLeaderBoardList[index].teamId,
                            myLeaderBoardList[index].userId);
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => GetMyTeamDetailList(
                                selectedMatchData: widget.selectedMatchData,
                                wkList: _wkList,
                                batsList: _batsList,
                                arList: _arList,
                                bowlersList: _bowlersList,
                                // teamPoints: _getMyTeamResponseModel
                                //     .response.myteam[index].points,
                                pageFromMatch: widget.pageFromMatch,
                                teamId: myLeaderBoardList[index].teamId,
                                teamName:
                                    myLeaderBoardList[index].user.teamName +
                                        "(" +
                                        myLeaderBoardList[index].team +
                                        ")",

                                // change here -
                                 userId: myLeaderBoardList[index].userId,
                              ),
                            ));
                        // } else {
                        //   UtilsFlushBar.showDefaultSnackbar(context,
                        //       "You cannot see other players team until match started");
                        // }
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            top: 8.0, bottom: 8, left: 8, right: 12),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 6,
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstant.COLOR_WHITE,
                                      border: Border.all(
                                          color:
                                              ColorConstant.COLOR_LIGHT_GREY2,
                                          width: 2),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(1.0),
                                      child: Center(
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(40.0),
                                          child: CachedNetworkImage(
                                            alignment: Alignment.center,
                                            width: 30.0,
                                            height: 30.0,
                                            imageUrl: myLeaderBoardList[index]
                                                .user
                                                .profileImage,
                                            placeholder: (context, url) =>
                                                Image.asset(
                                                    ImgConstants
                                                        .balleballe11_LOGO,
                                                    width: 40.0,
                                                    height: 40.0),
                                            errorWidget: (context, url, error) {
                                              return Image.asset(
                                                  ImgConstants
                                                      .balleballe11_LOGO,
                                                  width: 40.0,
                                                  height: 40.0);
                                            },
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10.0),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        "${myLeaderBoardList[index].user.teamName ?? ""}(${myLeaderBoardList[index].team ?? ""})",
                                        style: TextStyle(
                                            color: ColorConstant.COLOR_TEXT,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 12.0),
                                      ),
                                      Visibility(
                                        visible: pageFromMatch != null &&
                                            pageFromMatch ==
                                                StringConstant
                                                    .COMPLETED_MATCHES,
                                        // isFromView != null && !isFromView
                                        child: Text(
                                          "aaa",
                                          // "Won : ${Utils.rupeeSymbol} ${myLeaderBoardList[index].p_amount}",
                                          style: TextStyle(
                                              color: ColorConstant.COLOR_GREEN,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                      Visibility(
                                        visible: pageFromMatch != null &&
                                            pageFromMatch ==
                                                StringConstant.LIVE_MATCHES,
                                        //   isFromView != null && !isFromView
                                        child: Text(
                                          "Winning Zone",
                                          style: TextStyle(
                                              color: ColorConstant.COLOR_BLACK,
                                              fontSize: 12.0),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            //  Spacer(),
                            Expanded(
                              flex: 3,
                              child: Text(
                                "${myLeaderBoardList[index].point ?? ""}",
                                style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                              ),
                            ),
                            //   SizedBox(width: 30.0),
                            Expanded(
                              flex: 1,
                              child: Text(
                                "# ${myLeaderBoardList[index].rank ?? ""}",
                                style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 12.0),
                              ),
                            ),
                            // const SizedBox(width: 2),
                            Icon(Icons.keyboard_arrow_up)
                          ],
                        ),
                      ),
                    ),
                    Divider(
                      color: ColorConstant.COLOR_GREY,
                      height: 0,
                      thickness: 0.5,
                    ),
                  ],
                ),
              );
            }),
      ),
    );
  }
  // }
}
