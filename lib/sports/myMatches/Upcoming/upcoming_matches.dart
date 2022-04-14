import 'dart:developer';
import 'package:balleballe11/Language/appLocalizations.dart';
import 'package:balleballe11/apiService/apiServices.dart';
import 'package:balleballe11/constance/color_constant.dart';
import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/home_page/home_screen.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_joined_upcomingmatches.dart';
import 'package:balleballe11/sports/contest.dart';
import 'package:balleballe11/widget/card_view.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class UpComingPage extends StatefulWidget {
  @override
  _UpComingPageState createState() => _UpComingPageState();
}

class _UpComingPageState extends State<UpComingPage> {
  // List<MatchesData> _upcomingMatchLists = <MatchesData>[];
  // MatchesModel _matchData = MatchesModel();
  bool _isProgressRunning = false;

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  MyJoinedUpcomingMatchesModel _matchData = MyJoinedUpcomingMatchesModel();
  List<Upcomingmatch> _upcomingMatchLists = <Upcomingmatch>[];
  var match_count_start;

  void _onRefresh() async {
    await _getUpcomingMatch();
    _refreshController.refreshCompleted();
  }

  Future<void> _getUpcomingMatch() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _matchData = await APIServices.getMyJoinedUpcomingMatches("upcoming");
      _upcomingMatchLists.clear();
      if (_matchData != null)
        _upcomingMatchLists
            .addAll(_matchData.response.matchdata[0].upcomingMatch);

      log("${_upcomingMatchLists.length}", name: "length");
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

  Widget _noUpcomingMatchesFound() {
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

  Widget _getUpcomingMatchList() {
    return Padding(
      padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 14.0),
      child: SmartRefresher(
        enablePullDown: true,
        enablePullUp: false,
        onRefresh: _onRefresh,
        controller: _refreshController,
        header: MaterialClassicHeader(
            color: ColorConstant.COLOR_RED,
            backgroundColor: ColorConstant.COLOR_WHITE),
        child: ListView.builder(
            physics: ScrollPhysics(),
            itemBuilder: (context, index) {
              var match_countdown_timer =
                  _upcomingMatchLists[index].timestampStart;

              if (match_countdown_timer != null) {
                match_count_start = match_countdown_timer;
              }

              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CompleteCardView(
                  txt2: _upcomingMatchLists[index]?.teama?.shortName,
                  txt3: _upcomingMatchLists[index]?.teamb?.shortName,
                  txt5: _upcomingMatchLists[index]?.dateStart,
                  image1: CachedNetworkImage(
                    imageUrl: _upcomingMatchLists[index]?.teama?.logoUrl ??
                        "https://cricket.entitysport.com/assets/uploads/2021/05/team-120x120.png",
                    imageBuilder: (BuildContext contest, image) => Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: ColorConstant.COLOR_WHITE,
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Image.asset(
                        ImgConstants.DEFAULT_PLAYER,
                        width: 40.0,
                        height: 40.0),
                    errorWidget: (context, url, error) {
                      return Image.asset(ImgConstants.DEFAULT_PLAYER,
                          width: 40.0, height: 40.0);
                    },
                  ),

                  // Image.network(_upcomingMatchLists[index]?.teama?.logoUrl),
                  image2: CachedNetworkImage(
                    imageUrl: _upcomingMatchLists[index]?.teamb?.logoUrl ??
                        "https://cricket.entitysport.com/assets/uploads/2021/05/team-120x120.png",
                    imageBuilder: (BuildContext contest, image) => Container(
                      width: 40.0,
                      height: 40.0,
                      decoration: BoxDecoration(
                        color: ColorConstant.COLOR_WHITE,
                        image: DecorationImage(
                          image: image,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    placeholder: (context, url) => Image.asset(
                        ImgConstants.DEFAULT_PLAYER,
                        width: 40.0,
                        height: 40.0),
                    errorWidget: (context, url, error) {
                      return Image.asset(ImgConstants.DEFAULT_PLAYER,
                          width: 40.0, height: 40.0);
                    },
                  ),

                  //  Image.network(_upcomingMatchLists[index]?.teamb?.logoUrl),
                  // countDown: CountdownTimer(
                  //   endTime: (match_count_start) * 1000,
                  //   textStyle: TextStyle(
                  //     fontSize: 13.0,
                  //     color: Colors.red,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  //   onEnd: () {
                  //     //   getUpcomingMatch();
                  //   },
                  //   widgetBuilder: (_, CurrentRemainingTime time) {
                  //     if (time != null) {
                  //       return time.days != null
                  //           ? Text(
                  //               '${time.days}d : ${time.hours}h : ${time.min}m : ${time.sec}s',
                  //               style: TextStyle(
                  //                   color: Colors.red,
                  //                   fontSize: 13.0,
                  //                   fontWeight: FontWeight.bold),
                  //               textAlign: TextAlign.center,
                  //             )
                  //           : time.hours != null
                  //               ? Text(
                  //                   '${time.hours}h : ${time.min}m : ${time.sec}s',
                  //                   style: TextStyle(
                  //                       color: Colors.red,
                  //                       fontSize: 13.0,
                  //                       fontWeight: FontWeight.bold),
                  //                   textAlign: TextAlign.center,
                  //                 )
                  //               : time.min != null
                  //                   ? Text(
                  //                       '${time.min}m : ${time.sec}s',
                  //                       style: TextStyle(
                  //                           color: Colors.red,
                  //                           fontSize: 13.0,
                  //                           fontWeight: FontWeight.bold),
                  //                       textAlign: TextAlign.center,
                  //                     )
                  //                   : Text(
                  //                       '${time.sec}s',
                  //                       style: TextStyle(
                  //                           color: Colors.red,
                  //                           fontSize: 13.0,
                  //                           fontWeight: FontWeight.bold),
                  //                       textAlign: TextAlign.center,
                  //                     );
                  //     } else {
                  //       return Column(
                  //         children: [
                  //           Text(
                  //             "Upcoming",
                  //             //  "${upcomingmatchdata[index].status ?? ""}",
                  //             style: TextStyle(
                  //                 color: ColorConstant.COLOR_RED2,
                  //                 fontSize: 12.0,
                  //                 fontWeight: FontWeight.bold),
                  //             textAlign: TextAlign.center,
                  //           ),
                  //         ],
                  //       );
                  //     }
                  //   },
                  // ),
                  onClick: () {
                    // SharedPreference.setValue(PrefConstants.MATCH_ID,
                    //     _upcomingMatchLists[index].matchId ?? "");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ContestPage(
                          selectedMatchData: _upcomingMatchLists[index] ?? null,
                          //   remainingTime: "",
                          isFrom: StringConstant.UPCOMING_MATCHES,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            itemCount: _upcomingMatchLists?.length,
            shrinkWrap: true),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getUpcomingMatch();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isProgressRunning
        ? ShimmerProgressWidget(count: 8, isProgressRunning: _isProgressRunning)
        : _upcomingMatchLists != null && _upcomingMatchLists.length > 0
            ? _getUpcomingMatchList()
            : _noUpcomingMatchesFound();
  }
}
