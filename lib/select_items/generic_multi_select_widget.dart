import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/strings.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/db/hive_country.dart';
import 'package:starfish/db/hive_database.dart';
import 'package:starfish/db/hive_evaluation_category.dart';
import 'package:starfish/db/hive_language.dart';
import 'package:starfish/db/hive_material_topic.dart';
import 'package:starfish/db/hive_material_type.dart';
import 'package:starfish/select_items/item.dart';
import 'package:starfish/select_items/select_drop_down.dart';

class MultiSelect extends StatefulWidget {
  final String navTitle;
  final SelectType choice;
  final DataSourceType dataSource;
  final selectedValues;

  final Function<T>(T) onDoneClicked;

  MultiSelect(
      {Key? key,
      required this.navTitle,
      required this.choice,
      required this.dataSource,
      required this.onDoneClicked,
      required this.selectedValues})
      : super(key: key);

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState extends State<MultiSelect> {
  Icon actionIcon = Icon(Icons.search);

  late Widget appBarTitle;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  final TextEditingController _searchTextController =
      new TextEditingController();

  late Box<HiveCountry> _countryBox;
  late Box<HiveLanguage> _languageBox;
  late Box<HiveMaterialTopic> _materialTopicBox;
  late Box<HiveMaterialType> _materialTypeBox;
  late Box<HiveEvaluationCategory> _evaluationCategoryBox;

  List<Item> _items = [];

  bool _isSearching = false;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    appBarTitle = Text(widget.navTitle);

    switch (widget.dataSource) {
      case DataSourceType.country:
        _countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
        List<HiveCountry> _countries = _countryBox.values.toList();

        HiveCountry _selectedCountry = widget.selectedValues as HiveCountry;
        _countries.forEach((element) {
          if (element.id == _selectedCountry.id) {
            var country = Item(data: element, isSelected: true);
            _items.add(country);
          } else {
            var country = Item(data: element, isSelected: false);
            _items.add(country);
          }
        });

        break;
      case DataSourceType.countries:
        _countryBox = Hive.box<HiveCountry>(HiveDatabase.COUNTRY_BOX);
        List<HiveCountry> _countries = _countryBox.values.toList();

        List<HiveCountry> _selectedCountries =
            widget.selectedValues as List<HiveCountry>;
        _countries.forEach((element) {
          var country = Item(data: element, isSelected: false);
          _items.add(country);
        });

        _selectedCountries.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveCountry).id == element.id);
          _items[index].isSelected = true;
        });

        break;
      case DataSourceType.languages:
        _languageBox = Hive.box<HiveLanguage>(HiveDatabase.LANGUAGE_BOX);
        List<HiveLanguage> _languages = _languageBox.values.toList();

        _languages.forEach((element) {
          var language = Item(data: element, isSelected: false);
          _items.add(language);
        });

        List<HiveLanguage> _selectedLanguages =
            widget.selectedValues as List<HiveLanguage>;
        _selectedLanguages.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveLanguage).id == element.id);
          _items[index].isSelected = true;
        });

        break;
      case DataSourceType.topics:
        _materialTopicBox =
            Hive.box<HiveMaterialTopic>(HiveDatabase.MATERIAL_TOPIC_BOX);
        List<HiveMaterialTopic> _topics = _materialTopicBox.values.toList();

        _topics.forEach((element) {
          var topic = Item(data: element, isSelected: false);
          _items.add(topic);
        });

        List<HiveMaterialTopic> _selectedTopics =
            widget.selectedValues as List<HiveMaterialTopic>;
        _selectedTopics.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveMaterialTopic).name == element.name);
          _items[index].isSelected = true;
        });

        break;
      case DataSourceType.types:
        _materialTypeBox =
            Hive.box<HiveMaterialType>(HiveDatabase.MATERIAL_TYPE_BOX);
        List<HiveMaterialType> _types = _materialTypeBox.values.toList();

        _types.forEach((element) {
          var type = Item(data: element, isSelected: false);
          _items.add(type);
        });

        List<HiveMaterialType> _selectedTypes =
            widget.selectedValues as List<HiveMaterialType>;
        _selectedTypes.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveMaterialType).id == element.id);
          _items[index].isSelected = true;
        });

        break;
      case DataSourceType.evaluationCategory:
        _evaluationCategoryBox = Hive.box<HiveEvaluationCategory>(
            HiveDatabase.EVALUATION_CATEGORIES_BOX);
        List<HiveEvaluationCategory> _types =
            _evaluationCategoryBox.values.toList();

        _types.forEach((element) {
          var type = Item(data: element, isSelected: false);
          _items.add(type);
        });

        List<HiveEvaluationCategory> _selectedCateogries =
            widget.selectedValues as List<HiveEvaluationCategory>;
        _selectedCateogries.forEach((element) {
          final index = _items.indexWhere(
              (item) => (item.data as HiveEvaluationCategory).id == element.id);
          _items[index].isSelected = true;
        });

        break;
      default:
    }
  }

  _MultiSelectState() {
    _searchTextController.addListener(() {
      if (_searchTextController.text.isEmpty) {
        setState(() {
          _isSearching = false;
          _searchText = "";
        });
      } else {
        setState(() {
          _isSearching = true;
          _searchText = _searchTextController.text;
        });
      }
    });
  }

  void _handleSearchStart() {
    setState(() {
      _isSearching = true;
    });
  }

  void _handleSearchEnd() {
    setState(() {
      this.actionIcon = new Icon(
        Icons.search,
        color: Colors.white,
      );
      this.appBarTitle = new Text(
        widget.navTitle,
        style: new TextStyle(color: Colors.white),
      );
      _isSearching = false;
      _searchTextController.clear();
    });
  }

  Widget navigationSearchBar() {
    return IconButton(
      icon: actionIcon,
      onPressed: () {
        setState(
          () {
            if (this.actionIcon.icon == Icons.search) {
              this.actionIcon = Icon(Icons.close);
              this.appBarTitle = TextField(
                controller: _searchTextController,
                cursorColor: Colors.white,
                style: TextStyle(
                  color: Colors.white,
                ),
                decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search, color: Colors.white),
                  hintText: Strings.searchBarHint,
                  hintStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              );
              _handleSearchStart();
            } else {
              this.actionIcon = Icon(Icons.search);
              this.appBarTitle = Text(widget.navTitle);
              _handleSearchEnd();
            }
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      key: _scaffoldKey,
      appBar: AppBar(
        title: appBarTitle,
        automaticallyImplyLeading: true,
        leading: BackButton(
          onPressed: () => Navigator.pop(context, {_sendSelectedValues()}),
        ),
        actions: [
          navigationSearchBar(),
        ],
      ),
      body: Container(
        color: Colors.white,
        child: _isSearching ? _searchListBuilder() : _listBuilder(),
      ),
    );
  }

  Widget _listBuilder() {
    return Container(
      child: ListView.builder(
        itemCount: _items.length,
        itemBuilder: (context, index) {
          return ItemList(_items[index], this);
        },
      ),
    );
  }

  _searchListBuilder() {
    if (_searchText.isEmpty) {
      return _listBuilder();
    } else {
      List<Item> _searchList = [];
      for (int i = 0; i < _items.length; i++) {
        if (_items[i]
            .data
            .name
            .toLowerCase()
            .contains(_searchText.toLowerCase())) {
          _searchList.add(
              Item(data: _items[i].data, isSelected: _items[i].isSelected));
        }
      }
      return ListView.builder(
        itemCount: _searchList.length,
        itemBuilder: (context, index) {
          return ItemList(_searchList[index], this);
        },
      );
    }
  }

  itemTapped(Item selectedItem) {
    if (widget.choice == SelectType.single) {
      _singleSelectItemTapped(selectedItem);
    } else {
      _multiSelectItemTapped(selectedItem);
    }
  }

  void _singleSelectItemTapped(Item selectedItem) {
    final index =
        _items.indexWhere((element) => element.data.id == selectedItem.data.id);
    setState(() {
      _items[index].isSelected = !_items[index].isSelected;
    });

    widget.onDoneClicked(_items[index].data);
    Navigator.pop(context);
  }

  void _multiSelectItemTapped(Item selectedItem) {
    final index =
        _items.indexWhere((element) => element.data.id == selectedItem.data.id);
    setState(() {
      _items[index].isSelected = !_items[index].isSelected;
    });
  }

  void _sendSelectedValues() {
    switch (widget.dataSource) {
      case DataSourceType.countries:
        List<HiveCountry> selectedItems = [];
        _items.forEach((item) {
          if (item.isSelected == true) {
            selectedItems.add(item.data);
          }
        });
        widget.onDoneClicked(selectedItems);

        break;
      case DataSourceType.languages:
        List<HiveLanguage> selectedItems = [];
        _items.forEach((item) {
          if (item.isSelected == true) {
            selectedItems.add(item.data);
          }
        });
        widget.onDoneClicked(selectedItems);

        break;
      case DataSourceType.topics:
        List<HiveMaterialTopic> selectedItems = [];
        _items.forEach((item) {
          if (item.isSelected == true) {
            selectedItems.add(item.data);
          }
        });
        widget.onDoneClicked(selectedItems);

        break;
      case DataSourceType.types:
        List<HiveMaterialType> selectedItems = [];
        _items.forEach((item) {
          if (item.isSelected == true) {
            selectedItems.add(item.data);
          }
        });
        widget.onDoneClicked(selectedItems);

        break;
      case DataSourceType.evaluationCategory:
        List<HiveEvaluationCategory> selectedItems = [];
        _items.forEach((item) {
          if (item.isSelected == true) {
            selectedItems.add(item.data);
          }
        });
        widget.onDoneClicked(selectedItems);

        break;
      default:
    }
  }
}

class ItemList extends StatelessWidget {
  final Item item;
  final _MultiSelectState obj;

  ItemList(this.item, this.obj);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
          child: Container(
            margin: EdgeInsets.only(left: 15.w),
            height: 70,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Container(
                          height: 60.h,
                          width: MediaQuery.of(context).size.width - 90.0.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text('${this.item.data.name}'),
                            ],
                          ),
                        )
                      ],
                    ),
                    Container(
                      width: 60.w,
                      child: Icon(
                        (this.item.isSelected == true)
                            ? Icons.check_box
                            : Icons.check_box_outline_blank,
                        color: AppColors.selectedButtonBG,
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
          onTap: () => {this.obj.itemTapped(this.item)}),
      elevation: 2,
    );
  }
}
