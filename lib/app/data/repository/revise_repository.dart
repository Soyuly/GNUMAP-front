import 'package:gnumap/app/data/model/revise_model.dart';
import 'package:gnumap/app/data/provider/revise_post_api.dart';

class ReviseRepository {
  final ReviseApiClient apiClient;

  ReviseRepository({required this.apiClient}) : assert(apiClient != null);

  postRevise(ReviseModel revise) {
    return apiClient.postRevise(revise);
  }
}
