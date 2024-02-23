import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:zomato_clone/core/env/i_env.dart';
import 'package:zomato_clone/core/env/prod_env.dart';
import 'package:zomato_clone/core/handlers/network_response_handler.dart';
import 'package:zomato_clone/core/network_service/i_network_service.dart';
import 'package:zomato_clone/features/restarunts/data/data_sources.dart';
import 'package:zomato_clone/features/restarunts/data/repo.dart';
import 'package:zomato_clone/features/restarunts/domain/repo.dart';
import 'package:zomato_clone/features/restarunts/domain/usecases.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_bloc.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_states.dart';
import 'package:zomato_clone/features/restarunts/presentation/pages/restarunts_screen.dart';

import 'mock_json.dart';
import 'restarunts_test.mocks.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  IEnv env = ProdEnv();

  initLocators(env);
  INetworkService mockNetworkService = GetIt.I.get();

  testWidgets("Test Appbar text", (widgetTester) async {
    when(mockNetworkService
            .get("/rpsnaik/Hello-Angular/master/food_items.json"))
        .thenAnswer((realInvocation) async {
      return ApiResponseSuccess(
          data: RestaruntResponse.validResponse, statusCode: 200);
    });
    await widgetTester.pumpWidget(const MaterialApp(
      home: RestaruntsScreen(),
    ));
    final appBarTextFinder = find.text("Restarunts Screen");
    expect(appBarTextFinder, findsOne);
  });

  testWidgets("Test Loader", (widgetTester) async {
    when(mockNetworkService
            .get("/rpsnaik/Hello-Angular/master/food_items.json"))
        .thenAnswer((realInvocation) async {
      return ApiResponseSuccess(
          data: RestaruntResponse.validResponse, statusCode: 200);
    });
    await widgetTester.pumpWidget(const MaterialApp(
      home: RestaruntsScreen(),
    ));
    final loaderFinder = find.byType(CircularProgressIndicator);
    expect(loaderFinder, findsOne);
  });

  testWidgets("Test Success load", (widgetTester) async {
    when(mockNetworkService
            .get("/rpsnaik/Hello-Angular/master/food_items.json"))
        .thenAnswer((realInvocation) async {
      return ApiResponseSuccess(
          data: RestaruntResponse.validResponse, statusCode: 200);
    });
    await widgetTester.pumpWidget(const MaterialApp(
      home: RestaruntsScreen(),
    ));
    await widgetTester.pumpAndSettle();
    final listTileFinder = find.byType(ListTile);
    expect(listTileFinder, findsAny);
  });

  testWidgets("Test Invalid API response", (widgetTester) async {
    when(mockNetworkService
            .get("/rpsnaik/Hello-Angular/master/food_items.json"))
        .thenAnswer((realInvocation) async {
      return ApiResponseSuccess(data: "{}", statusCode: 200);
    });
    await widgetTester.pumpWidget(const MaterialApp(
      home: RestaruntsScreen(),
    ));
    await widgetTester.pumpAndSettle();
    final listTileFinder = find.textContaining("Error in response parsing");
    expect(listTileFinder, findsOne);
  });

  testWidgets("Test API Failure", (widgetTester) async {
    when(mockNetworkService
            .get("/rpsnaik/Hello-Angular/master/food_items.json"))
        .thenAnswer((realInvocation) async {
      await Future.delayed(const Duration(seconds: 1));
      return ApiResponseError(
          errorMessage: "Internal server error", statusCode: 500);
    });
    await widgetTester.pumpWidget(const MaterialApp(
      home: RestaruntsScreen(),
    ));
    await widgetTester.pumpAndSettle();
    final listTileFinder = find.textContaining("Internal server error");
    expect(listTileFinder, findsOne);
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
