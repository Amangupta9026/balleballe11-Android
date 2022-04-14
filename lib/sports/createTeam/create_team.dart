import 'dart:developer';

import 'package:balleballe11/balance/addcash.dart';
import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/create_team_model.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/getMyTeamList.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/selected_team_model.dart';
import 'package:balleballe11/model/squad_players_model.dart';
import 'package:balleballe11/sports/My%20Accounts/balance.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:url_launcher/url_launcher.dart';

import 'chooseCaptain.dart';

class CreateTeamPage extends StatefulWidget {
  Upcomingmatch selectedMatchData = Upcomingmatch();
  String remainingTime = "", createTeamMode = "createMode";
  TeamPlayersData getMyTeamData = TeamPlayersData();

  CreateTeamPage({
    this.selectedMatchData,
    this.remainingTime,
    this.createTeamMode,
    this.getMyTeamData,
  }) {
    this.selectedMatchData = selectedMatchData;
    this.remainingTime = remainingTime;
    this.createTeamMode = createTeamMode;
    this.getMyTeamData;
  }

  @override
  _CreateTeamPageState createState() => _CreateTeamPageState();
}

class _CreateTeamPageState extends State<CreateTeamPage> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  bool _isProgressRunning = false;
  bool isLineUp = false;
  bool _isProgressRunning2 = false;

  bool _isSalBySelected = false,
      _isSalByClicked = false,
      _isPointWiseSelected = false,
      _isPointClicked = false,
      _isRatingWiseSelected = false,
      _isRatingClicked = false;

  bool _isWkPlayers = true,
      _isBATPlayers = false,
      _isARPlayers = false,
      _isBowlPlayers = false;

  int _wkKeeperSelectionCount = 0,
      _batsManSelectionCount = 0,
      _allRounderSelectionCount = 0,
      _bowlerSelectionCount = 0,
      _totalPlayerCount = 0,
      teamAPlayerSelection = 0,
      teamBPlayerSelection = 0;

  final int TOTAL_PLAYER = 11;
  final int MAX_SELECTED_PLAYER_FROM_TEAM = 7;
  final int MIN_SELECTED_PLAYER_FROM_TEAM = 4;

  final int MIN_WK = 1;
  final int MAX_WK = 4;

  final int MIN_BATS = 1;
  final int MAX_BATS = 6;

  final int MIN_AR = 1;
  final int MAX_AR = 6;

  final int MIN_BOWL = 1;
  final int MAX_BOWL = 6;

  final int WANT_WK = 1;
  final int WANT_BAT = 2;
  final int WANT_ALL = 3;
  final int WANT_BOWL = 4;

  List<CricketPlayerModel> _wkSquadList = <CricketPlayerModel>[];
  List<CricketPlayerModel> _batsSquadList = <CricketPlayerModel>[];
  List<CricketPlayerModel> _arSquadList = <CricketPlayerModel>[];
  List<CricketPlayerModel> _bowlersSquadList = <CricketPlayerModel>[];

  //
  List<CricketPlayerModel> _wkSelectedSquadList = <CricketPlayerModel>[];
  List<CricketPlayerModel> _batsSelectedSquadList = <CricketPlayerModel>[];
  List<CricketPlayerModel> _arSelectedSquadList = <CricketPlayerModel>[];
  List<CricketPlayerModel> _bowlersSelectedSquadList = <CricketPlayerModel>[];
  bool isloading = true;

  String privacyPolicyUrl = "https://balleballe11.in/privacy-policy";
  CountdownTimerController controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      isloading = false;
    });
    // Future.delayed(Duration.zero, () {
    _getSquadsByMatchId();
    //  });
  }

  Future<void> _getSquadsByMatchId() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      var _squadModelData = await APIServices.getSquadsByMatchId(
          widget.selectedMatchData?.matchId);
      setState(() {
        if (_squadModelData.status == true) {
          var playerlist = _squadModelData.response.players;
          if (playerlist != null) {
            var wkList = playerlist.wk;
            var batList = playerlist.bat;
            var arList = playerlist.all;
            var bowlList = playerlist.bowl;

            _wkSquadList.addAll(wkList);

            _batsSquadList.addAll(batList);
            _arSquadList.addAll(arList);
            _bowlersSquadList.addAll(bowlList);

            if (widget.createTeamMode != null &&
                (widget.createTeamMode != null &&
                        widget.createTeamMode == "copyMode" ||
                    widget.createTeamMode == "editMode")) {
              for (int i = 0; i < _wkSquadList.length; i++) {
                for (int j = 0; j < widget.getMyTeamData.wk.length; j++) {
                  if (_wkSquadList[i].pid == widget.getMyTeamData.wk[j]) {
                    _wkSquadList[i].isSelected = true;
                    _wkKeeperSelectionCount++;
                    _totalPlayerCount++;

                    _wkSquadList[i].teamId ==
                            widget.selectedMatchData?.teama?.teamId
                        ? teamAPlayerSelection++
                        : teamBPlayerSelection++;

                    var wkobj = _wkSquadList[i];
                    wkobj.playingRole = "wk";
                    _wkSelectedSquadList.add(wkobj);
                  }
                }
              }

              for (int i = 0; i < _batsSquadList.length; i++) {
                for (int j = 0; j < widget.getMyTeamData.bat.length; j++) {
                  if (_batsSquadList[i].pid == widget.getMyTeamData.bat[j]) {
                    _batsSquadList[i].isSelected = true;
                    _batsManSelectionCount++;
                    _totalPlayerCount++;

                    _batsSquadList[i].teamId ==
                            widget.selectedMatchData?.teama?.teamId
                        ? teamAPlayerSelection++
                        : teamBPlayerSelection++;

                    var batobj = _batsSquadList[i];
                    batobj.playingRole = "bat";
                    _batsSelectedSquadList.add(batobj);
                  }
                }
              }

              for (int i = 0; i < _arSquadList.length; i++) {
                for (int j = 0; j < widget.getMyTeamData.all.length; j++) {
                  if (_arSquadList[i].pid == widget.getMyTeamData.all[j]) {
                    _arSquadList[i].isSelected = true;
                    _allRounderSelectionCount++;
                    _totalPlayerCount++;

                    _arSquadList[i].teamId ==
                            widget.selectedMatchData?.teama?.teamId
                        ? teamAPlayerSelection++
                        : teamBPlayerSelection++;

                    var arobj = _arSquadList[i];
                    arobj.playingRole = "all";
                    _arSelectedSquadList.add(arobj);

                    //    _arSelectedSquadList.add(_arSquadList[i]);
                  }
                }
              }

              for (int i = 0; i < _bowlersSquadList.length; i++) {
                for (int j = 0; j < widget.getMyTeamData.bowl.length; j++) {
                  if (_bowlersSquadList[i].pid ==
                      widget.getMyTeamData.bowl[j]) {
                    _bowlersSquadList[i].isSelected = true;
                    _bowlerSelectionCount++;
                    _totalPlayerCount++;

                    _bowlersSquadList[i].teamId ==
                            widget.selectedMatchData?.teama?.teamId
                        ? teamAPlayerSelection++
                        : teamBPlayerSelection++;

                    var bowlobj = _bowlersSquadList[i];
                    bowlobj.playingRole = "bow";
                    _bowlersSelectedSquadList.add(bowlobj);
                  }
                }
              }

              // for (int i = 0; i < playerlist.bat.length; i++) {
              //   playerlist.bat[i].isSelected = true;
              //   _batsManSelectionCount++;
              //   _totalPlayerCount++;
              // }

              // for (int i = 0; i < _arSquadList.length; i++) {
              //   _arSquadList[i].isSelected = true;
              //   _allRounderSelectionCount++;
              //   _totalPlayerCount++;
              // }
            }
          }
        } else {
          // draw Empty view // No players found
        }
      });
    } catch (e) {
      showErrorDialog(context, e);
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  void _launchPrivacyPolicy() async => await canLaunch(privacyPolicyUrl)
      ? await launch(privacyPolicyUrl)
      : throw 'Could not launch $privacyPolicyUrl';

  Widget _progressShimmer() {
    return Expanded(
      child: ListView.builder(
        itemBuilder: (_, __) => Padding(
          padding: const EdgeInsets.all(10.0),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48.0,
                height: 48.0,
                color: Colors.white,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8.0),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: double.infinity,
                      height: 8.0,
                      color: Colors.white,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 2.0),
                    ),
                    Container(
                      width: 40.0,
                      height: 8.0,
                      color: Colors.white,
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        itemCount: 8,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstant.COLOR_WHITE, // transparent status bar
    ));
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.COLOR_LIGHT_GREY_2,
        key: _scaffoldKey,
        body: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Column(
              children: [
                appBar(),
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 0.0,
                    vertical: 0.0,
                  ),
                  child: Container(
                    height: 45,
                    decoration: BoxDecoration(
                      color: ColorConstant.COLOR_WHITE,
                    ),
                    child: tabBar1(),
                  ),
                ),
                Container(
                  color: ColorConstant.COLOR_DARY_GREY_BLUE,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 12.0, bottom: 12.0, left: 10),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          _isWkPlayers
                              ? AppLocalizations.of('Pick 1-4 Wicket Keepers')
                              : _isARPlayers
                                  ? AppLocalizations.of('Pick 1-6 All Rounders')
                                  : _isBATPlayers
                                      ? AppLocalizations.of('Pick 1-6 Batsman')
                                      : _isBowlPlayers
                                          ? AppLocalizations.of(
                                              'Pick 1-6 Bowlers')
                                          : "",
                          style: Theme.of(context).textTheme.bodyText2.copyWith(
                                color: ColorConstant.COLOR_WHITE,
                                fontWeight: FontWeight.w900,
                                letterSpacing: 0.6,
                                fontSize: 13.0,
                              ),
                        ),
                      ],
                    ),
                  ),
                ),
                Container(
                  color: ColorConstant.COLOR_LIGHT_GREY_2,
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 30,
                      ),
                      Expanded(
                        flex: 5,
                        // _wkSquadList[index].analytics.selection
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isSalByClicked = true;
                              _isSalBySelected = !_isSalBySelected;
                              if (_isSalBySelected) {
                                if (_isWkPlayers) {
                                  _wkSquadList.sort((a, b) => b
                                      .analytics.selection
                                      .compareTo(a.analytics.selection));
                                } else if (_isBowlPlayers) {
                                  _bowlersSquadList.sort((a, b) => b
                                      .analytics.selection
                                      .compareTo(a.analytics.selection));
                                } else if (_isBATPlayers) {
                                  _batsSquadList.sort((a, b) => b
                                      .analytics.selection
                                      .compareTo(a.analytics.selection));
                                } else {
                                  _arSquadList.sort((a, b) => b
                                      .analytics.selection
                                      .compareTo(a.analytics.selection));
                                }
                              } else {
                                if (_isWkPlayers) {
                                  _wkSquadList.sort((a, b) => a
                                      .analytics.selection
                                      .compareTo(b.analytics.selection));
                                } else if (_isBowlPlayers) {
                                  _bowlersSquadList.sort((a, b) => a
                                      .analytics.selection
                                      .compareTo(b.analytics.selection));
                                } else if (_isBATPlayers) {
                                  _batsSquadList.sort((a, b) => a
                                      .analytics.selection
                                      .compareTo(b.analytics.selection));
                                } else {
                                  _arSquadList.sort((a, b) => a
                                      .analytics.selection
                                      .compareTo(b.analytics.selection));
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 32,
                            child: Row(
                              //   mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    AppLocalizations.of('SELECT BY'),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText2
                                        .copyWith(
                                          color: Colors.black54,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.6,
                                          fontSize: 12.0,
                                        ),
                                    //   textAlign: TextAlign.center,
                                  ),
                                ),
                                Visibility(
                                  visible: _isSalByClicked,
                                  child: _isSalBySelected
                                      ? Icon(Icons.arrow_downward_sharp,
                                          color: ColorConstant.COLOR_BLUE,
                                          size: 12.0)
                                      : Icon(Icons.arrow_upward_sharp,
                                          color: ColorConstant.COLOR_BLUE,
                                          size: 12.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isPointClicked = true;
                              _isPointWiseSelected = !_isPointWiseSelected;
                              if (_isPointWiseSelected) {
                                if (_isWkPlayers) {
                                  _wkSquadList.sort((a, b) =>
                                      b.playerPoints.compareTo(a.playerPoints));
                                } else if (_isBowlPlayers) {
                                  _bowlersSquadList.sort((a, b) =>
                                      b.playerPoints.compareTo(a.playerPoints));
                                  // _bowlersSquadList.sort(
                                  //     (a, b) => b.point.compareTo(a.point));
                                } else if (_isBATPlayers) {
                                  _batsSquadList.sort((a, b) =>
                                      b.playerPoints.compareTo(a.playerPoints));
                                  // _batsSquadList.sort(
                                  //     (a, b) => b.point.compareTo(a.point));
                                } else {
                                  _arSquadList.sort((a, b) =>
                                      b.playerPoints.compareTo(a.playerPoints));
                                  // _arSquadList.sort(
                                  //     (a, b) => b.point.compareTo(a.point));
                                }
                              } else {
                                if (_isWkPlayers) {
                                  _wkSquadList.sort((a, b) =>
                                      a.playerPoints.compareTo(b.playerPoints));
                                  // _wkSquadList.sort(
                                  //     (a, b) => a.point.compareTo(b.point));
                                } else if (_isBowlPlayers) {
                                  _bowlersSquadList.sort((a, b) =>
                                      a.playerPoints.compareTo(b.playerPoints));
                                  // _bowlersSquadList.sort(
                                  //     (a, b) => a.point.compareTo(b.point));
                                } else if (_isBATPlayers) {
                                  _batsSquadList.sort((a, b) =>
                                      a.playerPoints.compareTo(b.playerPoints));
                                  // _batsSquadList.sort(
                                  //     (a, b) => a.point.compareTo(b.point));
                                } else {
                                  _arSquadList.sort((a, b) =>
                                      a.playerPoints.compareTo(b.playerPoints));
                                  // _arSquadList.sort(
                                  //     (a, b) => a.point.compareTo(b.point));
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 32,
                            child: Row(
                              //    mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  AppLocalizations.of('POINTS'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 12.0,
                                      ),
                                  // textAlign: TextAlign.center,
                                ),
                                Visibility(
                                  visible: _isPointClicked,
                                  child: _isPointWiseSelected
                                      ? Icon(Icons.arrow_downward_sharp,
                                          color: ColorConstant.COLOR_BLUE,
                                          size: 14.0)
                                      : Icon(Icons.arrow_upward_sharp,
                                          color: ColorConstant.COLOR_BLUE,
                                          size: 14.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              _isRatingClicked = true;
                              _isRatingWiseSelected = !_isRatingWiseSelected;
                              if (_isRatingWiseSelected) {
                                if (_isWkPlayers ||
                                    _isBowlPlayers ||
                                    _isBATPlayers ||
                                    _isARPlayers) {
                                  _wkSquadList.sort((a, b) => b
                                      .fantasyPlayerRating
                                      .compareTo(a.fantasyPlayerRating));
                                  _bowlersSquadList.sort((a, b) => b
                                      .fantasyPlayerRating
                                      .compareTo(a.fantasyPlayerRating));
                                  _batsSquadList.sort((a, b) => b
                                      .fantasyPlayerRating
                                      .compareTo(a.fantasyPlayerRating));
                                  _arSquadList.sort((a, b) => b
                                      .fantasyPlayerRating
                                      .compareTo(a.fantasyPlayerRating));
                                }
                              } else {
                                if (_isWkPlayers ||
                                    _isBowlPlayers ||
                                    _isBATPlayers ||
                                    _isARPlayers) {
                                  _wkSquadList.sort((a, b) => a
                                      .fantasyPlayerRating
                                      .compareTo(b.fantasyPlayerRating));
                                  _bowlersSquadList.sort((a, b) => a
                                      .fantasyPlayerRating
                                      .compareTo(b.fantasyPlayerRating));
                                  _batsSquadList.sort((a, b) => a
                                      .fantasyPlayerRating
                                      .compareTo(b.fantasyPlayerRating));
                                  _arSquadList.sort((a, b) => a
                                      .fantasyPlayerRating
                                      .compareTo(b.fantasyPlayerRating));
                                }
                              }
                            });
                          },
                          child: Container(
                            height: 32,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  AppLocalizations.of('CREDITS'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText2
                                      .copyWith(
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.4,
                                        fontSize: 11.0,
                                      ),
                                  textAlign: TextAlign.center,
                                ),
                                Visibility(
                                  visible: _isRatingClicked,
                                  child: _isRatingWiseSelected
                                      ? Icon(Icons.arrow_downward_sharp,
                                          color: ColorConstant.COLOR_BLUE,
                                          size: 14.0)
                                      : Icon(Icons.arrow_upward_sharp,
                                          color: ColorConstant.COLOR_BLUE,
                                          size: 14.0),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                isloading
                    ? Container(
                        height: 100,
                        child: Align(
                            alignment: Alignment.center,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Container(child: CircularProgressIndicator()),
                              ],
                            )),
                      )
                    // ---------- Change _isProgressRunning

                    : _isWkPlayers == true
                        ? _wicketKeeperList()
                        : _isBATPlayers == true
                            ? _batsManList()
                            : _isARPlayers == true
                                ? _allRounderList()
                                : _isBowlPlayers == true
                                    ? _bowlerList()
                                    : SizedBox(),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => TeamPreViewPage(
                            selectedMatchData: widget.selectedMatchData,
                            wkList: _wkSelectedSquadList,
                            batsList: _batsSelectedSquadList,
                            arList: _arSelectedSquadList,
                            bowlersList: _bowlersSelectedSquadList,
                            pageFromMatch: StringConstant.UPCOMING_MATCHES,
                            // teamName: widget.getMyTeamData != null
                            //     ? "${widget.getMyTeamData.teamName}(${widget.getMyTeamData.team_tag})"
                            //     : "",
                          ),
                        ),
                      );
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: ColorConstant.COLOR_TEXT,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of('Team Preview'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: ColorConstant.COLOR_TEXT,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (_totalPlayerCount == 11 &&
                          _wkKeeperSelectionCount != 0 &&
                          _batsManSelectionCount != 0 &&
                          _bowlerSelectionCount != 0 &&
                          _allRounderSelectionCount != 0) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ChooseCaptainPage(
                              wkSelectedList: _wkSelectedSquadList,
                              batsSelectedList: _batsSelectedSquadList,
                              arSelectedList: _arSelectedSquadList,
                              bowlersSelectedList: _bowlersSelectedSquadList,
                              remainingTime: widget?.remainingTime,
                              selectedMatchData: widget?.selectedMatchData,
                              createTeamMode: widget?.createTeamMode,
                              getMyTeamData: widget?.getMyTeamData,
                            ),
                          ),
                        );
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          color: _totalPlayerCount == 11 &&
                                  _wkKeeperSelectionCount != 0 &&
                                  _batsManSelectionCount != 0 &&
                                  _bowlerSelectionCount != 0 &&
                                  _allRounderSelectionCount != 0
                              ? ColorConstant.COLOR_TEXT
                              : ColorConstant.COLOR_LIGHT_GREY,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of('Continue'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: ColorConstant.COLOR_WHITE,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget appBar() {
    return Row(
      children: [
        Expanded(
          child: Container(
            child: Column(
              children: [
                Container(
                  color: ColorConstant.COLOR_WHITE,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 12.0, right: 12.0, top: 30.0, bottom: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            //  _goBack();
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.arrow_back,
                            color: ColorConstant.COLOR_TEXT,
                            size: 24,
                          ),
                        ),
                        SizedBox(width: 14.0),
                        Spacer(),
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
                                              fontWeight: FontWeight.w500,
                                              color: ColorConstant.COLOR_TEXT),
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
                                                  fontWeight: FontWeight.w500,
                                                  color:
                                                      ColorConstant.COLOR_TEXT),
                                        )
                                      : time.min != null
                                          ? Text(
                                              '${time.min}m ${time.sec}s left',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                      fontSize: 14.0,
                                                      fontWeight:
                                                          FontWeight.w500,
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
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: ColorConstant
                                                          .COLOR_TEXT),
                                            );
                            }
                            return Text("");
                          },
                        ),
                        Expanded(child: SizedBox()),
                        InkWell(
                          onTap: () {
                            _launchPrivacyPolicy();
                          },
                          child: Image.asset(
                            ImgConstants.HELP,
                            height: 25,
                            width: 25,
                            color: ColorConstant.COLOR_TEXT,
                          ),
                        ),
                        const SizedBox(width: 8.0),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MyBalance(),
                              ),
                            );
                          },
                          child: Image.asset(
                            ImgConstants.WALLET2,
                            height: 25,
                            width: 25,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                Stack(
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width,
                      color: ColorConstant.COLOR_LIGHT_GREY_2,
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: Text(
                              "Max 7 player from a team",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 8, right: 8),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text("Players"),
                                        Text("$_totalPlayerCount/11"),
                                      ],
                                    ),
                                    const SizedBox(width: 5),
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.COLOR_WHITE,
                                        image: DecorationImage(
                                          image: NetworkImage(
                                            widget.selectedMatchData?.teama
                                                    ?.logoUrl ??
                                                null,
                                          ),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                        border: Border.all(
                                          color: ColorConstant.COLOR_GREY,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    Column(
                                      children: [
                                        Text(
                                          "${widget.selectedMatchData.teama.shortName ?? ""}",
                                          style: TextStyle(
                                              color: ColorConstant.COLOR_BLACK,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          "$teamAPlayerSelection",
                                          //  "0",
                                          //  "${widget.selectedMatchData?.teama[0]?.shortName ?? ""}",
                                          style: TextStyle(
                                              color: ColorConstant.COLOR_BLACK,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),

                                // widget.selectedMatchData?.teama != null
                                //     ?

                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        Text(
                                          "${widget.selectedMatchData.teamb.shortName ?? ""}",
                                          style: TextStyle(
                                              color: ColorConstant.COLOR_BLACK,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w900),
                                        ),
                                        Text(
                                          "$teamBPlayerSelection",
                                          //  "${widget.selectedMatchData?.teama[0]?.shortName ?? ""}",
                                          style: TextStyle(
                                              color: ColorConstant.COLOR_BLACK,
                                              fontSize: 14.0,
                                              fontWeight: FontWeight.w900),
                                        ),
                                      ],
                                    ),
                                    SizedBox(width: 5.0),
                                    Container(
                                      width: 50.0,
                                      height: 50.0,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.COLOR_WHITE,
                                        image: DecorationImage(
                                          image: NetworkImage(widget
                                                  .selectedMatchData
                                                  .teamb
                                                  ?.logoUrl ??
                                              ""),
                                          fit: BoxFit.cover,
                                        ),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(40.0)),
                                        border: Border.all(
                                          color: ColorConstant.COLOR_TEXT,
                                          width: 1.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10.0, top: 10.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                customContainerClipper(
                                    _totalPlayerCount == 1 ||
                                            _totalPlayerCount == 2 ||
                                            _totalPlayerCount == 3 ||
                                            _totalPlayerCount == 4 ||
                                            _totalPlayerCount == 5 ||
                                            _totalPlayerCount == 6 ||
                                            _totalPlayerCount == 7 ||
                                            _totalPlayerCount == 8 ||
                                            _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "1"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 2 ||
                                            _totalPlayerCount == 3 ||
                                            _totalPlayerCount == 4 ||
                                            _totalPlayerCount == 5 ||
                                            _totalPlayerCount == 6 ||
                                            _totalPlayerCount == 7 ||
                                            _totalPlayerCount == 8 ||
                                            _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "2"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 3 ||
                                            _totalPlayerCount == 4 ||
                                            _totalPlayerCount == 5 ||
                                            _totalPlayerCount == 6 ||
                                            _totalPlayerCount == 7 ||
                                            _totalPlayerCount == 8 ||
                                            _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "3"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 4 ||
                                            _totalPlayerCount == 5 ||
                                            _totalPlayerCount == 6 ||
                                            _totalPlayerCount == 7 ||
                                            _totalPlayerCount == 8 ||
                                            _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "4"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 5 ||
                                            _totalPlayerCount == 6 ||
                                            _totalPlayerCount == 7 ||
                                            _totalPlayerCount == 8 ||
                                            _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "5"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 6 ||
                                            _totalPlayerCount == 7 ||
                                            _totalPlayerCount == 8 ||
                                            _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "6"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 7 ||
                                            _totalPlayerCount == 8 ||
                                            _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "7"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 8 ||
                                            _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "8"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 9 ||
                                            _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "9"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainer(
                                    _totalPlayerCount == 10 ||
                                            _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "10"),
                                SizedBox(
                                  width: 1.0,
                                ),
                                customContainerRightClipper(
                                    _totalPlayerCount == 11
                                        ? ColorConstant.COLOR_GREY
                                        : ColorConstant.COLOR_WHITE,
                                    "11"),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                        ],
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget customContainerClipper(Color color, String count) {
    return Container(
      width: 30.0,
      height: 25.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40),
          bottomLeft: Radius.circular(40),
        ),
      ),
      child: Center(
        child: Text(
          count,
          style: TextStyle(
              color: ColorConstant.COLOR_WHITE,
              fontSize: 9.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget customContainerRightClipper(Color color, String count) {
    return Container(
      width: 30.0,
      height: 25.0,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Center(
        child: Text(
          count,
          style: TextStyle(
              color: ColorConstant.COLOR_TEXT,
              fontSize: 9.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget customContainer(Color color, String count) {
    return Container(
      width: 30.0,
      height: 25.0,
      decoration: BoxDecoration(
        //   shape: BoxShape.circle,
        color: color,
      ),
      child: Center(
        child: Text(
          count,
          style: TextStyle(
              color: ColorConstant.COLOR_WHITE,
              fontSize: 9.0,
              fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  Widget _wicketKeeperList() {
    return Expanded(
        child:
            // _wkSquadList.length != null && _wkSquadList.length > 0
            //     ?
            ListView.builder(
      physics: ClampingScrollPhysics(),
      key: ValueKey('${_wkSquadList.hashCode}'),
      padding: EdgeInsets.only(bottom: 70.0),
      itemBuilder: (context, index) {
        return _getWKListItem(context, index);
      },
      itemCount: _wkSquadList.length ?? 0,
    )
        //   :  Center(
        //   child: Text("No Wicket Keepers Found"),
        // ),
        );
  }

  Widget _batsManList() {
    return Expanded(
        child:
            //  _batsSquadList.length != null && _batsSquadList.length > 0
            //     ?
            ListView.builder(
      physics: ClampingScrollPhysics(),
      key: ValueKey('${_batsSquadList.hashCode}'),
      padding: EdgeInsets.only(bottom: 70.0),
      itemBuilder: (context, index) {
        return _getBatsManListItem(context, index);
      },
      itemCount: _batsSquadList.length ?? 0,
    )
        //  : Center(child: Text("No Batsman Found")),
        );
  }

  Widget _allRounderList() {
    return Expanded(
        child:
            //  _arSquadList.length != null && _arSquadList.length > 0
            //     ?
            ListView.builder(
      physics: ClampingScrollPhysics(),
      key: ValueKey('${_arSquadList.hashCode}'),
      padding: EdgeInsets.only(bottom: 70.0),
      itemBuilder: (context, index) {
        return _getAllRounderItem(context, index);
      },
      itemCount: _arSquadList.length ?? 0,
    )
        //  : Center(child: Text("No All Rounders Found")),
        );
  }

  Widget _bowlerList() {
    return Expanded(
        child:
            //_bowlersSquadList.length != null && _bowlersSquadList.length > 0
            //   ?
            ListView.builder(
      physics: ClampingScrollPhysics(),
      key: ValueKey('${_bowlersSquadList.hashCode}'),
      padding: EdgeInsets.only(bottom: 70.0),
      itemBuilder: (context, index) {
        return _getBowlerItem(context, index);
      },
      itemCount: _bowlersSquadList.length ?? 0,
    )
        //   : Center(child: Text("No Bowlers Found")),
        );
  }

  Widget _getWKListItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_wkSquadList[index].isSelected) {
            _wkSquadList[index].isSelected = false;
            _wkKeeperSelectionCount--;
            _totalPlayerCount--;
            _wkSelectedSquadList.remove(_wkSquadList[index]);

            if (teamAPlayerSelection != 0 || teamBPlayerSelection != 0) {
              _wkSquadList[index].teamId ==
                      widget.selectedMatchData?.teama?.teamId
                  ? teamAPlayerSelection--
                  : teamBPlayerSelection--;
            }
          } else if (!_wkSquadList[index].isSelected) {
            if (_totalPlayerCount < TOTAL_PLAYER) {
              if (_wkKeeperSelectionCount < MAX_WK) {
                print("****");
                print("Wk Selection Count = " +
                    _wkKeeperSelectionCount.toString());
                if (isMaxPlayersValid(_wkSquadList[index].teamId)) {
                  print(isMaxPlayersValid);

                  if (isMinimumPlayerSelected(WANT_WK)) {
                    _wkSquadList[index].isSelected = true;

                    _wkKeeperSelectionCount++;
                    print("Wk Selection Count ++ = " +
                        _wkKeeperSelectionCount.toString());

                    _totalPlayerCount++;
                    print(
                        "Total Player Count =" + _totalPlayerCount.toString());
                    var wkobj = _wkSquadList[index];
                    wkobj.playingRole = "wk";
                    _wkSelectedSquadList.add(wkobj);

                    _wkSquadList[index].teamId ==
                            widget.selectedMatchData?.teama?.teamId
                        ? teamAPlayerSelection++
                        : teamBPlayerSelection++;
                  }
                } else {
                  UtilsFlushBar.showDefaultSnackbar(
                      context,
                      "MAX " +
                          MAX_SELECTED_PLAYER_FROM_TEAM.toString() +
                          " Player Allowed this team");
                }
              } else {
                UtilsFlushBar.showDefaultSnackbar(
                    context, "MAX ALLOWED is " + MAX_WK.toString());
              }
            } else {
              UtilsFlushBar.showDefaultSnackbar(
                  context, "ALL 11 Players Selected");
            }
          }
        });
      },

      //
      child: Container(
        color: _wkSquadList[index].isSelected
            ? ColorConstant.COLOR_LIGHT_PINK
            : ColorConstant.COLOR_WHITE,
        padding: EdgeInsets.only(
          top: 5,
          left: 6,
          right: 6,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: _wkSquadList[index].playerImage.isEmpty
                          ? CachedNetworkImage(
                              width: 80.0,
                              height: 70.0,
                              imageUrl: _wkSquadList[index].playerImage ??
                                  Image.asset(ImgConstants.DEFAULT_PLAYER,
                                      width: 80.0, height: 70.0),
                              placeholder: (context, url) => Image.asset(
                                  ImgConstants.DEFAULT_PLAYER,
                                  width: 80.0,
                                  height: 70.0),
                              errorWidget: (context, url, error) {
                                return Image.asset(ImgConstants.DEFAULT_PLAYER,
                                    width: 80.0, height: 70.0);
                              },
                            )
                          : Image.asset(ImgConstants.DEFAULT_PLAYER,
                              width: 80.0, height: 70.0),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.232,
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: _wkSquadList[index].teamId ==
                                widget.selectedMatchData?.teama?.teamId
                            ? ColorConstant.COLOR_TEAM_PLAYER_RED
                                .withOpacity(0.8)
                            : ColorConstant.COLOR_TEAM_PLAYER_GREY
                                .withOpacity(0.8),
                      ),
                      child: _wkSquadList[index].teamId ==
                              widget.selectedMatchData?.teama?.teamId
                          ? Text(
                              "${widget?.selectedMatchData?.teama?.shortName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_WHITE,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "${widget?.selectedMatchData?.teamb?.shortName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_WHITE,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "${_wkSquadList[index].shortName}",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "${_wkSquadList[index].fullName}",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w400,
                              ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 7.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Sel by ${_wkSquadList[index].analytics.selection}%",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorConstant.COLOR_TEXT),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "${_wkSquadList[index].playerPoints}",
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
//

                            Expanded(
                              //  flex: 2,
                              child: Text(
                                "${_wkSquadList[index].fantasyPlayerRating}",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),

                            SizedBox(width: 6.0),
                            _wkSquadList[index].isSelected
                                ? Image.asset(
                                    ImgConstants.IC_REMOVE_SELECTED_PLAYER,
                                    width: 18.0,
                                  )
                                : Image.asset(
                                    ImgConstants.IC_SELECT_PLAYER,
                                    width: 18.0,
                                  ),
                            //
                          ],
                        ),

                        // playing last match  show
                        if (widget.selectedMatchData.lastMatchPlayed
                            .contains(_wkSquadList[index].pid.toString()))
                          Visibility(
                              visible:
                                  widget.selectedMatchData.isLineup == false,
                              child: Container(
                                margin: EdgeInsets.only(top: 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 6.0,
                                      width: 6.0,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.COLOR_GREEN,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      "Played Last Match",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstant.COLOR_BLUE3),
                                    ),
                                  ],
                                ),
                              )),

                        // playing show
                        Visibility(
                          visible: widget.selectedMatchData != null &&
                              widget.selectedMatchData.isLineup != null &&
                              widget.selectedMatchData.isLineup,
                          child: _wkSquadList[index].playing11 != null &&
                                  _wkSquadList[index].playing11 == true
                              ? Container(
                                  margin: EdgeInsets.only(top: 6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.COLOR_GREEN,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        "Announced",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.COLOR_GREEN),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.COLOR_RED,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        "Not Playing",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.COLOR_RED),
                                      ),
                                    ],
                                  ),
                                ),
                          // : Text("")
                        ),

                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: ColorConstant.COLOR_GREY,
            )
          ],
        ),
      ),
    );
  }

  Widget _getBatsManListItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_batsSquadList[index].isSelected) {
            _batsSquadList[index].isSelected = false;
            _batsManSelectionCount--;
            _totalPlayerCount--;
            _batsSelectedSquadList.remove(_batsSquadList[index]);

            if (teamAPlayerSelection != 0 || teamBPlayerSelection != 0) {
              _batsSquadList[index].teamId ==
                      widget.selectedMatchData?.teama?.teamId
                  ? teamAPlayerSelection--
                  : teamBPlayerSelection--;
            }
          } else if (!_batsSquadList[index].isSelected) {
            if (_totalPlayerCount < TOTAL_PLAYER) {
              if (_batsManSelectionCount < MAX_BATS) {
                print("****");
                print("BAT Selection Count = " +
                    _batsManSelectionCount.toString());
                if (isMaxPlayersValid(_batsSquadList[index].teamId)) {
                  print(isMaxPlayersValid);

                  if (isMinimumPlayerSelected(WANT_BAT)) {
                    _batsSquadList[index].isSelected = true;

                    _batsManSelectionCount++;
                    print("BAT Selection Count ++ = " +
                        _batsManSelectionCount.toString());

                    _totalPlayerCount++;
                    print(
                        "Total Player Count =" + _totalPlayerCount.toString());

                    var batobj = _batsSquadList[index];
                    batobj.playingRole = "bat";
                    _batsSelectedSquadList.add(batobj);

                    _batsSquadList[index].teamId ==
                            widget.selectedMatchData?.teama?.teamId
                        ? teamAPlayerSelection++
                        : teamBPlayerSelection++;
                  }
                } else {
                  UtilsFlushBar.showDefaultSnackbar(
                      context,
                      "MAX " +
                          MAX_SELECTED_PLAYER_FROM_TEAM.toString() +
                          " Player Allowed this team");
                }
              } else {
                UtilsFlushBar.showDefaultSnackbar(
                    context, "MAX ALLOWED is " + MAX_BATS.toString());
              }
            } else {
              UtilsFlushBar.showDefaultSnackbar(
                  context, "ALL 11 Players Selected");
            }
          }
        });
      },
      child: Container(
        color: _batsSquadList[index].isSelected
            ? ColorConstant.COLOR_LIGHT_PINK
            : ColorConstant.COLOR_WHITE,
        padding: EdgeInsets.only(
          top: 5,
          left: 6,
          right: 6,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    // if (_batsSquadList[index].playerImage != null &&
                    //     _batsSquadList[index].playerImage.length > 1)
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: CachedNetworkImage(
                        width: 80.0,
                        height: 70.0,
                        imageUrl: _batsSquadList[index].playerImage,
                        placeholder: (context, url) => Image.asset(
                            ImgConstants.DEFAULT_PLAYER,
                            width: 80.0,
                            height: 70.0),
                        errorWidget: (context, url, error) => Image.asset(
                            ImgConstants.DEFAULT_PLAYER,
                            width: 80.0,
                            height: 70.0),
                      ),
                    ),
                    //   Image.network(
                    //     _batsSquadList[index].playerImage ?? null,
                    //     width: 80.0,
                    //     height: 70.0,
                    //     errorBuilder: (BuildContext context, Object exception,
                    //         StackTrace stackTrace) {
                    //       return Image.asset(ImgConstants.DEFAULT_PLAYER,
                    //           //   fit: BoxFit.fill,
                    //           width: 80.0,
                    //           height: 70.0);
                    //     },
                    //   )
                    // else
                    //   Image.asset(ImgConstants.DEFAULT_PLAYER,
                    //       //   fit: BoxFit.fill,
                    //       width: 80.0,
                    //       height: 70.0),
                    // CachedNetworkImage(
                    //   width: 80.0,
                    //   height: 70.0,
                    //   imageUrl:
                    //   // _batsSquadList[index].playerImage != null ?
                    //   _batsSquadList[index].playerImage,
                    //       // : Image.asset(
                    //       // ImgConstants.DEFAULT_PLAYER,
                    //       // width: 80.0,
                    //       // height: 70.0),
                    //   placeholder: (context, url) => Image.asset(
                    //       ImgConstants.DEFAULT_PLAYER,
                    //       width: 80.0,
                    //       height: 70.0),
                    //   errorWidget: (context, url, error) => Image.asset(
                    //       ImgConstants.DEFAULT_PLAYER,
                    //       width: 80.0,
                    //       height: 70.0),
                    // ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.232,
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: _batsSquadList[index].teamId ==
                                widget.selectedMatchData?.teama?.teamId
                            ? ColorConstant.COLOR_TEAM_PLAYER_RED
                                .withOpacity(0.8)
                            : ColorConstant.COLOR_TEAM_PLAYER_GREY
                                .withOpacity(0.8),
                      ),
                      child: _batsSquadList[index].teamId ==
                              widget.selectedMatchData?.teama?.teamId
                          ? Text(
                              "${widget?.selectedMatchData?.teama?.shortName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_WHITE,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "${widget?.selectedMatchData?.teamb?.shortName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_WHITE,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "${_batsSquadList[index].shortName}",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "${_batsSquadList[index].fullName}",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w400,
                              ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 7.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Sel by ${_batsSquadList[index].analytics.selection}%",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorConstant.COLOR_TEXT),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "${_batsSquadList[index].playerPoints}",
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
//

                            Expanded(
                              child: Text(
                                "${_batsSquadList[index].fantasyPlayerRating}",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),

                            SizedBox(width: 6.0),
                            _batsSquadList[index].isSelected
                                ? Image.asset(
                                    ImgConstants.IC_REMOVE_SELECTED_PLAYER,
                                    width: 18.0,
                                  )
                                : Image.asset(
                                    ImgConstants.IC_SELECT_PLAYER,
                                    width: 18.0,
                                  ), //
                          ],
                        ),

                        // playing last match  show
                        if (widget.selectedMatchData.lastMatchPlayed
                            .contains(_batsSquadList[index].pid.toString()))
                          Visibility(
                              visible:
                                  widget.selectedMatchData.isLineup == false,
                              child: Container(
                                margin: EdgeInsets.only(top: 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 6.0,
                                      width: 6.0,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.COLOR_GREEN,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      "Played Last Match",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstant.COLOR_BLUE3),
                                    ),
                                  ],
                                ),
                              )),

                        // playing show

                        Visibility(
                          visible: widget.selectedMatchData != null &&
                              widget.selectedMatchData.isLineup != null &&
                              widget.selectedMatchData.isLineup,
                          child: _batsSquadList[index].playing11 != null &&
                                  _batsSquadList[index].playing11 == true
                              ? Container(
                                  margin: EdgeInsets.only(top: 6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.COLOR_GREEN,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        "Announced",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.COLOR_GREEN),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.COLOR_RED,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        "Not Playing",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.COLOR_RED),
                                      ),
                                    ],
                                  ),
                                ),
                          // : Text("")
                        ),

                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: ColorConstant.COLOR_GREY,
            )
          ],
        ),
      ),
    );
  }

  Widget _getAllRounderItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_arSquadList[index].isSelected) {
            _arSquadList[index].isSelected = false;
            _allRounderSelectionCount--;
            _totalPlayerCount--;
            _arSelectedSquadList.remove(_arSquadList[index]);

            if (teamAPlayerSelection != 0 || teamBPlayerSelection != 0) {
              _arSquadList[index].teamId ==
                      widget.selectedMatchData?.teama?.teamId
                  ? teamAPlayerSelection--
                  : teamBPlayerSelection--;
            }
          } else if (!_arSquadList[index].isSelected) {
            if (_totalPlayerCount < TOTAL_PLAYER) {
              if (_allRounderSelectionCount < MAX_AR) {
                print("****");
                print("ALL Selection Count = " +
                    _allRounderSelectionCount.toString());
                if (isMaxPlayersValid(_arSquadList[index].teamId)) {
                  print(isMaxPlayersValid);

                  if (isMinimumPlayerSelected(WANT_ALL)) {
                    _arSquadList[index].isSelected = true;

                    _allRounderSelectionCount++;
                    print("ALL Selection Count ++ = " +
                        _allRounderSelectionCount.toString());

                    _totalPlayerCount++;
                    print(
                        "Total Player Count =" + _totalPlayerCount.toString());

                    var allobj = _arSquadList[index];
                    allobj.playingRole = "all";

                    _arSelectedSquadList.add(_arSquadList[index]);

                    _arSquadList[index].teamId ==
                            widget.selectedMatchData?.teama?.teamId
                        ? teamAPlayerSelection++
                        : teamBPlayerSelection++;
                  }
                } else {
                  UtilsFlushBar.showDefaultSnackbar(
                      context,
                      "MAX " +
                          MAX_SELECTED_PLAYER_FROM_TEAM.toString() +
                          " Player Allowed this team");
                }
              } else {
                UtilsFlushBar.showDefaultSnackbar(
                    context, "MAX ALLOWED is " + MAX_AR.toString());
              }
            } else {
              UtilsFlushBar.showDefaultSnackbar(
                  context, "ALL 11 Players Selected");
            }
          }
        });
      },
      child: Container(
        color: _arSquadList[index].isSelected
            ? ColorConstant.COLOR_LIGHT_PINK
            : ColorConstant.COLOR_WHITE,
        padding: EdgeInsets.only(
          top: 5,
          left: 6,
          right: 6,
          //   top: 9,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: CachedNetworkImage(
                        width: 80.0,
                        height: 70.0,
                        imageUrl: _arSquadList[index].playerImage,
                        placeholder: (context, url) => Image.asset(
                            ImgConstants.DEFAULT_PLAYER,
                            width: 80.0,
                            height: 70.0),
                        errorWidget: (context, url, error) => Image.asset(
                            ImgConstants.DEFAULT_PLAYER,
                            width: 80.0,
                            height: 70.0),
                      ),
                    ),
                    //   Image.network(
                    //     _arSquadList[index].playerImage ?? null,
                    //     width: 80.0,
                    //     height: 70.0,
                    //     errorBuilder: (BuildContext context, Object exception,
                    //         StackTrace stackTrace) {
                    //       return Image.asset(ImgConstants.DEFAULT_PLAYER,
                    //           //   fit: BoxFit.fill,
                    //           width: 80.0,
                    //           height: 70.0);
                    //     },
                    //   )
                    // else
                    //   Image.asset(ImgConstants.DEFAULT_PLAYER,
                    //       //   fit: BoxFit.fill,
                    //       width: 80.0,
                    //       height: 70.0),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.232,
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: _arSquadList[index].teamId ==
                                widget.selectedMatchData?.teama?.teamId
                            ? ColorConstant.COLOR_TEAM_PLAYER_RED
                                .withOpacity(0.8)
                            : ColorConstant.COLOR_TEAM_PLAYER_GREY
                                .withOpacity(0.8),
                      ),
                      child: _arSquadList[index].teamId ==
                              widget.selectedMatchData?.teama?.teamId
                          ? Text(
                              "${widget?.selectedMatchData?.teama?.shortName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_WHITE,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "${widget?.selectedMatchData?.teamb?.shortName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_WHITE,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
                //  SizedBox(width: 2.0),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "${_arSquadList[index].shortName}",
                              style: TextStyle(
                                fontSize: 14.0,
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w700,
                              ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "${_arSquadList[index].fullName}",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w400,
                              ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 7.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Sel by ${_arSquadList[index].analytics.selection}%",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorConstant.COLOR_TEXT),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "${_arSquadList[index].playerPoints}",
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
//

                            Expanded(
                              child: Text(
                                "${_arSquadList[index].fantasyPlayerRating}",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),

                            SizedBox(width: 6.0),
                            _arSquadList[index].isSelected
                                ? Image.asset(
                                    ImgConstants.IC_REMOVE_SELECTED_PLAYER,
                                    width: 18.0,
                                  )
                                : Image.asset(
                                    ImgConstants.IC_SELECT_PLAYER,
                                    width: 18.0,
                                  ),
                          ],
                        ),

                        if (widget.selectedMatchData.lastMatchPlayed
                            .contains(_arSquadList[index].pid.toString()))
                          Visibility(
                              visible:
                                  widget.selectedMatchData.isLineup == false,
                              child: Container(
                                margin: EdgeInsets.only(top: 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 6.0,
                                      width: 6.0,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.COLOR_GREEN,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      "Played Last Match",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstant.COLOR_BLUE3),
                                    ),
                                  ],
                                ),
                              )),

                        // playing show

                        Visibility(
                          visible: widget.selectedMatchData != null &&
                              widget.selectedMatchData.isLineup != null &&
                              widget.selectedMatchData.isLineup,
                          child: _arSquadList[index].playing11 != null &&
                                  _arSquadList[index].playing11 == true
                              ? Container(
                                  margin: EdgeInsets.only(top: 6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.COLOR_GREEN,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        "Playing",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.COLOR_GREEN),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.COLOR_RED,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        "Not Playing",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.COLOR_RED),
                                      ),
                                    ],
                                  ),
                                ),
                          // : Text("")
                        ),

                        const SizedBox(
                          height: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: ColorConstant.COLOR_GREY,
            )
          ],
        ),
      ),
    );
  }

  Widget _getBowlerItem(BuildContext context, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          if (_bowlersSquadList[index].isSelected) {
            _bowlersSquadList[index].isSelected = false;
            _bowlerSelectionCount--;
            _totalPlayerCount--;
            _bowlersSelectedSquadList.remove(_bowlersSquadList[index]);

            if (teamAPlayerSelection != 0 || teamBPlayerSelection != 0) {
              _bowlersSquadList[index].teamId ==
                      widget.selectedMatchData?.teama?.teamId
                  ? teamAPlayerSelection--
                  : teamBPlayerSelection--;
            }
          } else if (!_bowlersSquadList[index].isSelected) {
            if (_totalPlayerCount < TOTAL_PLAYER) {
              if (_bowlerSelectionCount < MAX_BOWL) {
                print("****");
                print("BOWL Selection Count = " +
                    _bowlerSelectionCount.toString());
                if (isMaxPlayersValid(_bowlersSquadList[index].teamId)) {
                  print(isMaxPlayersValid);

                  if (isMinimumPlayerSelected(WANT_BOWL)) {
                    _bowlersSquadList[index].isSelected = true;

                    _bowlerSelectionCount++;
                    print("BOWL Selection Count ++ = " +
                        _bowlerSelectionCount.toString());

                    _totalPlayerCount++;
                    print(
                        "Total Player Count =" + _totalPlayerCount.toString());

                    var bowlobj = _bowlersSquadList[index];
                    bowlobj.playingRole = "bow";
                    _bowlersSelectedSquadList.add(bowlobj);

                    _bowlersSquadList[index].teamId ==
                            widget.selectedMatchData?.teama?.teamId
                        ? teamAPlayerSelection++
                        : teamBPlayerSelection++;
                  }
                } else {
                  UtilsFlushBar.showDefaultSnackbar(
                      context,
                      "MAX " +
                          MAX_SELECTED_PLAYER_FROM_TEAM.toString() +
                          " Player Allowed this team");
                }
              } else {
                UtilsFlushBar.showDefaultSnackbar(
                    context, "MAX ALLOWED is " + MAX_BOWL.toString());
              }
            } else {
              UtilsFlushBar.showDefaultSnackbar(
                  context, "ALL 11 Players Selected");
            }
          }
        });
      },
      child: Container(
        color: _bowlersSquadList[index].isSelected
            ? ColorConstant.COLOR_LIGHT_PINK
            : ColorConstant.COLOR_WHITE,
        padding: EdgeInsets.only(
          top: 5,
          left: 6,
          right: 6,
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                  alignment: Alignment.bottomLeft,
                  children: [
                    Container(
                      padding: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                          color: ColorConstant.COLOR_WHITE,
                          border: Border.all(color: Colors.grey, width: 0.5)),
                      child: CachedNetworkImage(
                        width: 80.0,
                        height: 70.0,
                        imageUrl: _bowlersSquadList[index].playerImage,
                        placeholder: (context, url) => Image.asset(
                            ImgConstants.DEFAULT_PLAYER,
                            width: 80.0,
                            height: 70.0),
                        errorWidget: (context, url, error) => Image.asset(
                            ImgConstants.DEFAULT_PLAYER,
                            width: 80.0,
                            height: 70.0),
                      ),
                    ),

                    //   Image.network(
                    //     _bowlersSquadList[index].playerImage ?? null,
                    //     width: 80.0,
                    //     height: 70.0,
                    //     errorBuilder: (BuildContext context, Object exception,
                    //         StackTrace stackTrace) {
                    //       return Image.asset(ImgConstants.DEFAULT_PLAYER,
                    //           //   fit: BoxFit.fill,
                    //           width: 80.0,
                    //           height: 70.0);
                    //     },
                    //   )
                    // else
                    //   Image.asset(ImgConstants.DEFAULT_PLAYER,
                    //       //   fit: BoxFit.fill,
                    //       width: 80.0,
                    //       height: 70.0),

                    Container(
                      width: MediaQuery.of(context).size.width * 0.232,
                      padding: EdgeInsets.all(4.0),
                      decoration: BoxDecoration(
                        color: _bowlersSquadList[index].teamId ==
                                widget.selectedMatchData?.teama?.teamId
                            ? ColorConstant.COLOR_TEAM_PLAYER_RED
                                .withOpacity(0.8)
                            : ColorConstant.COLOR_TEAM_PLAYER_GREY
                                .withOpacity(0.8),
                      ),
                      child: _bowlersSquadList[index].teamId ==
                              widget.selectedMatchData?.teama?.teamId
                          ? Text(
                              "${widget?.selectedMatchData?.teama?.shortName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_WHITE,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            )
                          : Text(
                              "${widget?.selectedMatchData?.teamb?.shortName}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_WHITE,
                                  fontSize: 10.0,
                                  fontWeight: FontWeight.bold),
                            ),
                    ),
                  ],
                ),
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Wrap(
                          children: [
                            SizedBox(height: 10.0),
                            Text(
                              "${_bowlersSquadList[index].shortName}",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w700,
                                  ),
                              maxLines: 2,
                            ),
                          ],
                        ),
                        SizedBox(height: 2.0),
                        Text(
                          "${_bowlersSquadList[index].fullName}",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w400,
                              ),
                          maxLines: 2,
                        ),
                        SizedBox(height: 7.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex: 3,
                              child: Text(
                                "Sel by ${_bowlersSquadList[index].analytics.selection}%",
                                style: TextStyle(
                                    fontSize: 12.0,
                                    color: ColorConstant.COLOR_TEXT),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Text(
                                "${_bowlersSquadList[index].playerPoints}",
                                style: TextStyle(fontSize: 14.0),
                                textAlign: TextAlign.center,
                              ),
                            ),
//

                            Expanded(
                              child: Text(
                                "${_bowlersSquadList[index].fantasyPlayerRating}",
                                style: TextStyle(fontSize: 14.0),
                              ),
                            ),

                            SizedBox(width: 6.0),
                            _bowlersSquadList[index].isSelected
                                ? Image.asset(
                                    ImgConstants.IC_REMOVE_SELECTED_PLAYER,
                                    width: 18.0,
                                  )
                                : Image.asset(
                                    ImgConstants.IC_SELECT_PLAYER,
                                    width: 18.0,
                                  ),
                          ],
                        ),
                        if (widget.selectedMatchData.lastMatchPlayed
                            .contains(_bowlersSquadList[index].pid.toString()))
                          Visibility(
                              visible:
                                  widget.selectedMatchData.isLineup == false,
                              child: Container(
                                margin: EdgeInsets.only(top: 6.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Container(
                                      height: 6.0,
                                      width: 6.0,
                                      decoration: BoxDecoration(
                                        color: ColorConstant.COLOR_GREEN,
                                        shape: BoxShape.circle,
                                      ),
                                    ),
                                    SizedBox(width: 4.0),
                                    Text(
                                      "Played Last Match",
                                      style: TextStyle(
                                          fontSize: 10.0,
                                          fontWeight: FontWeight.bold,
                                          color: ColorConstant.COLOR_BLUE3),
                                    ),
                                  ],
                                ),
                              )),
                        Visibility(
                          visible: widget.selectedMatchData != null &&
                              widget.selectedMatchData.isLineup != null &&
                              widget.selectedMatchData.isLineup,
                          child: _bowlersSquadList[index].playing11 != null &&
                                  _bowlersSquadList[index].playing11 == true
                              ? Container(
                                  margin: EdgeInsets.only(top: 6.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.COLOR_GREEN,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        "Announced",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.COLOR_GREEN),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  margin: EdgeInsets.only(top: 8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 6.0,
                                        width: 6.0,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.COLOR_RED,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 4.0),
                                      Text(
                                        "Not Playing",
                                        style: TextStyle(
                                            fontSize: 10.0,
                                            fontWeight: FontWeight.bold,
                                            color: ColorConstant.COLOR_RED),
                                      ),
                                    ],
                                  ),
                                ),
                          // : Text("")
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Divider(
              height: 2,
              color: ColorConstant.COLOR_GREY,
            )
          ],
        ),
      ),
    );
  }

  tabBar1() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              setState(() {
                _isWkPlayers = true;
                _isBATPlayers = false;
                _isARPlayers = false;
                _isBowlPlayers = false;
              });
            },
            child: Container(
              height: double.infinity,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "WK ($_wkKeeperSelectionCount)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: _isWkPlayers
                            ? ColorConstant.COLOR_BLUE3
                            : ColorConstant.COLOR_TEXT,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // BATSMAN CODE
        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              setState(() {
                _isWkPlayers = false;
                _isBATPlayers = true;
                _isARPlayers = false;
                _isBowlPlayers = false;
              });
            },
            child: Container(
              height: double.infinity,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "BATS ($_batsManSelectionCount)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: _isBATPlayers
                            ? ColorConstant.COLOR_BLUE3
                            : ColorConstant.COLOR_TEXT,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        //AR CODE

        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              setState(() {
                _isWkPlayers = false;
                _isBATPlayers = false;
                _isARPlayers = true;
                _isBowlPlayers = false;
              });
            },
            child: Container(
              height: double.infinity,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "AR ($_allRounderSelectionCount)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: _isARPlayers
                            ? ColorConstant.COLOR_BLUE3
                            : ColorConstant.COLOR_TEXT,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),

        // BOWLER CODE HERE

        Flexible(
          flex: 1,
          child: InkWell(
            onTap: () {
              setState(() {
                _isWkPlayers = false;
                _isBATPlayers = false;
                _isARPlayers = false;
                _isBowlPlayers = true;
              });
            },
            child: Container(
              height: double.infinity,
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "BOWL ($_bowlerSelectionCount)",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.0,
                        color: _isBowlPlayers
                            ? ColorConstant.COLOR_BLUE3
                            : ColorConstant.COLOR_TEXT,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  bool isMinimumPlayerSelected(playersType) {
    if (isSpotAvailable(playersType)) {
      if (_wkKeeperSelectionCount < MIN_WK) {
        UtilsFlushBar.showDefaultSnackbar(context,
            "Minimum " + MIN_WK.toString() + " " + "Wicket Keeper Required");

        return false;
      } else if (_batsManSelectionCount < MIN_BATS) {
        UtilsFlushBar.showDefaultSnackbar(context,
            "Minimum " + MIN_BATS.toString() + " " + "Batsman Required");

        return false;
      } else if (_allRounderSelectionCount < MIN_AR) {
        UtilsFlushBar.showDefaultSnackbar(context,
            "Minimum " + MIN_AR.toString() + " " + "All Rounder Required");

        return false;
      } else if (_bowlerSelectionCount < MIN_BOWL) {
        UtilsFlushBar.showDefaultSnackbar(context,
            "Minimum " + MIN_BOWL.toString() + " " + "Bowler Required");

        return false;
      }
      return true;
    }
    return true;
  }

  bool isSpotAvailable(playersType) {
    var remainingSpots = TOTAL_PLAYER - _totalPlayerCount;
    if (remainingSpots <=
        (_wkKeeperSelectionCount +
            _batsManSelectionCount +
            _allRounderSelectionCount +
            _bowlerSelectionCount)) {
      var totalWKRemaining = MIN_WK - _wkKeeperSelectionCount;
      var totalBatsRemaining = MIN_BATS - _batsManSelectionCount;
      var totalAllRounderRemaining = MIN_AR - _allRounderSelectionCount;
      var totalBowlerRemainig = MIN_BOWL - _bowlerSelectionCount;

      if (WANT_WK == playersType) {
        var countnow = 0;
        if (totalBatsRemaining > 0) {
          countnow += totalBatsRemaining;
        }
        if (totalAllRounderRemaining > 0) {
          countnow += totalAllRounderRemaining;
        }
        if (totalBowlerRemainig > 0) {
          countnow += totalBowlerRemainig;
        }
        if (remainingSpots > countnow) {
          return false;
        } else {
          return true;
        }
      } else if (WANT_BAT == playersType) {
        var countnow = 0;
        if (totalWKRemaining > 0) {
          countnow += totalWKRemaining;
        }

        if (totalAllRounderRemaining > 0) {
          countnow += totalAllRounderRemaining;
        }
        if (totalBowlerRemainig > 0) {
          countnow += totalBowlerRemainig;
        }
        if (remainingSpots > countnow) {
          return false;
        } else {
          return true;
        }
      } else if (WANT_ALL == playersType) {
        var countnow = 0;
        if (totalWKRemaining > 0) {
          countnow += totalWKRemaining;
        }
        if (totalBatsRemaining > 0) {
          countnow += totalBatsRemaining;
        }
        if (totalBowlerRemainig > 0) {
          countnow += totalBowlerRemainig;
        }
        if (remainingSpots > countnow) {
          return false;
        } else {
          return true;
        }
      } else if (WANT_BOWL == playersType) {
        var countnow = 0;
        if (totalWKRemaining > 0) {
          countnow += totalWKRemaining;
        }
        if (totalBatsRemaining > 0) {
          countnow += totalBatsRemaining;
        }
        if (totalAllRounderRemaining > 0) {
          countnow += totalAllRounderRemaining;
        }

        if (remainingSpots > countnow) {
          return false;
        } else {
          return true;
        }
      }
    }
    return false;
  }

  bool isMaxPlayersValid(teamavalue) {
    if (teamavalue == widget.selectedMatchData?.teama?.teamId) {
      if (teamAPlayerSelection < MAX_SELECTED_PLAYER_FROM_TEAM) {
        return true;
      } else {
        return false;
      }
    } else if (teamavalue == widget.selectedMatchData?.teamb?.teamId) {
      if (teamBPlayerSelection < MAX_SELECTED_PLAYER_FROM_TEAM) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }
}
