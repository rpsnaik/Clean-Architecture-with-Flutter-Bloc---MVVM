import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:zomato_clone/core/env/i_env.dart';
import 'package:zomato_clone/core/env/prod_env.dart';
import 'package:zomato_clone/core/handlers/network_response_handler.dart';
import 'package:zomato_clone/core/network_service/i_network_service.dart';
import 'package:zomato_clone/core/network_service/network_service.dart';
import 'package:zomato_clone/features/restarunts/data/data_sources.dart';
import 'package:zomato_clone/features/restarunts/data/models.dart';
import 'package:zomato_clone/features/restarunts/data/repo.dart';
import 'package:zomato_clone/features/restarunts/domain/repo.dart';
import 'package:zomato_clone/features/restarunts/domain/usecases.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_bloc.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_events.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_states.dart';

import 'mock_json.dart';
import 'restarunts_test.mocks.dart';

@GenerateNiceMocks([MockSpec<NetworkService>()])
void main() {
  IEnv env = ProdEnv();

  initLocators(env);
  INetworkService mockNetworkService = GetIt.I.get();

  test("Test Models", () {
    RestaruntModel restaruntModel =
        RestaruntModel.fromJson({"name": "Test", "cuisine": "Test cuisine"});

    expect(restaruntModel.name, "Test");
    expect(restaruntModel.cuisine, "Test cuisine");
    expect(restaruntModel.imageUrl, null);
  });

  group("Test Load Restarunts", () {
    test("Test Load Restarunts with valid response", () async {
      RestaruntsBloc restaruntsBloc = GetIt.I.get();
      when(mockNetworkService
              .get("/rpsnaik/Hello-Angular/master/food_items.json"))
          .thenAnswer((realInvocation) async {
        await Future.delayed(const Duration(seconds: 1));
        return ApiResponseSuccess(data: RestaruntResponse.validResponse, statusCode: 200);
      });
      restaruntsBloc.add(LoadRestaruntsEvent());
      expect(restaruntsBloc.state is RestaruntsLoading, true);
      await Future.delayed(const Duration(seconds: 2));
      expect(restaruntsBloc.state is RestaruntsLoadError, false);
      expect(restaruntsBloc.state is RestaruntsLoaded, true);
    });

    test("Test Load Restarunts with invalid response", () async {
      RestaruntsBloc restaruntsBloc = GetIt.I.get();
      when(mockNetworkService
              .get("/rpsnaik/Hello-Angular/master/food_items.json"))
          .thenAnswer((realInvocation) async {
        await Future.delayed(const Duration(seconds: 1));
        return ApiResponseSuccess(data: "{}", statusCode: 200);
      });
      restaruntsBloc.add(LoadRestaruntsEvent());
      expect(restaruntsBloc.state is RestaruntsLoading, true);
      await Future.delayed(const Duration(seconds: 2));
      expect(restaruntsBloc.state is RestaruntsLoadError, true);
    });

    test("Test when API failure", () async {
      RestaruntsBloc restaruntsBloc = GetIt.I.get();
      when(mockNetworkService
              .get("/rpsnaik/Hello-Angular/master/food_items.json"))
          .thenAnswer((realInvocation) async {
        await Future.delayed(const Duration(seconds: 1));
        return ApiResponseError(errorMessage: "Internal server error", statusCode: 500);
      });
      restaruntsBloc.add(LoadRestaruntsEvent());
      expect(restaruntsBloc.state is RestaruntsLoading, true);
      await Future.delayed(const Duration(seconds: 2));
      expect(restaruntsBloc.state is RestaruntsLoadError, true);
    });
  });
}

initLocators(IEnv env) {
  GetIt.instance.registerSingleton<INetworkService>(MockNetworkService());
  GetIt.instance
      .registerFactory<IRestaruntsApiService>(() => RestaruntsApiService());
  GetIt.instance.registerFactory<IRestaruntsRepo>(() => RestaruntsRepo());
  GetIt.instance
      .registerFactory<GetRestaruntUsecases>(() => GetRestaruntUsecases());
  GetIt.instance.registerFactory(() => RestaruntsBloc(RestaruntsLoading()));
}
