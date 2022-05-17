import 'package:flutter/material.dart';
import 'package:focus_detector/focus_detector.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/text_styles.dart';
// import 'package:starfish/db/hive_country.dart';
// import 'package:starfish/db/hive_evaluation_category.dart';
// import 'package:starfish/db/hive_group.dart';
// import 'package:starfish/db/hive_language.dart';
// import 'package:starfish/db/hive_material_topic.dart';
// import 'package:starfish/db/hive_material_type.dart';
// import 'package:starfish/db/providers/current_user_provider.dart';
// import 'package:starfish/select_items/item.dart';
import 'package:starfish/select_items/select_drop_down.dart';
// import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/helpers/snackbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class MultiSelect<T extends Named> extends StatefulWidget {
  final String navTitle;
  final bool enableSelectAllOption;
  final SelectDropDownController<T> controller;

  final void Function() onDoneClicked;


  MultiSelect({
    Key? key,
    required this.navTitle,
    required this.controller,
    required this.onDoneClicked,
    required this.enableSelectAllOption,
  }) : super(key: key);

  @override
  _MultiSelectState createState() => _MultiSelectState();
}

class _MultiSelectState<T extends Named> extends State<MultiSelect<T>> {
  // final Key _focusDetectorKey = UniqueKey();

  // final _scaffoldKey = GlobalKey<ScaffoldState>();

  final _searchTextController = TextEditingController();

  bool _isSearching = false;

  List<T>? _filteredList;

  List<T> get currentList => _filteredList ?? widget.controller.items;

  void _rebuild() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  initState() {
    super.initState();
    _searchTextController.addListener(_onSearchTextChange);
    widget.controller.addListener(_rebuild);
  }

  @override
  void dispose() {
    _searchTextController
      ..removeListener(_onSearchTextChange)
      ..dispose();
    widget.controller.removeListener(_rebuild);
    super.dispose();
  }

  void _onSearchTextChange() {
    final text = _searchTextController.text;

    setState(() {
      if (text.isEmpty) {
        _filteredList = null;
        _isSearching = true;
      } else {
        final searchString = text.toLowerCase();
        _filteredList = widget.controller.items.where(
          (item) => item.getName().toLowerCase().contains(searchString),
        ).toList();
        _isSearching = false;
      }
    });
  }

  Widget get _appBarTitle => _isSearching
    ? TextField(
      controller: _searchTextController,
      cursorColor: Colors.white,
      autofocus: true,
      style: TextStyle(
        color: Colors.white,
        fontSize: 19.sp,
      ),
      decoration: InputDecoration(
        prefixIcon: Icon(Icons.search, color: Colors.white),
        hintText: AppLocalizations.of(context)!.searchBarHint,
        hintStyle: TextStyle(color: Colors.white),
        border: InputBorder.none,
        focusedBorder: InputBorder.none,
        enabledBorder: InputBorder.none,
        disabledBorder: InputBorder.none,
      ),
    )
    : Text(
      widget.navTitle,
      style: TextStyle(color: Colors.white, fontSize: 19.sp),
    );

  Widget get _navigationSearchBar =>
    IconButton(
      icon: _isSearching ? const Icon(Icons.close) : Icon(Icons.search),
      onPressed: () {
        setState(() {
          _isSearching = !_isSearching;
          if (!_isSearching) {
            _searchTextController.clear();
          }
        });
      },
    );

