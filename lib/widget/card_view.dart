import 'package:balleballe11/Language/appLocalizations.dart';
import 'package:balleballe11/constance/color_constant.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:flutter/material.dart';

class CardView extends StatefulWidget {
  final String txt1;
  final String txt2;
  final String txt3;
  final String txt4;
  final Widget setTime;
  final String txt6;
  final String txt7;
  final Image image1;
  final Image image2;

  const CardView({
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

class _CardViewState extends State<CardView> {
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

class CompleteCardView extends StatefulWidget {
  final Widget countDown;
  final String txt1;
  final String txt2;
  final String txt3;

  final String txt5;

  final String status;
  final CachedNetworkImage image1;
  final CachedNetworkImage image2;
  final Function onClick;

  const CompleteCardView(
      {Key key,
      this.countDown,
      this.txt1,
      this.txt2,
      this.txt3,
      this.status,
      this.image1,
      this.image2,
      this.txt5,
      this.onClick})
      : super(key: key);

  @override
  _CompleteCardViewState createState() => _CompleteCardViewState();
}

class _CompleteCardViewState extends State<CompleteCardView> {
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 5,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10),
                child: Text(
                  widget.txt1 ?? "",
                  style: TextStyle(
                      color: ColorConstant.COLOR_BLACK,
                      fontWeight: FontWeight.w500,
                      fontSize: 14.0),
                ),
              ),
              // const SizedBox(
              //   height: 3,
              // ),
              Divider(
                thickness: 0.35,
                color: Colors.grey,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(horizontal: 10.0),
                child: Flex(
                  direction: Axis.vertical,
                  children: [
                    Flex(
                      direction: Axis.horizontal,
                      children: [
                        Container(
                          height: 48,
                          width: 48,
                          child: widget.image1,
                        ),
                        SizedBox(width: 10),
                        Text(
                          widget.txt2,
                          style: TextStyle(
                              color: ColorConstant.COLOR_BLACK,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0),
                        ),
                        Expanded(child: Container()),
                        Expanded(child: Container()),
                        Text(
                          widget.txt3,
                          style: TextStyle(
                              color: ColorConstant.COLOR_BLACK,
                              fontWeight: FontWeight.w800,
                              fontSize: 14.0),
                        ),
                        SizedBox(width: 10),
                        Container(
                          height: 48,
                          width: 48,
                          child: widget.image2,
                        ),
                      ],
                    ),
                    Center(
                      child: Text(
                        widget.txt5,
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              color: ColorConstant.COLOR_GREEN,
                              // widget.status == "1" || widget.status == "2"
                              //     ? ColorConstant.COLOR_GREEN
                              //     : widget.status == "3"
                              //         ? ColorConstant.COLOR_YELLOW
                              //         : ColorConstant.COLOR_RED,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.6,
                              fontSize: 15.0,
                            ),
                      ),
                    ),
                    SizedBox(height: 30.0),
                    // Padding(
                    //   padding: const EdgeInsets.only(bottom: 3.0),
                    //   child: Container(
                    //     decoration: BoxDecoration(
                    //       borderRadius: BorderRadius.only(
                    //         topRight: Radius.circular(10.0),
                    //         topLeft: Radius.circular(10.0),
                    //       ),
                    //       color: ColorConstant.COLOR_LIGHT_GREY,
                    //     ),
                    //     padding: EdgeInsets.only(
                    //         left: 5, right: 5, top: 8, bottom: 8),
                    //     child: widget.countDown,
                    //   ),
                    // ),
                  ],
                ),
              ),
              // Visibility(
              //   visible: widget.status == "2",
              //   child: Container(
              //     width: MediaQuery.of(context).size.width,
              //     padding: EdgeInsets.all(10.0),
              //     decoration: BoxDecoration(
              //       color: ColorConstant.COLOR_LIGHT_GREY,
              //       borderRadius: BorderRadius.only(
              //         bottomLeft: Radius.circular(10.0),
              //         bottomRight: Radius.circular(10.0),
              //       ),
              //     ),
              //     child: Text(
              //       "${widget.statusNote}",
              //       softWrap: true,
              //       overflow: TextOverflow.fade,
              //       style: Theme.of(context).textTheme.caption.copyWith(
              //             color: Theme.of(context).textTheme.caption.color,
              //             fontWeight: FontWeight.bold,
              //             letterSpacing: 0.6,
              //             fontSize: 14,
              //           ),
              //       textAlign: TextAlign.center,
              //     ),
              //   ),
              // ),
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
                            "xx",
                            //  widget.txt1,
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
                                Container(
                                  height: 35,
                                  width: 35,
                                  child: widget.image1,
                                ),
                                SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "cc",
                                  //  widget.txt4,
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
                                      Container(
                                        padding: EdgeInsets.all(4.0),
                                        decoration: BoxDecoration(
                                          color: widget.txt5 == "Playing"
                                              ? ColorConstant.COLOR_GREEN
                                              : ColorConstant.COLOR_RED,
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      SizedBox(width: 6.0),
                                      Text(
                                        widget.txt5,
                                        style: Theme.of(context)
                                            .textTheme
                                            .caption
                                            .copyWith(
                                              color: widget.txt5 == "Playing"
                                                  ? ColorConstant.COLOR_GREEN
                                                  : ColorConstant.COLOR_RED,
                                              fontWeight: FontWeight.bold,
                                              letterSpacing: 0.6,
                                              fontSize: 15.0,
                                            ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(child: SizedBox()),
                                Text(
                                  "aaaa",
                                  //  widget.txt6,
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
                              "ccccccccccc",
                              //   widget.txt7,
                              style:
                                  Theme.of(context).textTheme.caption.copyWith(
                                        color: ColorConstant.COLOR_RED,
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
