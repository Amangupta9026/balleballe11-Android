import 'dart:developer';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/contest_type_model.dart';
import 'package:balleballe11/model/getMyTeamById.dart';
import 'package:balleballe11/model/get_mywallet_model.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/sports/createTeam/create_team.dart';
import 'package:balleballe11/sports/join_contest/join_contest.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';

class SelectTeamForJoinContest2 extends StatefulWidget {
  String pageFromMatch = "";
  final Upcomingmatch selectedMatchData;
  final int contestId;
  final Contest selectedContestData;
  final int i;

  SelectTeamForJoinContest2(
      {Key key,
      this.selectedMatchData,
      this.pageFromMatch,
      this.contestId,
      this.selectedContestData,
      this.i = 1})
      : super(key: key);

  _SelecteTeamForJoinContestState createState() =>
      _SelecteTeamForJoinContestState();
}

class _SelecteTeamForJoinContestState extends State<SelectTeamForJoinContest2> {
  bool _isProgressRunning = true, _isRoundedProgress = false;
//  List<TeamPlayersData> _getMyTeamLists = <TeamPlayersData>[];
  bool isTeamSelected = false, isSelectAll = false;
  List<String> _selectedTeamIdList = <String>[];
  String captainImg = "", viceCaptainImg = "";
  int teamCount = 1;
  // var _myWalletData = new WalletData();
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  WalletInfo _myWalletData = WalletInfo();
  List<int> teamIds = [];
  bool isloading = true;

  GetMyTeamByIdResponseModel _getMyTeamResponseModel =
      GetMyTeamByIdResponseModel();

  num totalAmount = 0;

  double moneydeducted;

  @override
  void initState() {
    super.initState();
    getMyTeamList();
    getWalletData();

    Future.delayed(Duration.zero, () {
      isloading = false;
    });
  }

  Future<void> getMyTeamList() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      _getMyTeamResponseModel = await APIServices.getMyTeamByPlayerId(
          widget.selectedMatchData.matchId);
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

  Future<void> getWalletData() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      GetWalletModel myWalletResp = await APIServices.getWallet();