  @override
  Widget build(BuildContext context) {
    final isAllSelected = widget.controller.isAllSelected();

    return FocusDetector(
      // key: _focusDetectorKey,
      onFocusLost: _sendSelectedValues,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        // key: _scaffoldKey,
        appBar: AppBar(
          title: _appBarTitle,
          automaticallyImplyLeading: false,
          actions: [
            _navigationSearchBar,
          ],
          leading: InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Icon(Icons.arrow_back_ios_rounded, size: 32.r),
          ),
        ),
        body: Column(
          children: [
            Visibility(
              child: Card(
                child: InkWell(
                    child: Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.only(left: 15.w, top: 5.h),
                      color: Colors.white,
                      child: Row(
                        children: [
                          Row(
                            children: <Widget>[
                              Container(
                                height: 60.h,
                                width:
                                    MediaQuery.of(context).size.width - 90.0.w,
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: <Widget>[
                                    Text(
                                      AppLocalizations.of(context)!.selectAll,
                                      style: TextStyle(
                                        fontFamily: 'OpenSans',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 21.5.sp,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                          Container(
                            width: 60.w,
                            child: Icon(
                              isAllSelected
                                  ? Icons.check_box
                                  : Icons.check_box_outline_blank,
                              color: AppColors.selectedButtonBG,
                            ),
                          )
                        ],
                      ),
                    ),
                    onTap: () => widget.controller.setAllSelected(!isAllSelected)),
              ),
              visible: widget.enableSelectAllOption,
            ),
            SizedBox(
              height: 5.h,
            ),
            Expanded(
              child: _listBuilder(),
            ),
          ],
        ),
        bottomNavigationBar: Container(
          height: 75.h,
          padding: EdgeInsets.symmetric(vertical: 18.75.h, horizontal: 30.w),
          color: AppColors.txtFieldBackground,
          child: ElevatedButton(
            child: Text(
              AppLocalizations.of(context)!.back,
              textAlign: TextAlign.start,
              style: buttonTextStyle,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
            style: ElevatedButton.styleFrom(
              primary: AppColors.unselectedButtonBG,
              shape: new RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(20.0),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _listBuilder() {
    final list = currentList;

    return Container(
      child: Scrollbar(
        thickness: 5.w,
        isAlwaysShown: false,
        child: ListView.builder(
          itemCount: list.length,
          itemBuilder: (context, index) {
            final item = list[index];
            final isSelected = widget.controller.isSelected(item);
            return Card(
              child: InkWell(
                  child: Container(
                    margin: EdgeInsets.only(left: 15.w),
                    height: 60,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            Row(
                              children: <Widget>[
                                Container(
                                  height: 40.h,
                                  width: MediaQuery.of(context).size.width - 90.0.w,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        item.getName(),
                                        maxLines: 2,
                                        style: TextStyle(
                                          fontFamily: 'OpenSans',
                                          fontWeight: FontWeight.normal,
                                          fontSize: 17.sp,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              ],
                            ),
                            Container(
                              width: 60.w,
                              child: Icon(
                                isSelected
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
                  onTap: () {
                    final errorMessage = widget.controller.toggleSelected(item, !isSelected);
                    if (errorMessage != null) {
                      StarfishSnackbar.showErrorMessage(context, errorMessage);
                    } else if (widget.controller.isSelectionComplete) {
                      Navigator.of(context).pop();
                    }
                  },
                ),
              elevation: 2,
            );
          },
        ),
      ),
    );
  }

  void _sendSelectedValues() => widget.onDoneClicked();

  // @override
  // void initState() {
  //   super.initState();
  //   appBarTitle = Text(widget.navTitle);

  //   switch (widget.dataSourceType) {
  //     case DataSourceType.country:
  //       List<HiveCountry> _countries = widget.dataSource as List<HiveCountry>;
  //       HiveCountry _selectedCountry = widget.selectedValues as HiveCountry;

  //       _countries.forEach((element) {
  //         if (element.id == _selectedCountry.id) {
  //           var country = Item(data: element, isSelected: true);
  //           _items.add(country);
  //         } else {
  //           var country = Item(data: element, isSelected: false);
  //           _items.add(country);
  //         }
  //       });
  //       _sortSelectedItems();
  //       break;
  //     case DataSourceType.countries:
  //       List<HiveCountry> _countries = widget.dataSource as List<HiveCountry>;

  //       List<HiveCountry> _selectedCountries =
  //           widget.selectedValues as List<HiveCountry>;
  //       _countries.forEach((element) {
  //         var country = Item(data: element, isSelected: false);
  //         _items.add(country);
  //       });

  //       _selectedCountries.forEach((element) {
  //         final index = _items.indexWhere(
  //             (item) => (item.data as HiveCountry).id == element.id);
  //         _items[index].isSelected = true;
  //       });

  //       _sortSelectedItems();
  //       break;
  //     case DataSourceType.languages:
  //       List<HiveLanguage> _languages = widget.dataSource as List<HiveLanguage>;

  //       _languages.forEach((element) {
  //         var language = Item(data: element, isSelected: false);
  //         _items.add(language);
  //       });

  //       List<HiveLanguage> _selectedLanguages =
  //           widget.selectedValues as List<HiveLanguage>;
  //       _selectedLanguages.forEach((element) {
  //         final index = _items.indexWhere(
  //             (item) => (item.data as HiveLanguage).id == element.id);
  //         if (index > -1) {
  //           _items[index].isSelected = true;
  //         }
  //       });

  //       _sortSelectedItems();
  //       break;
  //     case DataSourceType.topics:
  //       List<HiveMaterialTopic> _topics =
  //           widget.dataSource as List<HiveMaterialTopic>;

  //       _topics.forEach((element) {
  //         var topic = Item(data: element, isSelected: false);
  //         _items.add(topic);
  //       });

  //       List<HiveMaterialTopic> _selectedTopics =
  //           widget.selectedValues as List<HiveMaterialTopic>;
  //       _selectedTopics.forEach((element) {
  //         final index = _items.indexWhere(
  //             (item) => (item.data as HiveMaterialTopic).name == element.name);
  //         _items[index].isSelected = true;
  //       });

  //       _sortSelectedItems();
  //       break;
  //     case DataSourceType.types:
  //       List<HiveMaterialType> _types =
  //           widget.dataSource as List<HiveMaterialType>;

  //       _types.forEach((element) {
  //         var type = Item(data: element, isSelected: false);
  //         _items.add(type);
  //       });

  //       List<HiveMaterialType> _selectedTypes =
  //           widget.selectedValues as List<HiveMaterialType>;
  //       _selectedTypes.forEach((element) {
  //         final index = _items.indexWhere(
  //             (item) => (item.data as HiveMaterialType).id == element.id);
  //         _items[index].isSelected = true;
  //       });

  //       _sortSelectedItems();
  //       break;
  //     case DataSourceType.evaluationCategory:
  //       List<HiveEvaluationCategory> _types =
  //           widget.dataSource as List<HiveEvaluationCategory>;

  //       _types.forEach((element) {
  //         var type = Item(data: element, isSelected: false);
  //         _items.add(type);
  //       });

  //       List<HiveEvaluationCategory> _selectedCateogries =
  //           widget.selectedValues as List<HiveEvaluationCategory>;
  //       _selectedCateogries.forEach((element) {
  //         final index = _items.indexWhere(
  //             (item) => (item.data as HiveEvaluationCategory).id == element.id);
  //         _items[index].isSelected = true;
  //       });

  //       _sortSelectedItems();
  //       break;
  //     case DataSourceType.groups:
  //       List<HiveGroup> _groups = widget.dataSource as List<HiveGroup>;

  //       final currentUserId = CurrentUserProvider().getUserSync().id;

  //       _groups.forEach((element) {
  //         if (element.isMe == true) {
  //           _items.add(Item(data: element, isSelected: false));
  //         } else {
  //           if (element.getMyRole(currentUserId) == GroupUser_Role.ADMIN ||
  //               element.getMyRole(currentUserId) == GroupUser_Role.TEACHER) {
  //             var type = Item(data: element, isSelected: false);
  //             _items.add(type);
  //           }
  //         }
  //       });

  //       List<HiveGroup> _selectedGroups =
  //           widget.selectedValues as List<HiveGroup>;

  //       _selectedGroups.forEach((element) {
  //         final index = _items
  //             .indexWhere((item) => (item.data as HiveGroup).id == element.id);
  //         _items[index].isSelected = true;
  //       });

  //       Item<dynamic> _me =
  //           _items.firstWhere((element) => (element.data as HiveGroup).isMe);
  //       List<Item<dynamic>> _itemSelected = _items
  //           .where((element) =>
  //               element.isSelected && !(element.data as HiveGroup).isMe)
  //           .toList();
  //       List<Item<dynamic>> _itemUnSelected = _items
  //           .where((element) =>
  //               !element.isSelected && !(element.data as HiveGroup).isMe)
  //           .toList();

  //       _itemSelected.sort((a, b) => a.data.name.compareTo(b.data.name));
  //       _itemUnSelected.sort((a, b) => a.data.name.compareTo(b.data.name));

  //       _items = _itemSelected + _itemUnSelected;

  //       _items.insert(0, _me);
  //       break;

  //     default:
  //   }

  //   _changeStatusOfSelectAllButton();
  // }

  // void _sortSelectedItems() {
  //   // TODO : Optimization is needed
  //   List<Item<dynamic>> _itemSelected =
  //       _items.where((element) => element.isSelected).toList();
  //   List<Item<dynamic>> _itemUnSelected =
  //       _items.where((element) => !element.isSelected).toList();

  //   _itemSelected.sort((a, b) => a.data.name.compareTo(b.data.name));
  //   _itemUnSelected.sort((a, b) => a.data.name.compareTo(b.data.name));

  //   _items = _itemSelected + _itemUnSelected;
  // }
}
