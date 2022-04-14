import 'package:balleballe11/balance/addcash.dart';
import 'package:balleballe11/balance/withdrawal_page.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/sports/My%20Accounts/referral_page.dart';

class Balance extends StatefulWidget {
  const Balance({Key key}) : super(key: key);

  @override
  _BalanceState createState() => _BalanceState();
}

class _BalanceState extends State<Balance> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(left: 10.0, right: 10, top: 15, bottom: 15),
        child: Column(
          children: [
            Container(
              color: ColorConstant.COLOR_WHITE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, top: 15, bottom: 15),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          ImgConstants.TRANSACTION_ICON,
                          height: 25,
                          width: 25,
                          color: ColorConstant.COLOR_TEXT,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹${SharedPreference.getValue(PrefConstants.DEPOSIT_AMOUNT) ?? ""}",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Text(
                          "My Deposit",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_GREY,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstant.COLOR_TEXT, // background
                            onPrimary: ColorConstant.COLOR_WHITE, // foreground
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddCash(
                                  walletbalance: SharedPreference.getValue(
                                      PrefConstants.WALLET_AMOUNT),
                                  prizeAmount: SharedPreference.getValue(
                                      PrefConstants.PRIZE_AMOUNT),
                                ),
                              ),
                            );
                          },
                          child: Text(
                            'Add Cash',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Container(
              color: ColorConstant.COLOR_WHITE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15, top: 15, bottom: 15),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Image.asset(
                          ImgConstants.CUP,
                          height: 25,
                          width: 25,
                          color: ColorConstant.COLOR_TEXT,
                        ),
                      ],
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "₹${SharedPreference.getValue(PrefConstants.WINNING_AMOUNT) ?? ""}",
                          style: Theme.of(context).textTheme.bodyText1.copyWith(
                                color: ColorConstant.COLOR_TEXT,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          "Your Winnings",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_GREY,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Text(
                          "Min Withdrawal ₹200",
                          style: Theme.of(context).textTheme.caption.copyWith(
                                color: ColorConstant.COLOR_PINK,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                      ],
                    ),
                    Spacer(),
                    Column(
                      children: [
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstant.COLOR_TEXT, // background
                            onPrimary: ColorConstant.COLOR_WHITE, // foreground
                          ),
                          onPressed: () {
                            if (SharedPreference.getValue(
                                    PrefConstants.WINNING_AMOUNT) >=
                                200) {
                              // bool success = await
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return WithdrawPage(
                                  bankName: SharedPreference.getValue(
                                      PrefConstants.BankName),
                                  bankNumber: SharedPreference.getValue(
                                      PrefConstants.BankAccontNumber),
                                );
                              }));
                            } else {
                              UtilsFlushBar.showDefaultSnackbar(
                                  context, "Amount is less than 200INR");
                            }

                            print('Pressed');
                          },
                          child: Text(
                            'Withdraw',
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      color: ColorConstant.COLOR_WHITE,
                                      fontWeight: FontWeight.w500,
                                    ),
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    color: ColorConstant.COLOR_WHITE,
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                ImgConstants.DOLLAR_ICON,
                                height: 25,
                                width: 25,
                                color: ColorConstant.COLOR_TEXT,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹${SharedPreference.getValue(PrefConstants.BONUS_AMOUNT) ?? ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Cash Bonus",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: ColorConstant.COLOR_GREY,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                          Spacer(),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Expanded(
                  child: Container(
                    color: ColorConstant.COLOR_WHITE,
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10.0, 10, 10, 10),
                      child: Row(
                        children: [
                          Column(
                            children: [
                              Image.asset(
                                ImgConstants.WALLET2,
                                height: 25,
                                width: 25,
                              ),
                            ],
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "₹${SharedPreference.getValue(PrefConstants.TOTAL_AMOUNT).toStringAsFixed(2) ?? ""}",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyText1
                                    .copyWith(
                                      color: ColorConstant.COLOR_TEXT,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                              const SizedBox(
                                height: 2,
                              ),
                              Text(
                                "Total Balance",
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: ColorConstant.COLOR_GREY,
                                      fontWeight: FontWeight.w500,
                                    ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 15,
            ),
            InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RefferalPage(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  color: ColorConstant.COLOR_WHITE,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, bottom: 20, left: 10, right: 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  "You have Referred",
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.wc,
                                    size: 25,
                                    color: ColorConstant.COLOR_TEXT,
                                  ),
                                  const SizedBox(
                                    width: 5,
                                  ),
                                  Text(
                                    "0",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyText1
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                  const SizedBox(
                                    width: 2,
                                  ),
                                  Text(
                                    "Friends",
                                    style: Theme.of(context)
                                        .textTheme
                                        .caption
                                        .copyWith(
                                          color: ColorConstant.COLOR_TEXT,
                                          fontWeight: FontWeight.w500,
                                        ),
                                  ),
                                ],
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Text(
                                  "Earn and Play Maches",
                                  style: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .copyWith(
                                        color: ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.w500,
                                      ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Spacer(),
                        Expanded(
                          child: Column(
                            children: [
                              Image.asset(
                                ImgConstants.REFERRAL,
                                height: 120,
                                width: 150,
                                fit: BoxFit.fill,
                              )
                            ],
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
