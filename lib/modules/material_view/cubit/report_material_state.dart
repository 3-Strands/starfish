part of 'report_material_cubit.dart';

@immutable
class ReportMaterialState {
  const ReportMaterialState({this.text = '', this.isSubmitted = false});

  final String text;
  final bool isSubmitted;

  bool get isValid => text.isNotEmpty;

  ReportMaterialState asSubmitted() =>
      ReportMaterialState(text: text, isSubmitted: true);
}
