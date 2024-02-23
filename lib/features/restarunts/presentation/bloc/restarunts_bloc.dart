import 'package:get_it/get_it.dart';
import 'package:zomato_clone/core/handlers/data_handlers.dart';
import 'package:zomato_clone/features/restarunts/domain/entities.dart';
import 'package:zomato_clone/features/restarunts/domain/usecases.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_events.dart';
import 'package:zomato_clone/features/restarunts/presentation/bloc/restarunts_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RestaruntsBloc extends Bloc<RestaruntEvents, RestaruntsStates> {
  GetRestaruntUsecases getRestaruntUsecases;

  RestaruntsBloc(super.initialState,
      {GetRestaruntUsecases? getRestaruntUsecases})
      : getRestaruntUsecases = getRestaruntUsecases ?? GetIt.I.get() {
    on<LoadRestaruntsEvent>((event, Emitter<RestaruntsStates> emit) async {
      await loadRestarunts(emit);
    });
  }

  loadRestarunts(Emitter<RestaruntsStates> emit) async {
    emit(RestaruntsLoading());
    IDataState<List<RestaruntEntity>> response =
        await getRestaruntUsecases.execute();
    if (response is DataStatsSuccess) {
      emit(RestaruntsLoaded(restarunts: response.data ?? []));
    } else {
      emit(RestaruntsLoadError(errorMesage: response.errorMessage));
    }
  }
}
