import 'dart:developer';

import 'package:carousel_pro/carousel_pro.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/contestTab/contest_tab.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/model/myjoined_live_matches_model.dart'
    as livematch;
import 'package:balleballe11/model/myjoined_live_matches_model.dart';

import 'package:balleballe11/sports/splash_screen/maintenance_page.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import 'contest.dart';

import 'myMatches/Live/Dashboard_live_match/dashboard_match_live_completed.dart';
import 'myMatches/Live/NoContestLiveMatch/matchlive_completed.dart';
import 'myMatches/Live/match_live_contest_completed.dart';
import 'myMatches/Upcoming/dashboard_match_completed.dart';
import 'myMatches/match_contest_live_completed.dart';

class CricketPage extends StatefulWidget {
  const CricketPage({Key key}) : super(key: key);

  @override
  _CricketPageState createState() => _CricketPageState();
}

class _CricketPageState extends State<CricketPage> {
  bool _isProgressRunning = false;
  MatchesModel _matchData = MatchesModel();
  MatchesModel _joinedmatchData = MatchesModel();

  livematch.MyLiveMatchesModel _LivematchData = livematch.MyLiveMatchesModel();
  List<livematch.Matchdatum> _liveMatchLists = <livematch.Matchdatum>[];
  CountdownTimerController controller;
  // List<Live> live;

  // MatchesModel _matchDataStored = MatchesModel();
  var teama_image;
  var teamb_image;
  var joinedteama_image;
  var joinedteamb_image;

  var match_time_start;
  var match_count_start;
  var joined_match_time_start;
  var joined_match_count_start;

  bool isloading = false;

  List<String> bannerimageshow = [];
  int _currentTimeStamp;
  var upcomingmatchdata;
  var bannerimagedata;
  var joinedmatchdata;
  RefreshController _refreshController2 =
      RefreshController(initialRefresh: false);

  MyCompletedMatchesModel _matchCompleteeData = MyCompletedMatchesModel();
  List<Completed> _completedMatchLists = <Completed>[];
//  bool completeTap = false;