      if (myWalletResp.status != null && myWalletResp.walletInfo != null) {
        setState(() {
          _myWalletData = myWalletResp.walletInfo;
          SharedPreference.setValue(
              PrefConstants.WALLET_AMOUNT, _myWalletData.walletAmount);
          SharedPreference.setValue(
              PrefConstants.BONUS_AMOUNT, _myWalletData.bonusAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.WINNING_AMOUNT, _myWalletData.prizeAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.DEPOSIT_AMOUNT, _myWalletData.depositAmount ?? 0);
          SharedPreference.setValue(
              PrefConstants.PRIZE_AMOUNT, _myWalletData.prizeAmount ?? 0);
          SharedPreference.setValue(PrefConstants.AFFILIATE_COMMISSION,
              _myWalletData.affiliateCommission ?? 0);
          SharedPreference.setValue(PrefConstants.REFFERAL_COUNT,
              _myWalletData.refferalFriendsCount ?? 0);
          SharedPreference.setValue(
              PrefConstants.EXTRA_AMOUNT, _myWalletData.extraCash ?? 0);

          if (_myWalletData != null &&
              // _myWalletData.bonusAmount != null &&
              _myWalletData.prizeAmount != null &&
              _myWalletData.depositAmount != null &&
              _myWalletData.bonusAmount != null) {
            totalAmount =
                (_myWalletData.depositAmount + _myWalletData.prizeAmount);
            SharedPreference.setValue(PrefConstants.TOTAL_AMOUNT, totalAmount);
          }
        });
      }
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, error);
    } finally {
      setState(() {
        _isProgressRunning = false;
      });
    }
  }

  @override
  void setState(VoidCallback fn) {
    if (mounted) super.setState(fn);
  }

  Widget _getMyTeamList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      itemBuilder: (context, index) {
        return Row(
          children: [
            Expanded(
                child: _getMyTeamItem(
              context,
              index,
            )),
            //  if (contestTypeDataList[index].maxEntry ?? "0")
            widget.i <= 1
                ? Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: _getMyTeamResponseModel
                          .response.myteam[index].isTeamSelect,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onChanged: (bool value) {
                        setState(() {
                          _getMyTeamResponseModel.response.myteam
                              .forEach((element) {
                            element.isTeamSelect = false;
                          });

                          _getMyTeamResponseModel
                              .response.myteam[index].isTeamSelect = value;
                          isTeamSelected = value;
                          _selectedTeamIdList.clear();
                          _selectedTeamIdList.add(_getMyTeamResponseModel
                              .response.myteam[index].createdTeam.teamId
                              .toString());
                          teamIds.clear();
                          teamIds.add(_getMyTeamResponseModel
                              .response.myteam[index].createdTeam.teamId);
                        });
                        _selectedTeamIdList.length ==
                                _getMyTeamResponseModel.response.myteam.length
                            ? setState(() {
                                isSelectAll = true;
                              })
                            : setState(() {
                                isSelectAll = false;
                              });
                      },
                      splashRadius: 1.0,
                      activeColor: ColorConstant.COLOR_TEXT,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  )
                : Transform.scale(
                    scale: 1.2,
                    child: Checkbox(
                      value: _getMyTeamResponseModel
                          .response.myteam[index].isTeamSelect,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      onChanged: (bool value) {
                        setState(() {
                          _getMyTeamResponseModel.response.myteam
                              .contains((element) {
                            element.isTeamSelect = false;
                          });

                          _getMyTeamResponseModel
                              .response.myteam[index].isTeamSelect = value;
                          //   isTeamSelected = value;
                          if (value) {
                            _selectedTeamIdList.add(_getMyTeamResponseModel
                                .response.myteam[index].createdTeam.teamId
                                .toString());
                          } else {
                            _selectedTeamIdList.remove(_getMyTeamResponseModel
                                .response.myteam[index].createdTeam.teamId
                                .toString());
                          }
                          _selectedTeamIdList =
                              _selectedTeamIdList.toSet().toList();

                          teamIds.add(_getMyTeamResponseModel
                              .response.myteam[index].createdTeam.teamId);
                          isTeamSelected = value;
                        });
                        _selectedTeamIdList.length ==
                                _getMyTeamResponseModel.response.myteam.length
                            ? setState(() {
                                isSelectAll = true;
                              })
                            : setState(() {
                                isSelectAll = false;
                              });
                      },
                      splashRadius: 1.0,
                      activeColor: ColorConstant.COLOR_TEXT,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                    ),
                  )
          ],
        );
      },
      itemCount: _getMyTeamResponseModel.response?.myteam?.length ?? 0,
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
    );
  }

  Widget _getMyTeamItem(BuildContext context, int index) {
    double height1 = MediaQuery.of(context).size.height;
    return Padding(
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
                    height: height1 * 0.16,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 0),
                    child: Row(
                      children: [
                        if (_getMyTeamResponseModel.response.myteam != null)
                          Text(
                            "${_getMyTeamResponseModel.response.myteam[index].teamName ?? ""}",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                          ),
                        Spacer(),
                        // if (widget.pageFromMatch ==
                        //     StringConstant.UPCOMING_MATCHES)
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateTeamPage(
                                  selectedMatchData: widget?.selectedMatchData,
                                  remainingTime: "",
                                  createTeamMode: "editMode",
                                  getMyTeamData: _getMyTeamResponseModel
                                      ?.response?.myteam[index],
                                ),
                              ),
                            );
                            // Navigator.push(
                            //   context,
                            //   MaterialPageRoute(
                            //     builder: (context) => CreateTeamPage(
                            //       selectedMatchData: widget?.selectedMatchData,
                            //       remainingTime: "",
                            //       createTeamMode: "editMode",
                            //       // getMyTeamData: selectedTeamData
                            //       //     .response?.myteam[index],
                            //     ),
                            //   ),
                            // );
                          },
                          child: Image.asset(
                            ImgConstants.IC_TEAM_EDIT,
                            height: 20,
                            width: 20,
                            color: ColorConstant.COLOR_WHITE,
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateTeamPage(
                                  selectedMatchData: widget?.selectedMatchData,
                                  remainingTime: "",
                                  createTeamMode: "copyMode",
                                  getMyTeamData: _getMyTeamResponseModel
                                      ?.response?.myteam[index],
                                ),
                              ),
                            );
                          },
                          child: Image.asset(
                            ImgConstants.IC_TEAM_DESC,
                            height: 20,
                            width: 20,
                            color: ColorConstant.COLOR_WHITE,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.only(left: 0, top: 30, bottom: 5),
                      child: Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "${_getMyTeamResponseModel.response.myteam[index].team[0].name ?? ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                "${_getMyTeamResponseModel.response.myteam[index].team[0].count ?? ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                              title: Text(
                                "${_getMyTeamResponseModel.response.myteam[index].team[1].name ?? ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                              subtitle: Text(
                                "${_getMyTeamResponseModel.response.myteam[index].team[1].count ?? ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.bold,
                                    ),
                              ),
                            ),
                          ),
                          Expanded(
                            child: ListTile(
                                title: Stack(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(top: 11.0),
                                      child: Image.asset(
                                        ImgConstants.balleballe11_DEFAULT_IMAGE,
                                        //  height: 50,
                                        width: 80,
                                      ),
                                    ),
                                    Container(
                                      width: 17,
                                      height: 17,
                                      decoration: new BoxDecoration(
                                        color: Color(0XFF514d4e),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        "c",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: ColorConstant.COLOR_WHITE,
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
                                        .bodyText1
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
                                      padding: const EdgeInsets.only(top: 11.0),
                                      child: Image.asset(
                                        ImgConstants.balleballe11_DEFAULT_IMAGE,
                                        // height: 50,
                                        width: 80,
                                      ),
                                    ),
                                    Container(
                                      width: 17,
                                      height: 17,
                                      decoration: new BoxDecoration(
                                        color: Color(0XFF514d4e),
                                        shape: BoxShape.circle,
                                      ),
                                      child: Text(
                                        "vc",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: ColorConstant.COLOR_WHITE,
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
                                    "${_getMyTeamResponseModel.response.myteam[index].vc.name ?? ""}",
                                    textAlign: TextAlign.center,
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
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
    );
  }

  Widget _getTeamData(BuildContext context, int index) {
    // if (_getMyTeamLists != null && _getMyTeamLists.length > 0) {
    return ListView(
      padding: EdgeInsets.zero,
      scrollDirection: Axis.vertical,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 12.0, right: 22.0, top: 12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Selected Your Team",
                      style: Theme.of(context).textTheme.caption.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontSize: 14.0,
                          fontWeight: FontWeight.w500),
                    ),
                  ]),
              Spacer(),
              Visibility(
                visible: widget.i >= 2,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Checkbox(
                          value: isSelectAll,
                          onChanged: (bool value) {
                            if (value) {
                              setState(() {
                                _selectedTeamIdList.clear();
                                // for (var isAllTeamSelect
                                //     in _getMyTeamResponseModel
                                //         .response.myteam)
                                for (var i = 0;
                                    i <
                                        _getMyTeamResponseModel
                                            .response.myteam.length;
                                    i++) {
                                  _getMyTeamResponseModel
                                      .response.myteam[i].isTeamSelect = value;
                                  _selectedTeamIdList.add(
                                      _getMyTeamResponseModel
                                          .response.myteam[i].createdTeam.teamId
                                          .toString());
                                  //  teamCount = 1;
                                }
                                teamCount = _selectedTeamIdList.length;
                                isSelectAll = value;
                                isTeamSelected = value;
                              });
                            } else {
                              setState(() {
                                _selectedTeamIdList.clear();

                                for (var isAllTeamSelect
                                    in _getMyTeamResponseModel
                                        .response.myteam) {
                                  isAllTeamSelect.isTeamSelect = false;
                                  // _selectedTeamIdList.add(
                                  //     _getMyTeamResponseModel.response
                                  //         .myteam[index].createdTeam.teamId
                                  //         .toString());

                                }
                                teamCount = 0;
                                isSelectAll = false;
                                isTeamSelected = false;
                              });
                            }
                          },
                          splashRadius: 1.0,
                          activeColor: ColorConstant.COLOR_TEXT,
                          materialTapTargetSize:
                              MaterialTapTargetSize.shrinkWrap),
                    ]),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 14.0, right: 14.0),
          child: _getMyTeamList(),
        )
      ],
    );

    // return Container();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: ColorConstant.COLOR_WHITE,
      // transparent status bar
    ));
    return SafeArea(
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: _isProgressRunning
            ? ColorConstant.COLOR_WHITE
            : ColorConstant.BACKGROUND_COLOR,
        appBar: AppBar(
          backgroundColor: ColorConstant.COLOR_WHITE,
          automaticallyImplyLeading: false,
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(
              Icons.arrow_back,
              color: ColorConstant.COLOR_TEXT,
              size: 22,
            ),
          ),
          title: Text(
            "Select Team",
            style: Theme.of(context).textTheme.caption.copyWith(
                  color: ColorConstant.COLOR_TEXT,
                  fontWeight: FontWeight.w500,
                  fontSize: 18,
                ),
          ),
        ),
        body: isloading
            ? Center(child: Container(child: CircularProgressIndicator()))
            :
            //  _isProgressRunning
            //     ? _progressShimmer(context)
            //     :
            // ProgressContainerView(
            //     isProgressRunning: _isRoundedProgress, child:
            _getTeamData(context, 1),
        //  ),
        bottomNavigationBar: Row(
          children: [
            SizedBox(width: 10.0),
            Expanded(
              child: InkWell(
                onTap: () {
                  // Navigator.of(context)..pop();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CreateTeamPage(
                          selectedMatchData: widget.selectedMatchData,
                          remainingTime: "",
                          createTeamMode: "joinContestMode"),
                    ),
                  );
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        border: Border.all(
                          color: ColorConstant.COLOR_BLUE,
                        ),
                        color: ColorConstant.COLOR_WHITE),
                    child: Center(
                      child: Text(
                        AppLocalizations.of('CREATE A TEAM'),
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: ColorConstant.COLOR_GREEN,
                              letterSpacing: 0.6,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: InkWell(
                onTap: () {
                  if (isTeamSelected) {
                    teamCount = _selectedTeamIdList.length;
                    log("$teamCount", name: "teamCount");
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => JoinContest(
                              selectedMatchData: widget?.selectedMatchData,
                              contestId: widget.contestId,
                              selectedContestData: widget.selectedContestData,
                              teamId: _selectedTeamIdList
                                  .map((e) => int.tryParse(e))
                                  .toList(),
                              teamCount: teamCount,
                              maxTeamAllowed: widget.i,
                            )));
                  } else {
                    UtilsFlushBar.showDefaultSnackbar(context,
                        "Please select at least one team to join contest");
                  }
                },
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Container(
                    height: 50,
                    width: 100,
                    decoration: BoxDecoration(
                      color: isTeamSelected
                          ? ColorConstant.COLOR_TEXT
                          : ColorConstant.COLOR_TEXT,
                      borderRadius: BorderRadius.circular(10),
                      // border: Border.all(
                      //   color: ColorConstant.COLOR_RED,
                      // ),
                    ),
                    child: Center(
                      child: Text(
                        // "${_getTeamlist.teamId}",
                        AppLocalizations.of('Join Contest'),
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
              ),
            ),
            SizedBox(width: 10.0),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}
