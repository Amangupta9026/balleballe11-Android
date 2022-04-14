import 'dart:developer';
import 'dart:io';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/widget/progressWidget.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class MyContestsLivePage extends StatefulWidget {
  Completed selectedMatchData;
  bool isFromView = false;
  String pageFromMatch = "";

  MyContestsLivePage(Completed selectedMatchData,
      {bool isFromView, String pageFromMatch}) {
    this.selectedMatchData = selectedMatchData;
    this.isFromView = isFromView;
    this.pageFromMatch = pageFromMatch;
  }

  @override
  _MyContestsLivePageState createState() => _MyContestsLivePageState();
}

class _MyContestsLivePageState extends State<MyContestsLivePage> {
  bool isProgressRunning = true;
  // List<MyContestData> getMyContestList = <MyContestData>[];
  // GetMyContestResponseModel getMyContest = GetMyContestResponseModel();
  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  // GetMyTeamByIdResponseModel _getMyTeamResponseModel =
  //     GetMyTeamByIdResponseModel();

  // List<TeamPlayersData> _getMyTeamLists = <TeamPlayersData>[];

  bool isMyTeamDownload = false;

  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  Widget _noAnyJoinContest() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            AppLocalizations.of("You haven't join any contest yet!"),
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: ColorConstant.COLOR_TEXT,
                  fontWeight: FontWeight.w600,
                  fontSize: 18.0,
                ),
          ),
          SizedBox(
            height: 10.0,
          ),
          Visibility(
            visible: widget.isFromView != null && !widget.isFromView,
            child: Column(
              children: [
                Text(
                  AppLocalizations.of('What are you waiting for?'),
                  style: Theme.of(context).textTheme.caption.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontSize: 14.0,
                      ),
                ),
                SizedBox(
                  height: 20,
                ),
                Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: InkWell(
                    onTap: () {},
                    child: Container(
                      height: 40,
                      width: 140,
                      decoration: BoxDecoration(
                        color: ColorConstant.COLOR_RED,
                        borderRadius: BorderRadius.circular(6.0),
                      ),
                      child: Center(
                        child: Text(
                          AppLocalizations.of('Join Contest'),
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
          ),
        ],
      ),
    );
  }

  Widget _getLeaguesList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return _getLeaguesItem(context, index);
      },
      itemCount: 2,
      //getMyContestList?.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
    );
  }

  Widget _getLeaguesItem(BuildContext context, int index) {
    //  log("${getMyContestList[index].toJson()}", name: "DATA");
    return Padding(
      padding: EdgeInsets.only(left: 10.0, top: 10.0, right: 10.0),
      child: InkWell(
        onTap: () async {
          // Defaultcontest myContestData = Defaultcontest();
          // myContestData = myContestData.clone(
          //     getMyContestList[index],
          //     getMyContestList[index].prizeBreakup,
          //     getMyContestList[index].myJoinedTeams);

          // if (!getMyContestList[index].isContestCancelled)
          //   Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //       builder: (context) => ContestDetailPage(
          //         contestDetails: myContestData,
          //         selectedMatchData: widget.selectedMatchData,
          //         isFromView: widget.isFromView,
          //         pageFromMatch: widget.pageFromMatch,
          //         max: getMyContestList[index].maxAllowedTeam,
          //       ),
          //     ),
          //   );
        },
        child: Card(
          elevation: 2.0,
          color: ColorConstant.COLOR_WHITE,
          shape: RoundedRectangleBorder(
            side: BorderSide(color: ColorConstant.COLOR_GREY, width: 0.8),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Container(
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(color: ColorConstant.COLOR_GREY, width: 0.8),
              ),
            ),
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
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Prize Pool",
                                        style: TextStyle(
                                          color: ColorConstant.COLOR_GREY,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      SizedBox(height: 5.0),
                                      Text(
                                        "cc",
                                        //   "${widget.selectedMatchData.}",
                                        style: TextStyle(
                                            color: ColorConstant.COLOR_TEXT,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0),
                                      ),
                                    ],
                                  ),
                                  Flex(
                                    direction: Axis.vertical,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Flex(
                                        direction: Axis.vertical,
                                        children: [
                                          Text(
                                            "Entry",
                                            style: TextStyle(
                                              color: ColorConstant.COLOR_GREY,
                                              fontSize: 12.0,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            height: 25,
                                            child: ElevatedButton(
                                              style: ElevatedButton.styleFrom(
                                                primary: ColorConstant
                                                    .COLOR_LIGHT_GREY, // background
                                                onPrimary: ColorConstant
                                                    .COLOR_WHITE, // foreground
                                              ),
                                              onPressed: () {},
                                              child: Text('₹0'),
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              SizedBox(height: 10.0),
                              Container(
                                color: ColorConstant.COLOR_LIGHT_PINK2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Row(
                                    children: [
                                      Image.asset(
                                        ImgConstants.GOOGLE_LOGO,
                                        height: 20,
                                        width: 20,
                                      ),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text("₹2222")
                                    ],
                                  ),
                                ),
                              ),
                              Container(
                                color: ColorConstant.COLOR_LIGHT_BLUE2,
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 8),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [Text("₹")],
                                  ),
                                ),
                              ),
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
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      //   getMyJoinContest();
    });
  }

  void _onRefresh() async {
    setState(() {
      // getMyContest = null;
      // getMyContestList.clear();
    });
    // await getMyJoinContest();
    _refreshController.refreshCompleted();
  }

  // Future<void> getMyJoinContest() async {
  //   try {
  //     setState(() {
  //       isProgressRunning = true;
  //     });
  //     getMyContest = await APIServices.getJoinContestById();
  //     if (getMyContest != null &&
  //         getMyContest.data != null &&
  //         getMyContest.data.length > 0) {
  //       setState(() {
  //         getMyContestList.addAll(getMyContest.data);
  //       });
  //     }
  //   } catch (error) {
  //     showErrorDialog(context, "Server not reachable, Please Contact Admin");
  //   } finally {
  //     setState(() {
  //       isProgressRunning = false;
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        backgroundColor: isProgressRunning
            ? ColorConstant.COLOR_WHITE
            : ColorConstant.BACKGROUND_COLOR,
        body:
            //  isProgressRunning
            //     ? ShimmerProgressWidget(
            //         count: 8, isProgressRunning: isProgressRunning)
            // : getMyContestList != null && getMyContestList.length > 0
            // ?
            //    :
            Stack(
          children: [
            SmartRefresher(
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: _onRefresh,
              controller: _refreshController,
              header: MaterialClassicHeader(
                  color: ColorConstant.COLOR_RED,
                  backgroundColor: ColorConstant.COLOR_WHITE),
              child: ListView(
                padding: EdgeInsets.zero,
                scrollDirection: Axis.vertical,
                children: [_getLeaguesList()],
              ),
            ),
            isMyTeamDownload
                ? Container(
                    color: ColorConstant.BACKGROUND_COLOR.withOpacity(0.5),
                    child: ProgressWidget(""),
                  )
                : Offstage()
          ],
        )
        //   : _noAnyJoinContest(),
        );
  }

  // Future<void> getMyTeamList() async {
  //   try {
  //     setState(() {
  //       isMyTeamDownload = true;
  //     });
  //     _getMyTeamLists.clear();
  //     _getMyTeamResponseModel = await APIServices.getMyTeamByPlayerId();

  //     if (_getMyTeamResponseModel.success) {
  //       _getMyTeamLists.addAll(_getMyTeamResponseModel.data);

  //       List<List<String>> teamData = [];
  //       teamData.add([
  //         "Team Name",
  //         "P1",
  //         "P2",
  //         "P3",
  //         "P4",
  //         "P5",
  //         "P6",
  //         "P7",
  //         "P8",
  //         "P9",
  //         "P10",
  //         "P11",
  //       ]);
  //       _getMyTeamLists.forEach((element) {
  //         List<String> teamPlayersAndDetails = [];
  //         teamPlayersAndDetails.add("${element.teamName}(${element.team_tag})");
  //         element.players.forEach((player) {
  //           teamPlayersAndDetails.add("${player.title}");
  //         });

  //         teamData.add(teamPlayersAndDetails);
  //       });

  //       String csvData = ListToCsvConverter().convert(teamData);
  //       final String documentDirectory =
  //           await ExternalPath.getExternalStoragePublicDirectory(
  //               ExternalPath.DIRECTORY_DOCUMENTS);
  //       final path =
  //           "$documentDirectory/myTeam-${DateTime.now().millisecondsSinceEpoch}.csv";
  //       final File file = await File(path).create();
  //       print(path);
  //       await file.writeAsString(csvData);

  //       UtilsFlushBar.showDefaultSnackbar(
  //           context, "Team player details successfully created!");

  //       setState(() {
  //         isMyTeamDownload = false;
  //       });
  //     }
  //   } catch (error) {
  //     log("$error", name: "error");
  //     showErrorDialog(context, "Server not reachable, Please Contact Admin");
  //   }
  // }
}
