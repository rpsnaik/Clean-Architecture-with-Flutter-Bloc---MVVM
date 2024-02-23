import 'package:zomato_clone/core/handlers/data_handlers.dart';
import 'package:zomato_clone/features/restarunts/domain/entities.dart';

abstract class IRestaruntsRepo{
  Future<IDataState<List<RestaruntEntity>>> getRestarunts();
}