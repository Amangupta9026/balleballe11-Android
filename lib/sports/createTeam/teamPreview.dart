import 'dart:ui';
import 'package:balleballe11/constance/apiConstants.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/squad_players_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class TeamPreViewPage extends StatefulWidget {
  Upcomingmatch selectedMatchData;
  List<CricketPlayerModel> wkList = <CricketPlayerModel>[];
  List<CricketPlayerModel> batsList = <CricketPlayerModel>[];
  List<CricketPlayerModel> arList = <CricketPlayerModel>[];
  List<CricketPlayerModel> bowlersList = <CricketPlayerModel>[];
  num teamPoints = 0.0;
  String pageFromMatch;
//  String teamName;
  String test;

  TeamPreViewPage({
    key: Key,
    this.selectedMatchData,
    this.wkList,
    this.batsList,
    this.arList,
    this.bowlersList,
    this.teamPoints,
    this.pageFromMatch,
    //    this.teamName,
    this.test,
  }) {
    this.selectedMatchData = selectedMatchData;
    this.wkList = wkList;
    this.batsList = batsList;
    this.arList = arList;
    this.bowlersList = bowlersList;
    this.teamPoints = teamPoints;
    this.pageFromMatch = pageFromMatch;
    //  this.teamName = teamName;
  }

  @override
  _TeamPreViewPageState createState() => _TeamPreViewPageState();
}

class _TeamPreViewPageState extends State<TeamPreViewPage> {
  int teamACount = 0, teamBCount = 0;

  final double runSpacing = 10;
  final double spacing = 3;

  int wkColumns = 4;
  int batColumns = 0;
  int allRoundColumns = 0;
  int bowlColumns = 0;

  int totalPoints = 0;

