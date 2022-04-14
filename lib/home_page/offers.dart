import 'package:balleballe11/constance/packages.dart';

class OFFERS extends StatelessWidget {
  const OFFERS({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.COLOR_TEXT_LIGHT,
        ),
        child: Column(
          children: [
            Padding(
              padding:
                  EdgeInsets.only(left: 15, right: 15, top: 15, bottom: 80),
              child: Column(
                children: [
                  Column(
                    children: [
                      Text(
                        "Welcome Bonus on Sign Up",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.COLOR_BUTTON2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 22.0, bottom: 22),
                          child: Column(
                            children: [
                              Image.asset(
                                ImgConstants.CUP2,
                                width: 40,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                height: 15,
                              ),
                              Text(
                                "Get ₹500 Bonus on sign up",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Column(
                    children: [
                      Text(
                        "100% Bonus on First Deposit",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headline5.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: ColorConstant.COLOR_BUTTON2,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(top: 22.0, bottom: 22),
                          child: Column(
                            children: [
                              Text(
                                "Get 75% Bonus on 2nd deposit",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Get 65% Bonus on 3rd deposit",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                              const SizedBox(
                                height: 6,
                              ),
                              Text(
                                "Get 40% Bonus on 4th deposit",
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .subtitle1
                                    .copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w600,
                                    ),
                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Special Deposit Offers",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline5.copyWith(
                          color: ColorConstant.COLOR_WHITE,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Wrap(
                    children: [
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            decoration: BoxDecoration(
                              color: ColorConstant.COLOR_BUTTON2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 15.0, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "DEPOSIT ₹5,000",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Get ₹5,000 Extra Cash",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Get ₹5,000 Extra Cash",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        width: 15,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Column(
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width / 2.4,
                            decoration: BoxDecoration(
                              color: ColorConstant.COLOR_BUTTON2,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 12, right: 12, top: 15.0, bottom: 15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    "DEPOSIT ₹10,000",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle1
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.bold,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Get ₹10,000 Extra Cash",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(
                                    "Get ₹10,000 Extra Cash",
                                    style: Theme.of(context)
                                        .textTheme
                                        .subtitle2
                                        .copyWith(
                                          color: ColorConstant.COLOR_WHITE,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: ColorConstant.COLOR_TEXT,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstant.COLOR_TEXT, // background
                        // foreground
                      ),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ReferEarn(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(
                            ImgConstants.balleballe11_DEFAULT_IMAGE,
                            height: 40,
                            width: 40,
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                          Flexible(
                            child: Text(
                              'REFERRAL PROGRAMS CHECK NOW',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: ColorConstant.COLOR_WHITE,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
