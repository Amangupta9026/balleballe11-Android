import 'dart:io';

import 'package:balleballe11/balance/verify_document.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class VerifyPanCardDocument extends StatefulWidget {
  const VerifyPanCardDocument({Key key}) : super(key: key);

  @override
  _VerifyPanCardDocumentState createState() => _VerifyPanCardDocumentState();
}

class _VerifyPanCardDocumentState extends State<VerifyPanCardDocument> {
  TextEditingController _PANNameController = TextEditingController();
  TextEditingController _PANCARDNUMBERController = TextEditingController();
  TextEditingController _CONFIRMPANCARDNUMBERController =
      TextEditingController();

  // Aadhar
  TextEditingController _AADHARNAMEController = TextEditingController();
  TextEditingController _AADHARCARDNUMBERController = TextEditingController();
  TextEditingController _CONFIRMAADHARCARDNUMBERController =
      TextEditingController();

  int selectedState = 1;
  int selectedState2;

  File _panimage;

  File _aadharfrontimage;
  File _aadharbackimage;

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
        _panimage = File(image.path);
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
    TabController _tabController;

    return DefaultTabController(
      initialIndex: 1, // default is 0
      length: 2,
      child: Scaffold(
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
                          "Max File Size 5MB",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: ColorConstant.COLOR_RED,
                                fontWeight: FontWeight.w500,
                              ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          "Upload Documents",
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                color: ColorConstant.COLOR_GREY,
                                fontWeight: FontWeight.w500,
                              ),
                        ),

