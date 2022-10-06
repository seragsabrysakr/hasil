import 'package:dartz/dartz.dart';
import 'package:hassel/core/data/network/error_handler.dart';
import 'package:hassel/features/auth/domain/model/use_model.dart';

abstract class UserRepository {
  Future<Either<Failure, UserModel>> login();
}
