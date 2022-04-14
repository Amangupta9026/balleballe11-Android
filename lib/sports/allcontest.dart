import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/contest_type_model.dart';
import 'package:balleballe11/model/joinnew_contest_status.dart';
import 'package:balleballe11/model/matchesModel.dart';
import 'package:balleballe11/sports/contestDetail.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:balleballe11/constance/global.dart' as global;
import 'package:random_color/random_color.dart';

import '../model/get_mywallet_model.dart';
import 'createTeam/create_team.dart';
import 'join_contest/select_team_join_contest.dart';
import 'join_contest/join_contest.dart';

class ALLContest extends StatefulWidget {
  Upcomingmatch selectedMatchData;
  Function countCallBack;

  ALLContest({Upcomingmatch selectedMatchData, Function countCallBack}) {
    this.selectedMatchData = selectedMatchData;
    this.countCallBack = countCallBack;
  }

  @override
  _ALLContestState createState() => _ALLContestState();
}

class _ALLContestState extends State<ALLContest> {
  bool isProgressRunning = true;
  ContestTypeModel contestTypeModel = ContestTypeModel();
  List<Response> contestTypeDataList = <Response>[];
  List<MyjoinedTeam> myjoinedteam = <MyjoinedTeam>[];
  List<Matchcontest> DataList = <Matchcontest>[];
  var contestMatch;
  bool isloading = true;
  bool isEntryFeeSelected = false, _isEntryWiseSelected = false;
  JoinNewContestStatusModel joinNewContestStatus = JoinNewContestStatusModel();
  WalletInfo _myWalletData = WalletInfo();

  RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  RefreshController _refreshController1 =
      RefreshController(initialRefresh: false);
  num totalAmount = 0;
  // bool shimmerEffect = false;

  @override
  void initState() {
    super.initState();

    contestTypeModel = SharedPreference.getAllContestData();

    getDefaultContestByType();
    getWalletData();
    //  _getJoinContestStatus();
    // Future.delayed(Duration.zero, () {
    //   isloading = false;
    // });
  }

