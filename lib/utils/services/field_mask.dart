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
];

final List<String> kGroupFieldMask = [
  'name',
  'description',
  'language_ids',
  'users',
  'evaluation_category_ids',
];

final List<String> kGroupUserFieldMask = [
  'group_id',
  'user_id',
  'role',
];

final List<String> kUserFieldMask = [
  'name',
  'phone',
];
