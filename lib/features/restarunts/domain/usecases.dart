import 'package:get_it/get_it.dart';
import 'package:zomato_clone/core/handlers/data_handlers.dart';
import 'package:zomato_clone/features/restarunts/domain/entities.dart';
import 'package:zomato_clone/features/restarunts/domain/repo.dart';

class GetRestaruntUsecases {
  IRestaruntsRepo repo;

  GetRestaruntUsecases({IRestaruntsRepo? repo}) : repo = repo ?? GetIt.I.get();

  Future<IDataState<List<RestaruntEntity>>> execute() async {
    return repo.getRestarunts();
  }
}
