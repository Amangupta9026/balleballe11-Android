import 'dart:developer';

import 'package:balleballe11/balance/addcash.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/create_team_model.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/squad_players_model.dart';
import 'package:balleballe11/sports/contest.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/current_remaining_time.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:balleballe11/constance/global.dart' as global;

class ChooseCaptainPage extends StatefulWidget {
  List<CricketPlayerModel> wkSelectedList = <CricketPlayerModel>[];
  List<CricketPlayerModel> batsSelectedList = <CricketPlayerModel>[];
  List<CricketPlayerModel> arSelectedList = <CricketPlayerModel>[];
  List<CricketPlayerModel> bowlersSelectedList = <CricketPlayerModel>[];
  Upcomingmatch selectedMatchData = Upcomingmatch();
  String remainingTime = "", createTeamMode = "createMode";
  TeamPlayersData getMyTeamData = TeamPlayersData();

  ChooseCaptainPage({
    this.wkSelectedList,
    this.batsSelectedList,
    this.arSelectedList,
    this.bowlersSelectedList,
    this.remainingTime,
    this.selectedMatchData,
    this.createTeamMode,
    this.getMyTeamData,
  }) {
    this.wkSelectedList = wkSelectedList;
    this.batsSelectedList = batsSelectedList;
    this.arSelectedList = arSelectedList;
    this.bowlersSelectedList = bowlersSelectedList;
    this.remainingTime = remainingTime;
    this.selectedMatchData = selectedMatchData;
    this.createTeamMode = createTeamMode;
    this.getMyTeamData = getMyTeamData;
  }

  @override
  _ChooseCaptainPageState createState() => _ChooseCaptainPageState();
}

