import 'package:zomato_clone/core/handlers/local_db_response_handler.dart';
import 'package:zomato_clone/core/local_db_service/i_local_database_service.dart';

class LocalDatabaseService extends ILocalDatabase{
  @override
  Future<ILocalDatabaseResponse> get(String tableName) {
    // TODO: implement get
    throw UnimplementedError();
  }

  @override
  Future<ILocalDatabaseResponse> set(String tableName, Map<String, dynamic> data) {
    // TODO: implement set
    throw UnimplementedError();
  }
  
}