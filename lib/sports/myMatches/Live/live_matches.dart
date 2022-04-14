import 'dart:developer';
import 'package:balleballe11/Language/appLocalizations.dart';
import 'package:balleballe11/constance/color_constant.dart';
import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/myjoined_live_matches_model.dart';
import 'package:balleballe11/widget/card_view.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';
import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

import '../match_contest_live_completed.dart';
import 'match_live_contest_completed.dart';

class LivePage extends StatefulWidget {
  @override
  _LivePageState createState() => _LivePageState();
}

class _LivePageState extends State<LivePage> {
  // List<MatchesData> _liveMatchLists = <MatchesData>[];
  MyLiveMatchesModel _matchData = MyLiveMatchesModel();
  List<Matchdatum> _liveMatchLists = <Matchdatum>[];
  bool _isProgressRunning = false;
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  void _onRefresh() async {
    setState(() {
      _matchData = null;
      _liveMatchLists.clear();
    });
    await _getLiveMatches();
    _refreshController.refreshCompleted();
  }

  Future<void> _getLiveMatches() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _matchData = await APIServices.getMyLiveMatches("live");
      if (_matchData != null)
        _liveMatchLists.addAll(_matchData.response.matchdata);
      log("${_liveMatchLists.length}", name: "live length");
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      if (!mounted) return;
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  Widget _noLiveMatchesFound() {
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
              AppLocalizations.of(
                  "You haven't joined any contest that are live"),
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

  Widget _getLiveMatchLists() {
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
        child: Column(
          children: [
            ListView.builder(
                physics: ScrollPhysics(),
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CompleteCardView(
                        txt1: _liveMatchLists[0].live[index].title,
                        txt2: _liveMatchLists[0].live[index].teama?.shortName,
                        txt3: _liveMatchLists[0]?.live[index].teamb?.shortName,
                        txt5: "Live",
                        //   status: "vv",
                        // _liveMatchLists[index]?.status,
                        image1: CachedNetworkImage(
                          imageUrl: _liveMatchLists[0]
                                  ?.live[index]
                                  .teama
                                  ?.logoUrl ??
                              "https://cricket.entitysport.com/assets/uploads/2021/05/team-120x120.png",
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
                        // Image.network(
                        //     _liveMatchLists[0]?.live[index].teama?.logoUrl ??
                        //         null),
                        image2: CachedNetworkImage(
                          imageUrl: _liveMatchLists[0]
                                  ?.live[index]
                                  .teamb
                                  ?.logoUrl ??
                              "https://cricket.entitysport.com/assets/uploads/2021/05/team-120x120.png",
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
                        //  Image.network(
                        //     _liveMatchLists[0]?.live[index].teamb?.logoUrl ??
                        //         null),
                        onClick: () {
                          SharedPreference.setValue(PrefConstants.MATCH_ID,
                              _liveMatchLists[0].live[index].matchId ?? "");
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => MatchLiveCompleted(
                                  selectedMatchData:
                                      _liveMatchLists[0].live[index] ?? null,
                                  pageFromMatch: StringConstant.LIVE_MATCHES),
                            ),
                          );
                        }),
                  );
                },
                itemCount: _liveMatchLists[0].live?.length,
                shrinkWrap: true),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getLiveMatches();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _isProgressRunning
        ? ShimmerProgressWidget(count: 8, isProgressRunning: _isProgressRunning)
        : _liveMatchLists != null && _liveMatchLists.length > 0
            ? _getLiveMatchLists()
            : _noLiveMatchesFound();
  }
}
