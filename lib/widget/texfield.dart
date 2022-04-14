import 'package:balleballe11/constance/packages.dart';

class TextFieldWidget extends StatelessWidget {
  final String labelName;
  final TextEditingController controller1;
  final Function validatormethod1;
  final String initialValue1;

  const TextFieldWidget(
      {Key key,
      this.labelName,
      this.controller1,
      this.validatormethod1,
      this.initialValue1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          labelName,
          style: Theme.of(context).textTheme.bodyText2.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w400,
              ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 35,
          decoration: BoxDecoration(
              color: ColorConstant.COLOR_WHITE,
              border: Border.all(color: Colors.grey)),
          child: Row(
            children: [
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                  child: TextFormField(
                    initialValue: initialValue1,
                    textInputAction: TextInputAction.next,
                    controller: controller1,
                    style: Theme.of(context).textTheme.bodyText1.copyWith(
                        color: ColorConstant.COLOR_BLACK, fontSize: 16.0),
                    validator: validatormethod1(),

                    //  (fullName) {
                    //   if (fullName.isEmpty) {
                    //     return "Fullname is required";
                    //   }
                    //   return null;
                    // },
                    keyboardType: TextInputType.text,
                    decoration: new InputDecoration(
                      border: InputBorder.none,
                      hintStyle: Theme.of(context).textTheme.bodyText2.copyWith(
                            color: ColorConstant.COLOR_TEXT,
                            fontWeight: FontWeight.w400,
                          ),
                      //  hintText: "Full Name",
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
