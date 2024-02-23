import 'package:zomato_clone/core/handlers/local_db_response_handler.dart';

abstract class ILocalDatabase {
  // Set Data in local db
  Future<ILocalDatabaseResponse> set(
      String tableName, Map<String, dynamic> data);

  // Fetching data in local db
  Future<ILocalDatabaseResponse> get(String tableName);
}
