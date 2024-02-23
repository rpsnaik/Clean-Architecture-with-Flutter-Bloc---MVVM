import 'package:zomato_clone/features/restarunts/domain/entities.dart';

abstract class RestaruntsStates {
  String? errorMesage;
  List<RestaruntEntity>? restarunts;

  RestaruntsStates({this.restarunts, this.errorMesage});
}

class RestaruntsLoading extends RestaruntsStates {}

class RestaruntsLoaded extends RestaruntsStates {
  RestaruntsLoaded({required super.restarunts});
}

class RestaruntsLoadError extends RestaruntsStates {
  RestaruntsLoadError({required super.errorMesage});
}
