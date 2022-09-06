part of 'generateCode.dart';

final List<String> _kMaterialFieldMask = [
  'title',
  'description',
  'visibility',
  'editability',
  'url',
  'files',
  'language_ids',
  'type_ids',
  'topics',
];

final List<String> _kCurrentUserFieldMask = [
  'name',
  'phone',
  'country_ids',
  'language_ids',
  'link_groups',
  'dialling_code',
  'selected_actions_tab',
  'selected_results_tab',
];

final List<String> _kGroupFieldMask = [
  'name',
  'description',
  'link_email',
  'language_ids',
  'evaluation_category_ids',
  'status',
];

final List<String> _kGroupUserFieldMask = [
  'role',
  'profile',
];

final List<String> _kUserFieldMask = [
  'name',
  'phone',
  'phone_country_id',
  'dialling_code'
];

final List<String> _kActionFieldMask = [
  'name',
  'type',
  'group_id',
  'instructions',
  'material_id',
  'question',
  'date_due',
];

final List<String> _kActionUserFieldMask = [
  'status',
  'teacher_response',
  'user_response',
  'evaluation',
];

final List<String> _kTransformationFieldMask = [
  'impact_story',
  'files',
];
