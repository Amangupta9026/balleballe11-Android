import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:balleballe11/constance/icon_constants.dart';
import 'package:balleballe11/constance/packages.dart';
import 'package:balleballe11/model/getUserModel.dart';
import 'package:balleballe11/model/profilepicture_model.dart';
import 'package:balleballe11/widget/gender.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as path;
import 'package:permission_handler/permission_handler.dart';

import '../model/updateProfile_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateProfile extends StatefulWidget {
  const UpdateProfile({Key key}) : super(key: key);

  @override
  State<UpdateProfile> createState() => _UpdateProfileState();
}

class _UpdateProfileState extends State<UpdateProfile> {
  final ImagePicker picker = ImagePicker();
  File _image;
  DateTime _selectedDate;

  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _mobileController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _stateController = TextEditingController();
  TextEditingController _genderController = TextEditingController();
  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _teamNameController = TextEditingController();
  TextEditingController _cityController = TextEditingController();

  Future<void> _setUserData() async {
    _fullNameController.text =
        SharedPreference.getValue(PrefConstants.USER_NAME);
    _mobileController.text =
        SharedPreference.getValue(PrefConstants.USER_MOB_NO);
    _emailController.text = SharedPreference.getValue(PrefConstants.USER_EMAIL);
    _textEditingController.text =
        SharedPreference.getValue(PrefConstants.USER_DOB);
    _teamNameController.text =
        SharedPreference.getValue(PrefConstants.TEAM_NAME);
    _cityController.text = SharedPreference.getValue(PrefConstants.CITY);
  }

  String base64Image;
  bool _isProgressRunning = false;
  bool isProgressRunning = false;
  GetUserModel userData = GetUserModel();
  // UpdateProfileModel postData = UpdateProfileModel();
  String _selectedGender;

  @override
  void initState() {
    super.initState();
    _getUserData();
    _setUserData();
  }

  Future<void> _getUserData() async {
    try {
      setState(() {
        isProgressRunning = true;
      });
      GetUserModel getDataModel = await APIServices.getUserData();
      if (getDataModel.status != null && getDataModel.data != null) {
        userData = getDataModel;

        print(userData.data.name);

        // here comment

        // if (userData.data.stateId != null || userData.data.stateId != '') {
        //   _selectedState = userData.data.stateId ?? "Select state";
        // } else {
        //   _selectedState = "Select state";
        // }
        _selectedGender = userData.data.gender ?? "0";
      }
    } catch (e) {
      showErrorDialog(context, "Server not reachable, Please Contact Admin");
    } finally {
      if (mounted) {
        setState(() {
          isProgressRunning = false;
        });
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
            color: ColorConstant.COLOR_TEXT,
          ),
        ),
        title: Text(
          "Update Profile",
          style: Theme.of(context).textTheme.headline6.copyWith(
                color: ColorConstant.COLOR_TEXT,
                fontWeight: FontWeight.bold,
              ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            Center(
                child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Stack(alignment: Alignment.bottomLeft, children: [
                  InkWell(
                    onTap: () {
                      showAlertDialog(context);
                    },
                    child: new Container(
                      width: 80.0,
                      height: 80.0,
                      decoration: new BoxDecoration(
                        shape: BoxShape.circle,
                        color: ColorConstant.COLOR_WHITE,
                        image: new DecorationImage(
                            fit: BoxFit.fill,
                            image: _image != null
                                ? FileImage(_image)
                                : userData.data?.profileImage != null &&
                                        userData.data?.profileImage != ''
                                    ? Image.network(
                                        userData?.data?.profileImage,
                                        errorBuilder: (BuildContext context,
                                            Object exception,
                                            StackTrace stackTrace) {
                                          return Image.asset(
                                              ImgConstants.DEFAULT_PLAYER);
                                        },
                                      ).image

                                    //  Image.memory(base64Decode(
                                    //         userData.data?.profileImage))
                                    //     .image
                                    : AssetImage(ImgConstants.DEFAULT_PLAYER)),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 35,
                    right: 0,
                    child: InkWell(
                      onTap: () async {
                        showAlertDialog(context);
                      },
                      child: Container(
                        color: ColorConstant.COLOR_TEXT,
                        //padding: EdgeInsets.fromLTRB(2, 1, 2, 1),
                        child: Icon(
                          Icons.edit,
                          color: ColorConstant.COLOR_WHITE,
                          size: 18.0,
                        ),
                      ),
                    ),
                  )
                ]),
              ],
            )),

            // TextField

            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                //mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "Team Name (Nick Name)",
                    style: Theme.of(context).textTheme.caption.copyWith(
                          color: Colors.grey,
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
                              textInputAction: TextInputAction.next,
                              controller: _teamNameController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontSize: 16.0),
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Name",
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
                              textInputAction: TextInputAction.next,
                              controller: _fullNameController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontSize: 16.0),
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // TextField Email

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Email",
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
                              enabled: false,
                              textInputAction: TextInputAction.next,
                              controller: _emailController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontSize: 16.0),
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Mobile

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Mobile",
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
                              textInputAction: TextInputAction.next,
                              controller: _mobileController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontSize: 16.0),
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Gender

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Gender",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),

