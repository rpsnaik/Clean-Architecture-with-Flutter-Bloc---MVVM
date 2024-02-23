import 'dart:convert';

import 'package:get_it/get_it.dart';
import 'package:zomato_clone/core/handlers/data_handlers.dart';
import 'package:zomato_clone/core/handlers/network_response_handler.dart';
import 'package:zomato_clone/features/restarunts/data/data_sources.dart';
import 'package:zomato_clone/features/restarunts/data/models.dart';
import 'package:zomato_clone/features/restarunts/domain/entities.dart';
import 'package:zomato_clone/features/restarunts/domain/repo.dart';

class RestaruntsRepo extends IRestaruntsRepo {
  IRestaruntsApiService restaruntsApiService;

  RestaruntsRepo({IRestaruntsApiService? restaruntsApiService})
      : restaruntsApiService = restaruntsApiService ?? GetIt.I.get();

  @override
  Future<IDataState<List<RestaruntEntity>>> getRestarunts() async {
    IApiResponse response = await restaruntsApiService.fetchRestaruntsData();
    if (response is ApiResponseSuccess) {
      try {
        var responseData = jsonDecode(response.data);
        List<RestaruntModel> restarunts = [];
        for (var restaruntMap in responseData["restaurants"]) {
          restarunts.add(RestaruntModel.fromJson(restaruntMap));
        }
        return DataStatsSuccess(data: restarunts);
      } catch (e) {
        return DataStateError(errorMessage: "Error in response parsing + $e");
      }
    }
    return DataStateError(errorMessage: response.errorMessage);
  }
}