  Future<void> getUpcomingMatch() async {
    try {
      setState(() {
        _isProgressRunning = true;
        isloading = true;
      });
      if (_matchData == null) {
        getUpcomingMatch();
      } else if (_matchData != null) {
        _matchData = await APIServices.getMatchListData();

        log("${_matchData}");

        setState(() {
          //  if (_matchData.response1.matchdata.length > 0) {
          if (_matchData?.response1?.matchdata?.length == 3) {
            upcomingmatchdata =
                _matchData?.response1?.matchdata[2]?.upcomingmatches;
            joinedmatchdata =
                _matchData?.response1?.matchdata[0]?.joinedmatches;
            bannerimagedata = _matchData?.response1?.matchdata[1]?.banners;
          } else {
            upcomingmatchdata =
                _matchData?.response1?.matchdata[1]?.upcomingmatches;
            // joinedmatchdata = _matchData.response1.matchdata[0].joinedmatches;
            bannerimagedata = _matchData?.response1?.matchdata[0]?.banners;
          }
        });
      }

      if (_matchData.maintainance == true) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MaintenancePage(),
          ),
        );
      }
      //    print(_bannerData);
    } catch (error) {
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      setState(() {
        _isProgressRunning = false;
        isloading = false;
      });
    }
  }

  Future<void> _getLiveMatches() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _LivematchData = await APIServices.getMyLiveMatches(
        "live",
      );
      if (_LivematchData != null)
        _liveMatchLists.addAll(_LivematchData?.response?.matchdata);
      //  log("${live.length}", name: "live length");
    } catch (error) {
      log("$error", name: "error");
      //  showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      if (!mounted) return;
      setState(() {
        _isProgressRunning = false;
      });
    }
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
          _matchCompleteeData.response.matchdata.length > 0) {
        _completedMatchLists
            .addAll(_matchCompleteeData?.response?.matchdata[0]?.completed);
      }

      log("${_completedMatchLists.length}", name: "length");
    } catch (error) {
      log("$error", name: "error");
      //  if (_matchCompleteeData != null)
      //   showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      // if (completeTap) {
      //   Navigator.pop(context);
      // }
      //  EasyLoading.dismiss();
      if (mounted)
        setState(() {
          _isProgressRunning = false;
        });
    }
    //  return 1;
  }

  void completeShareddata() {
    _matchCompleteeData = SharedPreference.getcompletedData();
    if (_matchCompleteeData != null) {
      _completedMatchLists
          .addAll(_matchCompleteeData?.response?.matchdata[0]?.completed);
    } else if (_matchCompleteeData == null || _completedMatchLists == null) {
      _getCompletedMatches();
    }
  }

  void upcomingSharedData() {
    getUpcomingMatch();
    upcomingmatchdata = SharedPreference.getUpcomingMatchData();

    if (_matchData != null) {
      setState(() {
        if (_matchData?.response1?.matchdata?.length == 3) {
          upcomingmatchdata =
              _matchData?.response1?.matchdata[2]?.upcomingmatches;
          joinedmatchdata = _matchData?.response1?.matchdata[0]?.joinedmatches;
          bannerimagedata = _matchData?.response1?.matchdata[1]?.banners;
        } else if (_matchData?.response1?.matchdata?.length == 2) {
          upcomingmatchdata =
              _matchData?.response1?.matchdata[1]?.upcomingmatches;
          bannerimagedata = _matchData?.response1?.matchdata[0]?.banners;
        }
      });
    }
  }

  @override
  void initState() {
    super.initState();
    completeShareddata();
    upcomingSharedData();

    Future.delayed(Duration.zero, () {
      _getCompletedMatches();
      //  getUpcomingMatch();
      _getLiveMatches();
      //  WidgetsBinding.instance.addPostFrameCallback(_showOpenDialog);

      // .then((value) {
      //   WidgetsBinding.instance.addPostFrameCallback(_showOpenDialog);
      // });
    });

    int _currentTimeStamp = DateTime.now().millisecondsSinceEpoch;
  }

  void _onRefresh1() async {
    await Future.delayed(Duration.zero, () {
      _getCompletedMatches();
      getUpcomingMatch();
    });
    _refreshController2.refreshCompleted();
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;

    return isloading
        ? ShimmerProgressWidget(count: 8, isProgressRunning: isloading)
        : Container(
            height: height1,
            child: SafeArea(
              child: SmartRefresher(
                enablePullDown: true,
                enablePullUp: false,
                onRefresh: _onRefresh1,
                controller: _refreshController2,
                header: MaterialClassicHeader(
                  color: ColorConstant.COLOR_TEXT,
                  backgroundColor: ColorConstant.COLOR_WHITE,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Stack(
                        children: [
                          // CachedNetworkImage(
                          //   progressIndicatorBuilder: null,
                          //   imageUrl:
                          //       "https://helpx.adobe.com/content/dam/help/en/photoshop/using/convert-color-image-black-white/jcr_content/main-pars/before_and_after/image-before/Landscape-Color.jpg",
                          //   fit: BoxFit.fill,
                          //   width: double.infinity,
                          //   placeholder: (context, url) {
                          //     return Image.asset(
                          //       ImgConstants.BANNER_IMAGE,
                          //       height: height1 * 0.15,
                          //       width: double.infinity,
                          //       fit: BoxFit.fill,
                          //     );
                          //   },
                          // ),

                          // Image.asset(
                          //   ImgConstants.BANNER_IMAGE,
                          //   height: height1 * 0.15,
                          //   width: double.infinity,
                          //   fit: BoxFit.fill,
                          // ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 10),
                            child: Column(
                              children: [
                                Visibility(
                                  visible: _matchData
                                          ?.response1?.matchdata?.length ==
                                      3,
                                  child: Container(
                                    height: height1 * 0.20,
                                    decoration: BoxDecoration(),
                                    child: SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: ListView.builder(
                                          scrollDirection: Axis.horizontal,
                                          padding: EdgeInsets.zero,
                                          physics:
                                              NeverScrollableScrollPhysics(),
                                          itemBuilder: (context, index) {
                                            return _getJoinedMatchItem(
                                                context, index);
                                          },
                                          itemCount:
                                              //3,
                                              joinedmatchdata?.length ?? 0,

                                          //  itemCount: _matchData.response1?.matchdata[0]?.joinedmatches?.length ?? 0,
                                          shrinkWrap: true),
                                    ),
                                  ),
                                ),

                                // Banner Image Show
                                //    if (bannerlistData.length > 0)

                                // if ((_matchData.response?.matchdata![1].upcomingmatches
                                //         ?.length)! >
                                //     0)

                                // if(bannerimagedata[index].url != null &&
                                //     bannerimagedata[index].url.length > 0
                                // )

                                const SizedBox(
                                  height: 15,
                                ),

                                SizedBox(
                                  height: 105.0,
                                  width: double.infinity,
                                  child: Swiper(
                                    itemCount: bannerimagedata?.length ?? 0,
                                    itemBuilder:
                                        (BuildContext context, int index) =>
                                            CarouselSlider(
                                      items: [
                                        Stack(
                                          children: [
                                            Image.asset(
                                              ImgConstants
                                                  .balleballe11_CONTEST_DASHBOARD,
                                              width: double.infinity,
                                              fit: BoxFit.fill,
                                            ),
                                            Positioned(
                                                top: 7,
                                                left: 0,
                                                right: 0,
                                                bottom: 10,
                                                child: Column(
                                                  children: [
                                                    Center(
                                                      child: Text(
                                                        "DASHBOARD",
                                                        textAlign:
                                                            TextAlign.center,
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .subtitle1
                                                            .copyWith(
                                                              color: ColorConstant
                                                                  .COLOR_WHITE,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                            ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 10,
                                                              left: 10.0,
                                                              right: 60,
                                                              bottom: 7),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "My Commission"
                                                                .toUpperCase(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                .copyWith(
                                                                  color: ColorConstant
                                                                      .COLOR_WHITE,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          Text(
                                                            "${SharedPreference.getValue(PrefConstants.AFFILIATE_COMMISSION) ?? 0}%",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                .copyWith(
                                                                  color: ColorConstant
                                                                      .COLOR_WHITE,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    Divider(
                                                      thickness: 0,
                                                      height: 0,
                                                      color: ColorConstant
                                                          .COLOR_WHITE,
                                                    ),
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              top: 7,
                                                              left: 10.0,
                                                              right: 60),
                                                      child: Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            "MY REFFERAL's"
                                                                .toUpperCase(),
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                .copyWith(
                                                                  color: ColorConstant
                                                                      .COLOR_WHITE,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                          Spacer(),
                                                          Text(
                                                            "${SharedPreference.getValue(PrefConstants.REFFERAL_COUNT) ?? 0}   ",
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .subtitle1
                                                                .copyWith(
                                                                  color: ColorConstant
                                                                      .COLOR_WHITE,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ))
                                          ],
                                        ),
                                        ...bannerimagedata.map<Widget>((data) {
                                          return CachedNetworkImage(
                                            width: double.infinity,
                                            height: 70.0,
                                            fit: BoxFit.fill,
                                            imageUrl: data.url != null
                                                ? data.url
                                                : Image.asset(
                                                    ImgConstants.BANNER_IMAGE,
                                                    width: double.infinity,
                                                    height: 70.0,
                                                    fit: BoxFit.fill),
                                            placeholder: (context, url) =>
                                                Image.asset(
                                              ImgConstants.BANNER_IMAGE,
                                              width: double.infinity,
                                              height: 70.0,
                                              fit: BoxFit.fill,
                                            ),
                                            errorWidget: (context, url,
                                                    error) =>
                                                Image.asset(
                                                    ImgConstants.BANNER_IMAGE,
                                                    width: double.infinity,
                                                    height: 70.0,
                                                    fit: BoxFit.fill),
                                          );
                                        })?.toList(),
                                      ],
                                      options: CarouselOptions(
                                        height: 180.0,
                                        enlargeCenterPage: true,
                                        autoPlay: true,
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                        autoPlayAnimationDuration:
                                            Duration(milliseconds: 200),
                                        viewportFraction: 0.97,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),

                      //Select an Upcoming Match
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0, top: 15),
                        child: Text(
                          AppLocalizations.of('Select an Upcoming Match'),
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 40),
                        child: ListView.builder(
                            padding: EdgeInsets.zero,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return _getMatchItem(context, index);
                            },
                            itemCount: upcomingmatchdata?.length ?? 0,
                            shrinkWrap: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
  }

  // Joined List Data

  Widget _getJoinedMatchItem(BuildContext context, int index) {
    var given_joinedteamaImage = joinedmatchdata[index].teama?.logoUrl;

    if (given_joinedteamaImage != null) {
      joinedteama_image = given_joinedteamaImage;
    }

    var given_joinedteambImage = joinedmatchdata[index].teamb?.logoUrl;

    if (given_joinedteambImage != null) {
      joinedteamb_image = given_joinedteambImage;
    }

    // var match_joinedtimeStartStamp = joinedteamb_image[index].dateStart;
    //
    // if (match_joinedtimeStartStamp != null) {
    //   joined_match_time_start = match_joinedtimeStartStamp;
    // }

    // Count Down Timer

    var joined_match_countdown_timer = joinedmatchdata[index].timestampStart;

    if (joined_match_countdown_timer != null) {
      joined_match_count_start = joined_match_countdown_timer;
    }

    return InkWell(
      onTap: () async {
        var completematchIndex;
        var upcomingmatchIndex;
        var joinedLivematchIndex;

        if (joinedmatchdata[index].statusStr == "Completed" ||
            joinedmatchdata[index].statusStr == "Abandoned") {
          if (joinedmatchdata[index].totalJoinContests == null ||
              joinedmatchdata[index].totalJoinContests == 0) {
            _getCompletedMatches();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchLiveNoContest(
                  pageFromMatch: StringConstant.COMPLETED_MATCHES,
                  teama: joinedmatchdata[index].teama?.shortName,
                  teamb: joinedmatchdata[index].teamb?.shortName,
                  status: joinedmatchdata[index].statusStr,
                  matchId: joinedmatchdata[index].matchId,
                  teamaId: joinedmatchdata[index].teama?.teamId,
                  teambId: joinedmatchdata[index].teamb?.teamId,
                ),
              ),
            );
          } else {
            // for (int j = 0; j < _completedMatchLists.length; j++)
            //   if (joinedmatchdata[index].matchId ==
            //       _completedMatchLists[j].matchId) {

            //     completematchIndex = j;

            //   }
            //  _getCompletedMatches();
            //  if (_completedMatchLists.length > 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardMatchContestCompleted(
                    joinedmatches: joinedmatchdata[index],
                    teama: joinedmatchdata[index].teama?.shortName,
                    teamb: joinedmatchdata[index].teamb?.shortName,
                    status: joinedmatchdata[index].statusStr,
                    pageFromMatch: StringConstant.COMPLETED_MATCHES),
              ),
            );
            //  }
          }
        } else if (joinedmatchdata[index].statusStr == "Upcoming") {
          for (int j = 0; j < upcomingmatchdata.length; j++)
            if (joinedmatchdata[index].matchId ==
                upcomingmatchdata[j].matchId) {
              upcomingmatchIndex = j;
            }
          SharedPreference.setValue(PrefConstants.MATCH_ID,
              upcomingmatchdata[upcomingmatchIndex].matchId ?? "");

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ContestPage(
                      selectedMatchData:
                          upcomingmatchdata[upcomingmatchIndex] ?? null,
                      //   remainingTime: remainingTime,
                      isFrom: StringConstant.UPCOMING_MATCHES,
                      //   guru: upcomingmatchdata[index].totalGuru ?? 0,
                    )),
          );
        } else if (joinedmatchdata[index].statusStr == "Live" ||
            joinedmatchdata[index].statusStr == "In Review" ||
            joinedmatchdata[index].statusStr == "Review") {
          if (joinedmatchdata[index].totalJoinContests == null ||
              joinedmatchdata[index].totalJoinContests == 0) {
            _getLiveMatches();

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MatchLiveNoContest(
                  //    selectedMatchData: _matchData,

                  pageFromMatch: StringConstant.LIVE_MATCHES,
                  teama: joinedmatchdata[index].teama?.shortName,
                  teamb: joinedmatchdata[index].teamb?.shortName,
                  status: joinedmatchdata[index].statusStr,
                  matchId: joinedmatchdata[index].matchId,
                  teamaId: joinedmatchdata[index].teama?.teamId,
                  teambId: joinedmatchdata[index].teamb?.teamId,
                ),
              ),
            );
          } else {
            // for (int j = 0; j < _liveMatchLists[0].live.length; j++)
            // if (joinedmatchdata[index].matchId ==
            //     _liveMatchLists[0].live[j].matchId) {
            //   // SharedPreference.setValue(
            //   //     PrefConstants.MATCH_ID, live[j].matchId ?? "");
            //   joinedLivematchIndex = j;
            // }
            // _getLiveMatches();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DashboardMatchLiveCompleted(
                  selectedMatchData: joinedmatchdata[index],
                  teama: joinedmatchdata[index].teama?.shortName,
                  teamb: joinedmatchdata[index].teamb?.shortName,
                  status: joinedmatchdata[index].statusStr,
                  pageFromMatch: StringConstant.LIVE_MATCHES,
                ),
              ),
            );
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 10.0),
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            color: ColorConstant.COLOR_WHITE,
            borderRadius: BorderRadius.circular(10.0),
          ),
          // elevation: 4.0,
          // color: ColorConstant.COLOR_WHITE,
          // shape: RoundedRectangleBorder(
          //   borderRadius: BorderRadius.circular(10.0),
          // ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "${joinedmatchdata[index].leagueTitle ?? ""}",
                      style: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400,
                          ),
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.15,
                color: ColorConstant.COLOR_TEXT,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CachedNetworkImage(
                            imageUrl: joinedteama_image != null
                                ? joinedteama_image
                                : "https://cricket.entitysport.com/assets/uploads/2021/05/team-120x120.png",
                            imageBuilder: (BuildContext contest, image) =>
                                Container(
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
                            }),
                        SizedBox(width: 10),
                        Text(
                          "${joinedmatchdata[index].teama?.shortName ?? ""}",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        CachedNetworkImage(
                            imageUrl: joinedteamb_image != null
                                ? joinedteamb_image
                                : "https://cricket.entitysport.com/assets/uploads/2021/05/team-120x120.png",
                            imageBuilder: (BuildContext contest, image) =>
                                Container(
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
                            }),
                        SizedBox(width: 10),
                        Text(
                          "${joinedmatchdata[index].teamb?.shortName ?? ""}",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w400,
                              ),
                        ),
                      ],
                    )
                  ],
                ),
              ),

              //  Exact Match Time
              if (joinedmatchdata[index] != null &&
                  joinedmatchdata[index].isLineup == false)
                Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10.0),
                  child: Text(
                    "${joinedmatchdata[index].statusStr ?? ""}",
                    style: TextStyle(
                        color: ColorConstant.COLOR_GREEN,
                        fontSize: 12.0,
                        fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                ),
              // else if (upcomingmatchdata[index].isLineup == true &&
              //     joinedmatchdata[index].statusStr == "Upcoming")
              //   Padding(
              //     padding: const EdgeInsets.only(top: 5, bottom: 10.0),
              //     child: Text(
              //       // "${joinedmatchdata[index].statusStr ?? ""}",
              //       "LINE UP",
              //       style: TextStyle(
              //           color: ColorConstant.COLOR_GREEN,
              //           fontSize: 12.0,
              //           fontWeight: FontWeight.w700),
              //     ),
              //   ),

              Visibility(
                //  visible: true,
                visible: joinedmatchdata[index].isLineup == true &&
                    joinedmatchdata[index].statusStr == "Upcoming",
                //  &&
                //     joinedmatchdata[index].statusStr != "Live" &&
                //     joinedmatchdata[index].statusStr != "completed",
                child: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 10.0),
                  child: Text(
                    //  "${joinedmatchdata[index].statusStr ?? ""}",
                    "LINE UP",
                    style: TextStyle(
                        color: ColorConstant.COLOR_GREEN,
                        fontSize: 12.0,
                        fontWeight: FontWeight.w700),
                  ),
                ),
              ),

              Spacer(),
              //   Timer
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "${joinedmatchdata[index].totalJoinedTeam ?? ""}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: ColorConstant.COLOR_BLACK,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Team",
                              style:
                                  Theme.of(context).textTheme.overline.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                            const SizedBox(
                              width: 6,
                            ),
                            Text(
                              "${joinedmatchdata[index].totalJoinContests ?? ""}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: ColorConstant.COLOR_BLACK,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Contest",
                              style:
                                  Theme.of(context).textTheme.overline.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w400,
                                      ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(bottom: 3.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(10.0),
                                        topLeft: Radius.circular(10.0),
                                      ),
                                      color: ColorConstant.COLOR_LIGHT_GREY,
                                    ),
                                    padding: EdgeInsets.only(
                                        left: 5, right: 5, top: 8, bottom: 8),
                                    child: CountdownTimer(
                                      controller: controller,
                                      endTime:
                                          (joined_match_count_start) * 1000,
                                      textStyle: TextStyle(
                                        fontSize: 13.0,
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      onEnd: () {
                                        //  getUpcomingMatch();
                                      },
                                      widgetBuilder:
                                          (_, CurrentRemainingTime time) {
                                        if (time != null) {
                                          return time.days != null
                                              ? Text(
                                                  '${time.days}d : ${time.hours}h : ${time.min}m : ${time.sec}s',
                                                  style: TextStyle(
                                                      color: Colors.red,
                                                      fontSize: 13.0,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  textAlign: TextAlign.center,
                                                )
                                              : time.hours != null
                                                  ? Text(
                                                      '${time.hours}h : ${time.min}m : ${time.sec}s',
                                                      style: TextStyle(
                                                          color: Colors.red,
                                                          fontSize: 13.0,
                                                          fontWeight:
                                                              FontWeight.bold),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  : time.min != null
                                                      ? Text(
                                                          '${time.min}m : ${time.sec}s',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        )
                                                      : Text(
                                                          '${time.sec}s',
                                                          style: TextStyle(
                                                              color: Colors.red,
                                                              fontSize: 13.0,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold),
                                                          textAlign:
                                                              TextAlign.center,
                                                        );
                                        } else {
                                          return Column(
                                            children: [
                                              Text(
                                                "${joinedmatchdata[index].statusStr ?? ""}",
                                                style: TextStyle(
                                                    color: ColorConstant
                                                        .COLOR_RED2,
                                                    fontSize: 12.0,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                  Spacer(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Upcoming Data List

//    upcomingmatchdata = _matchData.response1.matchdata[2].upcomingmatches;

  Widget _getMatchItem(BuildContext context, int index) {
    // if (upcomingmatchdata != null &&
    //     upcomingmatchdata.length > 0) {
    //   var diff = DateTime.fromMillisecondsSinceEpoch(
    //       upcomingmatchdata[index].timestampStart *
    //       1000);
    //   String remainingTime = "${diff?.hour}h ${diff?.minute}m ${diff?.second}s";
    //   if (upcomingmatchdata[index]
    //               .timestampStart *
    //           1000 <
    //       _currentTimeStamp) {
    //     upcomingmatchdata[index].isTimeUp =
    //         false;
    //   } else {
    //     upcomingmatchdata[index].isTimeUp =
    //         true;
    //   }

    var given_teamaImage = upcomingmatchdata[index].teama?.logoUrl;

    if (given_teamaImage != null) {
      teama_image = given_teamaImage;
    }

    var given_teambImage = upcomingmatchdata[index].teamb?.logoUrl;

    if (given_teambImage != null) {
      teamb_image = given_teambImage;
    }

    var match_timeStartStamp = upcomingmatchdata[index].dateStart;

    if (match_timeStartStamp != null) {
      match_time_start = match_timeStartStamp;
    }

    // Count Down Timer

    var match_countdown_timer = upcomingmatchdata[index].timestampStart;

    if (match_countdown_timer != null) {
      match_count_start = match_countdown_timer;
    }

    // var diff = DateTime.fromMillisecondsSinceEpoch(_matchData
    //         .response1.matchdata[1].upcomingmatches[index].timestampStart *
    //     1000);
    // String remainingTime = "${diff?.hour}h ${diff?.minute}m ${diff?.second}s";
    // if (_matchData
    //             .response1.matchdata[1].upcomingmatches[index].timestampStart *
    //         1000 <
    //     _currentTimeStamp) {
    //   _matchData.response1.matchdata[1].upcomingmatches[index].isTimeUp = false;
    // } else {
    //   _matchData.response1.matchdata[1].upcomingmatches[index].isTimeUp = false;
    // }

    return InkWell(
      onTap: () {
        SharedPreference.setValue(
            PrefConstants.MATCH_ID, upcomingmatchdata[index].matchId ?? "");
        //
        // _matchData
        //         ?.response1?.matchdata[1].upcomingmatches[index].matchId ??
        //     "");
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContestPage(
                    selectedMatchData: upcomingmatchdata[index] ?? null,
                    //   remainingTime: remainingTime,
                    isFrom: StringConstant.UPCOMING_MATCHES,
                    // guru:

                    //  upcomingmatchdata[index].totalGuru ?? 0,
                  )),
        );
      },
      child: Column(
        children: [
          // Visibility(
          //     visible: upcomingmatchdata[index].singlePlayerAvailable > 0 ?? 0,
          //     child: Row(
          //       mainAxisAlignment: MainAxisAlignment.center,
          //       children: [
          //         Image.asset(
          //           ImgConstants.FRIEND,
          //           width: 30,
          //           height: 30,
          //         ),
          //         Flexible(
          //           child: Text(
          //             "Single Player Game Available",
          //             style: Theme.of(context).textTheme.bodyText2.copyWith(
          //                   color: ColorConstant.COLOR_BLUE3,
          //                   fontWeight: FontWeight.w900,
          //                 ),
          //           ),
          //         ),
          //         Image.asset(
          //           ImgConstants.FRIEND,
          //           width: 30,
          //           height: 30,
          //         ),
          //       ],
          //     )),
          Card(
            elevation: 4.0,
            color: ColorConstant.COLOR_WHITE,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 8.0, right: 8, top: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "${upcomingmatchdata[index].leagueTitle ?? ""}",
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w400,
                            ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.15,
                  color: ColorConstant.COLOR_TEXT,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: teama_image != null
                                ? teama_image
                                : "https://cricket.entitysport.com/assets/uploads/2021/05/team-120x120.png",
                            imageBuilder: (BuildContext contest, image) =>
                                Container(
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
                          SizedBox(width: 10),
                          Text(
                            "${upcomingmatchdata[index].teama?.shortName ?? ""}",
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          CachedNetworkImage(
                            imageUrl: teamb_image != null
                                ? teamb_image
                                : "https://cricket.entitysport.com/assets/uploads/2021/05/team-120x120.png",
                            imageBuilder: (BuildContext contest, image) =>
                                Container(
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
                          SizedBox(width: 10),
                          Text(
                            "${upcomingmatchdata[index].teamb?.shortName ?? ""}",
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w400,
                                    ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                // Exact Match Time
                if (upcomingmatchdata[index] != null &&
                    upcomingmatchdata[index].isLineup == false)
                  Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10.0),
                    child: Text(
                      match_time_start ?? "",
                      style: TextStyle(
                          color: ColorConstant.COLOR_GREEN,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),

                Visibility(
                  visible: upcomingmatchdata[index].isLineup == true,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5, bottom: 10.0),
                    child: Text(
                      "LINE UP",
                      style: TextStyle(
                          color: ColorConstant.COLOR_GREEN,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w900),
                    ),
                  ),
                ),

                // Timer
                Padding(
                  padding: const EdgeInsets.only(bottom: 3.0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(10.0),
                        topLeft: Radius.circular(10.0),
                      ),
                      color: ColorConstant.COLOR_LIGHT_GREY,
                    ),
                    padding:
                        EdgeInsets.only(left: 5, right: 5, top: 8, bottom: 8),
                    child: CountdownTimer(
                      controller: controller,
                      endTime: (match_count_start) * 1000,
                      textStyle: TextStyle(
                        fontSize: 13.0,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                      onEnd: () {
                        getUpcomingMatch();
                      },
                      widgetBuilder: (_, CurrentRemainingTime time) {
                        if (time != null) {
                          return time.days != null
                              ? Text(
                                  '${time.days}d : ${time.hours}h : ${time.min}m : ${time.sec}s',
                                  style: TextStyle(
                                      color: Colors.red,
                                      fontSize: 13.0,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                )
                              : time.hours != null
                                  ? Text(
                                      '${time.hours}h : ${time.min}m : ${time.sec}s',
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13.0,
                                          fontWeight: FontWeight.bold),
                                      textAlign: TextAlign.center,
                                    )
                                  : time.min != null
                                      ? Text(
                                          '${time.min}m : ${time.sec}s',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        )
                                      : Text(
                                          '${time.sec}s',
                                          style: TextStyle(
                                              color: Colors.red,
                                              fontSize: 13.0,
                                              fontWeight: FontWeight.bold),
                                          textAlign: TextAlign.center,
                                        );
                        } else {
                          return Column(
                            children: [
                              Text(
                                "Upcoming",
                                //    "${upcomingmatchdata[index].statusStr ?? ""}",
                                style: TextStyle(
                                    color: ColorConstant.COLOR_RED2,
                                    fontSize: 12.0,
                                    fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          );
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ContestPage(
                          selectedMatchData: upcomingmatchdata[index] ?? null,
                          //   remainingTime: remainingTime,
                          isFrom: StringConstant.UPCOMING_MATCHES,
                        )),
              );
            },
            child: Visibility(
              visible: upcomingmatchdata[index].eventName != null,
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    color: ColorConstant.COLOR_TEXT, // background
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(10),
                      bottomRight: Radius.circular(10),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(top: 0.0, bottom: 0),
                  child: Row(
                    children: [
                      Container(
                        height: 25,
                        width: 25,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: ColorConstant.COLOR_WHITE,
                          ),
                        ),
                        child: Center(
                          child: Image.asset(
                            ImgConstants.TROPHY,
                            height: 18,
                            width: 18,
                          ),
                        ),
                      ),
                      Spacer(),
                      Center(
                        child: Text(
                          "${upcomingmatchdata[index].eventName ?? ""}",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: ColorConstant.COLOR_WHITE,
                              fontSize: 10.0,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Spacer(),
                    ],
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 13,
          ),
        ],
      ),
    );
    // }
    // else {
    //   return Container();
    // }
  }

  _showOpenDialog(_) async {
    //  if (promotionsListData.length > 0)
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              titlePadding: EdgeInsets.all(0),
              contentPadding: EdgeInsets.all(0),
              actionsPadding: EdgeInsets.all(0),
              insetPadding: EdgeInsets.symmetric(horizontal: 0),
              title: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.42,
                    width: MediaQuery.of(context).size.width * 0.71,
                    child: Swiper(
                      itemCount: 2,
                      //promotionsListData.length,
                      itemBuilder: (BuildContext context, int index) =>
                          Carousel(boxFit: BoxFit.fill, images: [
                        //  for (int i = 0; i < bannerlistData.length; i++)
                        CachedNetworkImage(
                          progressIndicatorBuilder: null,
                          imageBuilder: (BuildContext context, image) =>
                              Carousel(
                            dotSize: 4.0,
                            dotSpacing: 15.0,
                            dotColor: ColorConstant.COLOR_GREEN,
                            indicatorBgPadding: 5.0,
                            dotBgColor: Colors.transparent,
                            borderRadius: true,
                            boxFit: BoxFit.fill,
                            images: [image],
                          ),
                          imageUrl:
                              "https://i.ytimg.com/vi/DSyar-ja6zE/maxresdefault.jpg",
                          //"https://images.pexels.com/photos/2899097/pexels-photo-2899097.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                          // APIConstants.BASE_URL +
                          //     promotionsListData[i].bannerImage,
                          fit: BoxFit.fill,
                          placeholder: (context, url) {
                            return Image.asset(
                              ImgConstants.balleballe11_DEFAULT_IMAGE,
                              fit: BoxFit.fill,
                              width: double.infinity,
                            );
                          },
                        ),
                      ]),
                      autoplay: false,
                    ),
                  ),
                  Positioned(
                    top: 0,
                    right: 0,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: ColorConstant.COLOR_WHITE,
                          width: 2,
                        ),
                      ),
                      child: IconButton(
                          icon: Icon(
                            Icons.close,
                            color: Colors.black,
                            size: 25,
                          ),
                          onPressed: () {
                            Navigator.of(context).pop();
                          }),
                    ),
                  ),
                ],
              ),
            );
          });
        });
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }
}