  bool isLineUp = false;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      _getBothTeamPlayers();
    });
  }

  void _getBothTeamPlayers() {
    if (widget.wkList != null && widget.wkList.length > 0) {
      for (var item in widget.wkList) {
        if (!isLineUp) {
          setState(() {
            isLineUp = item.playing11 != null && item.playing11 == "true";
          });
        }
        if (item.teamId == widget.selectedMatchData?.teama?.teamId) {
          setState(() {
            teamACount++;
          });
        } else if (item.teamId == widget.selectedMatchData?.teamb?.teamId) {
          setState(() {
            teamBCount++;
          });
        }
      }
    }

    if (widget.batsList != null && widget.batsList.length > 0) {
      batColumns = widget.batsList.length <= 4 ? 4 : 3;

      for (var item in widget.batsList) {
        if (!isLineUp) {
          setState(() {
            isLineUp = item.playing11 != null && item.playing11 == "true";
          });
        }

        if (item.teamId == widget.selectedMatchData?.teama?.teamId) {
          setState(() {
            teamACount++;
          });
        } else if (item.teamId == widget.selectedMatchData?.teamb?.teamId) {
          setState(() {
            teamBCount++;
          });
        }
      }
    }

    if (widget.arList != null && widget.arList.length > 0) {
      allRoundColumns = widget.arList.length <= 4 ? 4 : 3;
      for (var item in widget.arList) {
        if (!isLineUp) {
          setState(() {
            isLineUp = item.playing11 != null && item.playing11 == "true";
          });
        }

        if (item.teamId == widget.selectedMatchData?.teama?.teamId) {
          setState(() {
            teamACount++;
          });
        } else if (item.teamId == widget.selectedMatchData?.teamb?.teamId) {
          setState(() {
            teamBCount++;
          });
        }
      }
    }

    if (widget.bowlersList != null && widget.bowlersList.length > 0) {
      bowlColumns = widget.bowlersList.length <= 4 ? 4 : 3;
      for (var item in widget.bowlersList) {
        if (!isLineUp) {
          setState(() {
            isLineUp = item.playing11 != null && item.playing11 == "true";
          });
        }

        if (item.teamId == widget.selectedMatchData?.teama?.teamId) {
          setState(() {
            teamACount++;
          });
        } else if (item.teamId == widget.selectedMatchData?.teamb?.teamId) {
          setState(() {
            teamBCount++;
          });
        }
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final wkColumnWidth =
        (MediaQuery.of(context).size.width - runSpacing * (wkColumns - 1)) /
            wkColumns;

    final batColumnWidth =
        (MediaQuery.of(context).size.width - runSpacing * (batColumns - 1)) /
            batColumns;

    final allRoundColumnWidth = (MediaQuery.of(context).size.width -
            runSpacing * (allRoundColumns - 1)) /
        allRoundColumns;

    final bowlColumnWidth =
        (MediaQuery.of(context).size.width - runSpacing * (bowlColumns - 1)) /
            bowlColumns;

    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstant.COLOR_WHITE,
      systemNavigationBarColor: Colors.transparent,
      // transparent status bar
    ));

    return Material(
      child: SafeArea(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(ImgConstants.cricketGround),
              fit: BoxFit.cover,
            ),
          ),
          child: Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.all(10.0),
                child: Flex(
                  direction: Axis.vertical,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Stack(
                      children: [
                        // Align(
                        //   child: Text(
                        //     "India",
                        //     //   widget.teamName != null ? widget.teamName : "",
                        //     style: TextStyle(
                        //         fontSize: 16.0,
                        //         fontWeight: FontWeight.bold,
                        //         color: ColorConstant.COLOR_WHITE),
                        //   ),
                        //   alignment: Alignment.centerLeft,
                        // ),
                        // Align(
                        //   child: Image.asset(
                        //     ImgConstants.APP_LOGO,
                        //     width: MediaQuery.of(context).size.width * 0.3,
                        //     fit: BoxFit.cover,
                        //   //  color: Colors.white.withOpacity(0.5),
                        //   ),
                        //   alignment: Alignment.center,
                        // ),
                        Align(
                          alignment: Alignment.centerRight,
                          child: InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: Icon(
                              Icons.close,
                              color: Theme.of(context).appBarTheme.color,
                              size: 26,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Flex(
                  direction: Axis.vertical,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // WICKET-KEEPERS
                    Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(
                              widget.wkList != null && widget.wkList.length > 1
                                  ? 'WICKET-KEEPERS'
                                  : 'WICKET-KEEPER'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                // color: Theme.of(context)
                                //     .appBarTheme
                                //     .color!
                                //     .withOpacity(0.5),
                                color: Colors.white.withOpacity(0.9),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                        ),
                        if (widget.wkList != null && widget.wkList.length > 0)
                          Center(
                            child: Wrap(
                              runSpacing: 0,
                              spacing: spacing,
                              alignment: WrapAlignment.center,
                              children: List.generate(
                                widget.wkList.length,
                                (index) {
                                  return playerDetail(
                                    wkColumnWidth,
                                    "${widget.wkList[index]?.shortName}",
                                    widget.pageFromMatch != null &&
                                            widget.pageFromMatch ==
                                                StringConstant.UPCOMING_MATCHES
                                        ? "${widget.wkList[index]?.fantasyPlayerRating}"
                                        : "${widget.wkList[index]?.points ?? "0"}",

                                    widget.wkList[index].playerImage != null &&
                                            widget.wkList[index].playerImage
                                                    .length >
                                                1
                                        ? Image.network(
                                            widget.wkList[index]?.playerImage ??
                                                null,
                                            //   width: 80.0,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1,
                                            errorBuilder: (BuildContext context,
                                                Object exception,
                                                StackTrace stackTrace) {
                                              return Image.asset(
                                                  ImgConstants.DEFAULT_PLAYER,
                                                  //   fit: BoxFit.fill,
                                                  // width: 80.0,
                                                  height: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1);
                                            },
                                          )
                                        : Image.asset(
                                            ImgConstants.DEFAULT_PLAYER,
                                            //   fit: BoxFit.fill,
                                            // width: 80.0,
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.1),
                                    // Image.asset(
                                    //   Utils.demoPlayerImg,
                                    //   fit: BoxFit.cover,
                                    //   height:
                                    //       MediaQuery.of(context).size.width *
                                    //           0.1,
                                    // ),
                                    widget.wkList[index]?.teamId != null &&
                                            widget.wkList[index]?.teamId !=
                                                widget.selectedMatchData?.teama
                                                    ?.teamId
                                        ? ColorConstant.COLOR_BLACK
                                        : ColorConstant.COLOR_WHITE,
                                    widget.wkList[index]?.teamId != null &&
                                            widget.wkList[index]?.teamId !=
                                                widget.selectedMatchData?.teama
                                                    ?.teamId
                                        ? ColorConstant.COLOR_WHITE
                                        : ColorConstant.COLOR_BLACK,
                                    widget.wkList[index]?.isCaptainSelected,
                                    widget.wkList[index]?.isViceCaptainSelected,
                                    isLineUp &&
                                        (widget.wkList[index]?.playing11 !=
                                                null &&
                                            widget.wkList[index]?.playing11 ==
                                                false),
                                  );
                                },
                              ),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),

                    // BATTERS
                    Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of('BATSMAN'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                        ),
                        if (widget.batsList != null &&
                            widget.batsList.length > 0)
                          Center(
                            child: Wrap(
                              runSpacing: 0,
                              spacing: spacing,
                              alignment: WrapAlignment.spaceEvenly,
                              children: List.generate(widget.batsList.length,
                                  (index) {
                                return playerDetail(
                                  batColumnWidth,
                                  "${widget.batsList[index]?.shortName}",
                                  widget.pageFromMatch != null &&
                                          widget.pageFromMatch ==
                                              StringConstant.UPCOMING_MATCHES
                                      ? "${widget.batsList[index]?.fantasyPlayerRating}"
                                      : "${widget.batsList[index]?.points ?? "0"}",
                                  widget.batsList[index].playerImage != null &&
                                          widget.batsList[index].playerImage
                                                  .length >
                                              1
                                      ? Image.network(
                                          widget.batsList[index]?.playerImage ??
                                              null,
                                          //   width: 80.0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace stackTrace) {
                                            return Image.asset(
                                                ImgConstants.DEFAULT_PLAYER,
                                                //   fit: BoxFit.fill,
                                                // width: 80.0,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1);
                                          },
                                        )
                                      : Image.asset(ImgConstants.DEFAULT_PLAYER,
                                          //   fit: BoxFit.fill,
                                          // width: 80.0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1),
                                  widget.batsList[index]?.teamId != null &&
                                          widget.batsList[index]?.teamId !=
                                              widget.selectedMatchData?.teama
                                                  ?.teamId
                                      ? ColorConstant.COLOR_BLACK
                                      : ColorConstant.COLOR_WHITE,
                                  widget.batsList[index]?.teamId != null &&
                                          widget.batsList[index]?.teamId !=
                                              widget.selectedMatchData?.teama
                                                  ?.teamId
                                      ? ColorConstant.COLOR_WHITE
                                      : ColorConstant.COLOR_BLACK,
                                  widget.batsList[index]?.isCaptainSelected,
                                  widget.batsList[index]?.isViceCaptainSelected,
                                  isLineUp &&
                                      (widget.batsList[index]?.playing11 !=
                                              null &&
                                          widget.batsList[index]?.playing11 ==
                                              false),
                                );
                              }),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),
                    // ALL-ROUNDERS
                    Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(
                              widget.arList != null && widget.arList.length > 1
                                  ? 'ALL-ROUNDERS'
                                  : 'ALL-ROUNDER'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                // color: Theme.of(context)
                                //     .appBarTheme
                                //     .color!
                                //     .withOpacity(0.5),
                                color: Colors.white.withOpacity(0.9),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                        ),
                        if (widget.arList != null && widget.arList.length > 0)
                          Center(
                            child: Wrap(
                              runSpacing: 0,
                              spacing: spacing,
                              alignment: WrapAlignment.center,
                              children:
                                  List.generate(widget.arList.length, (index) {
                                return playerDetail(
                                  allRoundColumnWidth,
                                  "${widget.arList[index]?.shortName}",
                                  widget.pageFromMatch != null &&
                                          widget.pageFromMatch ==
                                              StringConstant.UPCOMING_MATCHES
                                      ? "${widget.arList[index]?.fantasyPlayerRating}"
                                      : "${widget.arList[index]?.points ?? "0"}",
                                  widget.arList[index].playerImage != null &&
                                          widget.arList[index].playerImage
                                                  .length >
                                              1
                                      ? Image.network(
                                          widget.arList[index]?.playerImage ??
                                              null,
                                          //   width: 80.0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace stackTrace) {
                                            return Image.asset(
                                                ImgConstants.DEFAULT_PLAYER,
                                                //   fit: BoxFit.fill,
                                                // width: 80.0,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1);
                                          },
                                        )
                                      : Image.asset(ImgConstants.DEFAULT_PLAYER,
                                          //   fit: BoxFit.fill,
                                          // width: 80.0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1),
                                  widget.arList[index]?.teamId != null &&
                                          widget.arList[index]?.teamId !=
                                              widget.selectedMatchData?.teama
                                                  ?.teamId
                                      ? ColorConstant.COLOR_BLACK
                                      : ColorConstant.COLOR_WHITE,
                                  widget.arList[index]?.teamId != null &&
                                          widget.arList[index]?.teamId !=
                                              widget.selectedMatchData?.teama
                                                  ?.teamId
                                      ? ColorConstant.COLOR_WHITE
                                      : ColorConstant.COLOR_BLACK,
                                  widget.arList[index]?.isCaptainSelected,
                                  widget.arList[index]?.isViceCaptainSelected,
                                  isLineUp &&
                                      (widget.arList[index]?.playing11 !=
                                              null &&
                                          widget.arList[index]?.playing11 ==
                                              false),
                                );
                              }),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),
                    // BOWLERS
                    Flex(
                      direction: Axis.vertical,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          AppLocalizations.of(widget.bowlersList != null &&
                                  widget.bowlersList.length > 1
                              ? 'BOWLERS'
                              : 'BOWLER'),
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: Colors.white.withOpacity(0.9),
                                // color: Theme.of(context)
                                //     .appBarTheme
                                //     .color
                                //     .withOpacity(0.5),
                                fontSize:
                                    MediaQuery.of(context).size.width * 0.04,
                              ),
                        ),
                        if (widget.bowlersList != null &&
                            widget.bowlersList.length > 0)
                          Center(
                            child: Wrap(
                              runSpacing: 0,
                              spacing: spacing,
                              alignment: WrapAlignment.center,
                              children: List.generate(widget.bowlersList.length,
                                  (index) {
                                return playerDetail(
                                  bowlColumnWidth,
                                  "${widget.bowlersList[index]?.shortName}",
                                  widget.pageFromMatch != null &&
                                          widget.pageFromMatch ==
                                              StringConstant.UPCOMING_MATCHES
                                      ? "${widget.bowlersList[index]?.fantasyPlayerRating}"
                                      : "${widget.bowlersList[index]?.points ?? "0"}",
                                  widget.bowlersList[index].playerImage !=
                                              null &&
                                          widget.bowlersList[index].playerImage
                                                  .length >
                                              1
                                      ? Image.network(
                                          widget.bowlersList[index]
                                                  ?.playerImage ??
                                              null,
                                          //   width: 80.0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1,
                                          errorBuilder: (BuildContext context,
                                              Object exception,
                                              StackTrace stackTrace) {
                                            return Image.asset(
                                                ImgConstants.DEFAULT_PLAYER,
                                                //   fit: BoxFit.fill,
                                                // width: 80.0,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1);
                                          },
                                        )
                                      : Image.asset(ImgConstants.DEFAULT_PLAYER,
                                          //   fit: BoxFit.fill,
                                          // width: 80.0,
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.1),
                                  widget.bowlersList[index]?.teamId != null &&
                                          widget.bowlersList[index]?.teamId !=
                                              widget.selectedMatchData.teama
                                                  .teamId
                                      ? ColorConstant.COLOR_BLACK
                                      : ColorConstant.COLOR_WHITE,
                                  widget.bowlersList[index]?.teamId != null &&
                                          widget.bowlersList[index]?.teamId !=
                                              widget.selectedMatchData.teama
                                                  .teamId
                                      ? ColorConstant.COLOR_WHITE
                                      : ColorConstant.COLOR_BLACK,
                                  widget.bowlersList[index]?.isCaptainSelected,
                                  widget.bowlersList[index]
                                      ?.isViceCaptainSelected,
                                  isLineUp &&
                                      (widget.bowlersList[index]?.playing11 !=
                                              null &&
                                          widget.bowlersList[index]
                                                  ?.playing11 ==
                                              false),
                                );
                              }),
                            ),
                          )
                        else
                          Container(),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  vertical: 10.0,
                  horizontal: 16.0,
                ),
                color: Colors.black.withOpacity(0.2),
                child: Flex(
                  direction: Axis.horizontal,
                  children: [
                    Card(
                      color: ColorConstant.COLOR_WHITE,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, top: 2, bottom: 2),
                        child: Text(
                          "${widget.selectedMatchData.teama.shortName ?? ""}",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_BLACK,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "$teamACount",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      ":",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.bold,
                            fontSize: 14.0,
                          ),
                    ),
                    SizedBox(width: 10.0),
                    Text(
                      "$teamBCount",
                      style: Theme.of(context).textTheme.caption.copyWith(
                            color: ColorConstant.COLOR_WHITE,
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                          ),
                    ),
                    SizedBox(width: 10.0),
                    Card(
                      color: ColorConstant.COLOR_BLACK,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 6, right: 6, top: 2, bottom: 2),
                        child: Text(
                          "${widget.selectedMatchData.teamb.shortName}",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_WHITE,
                                fontWeight: FontWeight.bold,
                                fontSize: 14.0,
                              ),
                        ),
                      ),
                    ),
                    Spacer(),
                    Visibility(
                      visible:
                          widget.pageFromMatch == StringConstant.LIVE_MATCHES,
                      child: Row(
                        children: [
                          Text("Team Points : ",
                              style: TextStyle(
                                  fontSize: 14.0,
                                  color: ColorConstant.COLOR_WHITE)),
                          Text("${widget.teamPoints}",
                              //"0.25",

                              style: TextStyle(
                                  fontSize: 18.0,
                                  fontWeight: FontWeight.w700,
                                  color: ColorConstant.COLOR_WHITE)),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget playerDetail(
    double size,
    String txt1,
    String txt2,
    Image image1,
    Color color,
    Color txtColor,
    bool isCaptain,
    bool isViceCaptain,
    bool isPlaying,
  ) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.14,
      width: size,
      alignment: Alignment.center,
      child: Stack(
        children: [
          Visibility(
            visible: isCaptain || isViceCaptain,
            child: Positioned(
              top: 18.0,
              left: 6.0,
              child: Container(
                height: 18,
                width: 18,
                decoration: BoxDecoration(
                  color: ColorConstant.COLOR_BLACK,
                  border: Border.all(color: ColorConstant.COLOR_WHITE),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    isCaptain
                        ? "C"
                        : isViceCaptain
                            ? "VC"
                            : "",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: ColorConstant.COLOR_WHITE,
                          fontWeight: FontWeight.bold,
                          fontSize: 9,
                        ),
                  ),
                ),
              ),
            ),
          ),
          Visibility(
            visible: isPlaying,
            child: Positioned(
              top: 22.0,
              right: 18.0,
              child: Container(
                height: 8,
                width: 8,
                decoration: BoxDecoration(
                  color: ColorConstant.COLOR_RED,
                  shape: BoxShape.circle,
                ),
              ),
            ),
          ),
          Flex(
            direction: Axis.vertical,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              image1,
              Column(
                children: [
                  Container(
                    width: 75,
                    decoration: BoxDecoration(
                      color: color,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                    child: Padding(
                        padding: const EdgeInsets.only(
                            left: 3, right: 3, top: 2, bottom: 2),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: txt1.length > 10
                                    ? txt1.substring(0, 10) + '...'
                                    : txt1,
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: txtColor,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10.0,
                                    ),
                              ),
                            ],
                          ),
                          maxLines: 1,
                          textAlign: TextAlign.center,
                        )),
                  ),
                  const SizedBox(height: 2),
                ],
              ),
              widget.pageFromMatch != null &&
                      widget.pageFromMatch == StringConstant.UPCOMING_MATCHES
                  ? Text(
                      txt2 + " Cr",
                      style: TextStyle(
                        color: ColorConstant.COLOR_WHITE,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    )
                  : Text(
                      isCaptain
                          ? "${2 * double.parse(txt2)} Pts"
                          : isViceCaptain
                              ? "${1.5 * double.parse(txt2)} Pts"
                              : txt2 + " Pts",
                      style: TextStyle(
                        color: ColorConstant.COLOR_WHITE,
                        fontWeight: FontWeight.bold,
                        fontSize: 12.0,
                      ),
                    )
            ],
          ),
        ],
      ),
    );
  }
}
