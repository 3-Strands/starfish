import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/select_items/generic_multi_select_widget.dart';

enum SelectType { single, multiple }
enum DataSourceType { country, countries, language, languages, topics }

class SelectDropDown extends StatefulWidget {
  final String navTitle;
  final String placeholder;
  final selectedValues;
  final SelectType choice;
  final DataSourceType dataSource;

  final Function<T>(T) onDoneClicked;

  SelectDropDown(
      {Key? key,
      required this.navTitle,
      required this.placeholder,
      required this.selectedValues,
      required this.choice,
      required this.dataSource,
      required this.onDoneClicked})
      : super(key: key);

  @override
  _SelectDropDownState createState() => _SelectDropDownState();
}

class _SelectDropDownState extends State<SelectDropDown> {
  String _selectedValue = '';

  @override
  void initState() {
    super.initState();
    if (widget.selectedValues == null) {
      _selectedValue = widget.placeholder;
    } else {
      showSelectedValue(widget.selectedValues);
    }
  }

  void showSelectedValue(value) {
    String _value = '';
    switch (widget.dataSource) {
      case DataSourceType.country:
        HiveCountry country = value as HiveCountry;
        _value = country.name;
        _selectedValue = _value;

        break;
      case DataSourceType.countries:
        List<HiveCountry> countries = value as List<HiveCountry>;
        countries.forEach((element) {
          _value += '${element.name}, ';
        });

        break;
      case DataSourceType.languages:
        List<HiveLanguage> languages = value as List<HiveLanguage>;
        languages.forEach((element) {
          _value += '${element.name}, ';
        });

        break;
      case DataSourceType.topics:
        List<HiveMaterialTopic> topics = value as List<HiveMaterialTopic>;
        topics.forEach((element) {
          _value += '${element.name}, ';
        });

        break;

      default:
    }

    setState(() {
      if (widget.choice == SelectType.multiple) {
        if (_value.length == 0) {
          _selectedValue = widget.placeholder;
        } else {
          _selectedValue = _value.substring(0, _value.length - 2);
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 52.h,
      margin: EdgeInsets.only(left: 15.w, right: 15.w),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.transparent,
          width: 1.0,
        ),
        color: AppColors.txtFieldBackground,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MultiSelect(
                navTitle: widget.navTitle,
                selectedValues: widget.selectedValues,
                choice: widget.choice,
                dataSource: widget.dataSource,
                onDoneClicked: <T>(items) {
                  showSelectedValue(items);
                  widget.onDoneClicked(items);
                },
              ),
            ),
          );
        },
        child: Container(
          margin: EdgeInsets.only(left: 15.w),
          child: Row(
            children: [
              Container(
                width: 300.w,
                child: Text(
                  (widget.selectedValues == '')
                      ? widget.placeholder
                      : _selectedValue,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: textFormFieldText,
                ),
              ),
              Spacer(),
              Icon(Icons.navigate_next_sharp, color: Colors.grey),
              Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
