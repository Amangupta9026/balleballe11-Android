import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/contest_type_model.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/getMyTeamList.dart';
import 'package:balleballe11/model/leaderboard_model.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/model/my_contest_model.dart';
import 'package:balleballe11/model/myjoined_live_matches_model.dart';
import 'package:balleballe11/model/prizebreakUpModel.dart';
import 'package:balleballe11/widget/progressContainerView.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:url_launcher/url_launcher.dart';

import 'live_match_myteam_details.dart';

class LiveMatchContestPage extends StatefulWidget {
  Live selectedMatchData;

  MyJoinedContest contestDetails;

  bool isFromView;
  String pageFromMatch = "";
  LiveMatchContestPage(
      {Key key,
      this.selectedMatchData,
      this.contestDetails,
      this.isFromView,
      this.pageFromMatch})
      : super(key: key);

  @override
  _LiveMatchContestPageState createState() => _LiveMatchContestPageState();
}

class _LiveMatchContestPageState extends State<LiveMatchContestPage> {
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
  GetMyTeamByIdResponseModel _getMyTeamResponseModel =
      GetMyTeamByIdResponseModel();
  List<PlayerPoint> _wkList = <PlayerPoint>[];
  List<PlayerPoint> _batsList = <PlayerPoint>[];
  List<PlayerPoint> _arList = <PlayerPoint>[];
  List<PlayerPoint> _bowlersList = <PlayerPoint>[];
  RefreshController _refreshController2 =
      RefreshController(initialRefresh: false);

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
  void initState() {
    super.initState();
    _getLeaderBoardAPI();
    _getPrizeBreakUpAPI();
  }

  void _onRefresh1() async {
    await Future.delayed(Duration.zero, () {
      _getLeaderBoardAPI();
    });
    _refreshController2.refreshCompleted();
  }

  String fantasyPointSystemUrl =
      "https://balleballe11.in/fantasy-points-system/";

