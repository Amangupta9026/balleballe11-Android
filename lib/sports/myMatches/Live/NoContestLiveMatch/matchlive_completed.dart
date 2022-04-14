import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/matchesModel.dart';

import '../live_match_detail_page.dart';
import 'live_match_noContestPage.dart';
import 'live_no_contest_teampage.dart';

class MatchLiveNoContest extends StatefulWidget {
  String pageFromMatch = "";
  MatchesModel selectedMatchData;
  String teama;
  String teamb;
  String status;
  int matchId;
  int teamaId;
  int teambId;

  // ScoreData selectedData;

  MatchLiveNoContest({
    this.selectedMatchData,
    this.pageFromMatch,
    this.teama,
    this.teamb,
    this.status,
    this.matchId,
    this.teamaId,
    this.teambId,
    //    this.selectedData
  }) {
    this.pageFromMatch = pageFromMatch;
    this.selectedMatchData = selectedMatchData;

    // this.selectedData = selectedData;
  }

  @override
  _MatchLiveNoContestState createState() => _MatchLiveNoContestState();
}

class _MatchLiveNoContestState extends State<MatchLiveNoContest>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  // GetMatchScoreBoardRespModel matchScoreBoard = GetMatchScoreBoardRespModel();
  bool isProgressRunning = false;
  int myTeamCount = 0;
  int contestCount = 0;
  bool _isProgressRunning = false;
  GetMyTeamByIdResponseModel _getMyTeamResponseModel =
      GetMyTeamByIdResponseModel();

  @override
  void dispose() {
    super.dispose();
  }

  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    getMyTeamList();
    Future.delayed(Duration.zero, () {
      //   _getMatchScores();
    });
  }

  Future<void> getMyTeamList() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _getMyTeamResponseModel =
          await APIServices.getMyTeamByPlayerId(widget.matchId);
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
          body: ProgressContainerView(
            isProgressRunning: isProgressRunning,
            child: TabBarView(
              controller: _tabController,
              children: [
                LiveMatchNoContestPage(
                    // widget.selectedMatchData,
                    // isFromView: true, pageFromMatch: widget.pageFromMatch,
                    //  onClickJoinContest: ,
                    ),
                LiveNoContestTeamPage(
                    teama: widget.teama,
                    teamb: widget.teamb,
                    matchId: widget.matchId,
                    teamaId: widget.teamaId,
                    teambId: widget.teambId,
                    isFromView: true,
                    pageFromMatch: widget.pageFromMatch),
              ],
            ),
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
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(
            "${widget.teama}   vs   ${widget.teamb}",
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: ColorConstant.COLOR_TEXT,
                  fontWeight: FontWeight.w400,
                  fontSize: 14,
                ),
          ),
          Spacer(),
          Text(
            "${widget.status}",
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: ColorConstant.COLOR_PINK,
                  fontWeight: FontWeight.w500,
                  fontSize: 14,
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
            // Padding(
            //   padding: const EdgeInsets.only(left: 14, right: 14),
            //   child: Column(
            //     children: [
            //       Row(
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //         children: [
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Container(
            //                     width: 35.0,
            //                     height: 35.0,
            //                     decoration: BoxDecoration(
            //                       color: ColorConstant.COLOR_WHITE,
            //                       image: DecorationImage(
            //                         image: NetworkImage(
            //                           widget.selectedMatchData.teama.logoUrl ??
            //                               Container(),
            //                         ),
            //                         fit: BoxFit.cover,
            //                       ),
            //                       borderRadius:
            //                           BorderRadius.all(Radius.circular(40.0)),
            //                       border: Border.all(
            //                         color: ColorConstant.COLOR_GREY,
            //                         width: 1.0,
            //                       ),
            //                     ),
            //                   ),
            //                   SizedBox(width: 6.0),
            //                   Text(
            //                     "${widget.selectedMatchData.teama.name ?? ""}",
            //                     overflow: TextOverflow.ellipsis,
            //                     style: TextStyle(
            //                         color: ColorConstant.COLOR_TEXT,
            //                         fontSize: 14.0,
            //                         fontWeight: FontWeight.bold),
            //                   )
            //                 ],
            //               ),
            //             ],
            //           ),
            //           Column(
            //             crossAxisAlignment: CrossAxisAlignment.start,
            //             mainAxisAlignment: MainAxisAlignment.start,
            //             children: [
            //               Row(
            //                 children: [
            //                   Text(
            //                     "${widget.selectedMatchData.teamb.name ?? ""}",
            //                     overflow: TextOverflow.ellipsis,
            //                     style: TextStyle(
            //                         color: ColorConstant.COLOR_TEXT,
            //                         fontSize: 14.0,
            //                         fontWeight: FontWeight.bold),
            //                   ),
            //                   SizedBox(width: 6.0),
            //                   Container(
            //                     width: 35.0,
            //                     height: 35.0,
            //                     decoration: BoxDecoration(
            //                       color: ColorConstant.COLOR_WHITE,
            //                       image: DecorationImage(
            //                         image: NetworkImage(widget
            //                                 .selectedMatchData.teamb?.logoUrl ??
            //                             null),
            //                         fit: BoxFit.cover,
            //                       ),
            //                       borderRadius:
            //                           BorderRadius.all(Radius.circular(40.0)),
            //                       border: Border.all(
            //                         color: ColorConstant.COLOR_GREY,
            //                         width: 1.0,
            //                       ),
            //                     ),
            //                   ),
            //                 ],
            //               ),
            //             ],
            //           ),
            //         ],
            //       ),
            //     ],
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            Container(
              color: ColorConstant.BACKGROUND_COLOR,
              child: Container(
                child: TabBar(
                    indicatorColor: ColorConstant.COLOR_TEXT,
                    indicatorWeight: 2.0,
                    labelPadding: EdgeInsets.symmetric(
                      vertical: 16.0,
                    ),
                    indicatorSize: TabBarIndicatorSize.tab,
                    labelColor: ColorConstant.COLOR_TEXT,
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
                        "Contest (${contestCount ?? "0"})",
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
      ),
    );
  }
}
