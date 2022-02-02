import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starfish/constants/app_colors.dart';
import 'package:starfish/constants/text_styles.dart';
import 'package:starfish/db/hive_material.dart';
import 'package:starfish/repository/materials_repository.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/enums/action_type.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ActionTypeSelector extends StatefulWidget {
  Action_Type? selectedActionType;
  HiveMaterial? selectedMaterial;
  String? instructions;
  String? question;
  final Function(Action_Type?) onActionTypeChange;
  final Function(String?) onInstructionsChange;
  final Function(String?) onQuestionChange;
  final Function(HiveMaterial?) onMaterialChange;

  ActionTypeSelector({
    Key? key,
    required this.onActionTypeChange,
    required this.onInstructionsChange,
    required this.onQuestionChange,
    required this.onMaterialChange,
    this.selectedActionType = Action_Type.TEXT_INSTRUCTION,
    this.selectedMaterial,
    this.instructions = '',
    this.question = '',
  }) : super(key: key);

  @override
  _ActionTypeSelectorState createState() => _ActionTypeSelectorState();
}

class _ActionTypeSelectorState extends State<ActionTypeSelector> {
  final TextEditingController _instructionController = TextEditingController();
  final TextEditingController _questionController = TextEditingController();

  Action_Type _selectedActionType = Action_Type.TEXT_INSTRUCTION;
  HiveMaterial? _selectedMaterial;

  @override
  void initState() {
    super.initState();
    _instructionController.text = widget.instructions ?? '';
    _questionController.text = widget.question ?? '';

    if (widget.selectedActionType != null) {
      _selectedActionType = widget.selectedActionType!;
    }

    if (widget.selectedActionType != null) {
      _selectedMaterial = widget.selectedMaterial;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 4.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 52.h,
            decoration: BoxDecoration(
              color: AppColors.txtFieldBackground,
              borderRadius: BorderRadius.all(
                Radius.circular(10),
              ),
            ),
            child: DropdownButtonHideUnderline(
              child: ButtonTheme(
                alignedDropdown: true,
                child: DropdownButton<Action_Type>(
                  isExpanded: true,
                  iconSize: 35,
                  style: TextStyle(
                    color: Color(0xFF434141),
                    fontSize: 16.sp,
                    fontFamily: 'OpenSans',
                  ),
                  hint: Text(
                    widget.selectedActionType!.about,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Color(0xFF434141),
                      fontSize: 16.sp,
                      fontFamily: 'OpenSans',
                    ),
                    textAlign: TextAlign.left,
                  ),
                  onChanged: (Action_Type? value) {
                    setState(() {
                      _selectedActionType = value!;
                      widget.onActionTypeChange(value);
                    });
                  },
                  items: Action_Type.values
                      .map<DropdownMenuItem<Action_Type>>((Action_Type value) {
                    return DropdownMenuItem<Action_Type>(
                      value: value,
                      child: Text(
                        value.about,
                        style: TextStyle(
                          color: Color(0xFF434141),
                          fontSize: 14.sp,
                          fontFamily: 'OpenSans',
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),

          SizedBox(height: 20.h),

          Text(
            AppLocalizations.of(context)!.instructions,
            textAlign: TextAlign.left,
            style: titleTextStyle,
          ),

          SizedBox(height: 13.h),

          TextFormField(
            maxLines: 4,
            maxLength: 200,
            controller: _instructionController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
              hintText: AppLocalizations.of(context)!.hintInstructions,
              hintStyle: formTitleHintStyle,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: widget.onInstructionsChange,
          ),

          SizedBox(height: 20.h),

          // Action_Type.TEXT_INSTRUCTION child view
          Visibility(
            child: Container(
                margin: EdgeInsets.symmetric(vertical: 4.h),
                child: Container()),
            visible: _selectedActionType == Action_Type.TEXT_INSTRUCTION,
          ),

          // Action_Type.TEXT_RESPONSE child view
          Visibility(
            child: Container(
              child: _questionsWidget(),
            ),
            visible: _selectedActionType == Action_Type.TEXT_RESPONSE,
          ),

          // Action_Type.MATERIAL_INSTRUCTION child view
          Visibility(
            child: Container(
              child: _selectMaterialWidget(),
            ),
            visible: _selectedActionType == Action_Type.MATERIAL_INSTRUCTION,
          ),

          // Action_Type.MATERIAL_RESPONSE child view
          Visibility(
            child: Container(
              child: Column(
                children: [
                  _selectMaterialWidget(),
                  SizedBox(height: 20.h),
                  _questionsWidget(),
                ],
              ),
            ),
            visible: _selectedActionType == Action_Type.MATERIAL_RESPONSE,
          ),
        ],
      ),
    );
  }

  Widget _questionsWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.questionToBeAnswered,
          textAlign: TextAlign.left,
          style: titleTextStyle,
        ),
        SizedBox(height: 13.h),
        TextFormField(
          maxLines: null,
          controller: _questionController,
          keyboardType: TextInputType.multiline,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(
                color: Colors.transparent,
              ),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
          onChanged: (String? value) {
            widget.onQuestionChange(value);
          },
        ),
      ],
    );
  }

  Widget _selectMaterialWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context)!.selectAMaterial,
          textAlign: TextAlign.left,
          style: titleTextStyle,
        ),
        SizedBox(height: 13.h),
        Container(
          height: 52.h,
          decoration: BoxDecoration(
            color: AppColors.txtFieldBackground,
            borderRadius: BorderRadius.all(
              Radius.circular(10),
            ),
          ),
          child: FutureBuilder(
            future: MaterialRepository().fetchMaterialsFromDB(),
            builder: (BuildContext context,
                AsyncSnapshot<List<HiveMaterial>> snapshot) {
              if (snapshot.hasData) {
                return _createMaterialSelector(snapshot.data!);
              } else {
                return Container();
              }
            },
          ),
        ),
      ],
    );
  }

  Widget _createMaterialSelector(List<HiveMaterial> materials) {
    return DropdownButtonHideUnderline(
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<HiveMaterial>(
          isExpanded: true,
          iconSize: 35,
          style: TextStyle(
            color: Color(0xFF434141),
            fontSize: 16.sp,
            fontFamily: 'OpenSans',
          ),
          hint: Text(
            _selectedMaterial != null
                ? _selectedMaterial!.title!
                : AppLocalizations.of(context)!.selectAMaterial,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Color(0xFF434141),
              fontSize: 16.sp,
              fontFamily: 'OpenSans',
            ),
            textAlign: TextAlign.left,
          ),
          onChanged: (HiveMaterial? value) {
            setState(() {
              _selectedMaterial = value;
              widget.onMaterialChange(_selectedMaterial);
            });
          },
          items: materials
              .map<DropdownMenuItem<HiveMaterial>>((HiveMaterial value) {
            return DropdownMenuItem<HiveMaterial>(
              value: value,
              child: Text(
                value.title!,
                style: TextStyle(
                  color: Color(0xFF434141),
                  fontSize: 14.sp,
                  fontFamily: 'OpenSans',
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
