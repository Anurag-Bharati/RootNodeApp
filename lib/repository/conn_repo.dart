import 'package:rootnode/data_source/remote_data_store/conn_remote_data_source.dart';
import 'package:rootnode/data_source/remote_data_store/response/res_conn.dart';
import 'package:rootnode/model/conn.dart';

abstract class ConnRepo {
  Future<List<Connection>> getMyConns({int page = 1, int refresh = 0});
  Future<List<Connection>> getRecommendedConns({int page = 1, int refresh = 0});
  Future<List<Connection>> getRandomConns({int page = 1, int refresh = 0});
  Future<bool> checkIfConnected({required String id});
  Future<bool> toggleConnection({required String id});
  Future<String?> updateConn({required String id});
  Future<ConnOverviewResponse?> getOldRecentConns();
}

class ConnRepoImpl extends ConnRepo {
  @override
  Future<bool> checkIfConnected({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Connection>> getMyConns({int page = 1, int refresh = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<ConnOverviewResponse?> getOldRecentConns() async {
    return await ConnRemoteDataSource().getOldRecentConns();
  }

  @override
  Future<List<Connection>> getRandomConns({int page = 1, int refresh = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<List<Connection>> getRecommendedConns(
      {int page = 1, int refresh = 0}) {
    throw UnimplementedError();
  }

  @override
  Future<bool> toggleConnection({required String id}) {
    throw UnimplementedError();
  }

  @override
  Future<String?> updateConn({required String id}) {
    throw UnimplementedError();
  }
}