  Future<void> getDefaultContestByType() async {
    try {
      setState(() {
        isProgressRunning = true;
        // shimmerEffect = true;
      });
      contestTypeModel = await APIServices.getDefaultContestByType(
          widget.selectedMatchData?.matchId);
      contestTypeDataList.clear();

      //  contestTypeDataList.addAll(contestTypeDataList.matchcontests);
      // setState(() {
      //   contestMatch = contestTypeModel.response.matchcontests;
      // });

      // if (contestTypeModel.contestCount != null) {

      //   setState(() {
      //     global.totalMyContestCount = contestTypeModel.contestCount.toString();
      //   });
      //   FBroadcast.instance().broadcast("totalMyContestCount",
      //       value: global.totalMyContestCount);
      // }
      // if (contestTypeModel.myTeamCount != null) {
      //   setState(() {
      //     global.totalTeamCount = contestTypeModel.myTeamCount.toString();
      //   });
      //   FBroadcast.instance()
      //       .broadcast("totalTeamCount", value: global.totalTeamCount);
      // }

    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, error);
    } finally {
      if (mounted)
        setState(() {
          isProgressRunning = false;
          //    shimmerEffect = false;
        });
    }
  }

  // Wallet API

  Future<void> getWalletData() async {
    try {
      setState(() {
        isProgressRunning = true;
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
      if(mounted)
      setState(() {
        isProgressRunning = false;
      });
    }
  }

  Future<void> _onRefresh1() async {
    // setState(() {
    //   contestTypeModel = null;
    //   contestTypeDataList.clear();
    // });
    await getDefaultContestByType();
    await getWalletData();
    _refreshController1.refreshCompleted();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body:
            // isloading
            //     ? Column(
            //         mainAxisAlignment: MainAxisAlignment.center,
            //         crossAxisAlignment: CrossAxisAlignment.center,
            //         children: [
            //           const SizedBox(
            //             height: 60,
            //           ),
            //           Center(child: Container(child: CircularProgressIndicator())),
            //         ],
            //       )
            //   :
            Stack(
          children: [
            isProgressRunning
                ? ShimmerProgressWidget(
                    count: 8, isProgressRunning: isProgressRunning)
                : Stack(
                    children: [
                      // Container(
                      //   //  color: ColorConstant.COLOR_WHITE,
                      //   decoration: BoxDecoration(
                      //       border: Border(
                      //           bottom: BorderSide(
                      //               width: 0.1,
                      //               color: ColorConstant.COLOR_TEXT))),
                      //   child: Row(children: [
                      //     Expanded(
                      //       flex: 3,
                      //       child: TextButton(
                      //           onPressed: () {
                      //             getDefaultContestByType();
                      //           },
                      //           child: Text(
                      //             "ALL",
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .overline
                      //                 .copyWith(
                      //                   color: ColorConstant.COLOR_TEXT,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //           )),
                      //     ),
                      //     //      "₹${contestTypeModel.response.matchcontests[index].contests[0].entryFees ?? ""}",
                      //     Expanded(
                      //       flex: 3,
                      //       child: TextButton(
                      //           onPressed: () {
                      //             setState(() {
                      //               isEntryFeeSelected = true;
                      //               _isEntryWiseSelected =
                      //                   !_isEntryWiseSelected;
                      //               if (_isEntryWiseSelected) {
                      //                 contestTypeModel.response.matchcontests
                      //                     .sort((a, b) =>
                      //                         b.contests[0].entryFees.compareTo(
                      //                             a.contests[0].entryFees));
                      //               } else {
                      //                 contestTypeModel.response.matchcontests
                      //                     .sort((a, b) =>
                      //                         a.contests[0].entryFees.compareTo(
                      //                             b.contests[0].entryFees));
                      //               }
                      //             });
                      //           },
                      //           child: Row(
                      //             children: [
                      //               Text(
                      //                 "Entry",
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .overline
                      //                     .copyWith(
                      //                       color: ColorConstant.COLOR_TEXT,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //               ),
                      //               const SizedBox(
                      //                 width: 5,
                      //               ),
                      //               Text(
                      //                 "₹",
                      //                 style: Theme.of(context)
                      //                     .textTheme
                      //                     .overline
                      //                     .copyWith(
                      //                       color: ColorConstant.COLOR_TEXT,
                      //                       fontWeight: FontWeight.bold,
                      //                     ),
                      //               ),
                      //               Visibility(
                      //                 visible: isEntryFeeSelected,
                      //                 child: _isEntryWiseSelected
                      //                     ? Icon(Icons.arrow_downward_sharp,
                      //                         color: ColorConstant.COLOR_BLUE,
                      //                         size: 14.0)
                      //                     : Icon(Icons.arrow_upward_sharp,
                      //                         color: ColorConstant.COLOR_BLUE,
                      //                         size: 14.0),
                      //               )
                      //             ],
                      //           )),
                      //     ),
                      //     const SizedBox(
                      //       width: 10,
                      //     ),
                      //     Expanded(
                      //       //   flex: 1,
                      //       child: Text(
                      //         "Spots",
                      //         style:
                      //             Theme.of(context).textTheme.overline.copyWith(
                      //                   color: ColorConstant.COLOR_TEXT,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //       ),
                      //     ),
                      //     Expanded(
                      //       flex: 1,
                      //       // contestTypeModel.response.matchcontests[index].contests[0].totalSpots
                      //       child: TextButton(
                      //           onPressed: () async {
                      //             await getDefaultContestByType();

                      //             for (int i = 0;
                      //                 i <
                      //                     contestTypeModel
                      //                         .response.matchcontests.length;
                      //                 i++) {
                      //               //  contestTypeModel.response.matchcontests[i].contests.clear();
                      //               for (int j = 0;
                      //                   j <
                      //                       contestTypeModel
                      //                           .response
                      //                           .matchcontests[i]
                      //                           .contests
                      //                           .length;
                      //                   j++) {
                      //                 if (contestTypeModel
                      //                         .response
                      //                         .matchcontests[i]
                      //                         .contests[j]
                      //                         .totalSpots !=
                      //                     2) {
                      //                   setState(() {
                      //                     contestTypeModel.response
                      //                         .matchcontests[i].contests
                      //                         .remove(contestTypeModel
                      //                             .response
                      //                             .matchcontests[i]
                      //                             .contests[j]);
                      //                     // .where(
                      //                     //     (a) => a.contests[0].totalSpots == 2).toList();
                      //                   });
                      //                 }
                      //               }
                      //             }
                      //           },
                      //           child: Text(
                      //             "2",
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .overline
                      //                 .copyWith(
                      //                   color: ColorConstant.COLOR_TEXT,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //           )),
                      //     ),
                      //     Flexible(
                      //       flex: 1,
                      //       child: TextButton(
                      //           onPressed: () async {
                      //             await getDefaultContestByType();
                      //             setState(() {
                      //               contestTypeModel.response.matchcontests =
                      //                   contestTypeModel.response.matchcontests
                      //                       .where((a) =>
                      //                           a.contests[0].totalSpots == 3)
                      //                       .toList();
                      //             });
                      //           },
                      //           child: Text(
                      //             "3",
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .overline
                      //                 .copyWith(
                      //                   color: ColorConstant.COLOR_TEXT,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //           )),
                      //     ),
                      //     Flexible(
                      //       //flex: 1,
                      //       child: TextButton(
                      //           onPressed: () async {
                      //             await getDefaultContestByType();
                      //             setState(() {
                      //               contestTypeModel.response.matchcontests =
                      //                   contestTypeModel.response.matchcontests
                      //                       .where((a) =>
                      //                           a.contests[0].totalSpots == 4)
                      //                       .toList();
                      //             });
                      //           },
                      //           child: Text(
                      //             "4",
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .overline
                      //                 .copyWith(
                      //                   color: ColorConstant.COLOR_TEXT,
                      //                   fontWeight: FontWeight.bold,
                      //                 ),
                      //           )),
                      //     ),
                      //   ]),
                      // ),
                      Padding(
                        padding: const EdgeInsets.only(
                          top: 10.0,
                        ),
                        child: Stack(
                          children: [
                            SmartRefresher(
                              enablePullDown: true,
                              enablePullUp: false,
                              onRefresh: _onRefresh1,
                              controller: _refreshController,
                              header: MaterialClassicHeader(
                                color: ColorConstant.COLOR_TEXT,
                                backgroundColor: ColorConstant.COLOR_WHITE,
                              ),
                              child: ListView.builder(
                                  padding: EdgeInsets.zero,
                                  // physics: NeverScrollableScrollPhysics(),
                                  physics: ClampingScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    return ContestCardHeader(context, index);
                                  },
                                  itemCount: contestTypeModel
                                          ?.response?.matchcontests?.length ??
                                      0,
                                  shrinkWrap: true),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

            Visibility(
              visible: true,
              // visible: contestTypeModel.myTeamCount < 20,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => CreateTeamPage(
                              selectedMatchData: widget?.selectedMatchData,
                              remainingTime: "")));
                    },
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Container(
                        height: 40,
                        width: 140,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(6.0),
                          border: Border.all(
                            color: ColorConstant.COLOR_BLUE,
                          ),
                        ),
                        child: Center(
                          child: Text(
                            AppLocalizations.of('Create Team'),
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color: Colors.green,
                                  //     color: ColorConstant.COLOR_THEME_PURPLE,
                                  letterSpacing: 0.6,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 16,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),

            //  isloading
            //     ?
            //  Column(
            //     mainAxisAlignment: MainAxisAlignment.center,
            //     crossAxisAlignment: CrossAxisAlignment.center,
            //     children: [
            //       const SizedBox(
            //         height: 60,
            //       ),
            //       Center(
            //           child: Container(child: CircularProgressIndicator())),
            //     ],
            //   )
            //  :
            // Column(
            //   children: [
            // Container(
            //   color: ColorConstant.BACKGROUND_COLOR,
            //   child: Row(
            //     children: [
            //       Expanded(
            //         flex: 3,
            //         child: TextButton(
            //             onPressed: () {
            //               getDefaultContestByType();
            //             },
            //             child: Text(
            //               "ALL",
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .overline
            //                   .copyWith(
            //                     color: ColorConstant.COLOR_TEXT,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //             )),
            //       ),
            //       //      "₹${contestTypeModel.response.matchcontests[index].contests[0].entryFees ?? ""}",
            //       Expanded(
            //         flex: 3,
            //         child: TextButton(
            //             onPressed: () {
            //               setState(() {
            //                 isEntryFeeSelected = true;
            //                 _isEntryWiseSelected =
            //                     !_isEntryWiseSelected;
            //                 if (_isEntryWiseSelected) {
            //                   contestTypeModel
            //                       .response.matchcontests
            //                       .sort((a, b) => b
            //                           .contests[0].entryFees
            //                           .compareTo(
            //                               a.contests[0].entryFees));
            //                 } else {
            //                   contestTypeModel
            //                       .response.matchcontests
            //                       .sort((a, b) => a
            //                           .contests[0].entryFees
            //                           .compareTo(
            //                               b.contests[0].entryFees));
            //                 }
            //               });
            //             },
            //             child: Row(
            //               children: [
            //                 Text(
            //                   "Entry",
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .overline
            //                       .copyWith(
            //                         color: ColorConstant.COLOR_TEXT,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                 ),
            //                 const SizedBox(
            //                   width: 5,
            //                 ),
            //                 Text(
            //                   "₹",
            //                   style: Theme.of(context)
            //                       .textTheme
            //                       .overline
            //                       .copyWith(
            //                         color: ColorConstant.COLOR_TEXT,
            //                         fontWeight: FontWeight.bold,
            //                       ),
            //                 ),
            //                 Visibility(
            //                   visible: isEntryFeeSelected,
            //                   child: _isEntryWiseSelected
            //                       ? Icon(Icons.arrow_downward_sharp,
            //                           color:
            //                               ColorConstant.COLOR_BLUE,
            //                           size: 14.0)
            //                       : Icon(Icons.arrow_upward_sharp,
            //                           color:
            //                               ColorConstant.COLOR_BLUE,
            //                           size: 14.0),
            //                 )
            //               ],
            //             )),
            //       ),
            //       const SizedBox(
            //         width: 10,
            //       ),
            //       Expanded(
            //         //   flex: 1,
            //         child: Text(
            //           "Spots",
            //           style: Theme.of(context)
            //               .textTheme
            //               .overline
            //               .copyWith(
            //                 color: ColorConstant.COLOR_TEXT,
            //                 fontWeight: FontWeight.bold,
            //               ),
            //         ),
            //       ),
            //       Expanded(
            //         flex: 1,
            //         // contestTypeModel.response.matchcontests[index].contests[0].totalSpots
            //         child: TextButton(
            //             onPressed: () async {
            //               await getDefaultContestByType();

            //               for (int i = 0;
            //                   i <
            //                       contestTypeModel.response
            //                           .matchcontests.length;
            //                   i++) {
            //                 //  contestTypeModel.response.matchcontests[i].contests.clear();
            //                 for (int j = 0;
            //                     j <
            //                         contestTypeModel
            //                             .response
            //                             .matchcontests[i]
            //                             .contests
            //                             .length;
            //                     j++) {
            //                   if (contestTypeModel
            //                           .response
            //                           .matchcontests[i]
            //                           .contests[j]
            //                           .totalSpots !=
            //                       2) {
            //                     setState(() {
            //                       contestTypeModel.response
            //                           .matchcontests[i].contests
            //                           .remove(contestTypeModel
            //                               .response
            //                               .matchcontests[i]
            //                               .contests[j]);
            //                       // .where(
            //                       //     (a) => a.contests[0].totalSpots == 2).toList();
            //                     });
            //                   }
            //                 }
            //               }
            //             },
            //             child: Text(
            //               "2",
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .overline
            //                   .copyWith(
            //                     color: ColorConstant.COLOR_TEXT,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //             )),
            //       ),
            //       Flexible(
            //         flex: 1,
            //         child: TextButton(
            //             onPressed: () async {
            //               await getDefaultContestByType();
            //               setState(() {
            //                 contestTypeModel
            //                         .response.matchcontests =
            //                     contestTypeModel
            //                         .response.matchcontests
            //                         .where((a) =>
            //                             a.contests[0].totalSpots ==
            //                             3)
            //                         .toList();
            //               });
            //             },
            //             child: Text(
            //               "3",
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .overline
            //                   .copyWith(
            //                     color: ColorConstant.COLOR_TEXT,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //             )),
            //       ),
            //       Flexible(
            //         //flex: 1,
            //         child: TextButton(
            //             onPressed: () async {
            //               await getDefaultContestByType();
            //               setState(() {
            //                 contestTypeModel
            //                         .response.matchcontests =
            //                     contestTypeModel
            //                         .response.matchcontests
            //                         .where((a) =>
            //                             a.contests[0].totalSpots ==
            //                             4)
            //                         .toList();
            //               });
            //             },
            //             child: Text(
            //               "4",
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .overline
            //                   .copyWith(
            //                     color: ColorConstant.COLOR_TEXT,
            //                     fontWeight: FontWeight.bold,
            //                   ),
            //             )),
            //       ),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget ContestCardHeader(BuildContext context, int contestIndex) {
    var nameInitial = contestTypeModel
        .response.matchcontests[contestIndex].contestTitle[0]
        .toUpperCase();
    RandomColor _randomcolor = RandomColor();
    Color _color =
        _randomcolor.randomColor(colorBrightness: ColorBrightness.dark);

    return InkWell(
      onTap: () {},
      child: Card(
        elevation: 5.0,
        color: ColorConstant.COLOR_WHITE,
        shape: RoundedRectangleBorder(
          side: BorderSide(color: ColorConstant.COLOR_TEXT, width: 0.5),
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Column(
          children: [
            ListTile(
              leading: CircleAvatar(
                backgroundColor: _color,
                foregroundColor: ColorConstant.COLOR_WHITE,
                radius: 20,
                child: Text(
                  nameInitial,
                  style: Theme.of(context).textTheme.subtitle1.copyWith(
                        color: ColorConstant.COLOR_WHITE,
                        fontWeight: FontWeight.w900,
                      ),
                ),
              ),
              title: Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 3),
                child: Text(
                  "${contestTypeModel.response.matchcontests[contestIndex].contestTitle ?? ""}",
                  style: Theme.of(context).textTheme.bodyText2.copyWith(
                        color: ColorConstant.COLOR_TEXT,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
              subtitle: Text(
                "${contestTypeModel.response.matchcontests[contestIndex].contestSubTitle ?? ""}",
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: ColorConstant.COLOR_GREY,
                      fontWeight: FontWeight.w400,
                    ),
              ),
            ),
            Divider(
              color: ColorConstant.COLOR_GREY,
            ),
            ListView.builder(
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return contest(context, index, contestIndex);
                },
                itemCount: contestTypeModel
                        .response.matchcontests[contestIndex].contests.length ??
                    0,

                //    itemCount: _matchData?.data?.length ?? 0,
                shrinkWrap: true),
          ],
        ),
      ),
    );
  }

  Widget contest(BuildContext context, int index, int contestIndex) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ContestDetail(
                    selectedMatchData: widget.selectedMatchData,
                    contestDetails: contestTypeModel
                        .response.matchcontests[contestIndex].contests[index],

                    contestId: contestTypeModel.response
                        .matchcontests[contestIndex].contests[index].contestId,
                    selectedContestData: contestTypeModel
                        .response.matchcontests[contestIndex].contests[index],

                    maxAllowedTeam: contestTypeModel
                            .response
                            .matchcontests[contestIndex]
                            .contests[index]
                            .maxAllowedTeam ??
                        0,
                    // contestTypeModel
                    //                                   .response
                    //                                   .matchcontests[contestIndex]
                    //                                   .contests[index]
                    //                                   .contestId,
                    //    contestDetails: "",
                  )),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(
          left: 5.0,
          right: 5,
        ),
        child: Card(
          elevation: 10.0,
          color: ColorConstant.COLOR_WHITE,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Container(
            decoration: BoxDecoration(),
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
                          color: ColorConstant.COLOR_WHITE,
                          padding: EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 10.0),
                          child: Flex(
                            direction: Axis.vertical,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Prize Pool",
                                    style: TextStyle(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontSize: 12.0,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Text(
                                        "Winner ${contestTypeModel.response.matchcontests[contestIndex].contests[index].winnerCount ?? ""}",
                                        style: TextStyle(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontSize: 12.0,
                                        ),
                                      ),
                                      Icon(Icons.arrow_drop_up)
                                    ],
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 20.0),
                                    child: Text(
                                      "Entry",
                                      style: TextStyle(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontSize: 12.0,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "₹${contestTypeModel.response.matchcontests[contestIndex].contests[index].totalWinningPrize ?? ""}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  InkWell(
                                    onTap: () async {
                                      JoinNewContestStatusModel joinResp =
                                          await APIServices
                                              .joinNewContestStatus(
                                                  contestTypeModel
                                                      .response
                                                      .matchcontests[
                                                          contestIndex]
                                                      .contests[index]
                                                      .contestId,
                                                  widget.selectedMatchData
                                                      .matchId);
                                      if (joinResp.teamList == null) {
                                        Navigator.of(context).push(
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    CreateTeamPage(
                                                        selectedMatchData: widget
                                                            ?.selectedMatchData,
                                                        remainingTime: "")));
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  SelectTeamForJoinContest2(
                                                selectedMatchData:
                                                    widget.selectedMatchData,
                                                contestId: contestTypeModel
                                                    .response
                                                    .matchcontests[contestIndex]
                                                    .contests[index]
                                                    .contestId,
                                                selectedContestData:
                                                    contestTypeModel
                                                        .response
                                                        .matchcontests[
                                                            contestIndex]
                                                        .contests[index],
                                                i: contestTypeModel
                                                        .response
                                                        .matchcontests[
                                                            contestIndex]
                                                        .contests[index]
                                                        .maxAllowedTeam ??
                                                    0,
                                              ),
                                            )).then((value) {
                                          getDefaultContestByType();
                                          setState(() {});
                                        });
                                      }
                                    },
                                    child: Container(
                                      width: 80,
                                      height: 35,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(15.0),
                                          color: ColorConstant.COLOR_BUTTON2),
                                      child: Center(
                                        child: Text(
                                          "₹${contestTypeModel.response.matchcontests[contestIndex].contests[index].entryFees ?? ""}",
                                          textAlign: TextAlign.center,
                                          style: Theme.of(context)
                                              .textTheme
                                              .subtitle1
                                              .copyWith(
                                                color:
                                                    ColorConstant.COLOR_WHITE,
                                                fontWeight: FontWeight.bold,
                                              ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 10.0),
                              LinearPercentIndicator(
                                padding: EdgeInsets.all(3.0),
                                lineHeight: 10.0,
                                percent: contestTypeModel
                                                .response
                                                .matchcontests[contestIndex]
                                                .contests[index]
                                                .filledSpots !=
                                            null &&
                                        (contestTypeModel
                                                .response
                                                .matchcontests[contestIndex]
                                                .contests[index]
                                                .filledSpots) >
                                            0
                                    ? (contestTypeModel
                                                .response
                                                .matchcontests[contestIndex]
                                                .contests[index]
                                                .filledSpots /
                                            contestTypeModel
                                                .response
                                                .matchcontests[contestIndex]
                                                .contests[index]
                                                .totalSpots *
                                            100) /
                                        100
                                    : 0.0,
                                linearStrokeCap: LinearStrokeCap.roundAll,
                                backgroundColor: Color(0xffc5cae8),
                                progressColor: ColorConstant.COLOR_YELLOW,
                              ),
                              SizedBox(height: 10.0),
                              Flex(
                                direction: Axis.horizontal,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Visibility(
                                    visible: true,
                                    child: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                            text:
                                                "${((contestTypeModel.response.matchcontests[contestIndex].contests[index].totalSpots) - contestTypeModel.response.matchcontests[contestIndex].contests[index].filledSpots)}",
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline
                                                .copyWith(
                                                  color: ColorConstant
                                                      .COLOR_YELLOW,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                          TextSpan(
                                            text: " Spots Left",
                                            style: Theme.of(context)
                                                .textTheme
                                                .overline
                                                .copyWith(
                                                  color: ColorConstant
                                                      .COLOR_YELLOW,
                                                  fontWeight: FontWeight.w600,
                                                ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text:
                                              "${contestTypeModel.response.matchcontests[contestIndex].contests[index].totalSpots}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                                color: ColorConstant.COLOR_GREY,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                        TextSpan(
                                          text: " Spots",
                                          style: Theme.of(context)
                                              .textTheme
                                              .caption
                                              .copyWith(
                                                color: ColorConstant.COLOR_GREY,
                                                fontWeight: FontWeight.w600,
                                              ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              )
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
                IntrinsicHeight(
                  child: Flex(
                    direction: Axis.horizontal,
                    children: [
                      Expanded(
                        flex: 3,
                        child: Container(
                          color: Color(0xfff5f5f5),
                          padding: EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 10.0),
                          child: Flex(
                            direction: Axis.horizontal,
                            children: [
                              Image.asset(
                                ImgConstants.WINNER_TROPHY,
                                width: 12.0,
                                height: 12.0,
                              ),
                              SizedBox(width: 6.0),

                              Text(
                                "₹${contestTypeModel.response.matchcontests[contestIndex].contests[index].firstPrice ?? ""}",
                                style: TextStyle(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                    fontSize: 14.0),
                              ),

                              Spacer(),

                              /*
                                  ! fff
                                  ? ddd

                                   */

                              // Confirmed Contest

                              Visibility(
                                  //    visible: true,
                                  visible: !contestTypeModel
                                          .response
                                          .matchcontests[contestIndex]
                                          .contests[index]
                                          .cancellation ??
                                      false,

                                  // contestTypeModel
                                  //         .response
                                  //         .matchcontests[index]
                                  //         .contests[0]
                                  //         .isCancelled ??
                                  //     false,
                                  child: Container(
                                    padding: const EdgeInsets.all(7.0),
                                    decoration: BoxDecoration(
                                      color: Colors.green,
                                      shape: BoxShape.circle,
                                    ),
                                    child: Text(
                                      "C",
                                      style: TextStyle(
                                        fontSize: 10.0,
                                        color: Colors.white,
                                      ),
                                    ),
                                  )),

                              const SizedBox(
                                width: 4,
                              ),
                              Container(
                                padding: EdgeInsets.only(
                                    left: 4, right: 2, top: 2, bottom: 2),
                                decoration: BoxDecoration(
                                  color: Colors.red,
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Row(
                                  children: [
                                    contestTypeModel
                                                    .response
                                                    .matchcontests[contestIndex]
                                                    .contests[index]
                                                    .maxAllowedTeam !=
                                                null &&
                                            contestTypeModel
                                                    .response
                                                    .matchcontests[contestIndex]
                                                    .contests[index]
                                                    .maxAllowedTeam >
                                                1
                                        ?
                                        // contestTypeDataList[parentIndex].maxEntry !=
                                        //             null &&
                                        //         contestTypeDataList[parentIndex]
                                        //                 .maxEntry >
                                        //             1
                                        //    ?
                                        Row(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 2,
                                                      right: 2,
                                                      top: 2,
                                                      bottom: 2),
                                                  decoration: BoxDecoration(
                                                    //  color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    "M",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                              const SizedBox(width: 4),
                                              Container(
                                                  color: Colors.white,
                                                  padding: EdgeInsets.only(
                                                      left: 4,
                                                      right: 4,
                                                      top: 2,
                                                      bottom: 2),
                                                  child: Text(
                                                      "${contestTypeModel.response.matchcontests[contestIndex].contests[index].maxAllowedTeam}",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      ))),
                                            ],
                                          )
                                        : Row(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.only(
                                                      left: 2,
                                                      right: 2,
                                                      top: 2,
                                                      bottom: 2),
                                                  decoration: BoxDecoration(
                                                    //  color: Colors.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                  ),
                                                  child: Text(
                                                    "S",
                                                    style: TextStyle(
                                                      fontSize: 10,
                                                      color: Colors.white,
                                                    ),
                                                  )),
                                              const SizedBox(width: 4),
                                              Container(
                                                  color: Colors.white,
                                                  padding: EdgeInsets.only(
                                                      left: 4,
                                                      right: 4,
                                                      top: 2,
                                                      bottom: 2),
                                                  child: Text(
                                                      "${contestTypeModel.response.matchcontests[contestIndex].contests[index].maxAllowedTeam}",
                                                      style: TextStyle(
                                                        fontSize: 10,
                                                      ))),
                                            ],
                                          ),
                                  ],
                                ),
                              ),

                              SizedBox(width: 4),
                              if (contestTypeModel
                                      .response
                                      .matchcontests[contestIndex]
                                      .contests[index]
                                      .usableBonus >
                                  0)
                                Container(
                                  padding: EdgeInsets.only(
                                      left: 4, right: 2, top: 2, bottom: 2),
                                  decoration: BoxDecoration(
                                    color: ColorConstant.COLOR_YELLOW,
                                    borderRadius: BorderRadius.circular(4),
                                  ),
                                  child: Row(
                                    children: [
                                      // contestTypeDataList[parentIndex].maxEntry !=
                                      //             null &&
                                      //         contestTypeDataList[parentIndex]
                                      //                 .maxEntry >
                                      // 1
                                      //    ?
                                      Row(
                                        children: [
                                          Container(
                                              padding: EdgeInsets.only(
                                                  left: 2,
                                                  right: 2,
                                                  top: 2,
                                                  bottom: 2),
                                              decoration: BoxDecoration(
                                                //    color: Colors.green,
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                              ),
                                              child: Text(
                                                "B",
                                                style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white,
                                                ),
                                              )),
                                          const SizedBox(width: 4),
                                          Container(
                                              color: Colors.white,
                                              padding: EdgeInsets.only(
                                                  left: 2,
                                                  right: 2,
                                                  top: 2,
                                                  bottom: 2),
                                              child: Text(
                                                  "${contestTypeModel.response.matchcontests[contestIndex].contests[index].usableBonus}%",
                                                  style: TextStyle(
                                                    fontSize: 10,
                                                  ))),
                                        ],
                                      )
                                    ],
                                  ),
                                )
                              // else
                              //   Container(),
                            ],
                          ),
                        ),
                      ),
                      // Container(
                      //   height: 1.0,
                      //   color: ColorConstant.COLOR_LIGHT_GREY,
                      // ),
                      // Container(
                      //   width: MediaQuery.of(context).size.width * 0.20,
                      //   child: InkWell(
                      //     onTap: () {
                      //       if (contestTypeDataList[parentIndex].defaultcontest !=
                      //               null &&
                      //           contestTypeDataList[parentIndex]
                      //                   .defaultcontest
                      //                   .length >
                      //               0)
                      //                {
                      //         // Navigator.pop(context);
                      //         Navigator.push(
                      //             context,
                      //             MaterialPageRoute(
                      //               builder: (context) =>
                      //                   SelectTeamForJoinContest(
                      //                 selectedMatchData: widget.selectedMatchData,
                      //                 selectedContestData:
                      //                     contestTypeDataList[parentIndex]
                      //                         .defaultcontest[index],
                      //                 i: contestTypeDataList[parentIndex]
                      //                         .maxEntry ??
                      //                     0,
                      //               ),
                      //             )).then((value) => getDefaultContestByType());
                      //       }
                      //     },
                      //     child: Container(
                      //       alignment: Alignment.center,
                      //       decoration: BoxDecoration(
                      //         color: ColorConstant.COLOR_THEME_PURPLE,
                      //         borderRadius: BorderRadius.only(
                      //           bottomRight: Radius.circular(8.0),
                      //         ),
                      //       ),
                      //       child: Text(
                      //         contestTypeDataList[parentIndex]
                      //                     .defaultcontest[index]
                      //                     .entryFees ==
                      //                 0
                      //             ? "FREE"
                      //             : "JOIN",
                      //         style: TextStyle(
                      //             color: ColorConstant.COLOR_WHITE,
                      //             fontSize: 14.0,
                      //             fontWeight: FontWeight.bold),
                      //       ),
                      //     ),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
