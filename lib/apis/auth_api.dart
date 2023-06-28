import 'package:appwrite/appwrite.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:jobbhai/core/failure.dart';
import 'package:jobbhai/core/type_def.dart';
import 'package:appwrite/models.dart' as model;
import 'appwrite_injects.dart';

final authApiProvider = Provider((ref) {
  return AuthAPI(account: ref.watch(appwriteAuthProvider));
});

abstract class AuthInterface {
  FutureEither<model.User> recruiterSignUp({
    required String email,
    required String password,
  });
  FutureEither<model.User> applicantSignUp({
    required String email,
    required String password,
  });
  FutureEither<model.Session> signIn({
    required String email,
    required String password,
  });
  Future<model.User?> currentUserAccount();
  FutureEither<void> logout();
}

class AuthAPI implements AuthInterface {
  final Account _account;
  AuthAPI({required Account account}) : _account = account;
  @override
  FutureEither<model.User> applicantSignUp({
    required String email,
    required String password,
  }) async {
    try {
      final signUp = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: 'applicant',
      );
      return right(signUp);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<model.User> recruiterSignUp({
    required String email,
    required String password,
  }) async {
    try {
      final signUp = await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: 'recruiter',
      );
      return right(signUp);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  FutureEither<model.Session> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      return right(session);
    } on AppwriteException catch (e) {
      return left(Failure(e.message!));
    }
  }

  @override
  Future<model.User?> currentUserAccount() async {
    try {
      return await _account.get();
    } on AppwriteException {
      return null;
    } catch (e) {
      return null;
    }
  }

  @override
  FutureEither<void> logout() async {
    try {
      await _account.deleteSession(
        sessionId: 'current',
      );
      return right(null);
    } on AppwriteException catch (e) {
      return left(
        Failure(e.message ?? 'Some error occurred'),
      );
    } catch (e) {
      return left(
        Failure(e.toString()),
      );
    }
  }
}
