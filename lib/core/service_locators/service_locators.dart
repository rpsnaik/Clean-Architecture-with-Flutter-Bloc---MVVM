import 'package:get_it/get_it.dart';
import 'package:zomato_clone/core/env/i_env.dart';
import 'package:zomato_clone/core/network_service/i_network_service.dart';
import 'package:zomato_clone/core/network_service/network_service.dart';
import 'package:zomato_clone/features/restarunts/data/data_sources.dart';
import 'package:zomato_clone/features/restarunts/data/repo.dart';
import 'package:zomato_clone/features/restarunts/domain/repo.dart';
import 'package:zomato_clone/features/restarunts/domain/usecases.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_bloc.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_states.dart';

abstract class IServiceLocators {
  IEnv env;

  IServiceLocators({required this.env});

  Future initServices();

  Future initRestaruntServices();
}

class ServiceLocators extends IServiceLocators {
  ServiceLocators({required super.env});

  @override
  Future initRestaruntServices() async {
    GetIt.instance.registerSingleton<INetworkService>(NetworkService(env: env));
    GetIt.instance
        .registerFactory<IRestaruntsApiService>(() => RestaruntsApiService());
    GetIt.instance.registerFactory<IRestaruntsRepo>(() => RestaruntsRepo());
    GetIt.instance
        .registerFactory<GetRestaruntUsecases>(() => GetRestaruntUsecases());
    GetIt.instance.registerFactory(() => RestaruntsBloc(RestaruntsLoading()));
  }

  @override
  Future initServices() async {
    await initRestaruntServices();
  }
}
