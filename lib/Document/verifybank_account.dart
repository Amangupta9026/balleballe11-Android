import 'dart:convert';
import 'dart:io';

import 'package:balleballe11/constance/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class VerifyBankAccount extends StatefulWidget {
  const VerifyBankAccount({Key key}) : super(key: key);

  @override
  _VerifyBankAccountState createState() => _VerifyBankAccountState();
}

class _VerifyBankAccountState extends State<VerifyBankAccount> {
  TextEditingController _BankNameController = TextEditingController();
  TextEditingController _AccountHolderController = TextEditingController();
  TextEditingController _AccountNumberController = TextEditingController();
  TextEditingController _ConfirmAccountNumberController =
      TextEditingController();
  TextEditingController _IfscCodeController = TextEditingController();
  TextEditingController _AccountTypeController = TextEditingController();

  File _image;
  final ImagePicker picker = ImagePicker();

  String base64Image;

  void _showPicker(context) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
              title: Text("Add Photo!"),
              content: SingleChildScrollView(
                child: ListBody(
                  children: <Widget>[
                    GestureDetector(
                      child: Text("Choose from Gallery"),
                      onTap: () async {
                        await _imgFromGallery();
                        Navigator.of(context).pop();
                      },
                    ),
                    Padding(padding: EdgeInsets.all(8.0)),
                    GestureDetector(
                      child: Text("Cancel"),
                      onTap: () {
                        Navigator.pop(context);
                      },
                    )
                  ],
                ),
              ));
        });
  }

  Future<void> _imgFromGallery() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      XFile image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

      setState(() {
        _image = File(image.path);
      });
    } else {
      var permissionResult = await Permission.storage.request();
      if (permissionResult.isDenied || permissionResult.isPermanentlyDenied) {
        showDialog(
            context: context,
            builder: (BuildContext context) => CupertinoAlertDialog(
                  title: Text('Storage Permission'),
                  content: Text(
                      'This app needs storage access to take pictures for upload user profile photo'),
                  actions: <Widget>[
                    CupertinoDialogAction(
                      child: Text('Deny'),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                    CupertinoDialogAction(
                      child: Text('Settings'),
                      onPressed: () => openAppSettings(),
                    ),
                  ],
                ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstant.BACKGROUND_COLOR,
      appBar: AppBar(
        backgroundColor: ColorConstant.COLOR_WHITE,
        leading: InkWell(
          onTap: () {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 25,
            color: ColorConstant.COLOR_TEXT,
          ),
        ),
        title: Text(
          "Verify Documents",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.w500,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                decoration: BoxDecoration(color: ColorConstant.COLOR_WHITE),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15.0, 22, 15, 22),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Bank Account Details",
                        style: Theme.of(context).textTheme.subtitle1.copyWith(
                              color: ColorConstant.COLOR_GREY,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Container(
                          child: TextField(
                        controller: _BankNameController,
                        decoration: InputDecoration(
                          // border: OutlineInputBorder(),
                          labelText: 'Bank Name',
                          labelStyle:
                              Theme.of(context).textTheme.subtitle2.copyWith(
                                    color: ColorConstant.COLOR_GREY,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        onChanged: (text) {
                          setState(() {
                            //   fullName = text;
                            //fullName = nameController.text;
                          });
                        },
                      )),
                      Container(
                          child: TextField(
                        controller: _AccountHolderController,
                        decoration: InputDecoration(
                          labelText: 'Account holder name',
                          labelStyle:
                              Theme.of(context).textTheme.subtitle2.copyWith(
                                    color: ColorConstant.COLOR_GREY,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        onChanged: (text) {
                          setState(() {
                            //   fullName = text;

                            //fullName = nameController.text;
                          });
                        },
                      )),
                      Container(
                          child: TextField(
                        controller: _AccountNumberController,
                        decoration: InputDecoration(
                          labelText: 'Account NUMBER',
                          labelStyle:
                              Theme.of(context).textTheme.subtitle2.copyWith(
                                    color: ColorConstant.COLOR_GREY,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        onChanged: (text) {
                          setState(() {
                            //   fullName = text;

                            //fullName = nameController.text;
                          });
                        },
                      )),
                      Container(
                          child: TextField(
                        controller: _ConfirmAccountNumberController,
                        decoration: InputDecoration(
                          labelText: 'Confirm Account NUMBER',
                          labelStyle:
                              Theme.of(context).textTheme.subtitle2.copyWith(
                                    color: ColorConstant.COLOR_GREY,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        onChanged: (text) {
                          setState(() {
                            //   fullName = text;

                            //fullName = nameController.text;
                          });
                        },
                      )),
                      Container(
                          child: TextField(
                        controller: _IfscCodeController,
                        decoration: InputDecoration(
                          labelText: 'IFSC CODE',
                          labelStyle:
                              Theme.of(context).textTheme.subtitle2.copyWith(
                                    color: ColorConstant.COLOR_GREY,
                                    fontWeight: FontWeight.w500,
                                  ),
                        ),
                        onChanged: (text) {
                          setState(() {
                            //   fullName = text;

                            //fullName = nameController.text;
                          });
                        },
                      )),
                      Container(
                          margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                          child: TextField(
                            controller: _AccountTypeController,
                            decoration: InputDecoration(
                              labelText: 'Account Type (saving/current)',
                              labelStyle: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: ColorConstant.COLOR_GREY,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            onChanged: (text) {
                              setState(() {
                                //   fullName = text;

                                //fullName = nameController.text;
                              });
                            },
                          )),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Upload CHEQUE/PASSBOOK",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Container(
                              width: double.infinity,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: ColorConstant.COLOR_GREEN,
                                  side: BorderSide(
                                      width: 1.2,
                                      color: ColorConstant.COLOR_GREEN),
                                ),
                                child: new Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.35,
                                  height: 90.0,
                                  decoration: new BoxDecoration(
                                    //  shape: BoxShape.circle,

                                    image: new DecorationImage(
                                        fit: BoxFit.fill,
                                        image: _image != null
                                            ? FileImage(_image)
                                            // : userData.data?.logoUrl != null &&
                                            // userData.data?.logoUrl != ''
                                            // ? Image.memory(base64Decode(
                                            // userData.data?.logoUrl))
                                            // .image
                                            : AssetImage(
                                                ImgConstants.CAMERA_ICON,
                                              )),
                                  ),
                                ),
                                onPressed: () {
                                  _showPicker(context);
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: ColorConstant.COLOR_TEXT, // background
                            onPrimary: ColorConstant.COLOR_WHITE, // foreground
                          ),
                          onPressed: () {
                            if (_BankNameController.text.isEmpty &&
                                _AccountHolderController.text.isEmpty &&
                                _AccountNumberController.text.isEmpty &&
                                _ConfirmAccountNumberController.text.isEmpty &&
                                _IfscCodeController.text.isEmpty &&
                                _AccountTypeController.text.isEmpty) {
                              UtilsFlushBar.showDefaultSnackbar(
                                  context, "Please enter required field");
                            } else if (_BankNameController.text.isEmpty) {
                              UtilsFlushBar.showDefaultSnackbar(
                                  context, "Please enter Bank Name");
                            } else if (_AccountHolderController.text.isEmpty) {
                              UtilsFlushBar.showDefaultSnackbar(
                                  context, "Please enter Account Holder Name");
                            } else if (_AccountNumberController.text.isEmpty) {
                              UtilsFlushBar.showDefaultSnackbar(
                                  context, "Please enter Account Number");
                            } else if (_ConfirmAccountNumberController
                                .text.isEmpty) {
                              UtilsFlushBar.showDefaultSnackbar(context,
                                  "Please enter Confirm Account Number");
                            } else if (_IfscCodeController.text.isEmpty) {
                              UtilsFlushBar.showDefaultSnackbar(
                                  context, "Please enter IFSC Code");
                            } else if (_AccountTypeController.text.isEmpty) {
                              UtilsFlushBar.showDefaultSnackbar(
                                  context, "Please enter Account Type");
                            }
                          },
                          child: Padding(
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25),
                            child: Text('NEXT'),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
