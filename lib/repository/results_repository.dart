import 'package:grpc/grpc_or_grpcweb.dart';
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

  Future<ResponseStream<CreateUpdateGroupEvaluationResponse>>
      createUpdateGroupEvaluations(
              Stream<CreateUpdateGroupEvaluationRequest> request) =>
          apiProvider.createUpdateGroupEvaluations(request);

  Future<ResponseStream<CreateUpdateTransformationResponse>>
      createUpdateTransformations(
              Stream<CreateUpdateTransformationRequest> request) =>
          apiProvider.createUpdateTransformations(request);

  Future<ResponseStream<CreateUpdateTeacherResponseResponse>>
      createUpdateTeacherResponses(
              Stream<CreateUpdateTeacherResponseRequest> request) =>
          apiProvider.createUpdateTeacherResponses(request);

  Future<ResponseStream<CreateUpdateOutputResponse>> createUpdateOutputs(
          Stream<CreateUpdateOutputRequest> request) =>
      apiProvider.createUpdateOutputs(request);

  Future<ResponseStream<LearnerEvaluation>> listLearnerEvaluations() =>
      apiProvider.listLearnerEvaluations();

  Future<ResponseStream<TeacherResponse>> listTeacherResponses() =>
      apiProvider.listTeacherResponses();

  Future<ResponseStream<GroupEvaluation>> listGroupEvaluations() =>
      apiProvider.listGroupEvaluations();

  Future<ResponseStream<Transformation>> listTransformations() =>
      apiProvider.listTransformations();

  Future<ResponseStream<Output>> listOutputs() => apiProvider.listOutputs();
}
