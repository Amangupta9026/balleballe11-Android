import 'dart:developer';

import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/playing_history_model.dart';
import 'package:balleballe11/widget/shimmerProgressWidget.dart';

class PlayingHistory extends StatefulWidget {
  const PlayingHistory({Key key}) : super(key: key);

  @override
  _PlayingHistoryState createState() => _PlayingHistoryState();
}

class _PlayingHistoryState extends State<PlayingHistory> {
  bool _isProgressRunning = false;
  PlayingHistoryModel playinghistoryData = PlayingHistoryModel();
  Response response = Response();

  @override
  void initState() {
    super.initState();
    playingHistoryShareddata();
    //  _getplayingHistoryMatches();
  }

  void playingHistoryShareddata() {
    playinghistoryData = SharedPreference.getPlayingHistoryData();

    if (playinghistoryData != null) {
      response = playinghistoryData.response;
      // setState(() {
      //   response = playinghistoryData.response;
      // });
    } else if (playinghistoryData == null || response == null) {
      _getplayingHistoryMatches();
    }
  }

  Future<void> _getplayingHistoryMatches() async {
    try {
      setState(() {
        _isProgressRunning = true;
      });
      playinghistoryData = await APIServices.getplayinghistory();
      setState(() {
        response = playinghistoryData.response;
      });
    } catch (error) {
      log("$error", name: "error");
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      if (mounted)
        setState(() {
          _isProgressRunning = false;
        });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _isProgressRunning
        ? ShimmerProgressWidget(count: 8, isProgressRunning: _isProgressRunning)
        : SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(
                  top: 20.0, bottom: 15, left: 10, right: 10),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 15, bottom: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        ImgConstants.CRICKET_ICON,
                                        height: 50,
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      response.totalMatchPlayed != null
                                          ? Text(
                                              "${response.totalMatchPlayed ?? 0}",
                                              textAlign: TextAlign.center,
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText2
                                                  .copyWith(
                                                    color: ColorConstant
                                                        .COLOR_TEXT,
                                                    fontWeight: FontWeight.w500,
                                                  ),
                                            )
                                          : Text("0"),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Match Played",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 15, bottom: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        ImgConstants.BATCH_ICON,
                                        height: 50,
                                        width: 40,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${response.totalContestJoined ?? 0}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Contest Played",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.5,
                          decoration: BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 15, bottom: 15),
                            child: Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.asset(
                                      ImgConstants.WIN_ICON,
                                      height: 50,
                                      width: 50,
                                      color: ColorConstant.COLOR_TEXT,
                                    ),
                                  ],
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "${response.totalMatchWin ?? 0}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Contest Win",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      Expanded(
                        child: Container(
                          width: MediaQuery.of(context).size.width / 2.2,
                          decoration: BoxDecoration(
                            color: ColorConstant.COLOR_WHITE,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 10.0, right: 10, top: 15, bottom: 15),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Image.asset(
                                        ImgConstants.CUP2,
                                        height: 50,
                                        width: 50,
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  width: 5,
                                ),
                                Expanded(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      Text(
                                        "₹${response.totalWinningAmount.toStringAsFixed(2) ?? 0}",
                                        textAlign: TextAlign.center,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Total Winning",
                                        textAlign: TextAlign.center,
                                        maxLines: 2,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2
                                            .copyWith(
                                              color: ColorConstant.COLOR_TEXT,
                                              fontWeight: FontWeight.w500,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          );
  }
}
