import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rootnode/helper/simple_storage.dart';
import 'package:rootnode/model/user/user.dart';
import 'package:rootnode/provider/user_provider.dart';
import 'package:rootnode/repository/user_repo.dart';

class SessionModel {
  final String? token;
  final User? user;
  final bool isAuthenticated;
  final bool ready;
  final Map<String, dynamic> metaData;

  const SessionModel({
    this.token,
    this.isAuthenticated = false,
    this.user,
    this.ready = false,
    this.metaData = const {},
  });

  SessionModel copyWith(
      {String? token,
      User? user,
      bool? isAuthenticated,
      bool? ready,
      Map<String, dynamic>? metaData}) {
    return SessionModel(
      token: token ?? this.token,
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      ready: ready ?? this.ready,
      metaData: metaData ?? this.metaData,
    );
  }
}

class SessionProvider extends StateNotifier<SessionModel> {
  final Ref ref;
  static const _initial = SessionModel();

  SessionProvider(this.ref, [SessionModel sessionModel = _initial])
      : super(sessionModel) {
    init();
  }
  void updateUser({required User user}) {
    if (state.user == null) {
      state = state.copyWith(user: user);
      return;
    }
    state = state.copyWith(
      user: state.user!.copyWith(
        usernameChangedAt:
            user.usernameChangedAt ?? state.user!.usernameChangedAt,
        showOnlineStatus: user.showOnlineStatus ?? state.user!.showOnlineStatus,
        emailVerified: user.emailVerified ?? state.user!.emailVerified,
        storiesCount: user.storiesCount ?? state.user!.storiesCount,
        connsCount: user.connsCount ?? state.user!.connsCount,
        nodesCount: user.nodesCount ?? state.user!.nodesCount,
        isVerified: user.isVerified ?? state.user!.isVerified,
        postsCount: user.postsCount ?? state.user!.postsCount,
        updatedAt: user.updatedAt ?? state.user!.updatedAt,
        createdAt: user.createdAt ?? state.user!.createdAt,
        username: user.username ?? state.user!.username,
        lastSeen: user.lastSeen ?? state.user!.lastSeen,
        status: user.status ?? state.user!.status,
        avatar: user.avatar ?? state.user!.avatar,
        fname: user.fname ?? state.user!.fname,
        lname: user.lname ?? state.user!.lname,
        email: user.email ?? state.user!.email,
        id: user.id ?? state.user!.id,
      ),
    );
  }

  User? getUser() {
    return state.user;
  }

  Future<void> init() async {
    final String? tokenString = await SimpleStorage.getStringData('token');
    state = state.copyWith(
        ready: true, isAuthenticated: false, user: ref.read(userProvider));
    if (tokenString != null) setToken(tokenString);
  }

  Future<void> setToken(String token) async {
    SimpleStorage.saveStringData('token', token);
    final user = await UserRepoImpl().getUserFromToken();
    ref.read(userProvider.notifier).update((state) => user);
    state = state.copyWith(
      token: token,
      isAuthenticated: true,
      user: ref.read(userProvider),
      ready: true,
    );
  }
}

final sessionProvider = StateNotifierProvider<SessionProvider, SessionModel>(
  (ref) => SessionProvider(ref),
);
