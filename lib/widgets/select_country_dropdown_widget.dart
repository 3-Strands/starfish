import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'expanded_section_widget.dart';
import 'scrollbar_widget.dart';
import 'package:sizer/sizer.dart';

class CountryListTileModel {
  int id;
  String name;
  String code;
  bool isCheck;

  CountryListTileModel(
      {required this.id,
      required this.name,
      required this.code,
      required this.isCheck});

  static List<CountryListTileModel> getCountries() {
    return <CountryListTileModel>[
      CountryListTileModel(id: 1, name: "America", code: '+1', isCheck: false),
      CountryListTileModel(id: 2, name: "India", code: '+91', isCheck: false),
      CountryListTileModel(
          id: 3, name: "Australia", code: '+61', isCheck: false),
      CountryListTileModel(id: 4, name: "UK", code: '+44', isCheck: false),
    ];
  }
}

class CountryDropDown extends StatefulWidget {
  final Function(CountryListTileModel country) onCountrySelect;
  CountryDropDown({Key? key, required this.onCountrySelect}) : super(key: key);

  @override
  _CountryDropDownState createState() => _CountryDropDownState();
}

class _CountryDropDownState extends State<CountryDropDown> {
  bool isStrechedDropDown = false;
  late int groupValue;
  String title = 'Select Country';
  String selectedCountry = Strings.selectCountry;

  TextEditingController _textController = TextEditingController();
  List<CountryListTileModel> filteredCountryList =
      CountryListTileModel.getCountries();

  // Copy Main List into New List.
  List<CountryListTileModel> countryDataList =
      List.from(CountryListTileModel.getCountries());

  onTextChanged(String value) {
    setState(() {
      countryDataList = filteredCountryList
          .where((string) =>
              string.name.toLowerCase().contains(value.toLowerCase()))
          .toList();
    });
  }

  void onCountrySelect(bool val, int index) {
    final selectedFilteredCountryIndex =
        filteredCountryList.indexWhere((element) => element.isCheck == true);
    if (selectedFilteredCountryIndex >= 0) {
      filteredCountryList[selectedFilteredCountryIndex].isCheck = false;
    }

    final selectedCountryIndex =
        countryDataList.indexWhere((element) => element.isCheck == true);
    if (selectedCountryIndex >= 0) {
      countryDataList[selectedCountryIndex].isCheck = false;
    }

    final findIndex = filteredCountryList
        .indexWhere((element) => element.id == countryDataList[index].id);

    setState(() {
      if (findIndex >= 0) {
        filteredCountryList[findIndex].isCheck = val;
      }
      countryDataList[index].isCheck = val;
      selectedCountry = (countryDataList[index].isCheck == true)
          ? countryDataList[index].name
          : Strings.selectCountry;
      isStrechedDropDown = !isStrechedDropDown;
    });

    widget.onCountrySelect(countryDataList[index]);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 6.4.h,
          width: 92.0.w,
          margin: EdgeInsets.fromLTRB(4.0.w, 0.0, 4.0.w, 0.0),
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
              selectedCountry,
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
            child: Container(
              margin: EdgeInsets.fromLTRB(4.0.w, 5.0, 4.0.w, 15.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffbbbbbb)),
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Column(
                children: [
                  Visibility(
                    visible: isStrechedDropDown,
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: TextField(
                        controller: _textController,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(
                              vertical: 10, horizontal: 10),
                          //here your padding
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(22)),
                            borderSide:
                                BorderSide(color: Colors.black, width: 2),
                          ),
                          hintText: "Search Country",
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
                        itemCount: countryDataList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(right: 18.0),
                            child: CheckboxListTile(
                              value: countryDataList[index].isCheck,
                              title: Text(countryDataList[index].name),
                              onChanged: (bool? value) {
                                onCountrySelect(value!, index);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
      ],
    );
  }
}