class _ChooseCaptainPageState extends State<ChooseCaptainPage> {
  List<CricketPlayerModel> finalSquadList = <CricketPlayerModel>[];
  bool isViceCaptainSelected = false;
  bool isCaptainSelected = false;
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool isProgressRunning = false;
  int captainId, viceCaptainId;
  int teamId;

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
      manageTeamDataForSave();
    });
  }

  Future<void> manageTeamDataForSave() async {
    setState(() {
      finalSquadList.addAll(widget.wkSelectedList);

      log("${widget.wkSelectedList.length} - ${finalSquadList.length}",
          name: "wkSelectedList");

      finalSquadList.addAll(widget.batsSelectedList);
      log("${widget.batsSelectedList.length} - ${finalSquadList.length}",
          name: "batsSelectedList");

      finalSquadList.addAll(widget.arSelectedList);
      log("${widget.arSelectedList.length} - ${finalSquadList.length}",
          name: "arSelectedList");

      finalSquadList.addAll(widget.bowlersSelectedList);
      log("${widget.bowlersSelectedList.length} - ${finalSquadList.length} ",
          name: "bowlersSelectedList");

      if (finalSquadList != null &&
          finalSquadList.length > 0 &&
          widget.createTeamMode != null &&
          (widget.createTeamMode == "copyMode" ||
              widget.createTeamMode == "editMode")) {
        for (int i = 0; i < finalSquadList.length; i++) {
          if (finalSquadList[i].fullName == widget.getMyTeamData.c.name) {
            finalSquadList[i].isCaptainSelected = true;
            isCaptainSelected = true;
            captainId = finalSquadList[i]?.pid;
          }
          if (finalSquadList[i].fullName == widget.getMyTeamData.vc.name) {
            finalSquadList[i].isViceCaptainSelected = true;
            isViceCaptainSelected = true;
            viceCaptainId = finalSquadList[i]?.pid;
          }
        }
      }
    });
  }

  Future<void> _createAndSaveTeam() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      log("${finalSquadList.length}", name: "saveTeamData");
      if (widget.createTeamMode != null &&
          widget.createTeamMode.isNotEmpty &&
          widget.createTeamMode == "editMode") {
        teamId = widget.getMyTeamData?.createdTeam?.teamId ?? 0;
      } else
        teamId = 0;

      //   var playerList = <int>[];
      var teams = [
        widget.selectedMatchData?.teama?.teamId,
        widget.selectedMatchData?.teamb?.teamId
      ];
      List<int> playerList = List<int>(11);
      for (int i = 0; i < finalSquadList.length; i++) {
        playerList[i] = finalSquadList[i].pid;
      }
      CreateTeamModel createTeamResponse = await APIServices.createTeam(
          playerList, captainId, viceCaptainId, teamId, teams);
      if (createTeamResponse.status) {
        if (widget.createTeamMode != null &&
            widget.createTeamMode != "joinContestMode") {
          log("${widget.createTeamMode}");
        }
        Navigator.of(context)
          ..pop()
          ..pop();
        Navigator.pushReplacement(
          context,
          MaterialPageRoute<dynamic>(
            builder: (BuildContext context) => ContestPage(
                selectedMatchData: widget.selectedMatchData,
                remainingTime: widget.remainingTime),
          ),
        );
      } else {
        UtilsFlushBar.showDefaultSnackbar(context, createTeamResponse.message);
      }
    } catch (error) {
      log("$error", name: "createTeam");
      showErrorDialog(context, error);
    } finally {
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: ColorConstant.COLOR_LIGHT_GREY2,
        body: ProgressContainerView(
          isProgressRunning: isProgressRunning,
          child: Stack(alignment: Alignment.bottomCenter, children: [
            Column(children: [
              Container(
                decoration: BoxDecoration(
                  color: ColorConstant.COLOR_WHITE,
                  // image: DecorationImage(
                  //   image: AssetImage(
                  //     ImgConstants.chooseVcCBg,
                  //   ),
                  //   fit: BoxFit.cover,
                  // ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    appBar(),

                    // Row(
                    //   crossAxisAlignment: CrossAxisAlignment.center,
                    //   mainAxisAlignment: MainAxisAlignment.center,
                    //   children: [
                    //     Spacer(),
                    //     Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 14.0, vertical: 2.0),
                    //       decoration: BoxDecoration(
                    //         color: ColorConstant.COLOR_WHITE,
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //       child: Text(
                    //           "${widget.selectedMatchData.teama.shortName}",
                    //           //   "${widget.selectedMatchData.teama[0].shortName}",
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyText1
                    //               .copyWith(
                    //                   color: ColorConstant.COLOR_RED,
                    //                   fontSize: 14.0)),
                    //     ),
                    //     Spacer(),
                    //     Column(
                    //       crossAxisAlignment: CrossAxisAlignment.center,
                    //       mainAxisAlignment: MainAxisAlignment.center,
                    //       children: [
                    //         Text(
                    //           '11/11',
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .caption
                    //               .copyWith(
                    //                   fontSize: 14.0,
                    //                   fontWeight: FontWeight.bold,
                    //                   letterSpacing: 0.6,
                    //                   color: ColorConstant.COLOR_TEXT),
                    //         ),
                    //         CountdownTimer(
                    //           endTime: int.parse(widget
                    //                   .selectedMatchData.timestampStart
                    //                   .toString()) *
                    //               1000,
                    //           textStyle: Theme.of(context)
                    //               .textTheme
                    //               .caption
                    //               .copyWith(
                    //                   fontSize: 12.0,
                    //                   fontWeight: FontWeight.w400,
                    //                   color: ColorConstant.COLOR_WHITE),
                    //           onEnd: () {},
                    //           widgetBuilder: (_, CurrentRemainingTime time) {
                    //             if (time != null) {
                    //               return time.days != null
                    //                   ? Text(
                    //                       '${time.days}d ${time.hours}h ${time.min}m ${time.sec}s left',
                    //                       style: Theme.of(context)
                    //                           .textTheme
                    //                           .caption
                    //                           .copyWith(
                    //                               fontSize: 12.0,
                    //                               letterSpacing: 0.6,
                    //                               color: ColorConstant
                    //                                   .COLOR_WHITE),
                    //                     )
                    //                   : time.hours != null
                    //                       ? Text(
                    //                           '${time.hours}h ${time.min}m ${time.sec}s left',
                    //                           style: Theme.of(context)
                    //                               .textTheme
                    //                               .caption
                    //                               .copyWith(
                    //                                   fontSize: 12.0,
                    //                                   letterSpacing: 0.6,
                    //                                   color: ColorConstant
                    //                                       .COLOR_WHITE),
                    //                         )
                    //                       : time.min != null
                    //                           ? Text(
                    //                               '${time.min}m ${time.sec}s left',
                    //                               style: Theme.of(context)
                    //                                   .textTheme
                    //                                   .caption
                    //                                   .copyWith(
                    //                                       fontSize: 12.0,
                    //                                       letterSpacing: 0.6,
                    //                                       color: ColorConstant
                    //                                           .COLOR_WHITE),
                    //                             )
                    //                           : Text(
                    //                               '${time.sec}s left',
                    //                               style: Theme.of(context)
                    //                                   .textTheme
                    //                                   .caption
                    //                                   .copyWith(
                    //                                       fontSize: 12.0,
                    //                                       letterSpacing: 0.6,
                    //                                       color: ColorConstant
                    //                                           .COLOR_WHITE),
                    //                             );
                    //             }
                    //             return Text("");
                    //           },
                    //         ),
                    //       ],
                    //     ),
                    //     Spacer(),
                    //     Container(
                    //       padding: EdgeInsets.symmetric(
                    //           horizontal: 14.0, vertical: 2.0),
                    //       decoration: BoxDecoration(
                    //         color: ColorConstant.COLOR_WHITE,
                    //         borderRadius: BorderRadius.circular(20),
                    //       ),
                    //       child: Text(
                    //           "${widget.selectedMatchData.teamb.shortName}",
                    //           style: Theme.of(context)
                    //               .textTheme
                    //               .bodyText1
                    //               .copyWith(
                    //                   color: ColorConstant.COLOR_RED,
                    //                   fontSize: 14.0)),
                    //     ),
                    //     Spacer(),
                    //   ],
                    // ),

                    // SizedBox(height: 8.0),
                    // Container(
                    //   margin: EdgeInsets.only(
                    //     left: 5.0,
                    //     right: 5.0,
                    //   ),
                    //   padding: EdgeInsets.only(
                    //     top: 10.0,
                    //     bottom: 10.0,
                    //   ),
                    //   decoration: BoxDecoration(
                    //     color: ColorConstant.COLOR_WHITE,
                    //     border: Border.all(color: ColorConstant.COLOR_WHITE),
                    //     borderRadius: BorderRadius.only(
                    //       topLeft: Radius.circular(6.0),
                    //       topRight: Radius.circular(6.0),
                    //     ),
                    //   ),
                    //   child: Column(
                    //     crossAxisAlignment: CrossAxisAlignment.center,
                    //     mainAxisAlignment: MainAxisAlignment.center,
                    //     children: [
                    //       Text(
                    //         'Choose Your',
                    //         style: Theme.of(context).textTheme.caption.copyWith(
                    //             fontSize: 11.0,
                    //             letterSpacing: 0.6,
                    //             fontWeight: FontWeight.bold,
                    //             color: ColorConstant.COLOR_TEXT),
                    //       ),
                    //       SizedBox(height: 10.0),
                    //       Row(
                    //         crossAxisAlignment: CrossAxisAlignment.center,
                    //         mainAxisAlignment: MainAxisAlignment.center,
                    //         children: [
                    //           Container(
                    //             height: 30,
                    //             width: 30,
                    //             decoration: BoxDecoration(
                    //               color: ColorConstant.COLOR_RED,
                    //               border: Border.all(
                    //                 color: ColorConstant.COLOR_RED,
                    //               ),
                    //               shape: BoxShape.circle,
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 "C",
                    //                 style: Theme.of(context)
                    //                     .textTheme
                    //                     .bodyText2
                    //                     .copyWith(
                    //                       color: ColorConstant.COLOR_WHITE,
                    //                       letterSpacing: 0.6,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 14,
                    //                     ),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: 12.0),
                    //           Text(
                    //             'Get 2x Points',
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .caption
                    //                 .copyWith(
                    //                     fontSize: 11.0,
                    //                     letterSpacing: 0.6,
                    //                     color: ColorConstant.COLOR_BLACK),
                    //           ),
                    //           SizedBox(width: 12.0),
                    //           Container(
                    //             height: 25.0,
                    //             decoration: BoxDecoration(
                    //               border: Border(
                    //                 right: BorderSide(
                    //                     color: ColorConstant.COLOR_RED,
                    //                     width: 1.5),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: 12.0),
                    //           Container(
                    //             height: 30,
                    //             width: 30,
                    //             decoration: BoxDecoration(
                    //               color: ColorConstant.COLOR_RED,
                    //               border: Border.all(
                    //                 color: ColorConstant.COLOR_RED,
                    //               ),
                    //               shape: BoxShape.circle,
                    //             ),
                    //             child: Center(
                    //               child: Text(
                    //                 "VC",
                    //                 style: Theme.of(context)
                    //                     .textTheme
                    //                     .bodyText2
                    //                     .copyWith(
                    //                       color: ColorConstant.COLOR_WHITE,
                    //                       letterSpacing: 0.6,
                    //                       fontWeight: FontWeight.bold,
                    //                       fontSize: 14,
                    //                     ),
                    //               ),
                    //             ),
                    //           ),
                    //           SizedBox(width: 12.0),
                    //           Text(
                    //             'Get 1.5x Points',
                    //             style: Theme.of(context)
                    //                 .textTheme
                    //                 .caption
                    //                 .copyWith(
                    //                     fontSize: 11.0,
                    //                     letterSpacing: 0.6,
                    //                     color: ColorConstant.COLOR_BLACK),
                    //           ),
                    //         ],
                    //       )
                    //     ],
                    //   ),
                    // )
                  ],
                ),
              ),
              // Container(
              //   height: 42.0,
              //   color: ColorConstant.COLOR_RED,
              //   child: Padding(
              //     padding: EdgeInsets.only(left: 25.0, right: 25),
              //     child: Row(
              //       //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         Expanded(
              //           flex: 2,
              //           child: Text(
              //             AppLocalizations.of('Players'),
              //             style: Theme.of(context).textTheme.bodyText2.copyWith(
              //                   color: ColorConstant.COLOR_WHITE,
              //                   fontSize: 14.0,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //           ),
              //         ),
              //         Expanded(
              //           flex: 1,
              //           child: Text(
              //             AppLocalizations.of('Points'),
              //             style: Theme.of(context).textTheme.bodyText2.copyWith(
              //                   color: ColorConstant.COLOR_WHITE,
              //                   fontSize: 14.0,
              //                   fontWeight: FontWeight.bold,
              //                 ),
              //           ),
              //         ),
              //         //  SizedBox(width: 15),
              //         Text(
              //           AppLocalizations.of('Select by %'),
              //           style: Theme.of(context).textTheme.bodyText2.copyWith(
              //                 color: ColorConstant.COLOR_WHITE,
              //                 fontSize: 14.0,
              //                 fontWeight: FontWeight.bold,
              //               ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.only(
                    top: 8.0,
                    bottom: 70.0,
                  ),
                  itemBuilder: (context, index) {
                    return teamCardView(
                        finalSquadList[index]?.teamId ==
                                widget.selectedMatchData.teama.teamId
                            ? "${widget?.selectedMatchData?.teama?.shortName}"
                            : "${widget?.selectedMatchData?.teamb?.shortName}",
                        finalSquadList[index]?.playingRole,
                        "${finalSquadList[index]?.shortName}",

                        //  finalSquadList[index]?.shortName,
                        //   "Sel by ${finalSquadList[index]?.salebyperson}%",

                        finalSquadList[index].isCaptainSelected
                            ? Center(
                                child: Text(
                                  "2X",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: ColorConstant.COLOR_WHITE,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "C",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                        "${finalSquadList[index]?.captainPercentage}",
                        finalSquadList[index].isViceCaptainSelected
                            ? Center(
                                child: Text(
                                  "1.5",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: ColorConstant.COLOR_WHITE,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              )
                            : Center(
                                child: Text(
                                  "VC",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                        //   "VC",
                        "${finalSquadList[index]?.viceCaptainPercentage}",
                        AssetImage(ImgConstants.DEFAULT_PLAYER),
                        index,
                        "${finalSquadList[index]?.points}",
                        finalSquadList[index]?.playing11,
                        finalSquadList[index]?.teamId ==
                                widget.selectedMatchData.teama.teamId
                            ? true
                            : false);
                  },
                  itemCount: finalSquadList?.length,
                  shrinkWrap: true,
                ),
              )
            ]),
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
                            selectedMatchData: widget?.selectedMatchData,
                            wkList: widget?.wkSelectedList,
                            batsList: widget?.batsSelectedList,
                            arList: widget?.arSelectedList,
                            bowlersList: widget?.bowlersSelectedList,
                            pageFromMatch: StringConstant.UPCOMING_MATCHES,
                            //  teamName:
                            // widget.selectedMatchData?.teama != null
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
                        width: 143,
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
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () async {
                      if (isCaptainSelected && isViceCaptainSelected) {
                        await _createAndSaveTeam();
                      } else {
                        if (!isCaptainSelected) {
                          UtilsFlushBar.showDefaultSnackbar(
                              context, "Please choose captain");
                        } else if (!isViceCaptainSelected) {
                          UtilsFlushBar.showDefaultSnackbar(
                              context, "Please choose vice captain");
                        } else if (!isCaptainSelected &&
                            !isViceCaptainSelected) {
                          UtilsFlushBar.showDefaultSnackbar(context,
                              "Please choose captain and vice captain");
                        }
                      }
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Container(
                        height: 40,
                        width: 143,
                        decoration: BoxDecoration(
                          color: isCaptainSelected && isViceCaptainSelected
                              ? ColorConstant.COLOR_TEXT
                              : ColorConstant.COLOR_LIGHT_GREY,
                          borderRadius: BorderRadius.circular(6.0),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of('Save Team'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: ColorConstant.COLOR_WHITE,
                                  letterSpacing: 0.5,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ]),
        ),
      ),
    );
  }

  String playerRoleText = "";

  Widget teamCardView(
      String teamName,
      String playerRole,
      String playerShortName,
      //  String selByTxt,
      Widget captainTxt,
      String captainPercentagePoint,
      Widget viceCaptainTxt,
      String viceCaptainPercentagePoint,
      AssetImage playerImage,
      int index,
      String playerPoints,
      bool isPlaying11,
      bool isTeamA) {
    if (index > 0 && finalSquadList[index - 1].playingRole == playerRole) {
      playerRoleText = "";
    } else {
      playerRoleText = playerRole;
    }
    return Padding(
      padding: const EdgeInsets.symmetric(
        // horizontal: 10.0,
        vertical: 0.50,
      ),
      child: Flex(
        direction: Axis.vertical,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Visibility(
            visible: playerRoleText?.isNotEmpty ?? false,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Container(
                //   width: 160.0,
                //   height: 20.0,
                //   color: ColorConstant.COLOR_LIGHT_GREY2,
                // ),
                Positioned(
                  left: 0.0,
                  child: Container(
                    width: 8.0,
                    height: 20.0,
                    decoration: BoxDecoration(
                      color: ColorConstant.COLOR_LIGHT_GREY2,
                      // borderRadius: BorderRadius.only(
                      //   bottomRight: Radius.circular(8.0),
                      // ),
                    ),
                  ),
                ),
                Container(
                  //  width: 144.0,
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  decoration: BoxDecoration(
                    color: ColorConstant.COLOR_LIGHT_GREY2,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(8.0),
                      topLeft: Radius.circular(8.0),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        color: Color(0xFF0d98b9),
                        width: 144,
                        child: Center(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 6.0, bottom: 6),
                            child: Text(
                              playerRoleText == "wk"
                                  ? "WICKET-KEEPER"
                                  : playerRoleText == "bat"
                                      ? "BATSMAN"
                                      : playerRoleText == "all"
                                          ? "ALL ROUNDERS"
                                          : "BOWLERS",
                              softWrap: true,
                              overflow: TextOverflow.fade,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: ColorConstant.COLOR_WHITE,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                            ),
                          ),
                        ),
                      ),
                      Spacer(),
                      Text(
                        AppLocalizations.of('Points'),
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: ColorConstant.COLOR_BLUE,
                              fontSize: 14.0,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      Spacer(),
                      Spacer(),
                      Container(
                        width: 12,
                      ),
                    ],
                  ),
                ),

                // Positioned(
                //   right: 0.0,
                //   child: Container(
                //     width: 8.0,
                //     height: 20.0,
                //     decoration: BoxDecoration(
                //       color: ColorConstant.BACKGROUND_COLOR,
                //       borderRadius: BorderRadius.only(
                //         bottomLeft: Radius.circular(8.0),
                //       ),
                //     ),
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            color: ColorConstant.COLOR_WHITE,
            padding: EdgeInsets.only(
              left: 6,
              right: 6,
              top: 9,
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        if (finalSquadList[index].playerImage != null &&
                            finalSquadList[index].playerImage.length > 1)
                          Image.network(
                            finalSquadList[index].playerImage ?? null,
                            width: 80.0,
                            height: 70.0,
                            errorBuilder: (BuildContext context,
                                Object exception, StackTrace stackTrace) {
                              return Image.asset(
                                  ImgConstants.balleballe11_DEFAULT_IMAGE,
                                  //   fit: BoxFit.fill,
                                  width: 80.0,
                                  height: 70.0);
                            },
                          )
                        else
                          Image.asset(ImgConstants.balleballe11_DEFAULT_IMAGE,
                              //   fit: BoxFit.fill,
                              width: 80.0,
                              height: 70.0),

                        // CachedNetworkImage(
                        //   width: 80.0,
                        //   height: 70.0,
                        //   imageUrl: finalSquadList[index].playerImage,
                        //
                        //   errorWidget: (context, url, error) => Image.asset(ImgConstants.DEFAULT_PLAYER,
                        //
                        //       width: 80.0,
                        //       height: 70.0),
                        // ),

                        Row(
                          children: [
                            Container(
                              //  width: 40,
                              decoration: BoxDecoration(
                                color: ColorConstant.COLOR_TEXT,
                                // isTeamA
                                //     ? ColorConstant.COLOR_BLACK
                                //     : ColorConstant.COLOR_WHITE,
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(2),
                                  bottomLeft: Radius.circular(2),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 2.0, horizontal: 2.0),
                                child: Text(
                                  teamName,
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      .copyWith(
                                        color: ColorConstant.COLOR_WHITE,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ),
                            Container(
                              width: 30,
                              decoration: BoxDecoration(
                                color: Color(0xFFff7143),
                                borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(2),
                                  bottomRight: Radius.circular(2),
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(2.0),
                                child: Text(
                                  playerRole ?? "",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .overline
                                      .copyWith(
                                        color: ColorConstant.COLOR_WHITE,
                                        fontWeight: FontWeight.w400,
                                      ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            playerShortName,
                            style:
                                Theme.of(context).textTheme.bodyText2.copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 14.0,
                                    ),
                            //   overflow: TextOverflow.ellipsis,
                            //     maxLines: 1,
                          ),
                          //  SizedBox(height: 21.0),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                flex: 2,
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Row(
                                      mainAxisSize: MainAxisSize.max,
                                      children: [
                                        Expanded(
                                          child: Text(
                                            "Sel by ${finalSquadList[index]?.analytics?.selection ?? ""}%",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                  color: Theme.of(context)
                                                      .textTheme
                                                      .bodyText2
                                                      .color,
                                                  fontSize: 12,
                                                ),
                                          ),
                                        ),
                                        Expanded(
                                          // flex: 2,
                                          child: Text(
                                            // playerPoints,
                                            "${finalSquadList[index]?.playerPoints ?? ""}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyText2
                                                .copyWith(
                                                  color:
                                                      ColorConstant.COLOR_BLUE2,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 13.0,
                                                ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(width: 30),
                              Padding(
                                padding: const EdgeInsets.only(bottom: 5.0),
                                child: Column(children: [
                                  Container(
                                    //  width: 30,
                                    child: Column(
                                      //   direction: Axis.vertical,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            setState(() {
                                              finalSquadList.forEach((element) {
                                                element.isCaptainSelected =
                                                    false;
                                                isCaptainSelected = false;
                                                captainId;
                                              });

                                              if (finalSquadList[index]
                                                  .isViceCaptainSelected) {
                                                finalSquadList[index]
                                                        .isViceCaptainSelected =
                                                    false;
                                                isViceCaptainSelected = false;
                                              }

                                              finalSquadList[index]
                                                  .isCaptainSelected = true;
                                              isCaptainSelected = true;

                                              captainId =
                                                  finalSquadList[index]?.pid;
                                            });
                                          },
                                          child: Column(
                                            children: [
                                              Container(
                                                height: 30,
                                                width: 30,
                                                decoration: BoxDecoration(
                                                  color: finalSquadList[index]
                                                          .isCaptainSelected
                                                      ? ColorConstant
                                                          .COLOR_GREEN
                                                      : Colors.transparent,
                                                  border: Border.all(
                                                    color: finalSquadList[index]
                                                            .isCaptainSelected
                                                        ? ColorConstant
                                                            .COLOR_GREEN
                                                        : Colors.grey,
                                                    width: 1.5,
                                                  ),
                                                  shape: BoxShape.circle,
                                                ),
                                                child: captainTxt,
                                                // child: Center(
                                                //   child: Text(

                                                //     style: Theme.of(context)
                                                //         .textTheme
                                                //         .bodyText2
                                                //         .copyWith(
                                                //           color: ColorConstant
                                                //               .COLOR_TEXT,
                                                //           // finalSquadList[
                                                //           //             index]
                                                //           //         .isCaptainSelected
                                                //           //     ? ColorConstant
                                                //           //         .COLOR_WHITE
                                                //           //     : Theme.of(
                                                //           //             context)
                                                //           //         .textTheme
                                                //           //         .bodyText2
                                                //           //         .color,
                                                //           fontWeight:
                                                //               FontWeight.bold,
                                                //           fontSize: 14,
                                                //         ),
                                                //   ),
                                                // ),
                                              ),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                "${double.parse(finalSquadList[index]?.analytics?.captain?.toStringAsFixed(1) ?? 0.0)}",
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodyText2
                                                    .copyWith(
                                                      color: Theme.of(context)
                                                          .textTheme
                                                          .bodyText2
                                                          .color,
                                                      //   letterSpacing: 0.6,
                                                      fontSize: 12,
                                                    ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                  right: 10.0,
                                  bottom: 5,
                                ),
                                child: Container(
                                  //  width: 40,
                                  child: Column(
                                    //   direction: Axis.vertical,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          setState(() {
                                            finalSquadList.forEach((element) {
                                              element.isViceCaptainSelected =
                                                  false;
                                              isViceCaptainSelected = false;
                                              viceCaptainId;
                                            });

                                            if (finalSquadList[index]
                                                .isCaptainSelected) {
                                              finalSquadList[index]
                                                  .isCaptainSelected = false;
                                              isCaptainSelected = false;
                                            }

                                            finalSquadList[index]
                                                .isViceCaptainSelected = true;
                                            isViceCaptainSelected = true;

                                            viceCaptainId =
                                                finalSquadList[index]?.pid;
                                          });
                                        },
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 30,
                                              width: 30,
                                              decoration: BoxDecoration(
                                                color: finalSquadList[index]
                                                        .isViceCaptainSelected
                                                    ? ColorConstant.COLOR_GREEN
                                                    : Colors.transparent,
                                                border: Border.all(
                                                  color: finalSquadList[index]
                                                          .isViceCaptainSelected
                                                      ? ColorConstant
                                                          .COLOR_GREEN
                                                      : Colors.grey,
                                                  width: 1.5,
                                                ),
                                                shape: BoxShape.circle,
                                              ),
                                              child: viceCaptainTxt,
                                              // child: Center(
                                              //   child: Text(
                                              //     viceCaptainTxt,
                                              //     style: Theme.of(context)
                                              //         .textTheme
                                              //         .bodyText2
                                              //         .copyWith(
                                              //           color: ColorConstant
                                              //               .COLOR_TEXT,
                                              //           fontWeight:
                                              //               FontWeight.bold,
                                              //           fontSize: 14,
                                              //         ),
                                              //   ),
                                              // ),
                                            ),
                                            SizedBox(
                                              height: 5,
                                            ),
                                            Text(
                                              "${double.parse(finalSquadList[index]?.analytics?.viceCaptain?.toStringAsFixed(1) ?? 0.0)}",
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                    color: Theme.of(context)
                                                        .textTheme
                                                        .bodyText2
                                                        .color,
                                                    //  letterSpacing: 0.6,
                                                    fontSize: 12,
                                                  ),
                                              textAlign: TextAlign.center,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //
                          // playing show
                          Visibility(
                            visible: widget.selectedMatchData != null &&
                                widget.selectedMatchData.isLineup != null &&
                                widget.selectedMatchData.isLineup,
                            child: finalSquadList[index]?.playing11 != null &&
                                    finalSquadList[index]?.playing11 == true
                                ? Column(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(top: 6.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 6.0,
                                              width: 6.0,
                                              decoration: BoxDecoration(
                                                color:
                                                    ColorConstant.COLOR_GREEN,
                                                shape: BoxShape.circle,
                                              ),
                                            ),
                                            SizedBox(width: 4.0),
                                            Text(
                                              "Announced",
                                              style: TextStyle(
                                                  fontSize: 10.0,
                                                  fontWeight: FontWeight.bold,
                                                  color: ColorConstant
                                                      .COLOR_GREEN),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  )
                                : Column(
                                    children: [
                                      Container(
                                        // margin: EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
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
                                                  color:
                                                      ColorConstant.COLOR_RED),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                            // : Text("")
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget appBar() {
    return Column(
      children: [
        Container(
          height: AppBar().preferredSize.height,
          child: Padding(
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Icon(
                    Icons.arrow_back,
                    color: ColorConstant.COLOR_TEXT,
                    size: 28.0,
                  ),
                ),
                Expanded(child: SizedBox()),
                CountdownTimer(
                  controller: controller,
                  endTime: int.parse(
                          widget.selectedMatchData.timestampStart.toString()) *
                      1000,
                  textStyle: Theme.of(context).textTheme.caption.copyWith(
                      fontSize: 14.0,
                      fontWeight: FontWeight.w900,
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
                                          color: ColorConstant.COLOR_TEXT),
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
                                              color: ColorConstant.COLOR_TEXT),
                                    )
                                  : Text(
                                      '${time.sec}s left',
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                              fontSize: 14.0,
                                              letterSpacing: 0.6,
                                              color: ColorConstant.COLOR_TEXT),
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
                  child: Icon(
                    Icons.help,
                    color: ColorConstant.COLOR_TEXT,
                    size: 24.0,
                  ),
                ),
                const SizedBox(
                  width: 7,
                ),
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
                    height: 24,
                    width: 24,
                  ),
                ),
              ],
            ),
          ),
        ),
        Container(
          color: Color(0xffc7ced8),
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10),
            child: Column(
              children: [
                Text(
                  "Choose your Captain and Vice Captain player",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: ColorConstant.COLOR_BLUE2,
                        fontWeight: FontWeight.w500,
                      ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Text(
                  "C gets 2x points, VC gets 1.5x points",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: ColorConstant.COLOR_BLUE2,
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  String privacyPolicyUrl = "https://balleballe11.in/privacy-policy";

  void _launchPrivacyPolicy() async => await canLaunch(privacyPolicyUrl)
      ? await launch(privacyPolicyUrl)
      : throw 'Could not launch $privacyPolicyUrl';
}
