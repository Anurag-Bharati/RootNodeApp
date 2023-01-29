import 'package:rootnode/model/conn.dart';

abstract class ConnRepo {
  Future<List<Connection>> getMyConns({int page = 1, int refresh = 0});
  Future<List<Connection>> getRecommendedConns({int page = 1, int refresh = 0});
  Future<List<Connection>> getRandomConns({int page = 1, int refresh = 0});
  Future<bool> checkIfConnected({required String id});
  Future<bool> toggleConnection({required String id});
  Future<String?> updateConn({required String id});
  Future<List<Connection>> getOldRecentConns();
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
  Future<List<Connection>> getOldRecentConns() {
    throw UnimplementedError();
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
