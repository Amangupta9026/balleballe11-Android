import 'dart:developer';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/model/my_joined_upcomingmatches.dart';
import 'package:balleballe11/widget/completed_widget.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:balleballe11/widget/card_view.dart';

import '../match_contest_live_completed.dart';

class CompletedPage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<CompletedPage> {
  // List<MatchesData> _completedMatchLists = <MatchesData>[];
  // MatchesModel _matchData = MatchesModel();
  bool _isProgressRunning = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  MyCompletedMatchesModel _matchCompleteeData = MyCompletedMatchesModel();
  List<Completed> _completedMatchLists = <Completed>[];

  void _onRefresh() async {
    setState(() {
      _matchCompleteeData = null;
      _completedMatchLists.clear();
    });
    await _getCompletedMatches();
    _refreshController.refreshCompleted();
  }

  void completeSharedData() {
    _matchCompleteeData = SharedPreference.getcompletedData();
    // _getCompletedMatches();

    if (_matchCompleteeData?.response?.matchdata != null) {
      _completedMatchLists
          .addAll(_matchCompleteeData.response.matchdata[0].completed);
    } else if (_matchCompleteeData == null ||
        _matchCompleteeData.response == null ||
        _completedMatchLists == null) {
      _getCompletedMatches();
    }
  }

  @override
  void initState() {
    super.initState();
    completeSharedData();

    // if (_matchCompleteeData.response == null) {
    //   _getCompletedMatches();
    // } else if (_matchCompleteeData.response.matchdata != null) {
    //   _matchCompleteeData = SharedPreference.getcompletedData();
    //   _completedMatchLists
    //       .addAll(_matchCompleteeData.response.matchdata[0].completed);
    // }

    // ----

    // Future.delayed(Duration.zero, () {
    //   _getCompletedMatches();
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
      if (_matchCompleteeData != null &&
              _matchCompleteeData.response.matchdata.length > 0
          // _matchData.response.matchdata.length > 0
          ) {
        _completedMatchLists
            .addAll(_matchCompleteeData.response.matchdata[0].completed);
      }

      log("${_completedMatchLists.length}", name: "length");
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

  Widget _noCompletedMatchesFound() {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 50,
          ),
          Center(
            child: Text(
              AppLocalizations.of("You haven't any completed matches"),
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.caption.copyWith(
                    color: Theme.of(context).textTheme.bodyText2.color,
                    letterSpacing: 0.6,
                    fontSize: 16,
                  ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            height: 200,
            width: 200,
            decoration: BoxDecoration(
              color: ColorConstant.COLOR_WHITE,
              shape: BoxShape.circle,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  ImgConstants.CUP,
                  height: 100,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            AppLocalizations.of(
                'Join contests for any of the upcoming matches'),
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: Theme.of(context).textTheme.bodyText2.color,
                  letterSpacing: 0.6,
                  fontSize: 14,
                ),
          ),
          SizedBox(
            height: 40,
          ),
          InkWell(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => HomeScreen()));
            },
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
              child: Container(
                height: 40,
                width: 220,
                decoration: BoxDecoration(
                  color: ColorConstant.COLOR_TEXT,
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Center(
                  child: Text(
                    AppLocalizations.of('View Upcoming Matches'),
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
    );
  }

  Widget _getLiveMatchList() {
    return Padding(
      padding:
          const EdgeInsets.only(left: 0.0, right: 0.0, top: 14.0, bottom: 0),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: _onRefresh,
        controller: _refreshController,
        header: MaterialClassicHeader(
            color: ColorConstant.COLOR_TEXT,
            backgroundColor: ColorConstant.COLOR_WHITE),
        child: ListView.builder(
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CompleteCardWidget(
                  txt1: "${_completedMatchLists[index].shortTitle ?? ""}",
                  txt2: _completedMatchLists[index]?.teama?.shortName,
                  txt3: _completedMatchLists[index]?.teamb?.shortName,

                  timerset: _completedMatchLists[index].dateStart == null
                      ? ""
                      : _completedMatchLists[index].dateStart,

                  status: _completedMatchLists[index].statusStr == null
                      ? ""
                      : _completedMatchLists[index]?.statusStr,
                  //_completedMatchLists[index]?.statusStr ?? "",
                  image1: _completedMatchLists[index]?.teama?.logoUrl ?? null,
                  // Image.network(
                  //     _completedMatchLists[index]?.teama?.logoUrl),
                  image2: _completedMatchLists[index]?.teamb?.logoUrl ?? null,
                  // Image.network(
                  //     _completedMatchLists[index]?.teamb?.logoUrl),
                  teamCount:
                      "${_completedMatchLists[index]?.totalJoinedTeam} Team",
                  contestCount:
                      "${_completedMatchLists[index]?.totalJoinContests}",
                  prizeWin:
                      "You Won ₹${_completedMatchLists[index]?.prizeAmount?.toStringAsFixed(2) ?? ""}",

                  onClick: () {
                    SharedPreference.setValue(PrefConstants.MATCH_ID,
                        _completedMatchLists[index].matchId ?? "");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => MatchContestByLiveCompleted(
                            selectedMatchData:
                                _completedMatchLists[index] ?? null,
                            pageFromMatch: StringConstant.COMPLETED_MATCHES),
                      ),
                    );
                  },
                ),
              );
            },
            itemCount: _completedMatchLists?.length,
            shrinkWrap: true),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isProgressRunning
        ? ShimmerProgressWidget(count: 8, isProgressRunning: _isProgressRunning)
        : _completedMatchLists != null && _completedMatchLists.length > 0
            ? _getLiveMatchList()
            : _noCompletedMatchesFound();
  }
}
