final List<String> kMaterialFieldMask = [
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

final List<String> kCurrentUserFieldMask = [
  'name',
  'phone',
  'country_ids',
  'language_ids',
  'link_groups',
  'dialling_code',
  'selected_actions_tab',
  'selected_results_tab',
];

final List<String> kGroupFieldMask = [
  'name',
  'description',
  'link_email',
  'language_ids',
  'users',
  'evaluation_category_ids',
  'status',
];

final List<String> kGroupUserFieldMask = [
  'group_id',
  'user_id',
  'role',
];

final List<String> kUserFieldMask = [
  'name',
  'phone',
  'phone_country_id',
  'dialling_code'
];

final List<String> kActionFieldMask = [
  'name',
  'type',
  'group_id',
  'instructions',
  'material_id',
  'question',
  'date_due',
];

final List<String> kActionUserFieldMask = [
  'status',
  'teacher_response',
  'user_response',
  'evaluation',
];

final List<String> kTransformationFieldMask = [
  'impactStory',
];
