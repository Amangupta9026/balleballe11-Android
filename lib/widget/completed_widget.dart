import 'package:balleballe11/constance/packages.dart';
import 'package:flutter/material.dart';

class CompletedWidget extends StatefulWidget {
  final String txt1;
  final String txt2;
  final String txt3;
  final String txt4;
  final Widget setTime;
  final String txt6;
  final String txt7;
  final Image image1;
  final Image image2;

  const CompletedWidget({
    Key key,
    this.txt1,
    this.txt2,
    this.txt3,
    this.txt4,
    this.txt6,
    this.txt7,
    this.image1,
    this.image2,
    this.setTime,
  }) : super(key: key);

  @override
  _CardViewState createState() => _CardViewState();
}

class _CardViewState extends State<CompletedWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navigator.push(
        //   context,
        //   MaterialPageRoute(
        //     builder: (context) => MatchAllContest(null,null),
        //   ),
        // );
      },
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 5,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  color: Theme.of(context).appBarTheme.color.withOpacity(0.5),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.txt1,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.6,
                                  fontSize: 14,
                                ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.notifications_on_outlined)
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.txt2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  widget.txt3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: widget.image1,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  widget.txt4,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                widget.setTime,
                                Expanded(child: SizedBox()),
                                Text(
                                  widget.txt6,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: widget.image2,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              widget.txt7,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                            ),
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 25,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  "Mega",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context).primaryColor,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Icon(
                              Icons.outbox,
                              color: Theme.of(context).primaryColor,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CompleteCardWidget extends StatefulWidget {
  final String txt1;
  final String txt2;
  final String txt3;
  final String teamCount;
  final String contestCount;
  final String prizeWin;
  final String timerset;
  final String statusNote;
  final String status;
  final String image1;
  final String image2;
  final Function onClick;

  const CompleteCardWidget(
      {Key key,
      this.txt1,
      this.txt2,
      this.txt3,
      this.timerset,
      this.statusNote,
      this.status,
      this.image1,
      this.image2,
      this.onClick,
      this.teamCount,
      this.contestCount,
      this.prizeWin})
      : super(key: key);

  @override
  _CompleteCardWidgetState createState() => _CompleteCardWidgetState();
}

class _CompleteCardWidgetState extends State<CompleteCardWidget> {
//  MatchesModel _matchData = MatchesModel();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onClick,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          // decoration: BoxDecoration(
          //   border: Border.all(color: ColorConstant.COLOR_GREEN, width: 0.8),
          //   borderRadius: BorderRadius.circular(10),

          child: Flex(
            direction: Axis.vertical,
            //   crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.only(left: 15.0, right: 15, top: 12),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      widget.txt1,
                      softWrap: true,
                      style: TextStyle(
                          color: ColorConstant.COLOR_TEXT,
                          fontSize: 13.0,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                    Text(
                      widget.status,
                      softWrap: true,
                      style: TextStyle(
                          color: ColorConstant.COLOR_TEXT,
                          fontSize: 12.0,
                          fontWeight: FontWeight.w500),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              Divider(
                thickness: 0.35,
                color: Colors.grey,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.fromLTRB(10, 0, 10, 5),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        CachedNetworkImage(
                          imageUrl: widget.image1,
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
                        // Container(
                        //   height: 48,
                        //   width: 48,
                        //   child: widget.image1,
                        // ),
                        SizedBox(width: 10),
                        Text(
                          widget.txt2,
                          style: TextStyle(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0),
                        ),
                        Expanded(child: Container()),
                        Row(
                          children: [
                            SizedBox(height: 10),
                          ],
                        ),
                        Expanded(child: Container()),
                        Text(
                          widget.txt3,
                          style: TextStyle(
                              color: ColorConstant.COLOR_TEXT,
                              fontWeight: FontWeight.w400,
                              fontSize: 14.0),
                        ),
                        SizedBox(width: 10),

                        CachedNetworkImage(
                          imageUrl: widget.image2,
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
                        // Container(
                        //   height: 48,
                        //   width: 48,
                        //   child: widget.image2,
                        // ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          widget.timerset,
                          style: TextStyle(
                              color: ColorConstant.COLOR_TEXT,
                              fontSize: 14.0,
                              fontWeight: FontWeight.w400),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Text(
                              widget.teamCount,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_TEXT,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400),
                            ),
                            const SizedBox(
                              width: 5,
                            ),
                            Text(
                              widget.contestCount,
                              style: TextStyle(
                                  color: ColorConstant.COLOR_BLACK,
                                  fontSize: 14.0,
                                  fontWeight: FontWeight.w800),
                            ),
                            const SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Contest",
                              style: TextStyle(
                                  color: ColorConstant.COLOR_BLACK,
                                  fontSize: 12.0,
                                  fontWeight: FontWeight.w400),
                            ),
                          ],
                        ),
                        Text(
                          widget.prizeWin,
                          style: TextStyle(
                              color: ColorConstant.COLOR_GREEN,
                              fontSize: 14.0,
                              letterSpacing: 0.3,
                              fontWeight: FontWeight.w900),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );

    return InkWell(
      onTap: widget.onClick,
      child: Row(
        children: [
          Expanded(
            child: Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                height: 150,
                decoration: BoxDecoration(
                  border:
                      Border.all(color: ColorConstant.COLOR_GREEN, width: 0.8),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 10, right: 10, top: 5, bottom: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            widget.txt1,
                            softWrap: true,
                            overflow: TextOverflow.fade,
                            style: Theme.of(context).textTheme.caption.copyWith(
                                  color:
                                      Theme.of(context).textTheme.caption.color,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 0.6,
                                  fontSize: 14,
                                ),
                          ),
                          Expanded(child: SizedBox()),
                          Icon(Icons.notifications_on_outlined)
                        ],
                      ),
                    ),
                    Divider(),
                    Container(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              left: 10,
                              right: 10,
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  widget.txt2,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  widget.txt3,
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .color,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 14,
                                      ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5, right: 5),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CachedNetworkImage(
                                  imageUrl: widget.image1,
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
                                    return Image.asset(
                                        ImgConstants.DEFAULT_PLAYER,
                                        width: 40.0,
                                        height: 40.0);
                                  },
                                ),
                                // Container(
                                //   height: 35,
                                //   width: 35,
                                //   child: widget.image1,
                                // ),
                                SizedBox(
                                  width: 10,
                                ),
                                Expanded(child: SizedBox()),
                                Container(
                                  padding: EdgeInsets.all(3.0),
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: ColorConstant.COLOR_TEXT,
                                    ),
                                    borderRadius: BorderRadius.circular(4.0),
                                  ),
                                  child: Row(
                                    children: [
                                      SizedBox(width: 6.0),
                                    ],
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                SizedBox(
                                  width: 10,
                                ),

                                CachedNetworkImage(
                                  imageUrl: widget.image2,
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
                                    return Image.asset(
                                        ImgConstants.DEFAULT_PLAYER,
                                        width: 40.0,
                                        height: 40.0);
                                  },
                                ),
                                // Container(
                                //   height: 35,
                                //   width: 35,
                                //   child: widget.image2,
                                // ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(child: SizedBox()),
                    Container(
                      height: 35,
                      decoration: BoxDecoration(
                        color: Theme.of(context).disabledColor.withOpacity(0.2),
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(10),
                          bottomRight: Radius.circular(10),
                        ),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          left: 10,
                          right: 10,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SizedBox(
                              width: 5,
                            ),
                            Container(
                              height: 25,
                              width: 60,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(4),
                                border: Border.all(
                                  color: ColorConstant.COLOR_RED,
                                ),
                              ),
                              child: Center(
                                child: Text(
                                  AppLocalizations.of('Mega'),
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: ColorConstant.COLOR_RED,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 0.6,
                                        fontSize: 12,
                                      ),
                                ),
                              ),
                            ),
                            Expanded(child: SizedBox()),
                            Icon(
                              Icons.outbox,
                              color: ColorConstant.COLOR_RED,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