                        const SizedBox(
                          height: 15,
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 38,
                              color: selectedState == 1
                                  ? ColorConstant.COLOR_TEXT
                                  : ColorConstant.COLOR_WHITE,
                              width: MediaQuery.of(context).size.width * 0.28,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: selectedState == 1
                                      ? ColorConstant.COLOR_TEXT
                                      : ColorConstant.COLOR_WHITE,
                                  side: BorderSide(
                                      color: ColorConstant.COLOR_TEXT),
                                ),
                                child: Text(
                                  'PAN',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                        color: selectedState == 1
                                            ? ColorConstant.COLOR_WHITE
                                            : ColorConstant.COLOR_TEXT,
                                        fontWeight: FontWeight.bold,
                                      ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedState = 1;
                                  });
                                },
                              ),
                            ),
                            Text(
                              "OR",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(
                                    color: ColorConstant.COLOR_TEXT,
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),
                            Container(
                              height: 38,
                              width: MediaQuery.of(context).size.width * 0.28,
                              color: selectedState == 1
                                  ? ColorConstant.COLOR_WHITE
                                  : ColorConstant.COLOR_TEXT,
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  primary: ColorConstant.COLOR_TEXT,
                                  side: BorderSide(
                                      width: 1.2,
                                      color: ColorConstant.COLOR_TEXT),
                                ),
                                child: Text(
                                  'AADHAR',
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                        color: selectedState == 1
                                            ? ColorConstant.COLOR_TEXT
                                            : ColorConstant.COLOR_WHITE,
                                        fontWeight: FontWeight.w600,
                                      ),
                                ),
                                onPressed: () {
                                  setState(() {
                                    selectedState = 2;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),

                        Visibility(
                          visible: selectedState == 1,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                  child: TextField(
                                    controller: _PANNameController,
                                    decoration: InputDecoration(
                                      // border: OutlineInputBorder(),
                                      labelText: 'Enter Name (as per Pan)',
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
                              Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  child: TextField(
                                    controller: _PANCARDNUMBERController,
                                    decoration: InputDecoration(
                                      labelText: 'PANCARD NUMBER',
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
                              Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: TextField(
                                    controller: _CONFIRMPANCARDNUMBERController,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm PANCARD NUMBER',
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
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upload Pancard",
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: 90.0,
                                          decoration: new BoxDecoration(
                                            //  shape: BoxShape.circle,

                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: _panimage != null
                                                    ? FileImage(_panimage)
                                                    // : userData.data?.logoUrl != null &&
                                                    // userData.data?.logoUrl != ''
                                                    // ? Image.memory(base64Decode(
                                                    // userData.data?.logoUrl))
                                                    // .image
                                                    : AssetImage(
                                                        ImgConstants
                                                            .CAMERA_ICON,
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
                                    primary: ColorConstant.COLOR_TEXT,
                                    // background
                                    onPrimary:
                                        ColorConstant.COLOR_WHITE, // foreground
                                  ),

                                  // Pan Card
                                  onPressed: () {
                                    if (_PANNameController.text.isEmpty &&
                                        _PANCARDNUMBERController.text.isEmpty &&
                                        _CONFIRMPANCARDNUMBERController
                                            .text.isEmpty) {
                                      UtilsFlushBar.showDefaultSnackbar(context,
                                          "Please enter required field");
                                    } else if (_PANNameController
                                        .text.isEmpty) {
                                      UtilsFlushBar.showDefaultSnackbar(
                                          context, "Please enter PAN Name");
                                    } else if (_PANCARDNUMBERController
                                        .text.isEmpty) {
                                      UtilsFlushBar.showDefaultSnackbar(context,
                                          "Please enter PAN Card Number");
                                    } else if (_CONFIRMPANCARDNUMBERController
                                        .text.isEmpty) {
                                      UtilsFlushBar.showDefaultSnackbar(context,
                                          "Please enter Confirm PAN Card Number");
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25),
                                    child: Text('NEXT'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),

                        // Aadhar Details -

                        Visibility(
                          visible: selectedState == 2,
                          child: Column(
                            children: [
                              Container(
                                  margin: EdgeInsets.fromLTRB(20, 20, 20, 10),
                                  child: TextField(
                                    controller: _AADHARNAMEController,
                                    decoration: InputDecoration(
                                      // border: OutlineInputBorder(),
                                      labelText: 'Enter Name',
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
                              Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 10),
                                  child: TextField(
                                    controller: _AADHARCARDNUMBERController,
                                    decoration: InputDecoration(
                                      labelText: 'AADHARCARD NUMBER',
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
                              Container(
                                  margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: TextField(
                                    controller:
                                        _CONFIRMAADHARCARDNUMBERController,
                                    decoration: InputDecoration(
                                      labelText: 'Confirm AADHARCARD NUMBER',
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
                                padding:
                                    const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Upload Aadharcard Front",
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: 90.0,
                                          decoration: new BoxDecoration(
                                            //  shape: BoxShape.circle,

                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: _aadharfrontimage != null
                                                    ? FileImage(
                                                        _aadharfrontimage)
                                                    // : userData.data?.logoUrl != null &&
                                                    // userData.data?.logoUrl != ''
                                                    // ? Image.memory(base64Decode(
                                                    // userData.data?.logoUrl))
                                                    // .image
                                                    : AssetImage(
                                                        ImgConstants
                                                            .CAMERA_ICON,
                                                      )),
                                          ),
                                        ),
                                        onPressed: () {
                                          _showPickerAadharFront(context);
                                        },
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "Upload Aadharcard Back",
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
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.35,
                                          height: 90.0,
                                          decoration: new BoxDecoration(
                                            //  shape: BoxShape.circle,

                                            image: new DecorationImage(
                                                fit: BoxFit.fill,
                                                image: _aadharbackimage != null
                                                    ? FileImage(
                                                        _aadharbackimage)
                                                    // : userData.data?.logoUrl != null &&
                                                    // userData.data?.logoUrl != ''
                                                    // ? Image.memory(base64Decode(
                                                    // userData.data?.logoUrl))
                                                    // .image
                                                    : AssetImage(
                                                        ImgConstants
                                                            .CAMERA_ICON,
                                                      )),
                                          ),
                                        ),
                                        onPressed: () {
                                          _showPickerAadharBack(context);
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    primary: ColorConstant.COLOR_TEXT,
                                    // background
                                    onPrimary:
                                        ColorConstant.COLOR_WHITE, // foreground
                                  ),
                                  // Aadhar -

                                  onPressed: () {
                                    if (_AADHARNAMEController.text.isEmpty &&
                                        _AADHARCARDNUMBERController
                                            .text.isEmpty &&
                                        _CONFIRMAADHARCARDNUMBERController
                                            .text.isEmpty) {
                                      UtilsFlushBar.showDefaultSnackbar(context,
                                          "Please enter required field");
                                    } else if (_AADHARNAMEController
                                        .text.isEmpty) {
                                      UtilsFlushBar.showDefaultSnackbar(context,
                                          "Please enter Aadhar Card Name");
                                    } else if (_AADHARCARDNUMBERController
                                        .text.isEmpty) {
                                      UtilsFlushBar.showDefaultSnackbar(context,
                                          "Please enter Aadhar Card Number");
                                    } else if (_CONFIRMAADHARCARDNUMBERController
                                        .text.isEmpty) {
                                      UtilsFlushBar.showDefaultSnackbar(context,
                                          "Please enter Confirm Aadhar Card Number");
                                    }
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.only(
                                        left: 25.0, right: 25),
                                    child: Text('NEXT'),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Aadhar Card

  void _showPickerAadharFront(context) {
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
                        await _imgFromAadharGallery();
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

  Future<void> _imgFromAadharGallery() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      XFile image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

      setState(() {
        _aadharfrontimage = File(image.path);
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

  // aadhar Card Back

  void _showPickerAadharBack(context) {
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
                        await _imgFromAadharBackGallery();
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

  Future<void> _imgFromAadharBackGallery() async {
    var status = await Permission.storage.status;
    if (status.isGranted) {
      XFile image =
          await picker.pickImage(source: ImageSource.gallery, imageQuality: 25);

      setState(() {
        _aadharbackimage = File(image.path);
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
}
