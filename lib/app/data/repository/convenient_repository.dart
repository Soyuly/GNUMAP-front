import 'package:gnumap/app/data/provider/convenient_list_api.dart';

class ConvenientRepository {
  final ConvenientClient apiClient;

  ConvenientRepository({required this.apiClient}) : assert(apiClient != null);

  getAll(String category) {
    return apiClient.getAll(category);
  }
}
