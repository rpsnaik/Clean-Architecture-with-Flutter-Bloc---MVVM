abstract class IDataState<T> {
  T? data;
  String? errorMessage;

  IDataState({this.data, this.errorMessage});
}

class DataStatsSuccess<T> extends IDataState<T> {
  DataStatsSuccess({required super.data});
}

class DataStateError<T> extends IDataState<T> {
  DataStateError({required super.errorMessage});
}
