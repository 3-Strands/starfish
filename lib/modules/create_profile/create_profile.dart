import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:starfish/constants/assets_path.dart';
import 'package:starfish/constants/strings.dart';

class CreateProfileScreen extends StatefulWidget {
  CreateProfileScreen({Key? key, this.title = ''}) : super(key: key);

  final String title;

  @override
  _CreateProfileScreenState createState() => _CreateProfileScreenState();
}

class _CreateProfileScreenState extends State<CreateProfileScreen> {
  final _nameController = TextEditingController();

  final FocusNode _nameFocus = FocusNode();

  @override
  Widget build(BuildContext context) {
    Widget getNameField() {
      return TextFormField(
        controller: _nameController,
        focusNode: _nameFocus,
        onFieldSubmitted: (term) {
          _nameFocus.unfocus();
        },
        obscureText: false,
        keyboardType: TextInputType.emailAddress,
        decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(20.0, 15.0, 20.0, 15.0),
            hintText: Strings.nameHint,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.white,
              ),
            ),
            filled: true,
            fillColor: Colors.grey[200]),
      );
    }

    Widget getSelectCountryOption() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60.0,
          width: MediaQuery.of(context).size.width - 40.0,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            onPressed: () {},
            child: Text(Strings.selectCountry),
          ),
        ),
      );
    }

    Widget getSelectLanguagesOption() {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          height: 60.0,
          width: MediaQuery.of(context).size.width - 40.0,
          padding: const EdgeInsets.only(left: 10.0, right: 10.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: Colors.grey[200],
          ),
          child: TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.all<Color>(Colors.grey),
            ),
            onPressed: () {},
            child: Text(Strings.selectLanugages),
          ),
        ),
      );
    }

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
        },
        child: Stack(
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              color: Colors.transparent,
              child: Center(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.transparent,
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.all(36.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Image.asset(ImagePath.logoStarfish),
                          SizedBox(height: 50.0),
                          Container(
                            width: MediaQuery.of(context).size.width - 60.0,
                            height: 170.0,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  Strings.enterName,
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 10.0),
                                getNameField(),
                                SizedBox(height: 10.0),
                                Text(
                                  Strings.enterNameDetail,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 60.0,
                            height: 170.0,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  Strings.selectCountry,
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 10.0),
                                getSelectCountryOption(),
                                SizedBox(height: 10.0),
                                Text(
                                  Strings.selectCountryDetail,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width - 60.0,
                            height: 170.0,
                            color: Colors.transparent,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text(
                                  Strings.selectLanugages,
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 10.0),
                                getSelectLanguagesOption(),
                                SizedBox(height: 10.0),
                                Text(
                                  Strings.selectLanugagesDetail,
                                  textAlign: TextAlign.left,
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Container(
                color: Colors.grey[200],
                width: MediaQuery.of(context).size.width,
                height: 75,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width - 50.0,
                      color: Colors.blue,
                      child: TextButton(
                        onPressed: () {},
                        child: Text(Strings.finish),
                      ),
                    ),
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
