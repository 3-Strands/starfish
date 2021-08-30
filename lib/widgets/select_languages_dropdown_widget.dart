import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'expanded_section_widget.dart';
import 'scrollbar_widget.dart';
import 'package:sizer/sizer.dart';

class LanguageListTileModel {
  int id;
  String name;
  bool isCheck;

  LanguageListTileModel(
      {required this.id, required this.name, required this.isCheck});

  static List<LanguageListTileModel> getLanguages() {
    return <LanguageListTileModel>[
      LanguageListTileModel(id: 1, name: "English", isCheck: false),
    ];
  }
}

class LanguageDropDown extends StatefulWidget {
  final Function(LanguageListTileModel country) onCountrySelect;
  LanguageDropDown({Key? key, required this.onCountrySelect}) : super(key: key);

  @override
  _LanguageDropDownState createState() => _LanguageDropDownState();
}

class _LanguageDropDownState extends State<LanguageDropDown> {
  bool isStrechedDropDown = false;
  late int groupValue;
  String title = 'Select Language';
  TextEditingController _textController = TextEditingController();
  List<LanguageListTileModel> filteredLanguageList =
      LanguageListTileModel.getLanguages();

  List<LanguageListTileModel> languageDataList =
      List.from(LanguageListTileModel.getLanguages());

  onTextChanged(String value) {
    setState(() {
      languageDataList = filteredLanguageList
          .where((string) =>
              string.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void onLanguageSelect(bool val, int index) {
    widget.onCountrySelect(languageDataList[index]);
    final findIndex = filteredLanguageList
        .indexWhere((element) => element.id == languageDataList[index].id);

    setState(() {
      if (findIndex >= 0) {
        filteredLanguageList[findIndex].isCheck = val;
      }
      languageDataList[index].isCheck = val;
      isStrechedDropDown = !isStrechedDropDown;
    });
  }

  String formatString(List<LanguageListTileModel> x) {
    String formatted = '';
    for (var i in x) {
      formatted += '${i.name}, ';
    }
    return x.isNotEmpty
        ? formatted.replaceRange(formatted.length - 2, formatted.length, '')
        : title;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 6.4.h,
          width: 92.0.w,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0),
            color: AppColors.txtFieldBackground,
          ),
          child: TextButton(
            style: ButtonStyle(
              alignment: Alignment.centerLeft,
            ),
            onPressed: () {
              setState(() {
                isStrechedDropDown = !isStrechedDropDown;
              });
            },
            child: Text(
              Strings.selectCountry,
              style: TextStyle(
                fontFamily: 'OpenSans',
                fontWeight: FontWeight.normal,
                fontSize: 16.0.sp,
                color: AppColors.txtFieldTextColor,
              ),
            ),
          ),
        ),
        SizedBox(height: 2),
        Visibility(
          visible: isStrechedDropDown,
          child: Container(
            decoration: BoxDecoration(
                border: Border.all(color: Color(0xffbbbbbb)),
                borderRadius: BorderRadius.all(Radius.circular(10))),
            child: Column(
              children: [
                Visibility(
                  visible: isStrechedDropDown,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextField(
                      controller: _textController,
                      decoration: InputDecoration(
                        contentPadding:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                        //here your padding
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(22)),
                          borderSide: BorderSide(color: Colors.black, width: 2),
                        ),
                        hintText: "search",
                      ),
                      onChanged: onTextChanged,
                    ),
                  ),
                ),
                ExpandedSection(
                  expand: isStrechedDropDown,
                  height: 10,
                  child: MyScrollbar(
                    builder: (context, scrollController) =>
                        new ListView.builder(
                            padding: EdgeInsets.all(0),
                            controller: scrollController,
                            shrinkWrap: true,
                            itemCount: languageDataList.length,
                            itemBuilder: (context, index) {
                              return Padding(
                                padding: const EdgeInsets.only(right: 18.0),
                                child: CheckboxListTile(
                                  value: languageDataList[index].isCheck,
                                  title: Text(languageDataList[index].name),
                                  onChanged: (bool? value) {
                                    onLanguageSelect(value!, index);
                                  },
                                ),
                              );
                            }),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