  void _launchFantasyPoint() async => await canLaunch(fantasyPointSystemUrl)
      ? await launch(fantasyPointSystemUrl)
      : throw 'Could not launch $fantasyPointSystemUrl';

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
            InkWell(
              onTap: () {
                _launchFantasyPoint();
              },
              child: Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Image.asset(
                  ImgConstants.POINTS_ICON,

                  width: 30,
                  //  fit: BoxFit.fill,
                  color: ColorConstant.COLOR_TEXT,
                ),
              ),
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
                                fontWeight: FontWeight.bold,
                              ),
                          children: <TextSpan>[
                            TextSpan(
                              text: '  VS  ',
                              style:
                                  Theme.of(context).textTheme.overline.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.bold,
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
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          Text(
                            "${widget.selectedMatchData.statusStr}",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: ColorConstant.COLOR_GREEN,
                                      fontWeight: FontWeight.w500,
                                    ),
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
                                ? ColorConstant.COLOR_BLUE
                                : ColorConstant.COLOR_TEXT,
                            fontSize: 14.0,
                            fontWeight: isWinningBreakUp
                                ? FontWeight.w900
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
                                ? ColorConstant.COLOR_BLUE
                                : ColorConstant.COLOR_TEXT,
                            fontSize: 14.0,
                            fontWeight: isLeaderBoard
                                ? FontWeight.w900
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
                            Container(
                              color: ColorConstant.BACKGROUND_COLOR,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Spacer(),
                                  Align(
                                    alignment: Alignment.topCenter,
                                    child: Center(
                                      child: Text(
                                        "FULL SCORES IN balleballe11",
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                            color: ColorConstant.COLOR_YELLOW,
                                            fontSize: 16.0,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.arrow_forward_ios,
                                    size: 15,
                                    color: ColorConstant.COLOR_GREY,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Row(
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.COLOR_BLUE2,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${widget.selectedMatchData.teama.scores ?? ""}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(
                                                color:
                                                    ColorConstant.COLOR_WHITE,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 27.0,
                                              height: 27.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorConstant.COLOR_WHITE,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    widget.selectedMatchData
                                                            .teama?.logoUrl ??
                                                        null,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40.0)),
                                                border: Border.all(
                                                  color:
                                                      ColorConstant.COLOR_GREY,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${widget.selectedMatchData.teama.shortName ?? ""}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                    color: ColorConstant
                                                        .COLOR_WHITE,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "(${widget.selectedMatchData.teama.overs ?? ""})",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                    color: ColorConstant
                                                        .COLOR_WHITE,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),

                                //
                                const SizedBox(
                                  width: 10,
                                ),

                                Container(
                                  width:
                                      MediaQuery.of(context).size.width / 2.5,
                                  decoration: BoxDecoration(
                                    color: ColorConstant.COLOR_TEXT,
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(10.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          "${widget.selectedMatchData.teamb.scores ?? ""}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle2
                                              .copyWith(
                                                color:
                                                    ColorConstant.COLOR_WHITE,
                                                fontWeight: FontWeight.w500,
                                              ),
                                        ),
                                        Row(
                                          children: [
                                            Container(
                                              width: 27.0,
                                              height: 27.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorConstant.COLOR_WHITE,
                                                image: DecorationImage(
                                                  image: NetworkImage(
                                                    widget.selectedMatchData
                                                            .teamb?.logoUrl ??
                                                        null,
                                                  ),
                                                  fit: BoxFit.cover,
                                                ),
                                                borderRadius: BorderRadius.all(
                                                    Radius.circular(40.0)),
                                                border: Border.all(
                                                  color:
                                                      ColorConstant.COLOR_GREY,
                                                  width: 1.0,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "${widget.selectedMatchData.teamb.shortName ?? ""}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                    color: ColorConstant
                                                        .COLOR_WHITE,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Text(
                                              "(${widget.selectedMatchData.teamb.overs ?? ""})",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .subtitle2
                                                  .copyWith(
                                                    color: ColorConstant
                                                        .COLOR_WHITE,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            ),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                )
                              ],
                            ),
                            // Status match
                            //
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
                        color: ColorConstant.COLOR_WHITE,
                        padding: EdgeInsets.symmetric(
                            vertical: 5.0, horizontal: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Prize Pool",
                                  style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  "₹${widget.contestDetails.totalWinningPrize ?? ""}",
                                  style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Spots",
                                  style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  "${widget.contestDetails.totalSpots ?? ""}",
                                  style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                            Column(
                              children: [
                                Text(
                                  "Entry",
                                  style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontSize: 12.0,
                                  ),
                                ),
                                Text(
                                  "₹${widget.contestDetails.entryFees ?? ""}",
                                  style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontSize: 12.0,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
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
    //  if (prizebreakup != null && prizebreakup.length > 0) {
    return Expanded(
      child: Container(
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
                        fontSize: 15.0,
                        fontWeight: FontWeight.w500,
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
                          fontSize: 15.0,
                          fontWeight: FontWeight.w500),
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
    if (myLeaderBoardList != null && myLeaderBoardList.length <= 0) {
      return Container();
    }
    return Expanded(
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: _onRefresh1,
        controller: _refreshController2,
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
                        await getMyTeamListDetails(
                            myLeaderBoardList[index].matchId,
                            myLeaderBoardList[index].teamId,
                            myLeaderBoardList[index].userId);

                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LiveMatchMyTeamDetail(
                                selectedMatchData: widget.selectedMatchData,
                                wkList: _wkList,
                                batsList: _batsList,
                                arList: _arList,
                                bowlersList: _bowlersList,
                                teamPoints: myLeaderBoardList[index].point,
                                pageFromMatch: widget.pageFromMatch,
                                teamId: myLeaderBoardList[index].teamId,
                                teamName:
                                    myLeaderBoardList[index].user.teamName +
                                        "(" +
                                        myLeaderBoardList[index].team +
                                        ")",
                                totalPoints: _getmyteamdetailslist.totalPoints,
                                // teamName:
                                // "${modelResp.leaderBoardTeamListData.teamName}(${modelResp.leaderBoardTeamListData.teamTag})",
                              ),
                            ));
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
                                        color: ColorConstant.COLOR_LIGHT_GREY2,
                                        width: 2,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(40.0)),
                                    ),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(40.0),
                                      child: Padding(
                                        padding: const EdgeInsets.all(1.0),
                                        child: Center(
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
                                        "${myLeaderBoardList[index].user.teamName ?? ""}(${myLeaderBoardList[index].team}) ",
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
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Visibility(
                                        visible:
                                            myLeaderBoardList[index].rank == 1,
                                        // visible: pageFromMatch != null &&
                                        //     pageFromMatch ==
                                        //         StringConstant.LIVE_MATCHES,
                                        //   isFromView != null && !isFromView
                                        child: Text(
                                          "Winning Zone",
                                          style: TextStyle(
                                              color: ColorConstant.COLOR_GREEN2,
                                              fontSize: 12.0,
                                              fontWeight: FontWeight.bold),
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

                            Icon(Icons.keyboard_arrow_up),
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