                  // GenderField(['Male', 'Female']),

                  Container(
                    height: 35,
                    decoration: BoxDecoration(
                        color: ColorConstant.COLOR_WHITE,
                        border: Border.all(color: Colors.grey)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(height: 35, color: Colors.grey, width: 0.5),
                        Flexible(
                          child: Container(
                            width: double.infinity,
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(6, 0, 0, 0),
                              child: DropdownButton<String>(
                                icon: null,
                                iconSize: 0.0,
                                isExpanded: true,
                                underline: Container(),
                                hint: Text("Select Gender"),
                                items: <String>[
                                  // 'Male',
                                  // 'Female',
                                  // 'Others'
                                  '0',
                                  '1',
                                  '2',
                                ].map((String value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(value == '0'
                                        ? 'Male'
                                        : value == '1'
                                            ? 'Female'
                                            : 'Others'),
                                  );
                                }).toList(),
                                onChanged: (data) {
                                  setState(() {
                                    _selectedGender = data;
                                  });
                                },
                                value: _selectedGender,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Date of Birth

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Date of Birth",
                    style: Theme.of(context).textTheme.bodyText2.copyWith(
                          color: ColorConstant.COLOR_TEXT,
                          fontWeight: FontWeight.w400,
                        ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
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
                                enabled: false,
                                controller: _textEditingController,
                                onTap: () {
                                  _selectDate(context);
                                },
                                decoration: new InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: new TextStyle(color: Colors.grey),
                                  hintText: "BirthDate",
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // City

                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "City",
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
                              textInputAction: TextInputAction.next,
                              controller: _cityController,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(
                                      color: ColorConstant.COLOR_BLACK,
                                      fontSize: 16.0),
                              keyboardType: TextInputType.text,
                              decoration: new InputDecoration(
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Action Button Upload Profile

                  const SizedBox(
                    height: 15,
                  ),

                  Container(
                    width: double.infinity,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        primary: ColorConstant.COLOR_TEXT, // background
                      ),
                      onPressed: () async {
                        ProfilePictureModel profilePictureUpdate;
                        //  ProfilePictureModel res1;
                        if (_image != null) {
                          File imageFile = File(_image.path);
                          List<int> imageBytes = imageFile.readAsBytesSync();
                          base64Image = base64.encode(imageBytes);

                          ProfilePictureModel res1 = await sendForm(
                              'https://developer.fan11.in/api/sf/uploadbase64Image',
                              {
                                'image_bytes': base64Image,
                                'user_id': SharedPreference.getValue(
                                    PrefConstants.USER_ID),
                                'documents_type': 'profile'
                              },
                              {
                                'profile': imageFile
                              });
                          //  print("res-1 ${res1.imageUrl}");

                          // profilePictureUpdate =
                          //     await APIServices.profilepicture(
                          //         base64Image, "profile");
                          // log("profile update picture ${profilePictureUpdate.imageUrl}");

                          UpdateProfileModel postData =
                              await APIServices.UpdateProfile(
                                  _cityController.text,
                                  _textEditingController.text,
                                  _selectedGender,
                                  // base64Image,
                                  res1.imageUrl,
                                  _mobileController.text,
                                  _fullNameController.text,
                                  _teamNameController.text);
                          //  log("final image ${profilePictureUpdate.imageUrl}");

                          if (postData.status == true) {
                            await SharedPreferences.getInstance().then((value) {
                              if (_fullNameController.text ==
                                      value
                                          .getString(PrefConstants.USER_NAME) &&
                                  _fullNameController.text.isEmpty) {
                              } else {
                                value.remove(PrefConstants.USER_NAME).then(
                                    (done) => done
                                        ? value
                                            .setString(PrefConstants.USER_NAME,
                                                _fullNameController.text)
                                            .then((value) => null)
                                        : null);
                              }

                              if (_selectedGender ==
                                      value.getString(
                                          PrefConstants.USER_GENDER) &&
                                  _selectedGender.isEmpty) {
                              } else {
                                value.remove(PrefConstants.USER_GENDER).then(
                                    (done) => done
                                        ? value
                                            .setString(
                                                PrefConstants.USER_GENDER,
                                                _selectedGender)
                                            .then((value) => null)
                                        : null);
                              }
                              if (_textEditingController.text ==
                                      value.getString(PrefConstants.USER_DOB) &&
                                  _textEditingController.text.isEmpty) {
                              } else {
                                value.remove(PrefConstants.USER_DOB).then(
                                    (done) => done
                                        ? value
                                            .setString(PrefConstants.USER_DOB,
                                                _textEditingController.text)
                                            .then((value) => null)
                                        : null);
                              }

                              if (_teamNameController.text ==
                                      value
                                          .getString(PrefConstants.TEAM_NAME) &&
                                  _teamNameController.text.isEmpty) {
                              } else {
                                value.remove(PrefConstants.TEAM_NAME).then(
                                    (done) => done
                                        ? value
                                            .setString(PrefConstants.TEAM_NAME,
                                                _teamNameController.text)
                                            .then((value) => null)
                                        : null);
                              }

                              if (_mobileController.text ==
                                      value.getString(
                                          PrefConstants.USER_MOB_NO) &&
                                  _mobileController.text.isEmpty) {
                              } else {
                                value.remove(PrefConstants.USER_MOB_NO).then(
                                    (done) => done
                                        ? value
                                            .setString(
                                                PrefConstants.USER_MOB_NO,
                                                _mobileController.text)
                                            .then((value) => null)
                                        : null);
                              }

                              if (_cityController.text ==
                                      value.getString(PrefConstants.CITY) &&
                                  _cityController.text.isEmpty) {
                              } else {
                                value.remove(PrefConstants.CITY).then((done) =>
                                    done
                                        ? value
                                            .setString(PrefConstants.CITY,
                                                _cityController.text)
                                            .then((value) => null)
                                        : null);
                              }
                            });

                            showUpdateAlertDialog(
                                context, "${postData.message}");
                          }
                        } else {
                          if (userData?.data?.profileImage != null) {
                            UpdateProfileModel postData =
                                await APIServices.UpdateProfile(
                                    _cityController.text,
                                    _textEditingController.text,
                                    _selectedGender,
                                    // base64Image,
                                    userData?.data?.profileImage,
                                    _mobileController.text,
                                    _fullNameController.text,
                                    _teamNameController.text);
                            if (postData.status == true) {
                              await SharedPreferences.getInstance()
                                  .then((value) {
                                if (_fullNameController.text ==
                                        value.getString(
                                            PrefConstants.USER_NAME) &&
                                    _fullNameController.text.isEmpty) {
                                } else {
                                  value.remove(PrefConstants.USER_NAME).then(
                                      (done) => done
                                          ? value
                                              .setString(
                                                  PrefConstants.USER_NAME,
                                                  _fullNameController.text)
                                              .then((value) => null)
                                          : null);
                                }

                                if (_selectedGender ==
                                        value.getString(
                                            PrefConstants.USER_GENDER) &&
                                    _selectedGender.isEmpty) {
                                } else {
                                  value.remove(PrefConstants.USER_GENDER).then(
                                      (done) => done
                                          ? value
                                              .setString(
                                                  PrefConstants.USER_GENDER,
                                                  _selectedGender)
                                              .then((value) => null)
                                          : null);
                                }
                                if (_textEditingController.text ==
                                        value.getString(
                                            PrefConstants.USER_DOB) &&
                                    _textEditingController.text.isEmpty) {
                                } else {
                                  value.remove(PrefConstants.USER_DOB).then(
                                      (done) => done
                                          ? value
                                              .setString(PrefConstants.USER_DOB,
                                                  _textEditingController.text)
                                              .then((value) => null)
                                          : null);
                                }

                                if (_teamNameController.text ==
                                        value.getString(
                                            PrefConstants.TEAM_NAME) &&
                                    _teamNameController.text.isEmpty) {
                                } else {
                                  value.remove(PrefConstants.TEAM_NAME).then(
                                      (done) => done
                                          ? value
                                              .setString(
                                                  PrefConstants.TEAM_NAME,
                                                  _teamNameController.text)
                                              .then((value) => null)
                                          : null);
                                }

                                if (_mobileController.text ==
                                        value.getString(
                                            PrefConstants.USER_MOB_NO) &&
                                    _mobileController.text.isEmpty) {
                                } else {
                                  value.remove(PrefConstants.USER_MOB_NO).then(
                                      (done) => done
                                          ? value
                                              .setString(
                                                  PrefConstants.USER_MOB_NO,
                                                  _mobileController.text)
                                              .then((value) => null)
                                          : null);
                                }

                                if (_cityController.text ==
                                        value.getString(PrefConstants.CITY) &&
                                    _cityController.text.isEmpty) {
                                } else {
                                  value.remove(PrefConstants.CITY).then(
                                      (done) => done
                                          ? value
                                              .setString(PrefConstants.CITY,
                                                  _cityController.text)
                                              .then((value) => null)
                                          : null);
                                }
                              });

                              showUpdateAlertDialog(
                                  context, "${postData.message}");
                            }
                          } else
                            UtilsFlushBar.showDefaultSnackbar(
                                context, "Please select profile picture");
                        }

                        print("false data");
                      },
                      child: Text(
                        'Update Profile',
                        style: Theme.of(context).textTheme.bodyText2.copyWith(
                              color: ColorConstant.COLOR_WHITE,
                              fontWeight: FontWeight.w500,
                            ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
        title: Text("Add Photo!"),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await _imgFromGallery();
              },
              child: Text(
                "Choose from Gallery",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: Theme.of(context).textTheme.subtitle1.copyWith(
                      color: ColorConstant.COLOR_TEXT,
                      fontWeight: FontWeight.w500,
                    ),
              ),
            ),
          ],
        ));

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
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

  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: _selectedDate != null ? _selectedDate : DateTime.now(),
        firstDate: DateTime(1960),
        lastDate: DateTime(2050),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.dark(
                primary: Colors.deepPurple,
                onPrimary: Colors.white,
                surface: Colors.blueGrey,
                onSurface: Colors.black,
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _textEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _textEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  showUpdateAlertDialog(BuildContext context, String message) {
    // set up the button
    Widget okButton = TextButton(
      child: Text("OK"),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
        // _getUserData();
        //  Navigator.pop(context);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      // title: Text("My title"),
      content: Text(message),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<ProfilePictureModel> sendForm(
      String url, Map<String, dynamic> data, Map<String, File> files) async {
    Map<String, MultipartFile> fileMap = {};
    for (MapEntry fileEntry in files.entries) {
      File file = fileEntry.value;
      String fileName = path.basename(file.path);
      fileMap[fileEntry.key] = MultipartFile(
          file.openRead(), await file.length(),
          filename: fileName);
    }
    data.addAll(fileMap);
    var formData = FormData.fromMap(data);
    Dio dio = new Dio();
    var response = await dio.post(url,
        data: formData, options: Options(contentType: 'multipart/form-data'));
    return ProfilePictureModel.fromJson(response.data);
  }

  Future<Response> sendFile(String url, File file) async {
    Dio dio = new Dio();
    var len = await file.length();
    var response = await dio.post(url,
        data: file.openRead(),
        options: Options(headers: {
          Headers.contentLengthHeader: len,
        } // set content-length
            ));
    return response;
  }
}
