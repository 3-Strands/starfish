import 'package:grpc/grpc.dart';
import 'package:starfish/db/providers/results_provider.dart';
import 'package:starfish/src/generated/starfish.pb.dart';
import 'package:starfish/utils/services/api_provider.dart';

class ResultsRepository {
  final dbProvider = ResultsProvider();
  final apiProvider = ApiProvider();

  Future<ResponseStream<CreateUpdateLearnerEvaluationResponse>>
      createUpdateLearnerEvaluations(
              Stream<CreateUpdateLearnerEvaluationRequest> request) =>
          apiProvider.createUpdateLearnerEvaluations(request);

  Future<ResponseStream<CreateUpdateTeacherResponseResponse>>
      createUpdateTeacherResponses(
              Stream<CreateUpdateTeacherResponseRequest> request) =>
          apiProvider.createUpdateTeacherResponses(request);

  Future<ResponseStream<LearnerEvaluation>> listLearnerEvaluations() =>
      apiProvider.listLearnerEvaluations();

  Future<ResponseStream<TeacherResponse>> listTeacherResponses() =>
      apiProvider.listTeacherResponses();
}
