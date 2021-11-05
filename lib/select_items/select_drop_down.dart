import 'package:flutter/material.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_group.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/select_items/generic_multi_select_widget.dart';

enum SelectType { single, multiple }
enum DataSourceType {
  country,
  countries,
  language,
  languages,
  topics,
  types,
  evaluationCategory,
  groups,
}

class SelectDropDown extends StatefulWidget {
  final String navTitle;
  final int maxSelectItemLimit;
  final String placeholder;
  final bool enableSelectAllOption;
  final bool enabled;
  final selectedValues;
  final dataSource;
  final SelectType type;
  final DataSourceType dataSourceType;

  final Function<T>(T) onDoneClicked;

  SelectDropDown({
    Key? key,
    required this.navTitle,
    required this.placeholder,
    this.enabled = true,
    this.enableSelectAllOption = false,
    required this.selectedValues,
    required this.dataSource,
    required this.type,
    required this.dataSourceType,
    required this.onDoneClicked,
    this.maxSelectItemLimit = 0,
  }) : super(key: key);

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

    switch (widget.dataSourceType) {
      case DataSourceType.country:
        HiveCountry country = value as HiveCountry;
        _value = country.name;
        _selectedValue = _value;

        break;
      case DataSourceType.countries:
        // List<HiveCountry> countries = value as List<HiveCountry>;

        List<HiveCountry> countries =
            List<HiveCountry>.from(value as List<dynamic>);

        countries.forEach((element) {
          _value += '${element.name}, ';
        });

        break;
      case DataSourceType.languages:

        // List<HiveLanguage> languages = value as List<HiveLanguage>;

        List<HiveLanguage> languages =
            List<HiveLanguage>.from(value as List<dynamic>);

        languages.forEach((element) {
          _value += '${element.name}, ';
        });

        break;
      case DataSourceType.topics:
        // List<HiveMaterialTopic> topics = value as List<HiveMaterialTopic>;

        List<HiveMaterialTopic> topics =
            List<HiveMaterialTopic>.from(value as List<dynamic>);

        topics.forEach((element) {
          _value += '${element.name}, ';
        });

        break;
      case DataSourceType.types:
        // List<HiveMaterialType> types = value as List<HiveMaterialType>;

        List<HiveMaterialType> types =
            List<HiveMaterialType>.from(value as List<dynamic>);

        types.forEach((element) {
          _value += '${element.name}, ';
        });

        break;
      case DataSourceType.evaluationCategory:
        // List<HiveEvaluationCategory> cateogries =
        //     value as List<HiveEvaluationCategory>;

        List<HiveEvaluationCategory> cateogries =
            List<HiveEvaluationCategory>.from(value as List<dynamic>);

        cateogries.forEach((element) {
          _value += '${element.name}, ';
        });

        break;
      case DataSourceType.groups:
        // List<HiveGroup> groups = value as List<HiveGroup>;

        List<HiveGroup> groups = List<HiveGroup>.from(value as List<dynamic>);

        groups.forEach((element) {
          _value += '${element.name}, ';
        });

        break;

      default:
    }

    setState(() {
      if (widget.type == SelectType.multiple) {
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
          if (widget.enabled) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MultiSelect(
                  navTitle: widget.navTitle,
                  selectedValues: widget.selectedValues,
                  dataSource: widget.dataSource,
                  type: widget.type,
                  dataSourceType: widget.dataSourceType,
                  onDoneClicked: <T>(items) {
                    showSelectedValue(items);
                    widget.onDoneClicked(items);
                  },
                  enableSelectAllOption: widget.enableSelectAllOption,
                  maxSelectItemLimit: widget.maxSelectItemLimit,
                ),
              ),
            ).then(
              (value) => FocusScope.of(context).requestFocus(
                new FocusNode(),
              ),
            );
          }
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
