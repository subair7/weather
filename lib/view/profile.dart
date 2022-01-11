import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/view_model/weather_viewmodel.dart';

import '../main.dart';
import '../network/Response/git_model.dart';

class Profile extends StatefulWidget {

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with WidgetsBindingObserver {
  final _formKey = GlobalKey<FormState>();

  // UserModel? userDetails;
  var _isLogin = true;
  bool isShow = false;
  bool isColor = false;
  var isLoading = false;
  File? image;
  int val = -1;
  var _profile;
  var _mobile = TextEditingController();
  var _firstname = TextEditingController();
  var _country = TextEditingController();
  var userId = TextEditingController();
  var _lastName = TextEditingController();
  var email = TextEditingController();
  var _gender = TextEditingController();
  var phoneNo = TextEditingController();
  var pic = TextEditingController();
  var _userName = '';
  var _userEmail = '';
  var _userPassword = '';

  // UserDetailsResponse? _userDetailsResponse;

  List<FocusNode> _focusNodes = [
    FocusNode(),
    FocusNode(),
    FocusNode(),
    FocusNode(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    triggerObservers();

    super.initState();
    // userDetails = UserModel.getInstance();

    _profile = Provider.of<WeatherProvider>(context, listen: false);
  }

  @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);

    super.dispose();
  }

  void triggerObservers() {
    WidgetsBinding.instance!.addObserver(this);
  }

  // hitpostUpdateProfilePic() async {
  //   // await initPref();
  //   // print(ema)
  //   _profile.updateProfilePic(context, userDetails!.userId, image);
  //
  //   // _register.doRegister(context);
  // }

  Future<void> _trySubmit() async {
    final isValid = _formKey.currentState!.validate();
    FocusScope.of(context).unfocus();

    if (isValid) {
      // try{
      // await dao!.insertRepo(Repo(
      //   id: 0,
      //   name: _firstname.text,));}
      //   catch(e){
      //     await dao!.updateRepo(Repo(
      //       id: 0,
      //       name: _firstname.text,));
      //
      //   }

      await dao!.updateRepo(Repo(
        id: 0,
        name: _firstname.text,
      ));
      // print(dao!.findAllRepo());

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Stack(children: [
            Align(
              alignment: Alignment.center,
              child: Container(
                color: Colors.transparent,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          Container(
                            width: 100,
                            height: 110,
                            // color: Colors.yellow,
                            child: Stack(
                              fit: StackFit.loose,
                              children: [
                                ClipOval(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.white, width: 2),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: CachedNetworkImage(
                                        width: 100,
                                        height: 100,
                                        imageUrl: '',
                                        // _image,
                                        imageBuilder:
                                            (context, imageProvider) =>
                                                Container(
                                                  width: 100,
                                                  height: 100,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: imageProvider,
                                                      fit: BoxFit.cover,
                                                      // colorFilter: ColorFilter.mode(
                                                      //     Colors.red, BlendMode.colorBurn)
                                                    ),
                                                  ),
                                                ),
                                        placeholder: (context, url) => ClipOval(
                                              child: Container(
                                                  height: 100,
                                                  width: 100,
                                                  child: Image.asset(
                                                      'assets/user.jpg')),
                                            ),

                                        // CircularProgressIndicator(),
                                        errorWidget: (context, url, error) =>
                                            ClipOval(
                                                child: Image.asset(
                                              'assets/user.jpg',
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            ))
                                        // Icon(Icons.error,size: 100,),
                                        ),
                                  ),
                                ),
                                Align(
                                    alignment: Alignment.bottomRight,
                                    child: InkWell(
                                      // onTap: () => _showPicker(context),
                                      child: ClipOval(
                                        child: Container(
                                            height: 40,
                                            width: 40,
                                            // margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
                                            color: Colors.white,
                                            child: Icon(
                                              Icons.camera_alt_outlined,
                                              size: 25,
                                              color: Colors.black54,
                                            )),
                                        // Image.asset(
                                        //   'assets/logo.png',
                                        //   height: 50,
                                        //   width: 50,
                                        //   fit: BoxFit.cover,
                                        // )),
                                      ),
                                    )),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 12,
                          ),
                          FutureBuilder<Repo?>(
                            future: dao!.findAllRepo(),
                            builder: (_, snapshot) {
                              if (!snapshot.hasData) return Text('');

                              final tasks = snapshot.requireData;

                              return Text(
                                tasks!.name ?? '',
                                style: const TextStyle(
                                    color: Colors.black54,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              );
                            },
                          ),
                          // Text(
                          //   _firstname.text,
                          //   style: const TextStyle(
                          //       color: Colors.black54,
                          //       fontSize: 20,
                          //       fontWeight: FontWeight.bold),
                          // ),

                          SizedBox(
                            height: 30,
                          ),
                          TextFormField(
                            key: ValueKey('username'),
                            focusNode: _focusNodes[0],
                            controller: _firstname,
                            validator: (value) {
                              // if (value!.isEmpty) {
                              //   return 'Please enter valid First';
                              // }
                              // return null;
                            },
                            style: TextStyle(
                                color: _focusNodes[0].hasFocus
                                    ? Color(0xFF5B2789)
                                    : Colors.grey,
                                fontFamily: 'poppins',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                fontStyle: FontStyle.normal),
                            keyboardType: TextInputType.name,
                            decoration: InputDecoration(
                              // labelText: 'Emai Address',
                              hintText: 'First Name',

                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontFamily: 'poppins',
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  fontStyle: FontStyle.normal),
                              prefixIcon: Icon(
                                Icons.person_outline,
                                color: _focusNodes[0].hasFocus
                                    ? Color(0xFF5B2789)
                                    : Colors.grey,
                              ),
                              // suffixIcon: Container(
                              //     width: 50,
                              //     // color:Colors.yellowAccent,
                              //     child: Align(
                              //         alignment: Alignment.center,
                              //         child: Text(
                              //           'Edit',
                              //           style: TextStyle(
                              //               color: Colors.grey, fontSize: 12),
                              //         ))),
                              // Icon(Icons.check_circle_rounded,color: _focusNodes[0].hasFocus ? Colors.white:Colors.grey,),

                              fillColor: Colors.white54,
                              filled: true,
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                borderSide: BorderSide(
                                  color: Color(0xFF5B2789),
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.0),
                                // borderSide: BorderSide(
                                //   color: Colors.grey,
                                //   width: 1.0,
                                // ),
                              ),
                              border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(12.0)),
                              ),
                            ),
                            onChanged: (newValue) {
                              setState(() {
                                _userEmail = newValue!;
                              });
                            },
                            onFieldSubmitted: (value) {
                              isColor = !isColor;
                              setState(() {});
                            },
                          ),
                          SizedBox(
                            height: 12,
                          ),

                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: Color(0xFF5B2789),
                                // gradient: LinearGradient(
                                //     begin: Alignment.centerLeft,
                                //     end: Alignment.centerRight,
                                //     colors: [Colors.purple, Colors.blue]),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10))),
                            height: 50,
                            child: FlatButton(
                              child: Text(
                                'SUBMIT',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    fontStyle: FontStyle.normal),
                              ),
                              onPressed: () async {
                                _trySubmit();
                              },

                              // _trySubmit,
                            ),
                          ),

                          SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
