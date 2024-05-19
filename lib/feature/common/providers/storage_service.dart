import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:roflit/core/entity/account.dart';
import 'package:roflit/core/enums.dart';
import 'package:roflit/core/providers/di_service.dart';
import 'package:roflit/data/local/api_db.dart';
import 'package:roflit/feature/common/providers/session/provider.dart';

part 'storage_service.g.dart';

@riverpod
StorageService storageService(StorageServiceRef ref) {
  return StorageService(
    sessionBloc: ref.watch(sessionBlocProvider.notifier),
    apiLocalClient: ref.watch(diServiceProvider).apiLocalClient.accountsDao,
  );
}

final class StorageService {
  final SessionBloc sessionBloc;
  final AccountDao apiLocalClient;

  StorageService({
    required this.sessionBloc,
    required this.apiLocalClient,
  });

  Future<bool> createStorage({
    required String name,
    required AppLocalization localization,
    required String password,
  }) async {
    if (name.isEmpty ||
        name.isNotEmpty && name.length < 3 ||
        password.isNotEmpty && password.length < 3) {
      //TODO snackbar
      return false;
    }

    final account = AccountEntity(
      idAccount: -1,
      name: name,
      localization: localization,
      password: password.isEmpty ? null : password,
      activeBucket: '',
    );

    final responseAccount = await apiLocalClient.createAccount(account: account);

    if (responseAccount == null) {
      return false;
      //TODO snackbar
    }
    // await Future.delayed(Duration(seconds: 3), () {});
    await sessionBloc.loginFreeAccount(responseAccount);
    // });
    //TODO snackbar
    return true;
  }

  // Future<bool> updateStorage({
  //   required int? idStorage,
  //   required String name,
  //   required AppLocalization localization,
  //   required String password,
  // }) async {
  //   if (idStorage == null) return false;
  //   if (name.isEmpty ||
  //       name.isNotEmpty && name.length < 3 ||
  //       password.isNotEmpty && password.length < 3) {
  //     //TODO snackbar
  //     return false;
  //   }

  //   final account = AccountEntity(
  //     idAccount: idAccount,
  //     name: name,
  //     localization: localization,
  //     password: password.isEmpty ? null : password,
  //   );

  //   final response = await apiLocalClient.updateAccount(account: account);

  //   if (!response) {
  //     return false;
  //     //TODO snackbar
  //   }
  //   //TODO snackbar
  //   return true;
  // }

  // Future<bool> deleteStorage({required int idStorage}) async {
  //   final responseSession = await sessionBloc.clearSession(idAccount);

  //   if (!responseSession) {
  //     return false;
  //     //TODO snackbar
  //   }

  //   final response = await apiLocalClient.deleteAccount(idAccount: idAccount);

  //   if (!response) {
  //     return false;
  //     //TODO snackbar
  //   }

  //   return response;
  // }
}
