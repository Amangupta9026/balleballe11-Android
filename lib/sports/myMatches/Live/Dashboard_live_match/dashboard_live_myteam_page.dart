import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/create_team_model.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/getMyTeamList.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/model/my_completed_matches_model.dart';
import 'package:balleballe11/model/myjoined_live_matches_model.dart';
import 'package:balleballe11/model/selected_team_model.dart';
import 'package:balleballe11/model/squad_players_model.dart';
import 'package:balleballe11/sports/contest/getmyteam_detail_list.dart';
import 'package:balleballe11/sports/createTeam/create_team.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';

import 'dashboard_live_match_myteam_details.dart';


class DashboardLiveMyTeamPage extends StatefulWidget {
  Joinedmatch selectedMatchData;
  bool isFromView;
  String pageFromMatch = "";
  DashboardLiveMyTeamPage(Joinedmatch selectedMatchData,
      {bool isFromView, String pageFromMatch}) {
    this.selectedMatchData = selectedMatchData;
    this.isFromView = isFromView;
    this.pageFromMatch = pageFromMatch;
  }

  @override
  _DashboardLiveMyTeamPageState createState() => _DashboardLiveMyTeamPageState();
}

class _DashboardLiveMyTeamPageState extends State<DashboardLiveMyTeamPage> {
  GetMyTeamByIdResponseModel _getMyTeamResponseModel =
      GetMyTeamByIdResponseModel();
  GetMyTeam _getmyteamdetailslist = GetMyTeam();
  SelectedTeamModel selectedTeamData = SelectedTeamModel();
  bool _isProgressRunning = false;
  bool isloading = true;
  List<PlayerPoint> _wkList = <PlayerPoint>[];
  List<PlayerPoint> _batsList = <PlayerPoint>[];
  List<PlayerPoint> _arList = <PlayerPoint>[];
  List<PlayerPoint> _bowlersList = <PlayerPoint>[];

  Future<void> getMyTeamList() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _getMyTeamResponseModel = await APIServices.getMyTeamByPlayerId(
          widget?.selectedMatchData?.matchId);
      //   await getMyTeamListDetails();
      //  _getMyTeamLists.addAll(_getMyTeamResponseModel.data);
      //    log("${_getMyTeamLists.length}", name: "getMyTeamLists");
      setState(() {
        //   totalTeamCount = _getMyTeamLists.length;
      });
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, error);
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  // Get MY TEAM LIST DETAILS

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
    Future.delayed(Duration.zero, () {
      isloading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstant.COLOR_WHITE, // transparent status bar
    ));
    return isloading
        ? Center(child: Container(child: CircularProgressIndicator()))
        : _getMyTeamResponseModel.response.myteam.length != null &&
                _getMyTeamResponseModel.response.myteam.length > 0
            ? ListView.builder(
                physics: ClampingScrollPhysics(),
                padding: EdgeInsets.only(bottom: 30.0),
                itemBuilder: (context, index) {
                  return _getMyTeamList(context, index);
                },
                itemCount: _getMyTeamResponseModel.response.myteam.length,
              )
            : _noAnyTeam();
  }

  Widget _getMyTeamList(BuildContext context, int index) {
    double height1 = MediaQuery.of(context).size.height;

    return InkWell(
      onTap: () async {
        await getMyTeamListDetails(
            widget.selectedMatchData.matchId,
            _getMyTeamResponseModel.response.myteam[index].createdTeam.teamId,
            SharedPreference.getValue(PrefConstants.USER_ID));
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DashboardLiveMatchMyTeamDetail(
                selectedMatchData: widget.selectedMatchData,
                wkList: _wkList,
                batsList: _batsList,
                arList: _arList,
                bowlersList: _bowlersList,
                teamPoints:
                    _getMyTeamResponseModel.response.myteam[index].points,
                pageFromMatch: widget.pageFromMatch,
                teamId: _getMyTeamResponseModel
                    .response.myteam[index].createdTeam.teamId,
                teamName:
                    _getMyTeamResponseModel.response.myteam[index].teamName,
                totalPoints: _getmyteamdetailslist.totalPoints,
              ),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(10.0, 20, 10, 10),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(22.0),
          child: Card(
            child: Column(
              children: [
                Stack(
                  children: [
                    Image.asset(
                      ImgConstants.balleballe11_GROUND_IMAGE,
                      width: double.infinity,
                      height: height1 * 0.15,
                      fit: BoxFit.cover,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                      child: Row(
                        children: [
                          if (_getMyTeamResponseModel.response.myteam != null)
                            Text(
                              "${_getMyTeamResponseModel.response.myteam[index].teamName ?? ""}",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                    color: ColorConstant.COLOR_WHITE,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                        ],
                      ),
                    ),
                    Padding(
                        padding: EdgeInsets.only(left: 30, top: 30, bottom: 5),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 2,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Points",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    "${_getMyTeamResponseModel.response.myteam[index].points ?? ""}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.w500,
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
                                            const EdgeInsets.only(top: 0.0),
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
                                  subtitle: Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstant.COLOR_TEXT,
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Text(
                                      "${_getMyTeamResponseModel.response.myteam[index].c.name ?? ""}",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: ColorConstant.COLOR_WHITE,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  )),
                            ),
                            Expanded(
                              child: ListTile(
                                  title: Stack(
                                    children: [
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 0.0),
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
                                  subtitle: Container(
                                    decoration: BoxDecoration(
                                      color: ColorConstant.COLOR_WHITE,
                                      shape: BoxShape.rectangle,
                                    ),
                                    child: Text(
                                      "${_getMyTeamResponseModel.response.myteam[index].vc.name ?? ""}",
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .caption
                                          .copyWith(
                                            color: ColorConstant.COLOR_TEXT,
                                            fontWeight: FontWeight.bold,
                                          ),
                                    ),
                                  )),
                            ),
                          ],
                        )),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(
                        "WK ${_getMyTeamResponseModel.response.myteam[index].wk.length ?? 0}",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        "BAT ${_getMyTeamResponseModel.response.myteam[index].bat.length ?? 0}",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        "ALL ${_getMyTeamResponseModel.response.myteam[index].all.length ?? 0}",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      Text(
                        "BOWL ${_getMyTeamResponseModel.response.myteam[index].bowl.length ?? 0}",
                        style: Theme.of(context).textTheme.bodyText1.copyWith(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
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

  Widget _noAnyTeam() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 100,
          ),
          Text(
            AppLocalizations.of("You haven't created any team yet!"),
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
                          AppLocalizations.of('Create Team'),
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
}
