import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/getMyTeamList.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/sports/contest/getmyteam_detail_list.dart';

import 'guru_team_preview.dart';

class GuruUi extends StatefulWidget {
  int guru;
  Upcomingmatch selectedMatchData;

  GuruUi({
    Key key,
    this.guru,
    this.selectedMatchData,
  }) : super(key: key);

  @override
  _GuruUiState createState() => _GuruUiState();
}

class _GuruUiState extends State<GuruUi> {
  String pageFromMatch = "";

  List<PlayerPoint> _wkList = <PlayerPoint>[];
  List<PlayerPoint> _batsList = <PlayerPoint>[];
  List<PlayerPoint> _arList = <PlayerPoint>[];
  List<PlayerPoint> _bowlersList = <PlayerPoint>[];

  bool locked = false;
  bool _isProgressRunning = false;
  bool isloading = true;
  GetMyTeam _getmyteamdetailslist = GetMyTeam();
  GetMyTeamByIdResponseModel _getMyTeamResponseModel =
      GetMyTeamByIdResponseModel();

  Future<void> getMyTeamList() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _getMyTeamResponseModel = await APIServices.getMyTeamByPlayerId(
          widget.selectedMatchData.matchId);
      // setState(() {
      //   totalTeamCount = _getMyTeamResponseModel.teamCount;
      // });

    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, error);
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

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
    getMyTeamList();
  }

  @override
  Widget build(BuildContext context) {
    double height1 = MediaQuery.of(context).size.height;
    return Container(
      child: Column(
        children: [
          Container(
            color: ColorConstant.COLOR_GREY2,
            width: double.infinity,
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                "TEAMS FROM GURUs",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ),
          Expanded(
            child: Container(
              height: height1,
              child: ListView.builder(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 15.0),
                itemBuilder: (context, index) {
                  return _getMyTeamList(context, index);
                },
                itemCount: widget.guru,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _getMyTeamList(BuildContext context, int index) {
    double height1 = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () async {
        // await getMyTeamListDetails(
        //     widget.selectedMatchData.matchId,
        //     _getMyTeamResponseModel.response.myteam[index].createdTeam.teamId,
        //     SharedPreference.getValue(PrefConstants.USER_ID));
        // Navigator.push(
        //     context,
        //     MaterialPageRoute(
        //       builder: (context) => GuruTeamPreview(
        //         selectedMatchData: widget.selectedMatchData,
        //         wkList: _wkList,
        //         batsList: _batsList,
        //         arList: _arList,
        //         bowlersList: _bowlersList,
        //         teamPoints:
        //             _getMyTeamResponseModel.response.myteam[index].points,
        //         //    pageFromMatch: widget.pageFromMatch,
        //         teamId: _getMyTeamResponseModel
        //             .response.myteam[index].createdTeam.teamId,

        //         // teamName:
        //         // "${modelResp.leaderBoardTeamListData.teamName}(${modelResp.leaderBoardTeamListData.teamTag})",
        //       ),
        //     ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.0),
          child: Card(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      ImgConstants.balleballe11_GROUND_IMAGE,
                      color: ColorConstant.COLOR_GREEN3,
                      width: double.infinity,
                      height: height1 * 0.19,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      color: Colors.black.withOpacity(0.3),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20.0, 15, 20, 15),
                        child: Row(
                          children: [
                            // if (_getMyTeamResponseModel.response.myteam != null)
                            Text(
                              "dd",
                              //  "${_getMyTeamResponseModel.response.myteam[index].teamName ?? ""}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: ColorConstant.COLOR_WHITE,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                            Spacer(),
                            // if (widget.pageFromMatch ==
                            //     StringConstant.UPCOMING_MATCHES)
                            Text(
                              "04:00 am",
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: ColorConstant.COLOR_WHITE,
                                        fontWeight: FontWeight.w500,
                                      ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 20, top: 50, bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Row(
                                children: [
                                  Image.asset(
                                    ImgConstants.COIN,
                                    width: 15,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    "Premium Team",
                                    //  "${_getMyTeamResponseModel.response.myteam[index].team[1].name ?? ""}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              child: ListTile(
                                  title: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImgConstants
                                              .balleballe11_DEFAULT_IMAGE,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      Container(
                                        width: 17,
                                        height: 17,
                                        decoration: new BoxDecoration(
                                          color: ColorConstant.COLOR_TEXT,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          "c",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                                color:
                                                    ColorConstant.COLOR_WHITE,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      if (locked == false)
                                        Icon(
                                          Icons.lock,
                                          size: 18,
                                          color: ColorConstant.COLOR_RED2,
                                        )
                                      else
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorConstant.COLOR_TEXT,
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0, right: 2),
                                            child: Text(
                                              "xx",
                                              //  "${_getMyTeamResponseModel.response.myteam[index].c.name ?? ""}",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                    color: ColorConstant
                                                        .COLOR_WHITE,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        )
                                    ],
                                  )),
                            ),
                            Expanded(
                              child: ListTile(
                                  title: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Image.asset(
                                          ImgConstants
                                              .balleballe11_DEFAULT_IMAGE,
                                          height: 50,
                                          width: 50,
                                        ),
                                      ),
                                      Container(
                                        width: 17,
                                        height: 17,
                                        decoration: new BoxDecoration(
                                          color: ColorConstant.COLOR_TEXT,
                                          shape: BoxShape.circle,
                                        ),
                                        child: Text(
                                          "vc",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                                color:
                                                    ColorConstant.COLOR_WHITE,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  subtitle: Column(
                                    children: [
                                      if (locked == false)
                                        Icon(
                                          Icons.lock,
                                          size: 18,
                                          color: ColorConstant.COLOR_RED2,
                                        )
                                      else
                                        Container(
                                          decoration: BoxDecoration(
                                            color: ColorConstant.COLOR_WHITE,
                                            shape: BoxShape.rectangle,
                                          ),
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 2.0, right: 2),
                                            child: Text(
                                              "zz",
                                              //  "${_getMyTeamResponseModel.response.myteam[index].vc.name ?? ""}",
                                              textAlign: TextAlign.center,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .caption
                                                  .copyWith(
                                                    color: ColorConstant
                                                        .COLOR_TEXT,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                            ),
                                          ),
                                        )
                                    ],
                                  )),
                            ),
                          ],
                        )),
                  ],
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    color: locked == true
                        ? ColorConstant.COLOR_GREY2
                        : ColorConstant.COLOR_BLUE4,
                    child: Padding(
                      padding: const EdgeInsets.only(
                          top: 13.0, bottom: 13.0, right: 15),
                      child: Row(
                        children: [
                          Spacer(),
                          if (locked == false)
                            Center(
                              child: Text(
                                "UNLOCKED & COPY",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            )
                          else
                            Center(
                              child: Text(
                                "UNLOCKED",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle2
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ),
                          Spacer(),
                          Icon(
                            Icons.lock,
                            color: ColorConstant.COLOR_RED2,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 10, right: 10, top: 15, bottom: 15.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "10% Commission on your profit",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w400,
                            ),
                      ),

                      //

                      Text(
                        "TNC",
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: ColorConstant.COLOR_BLUE3,
                              fontWeight: FontWeight.w900,
                              decoration: TextDecoration.underline,
                            ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
