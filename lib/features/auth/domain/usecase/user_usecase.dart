import 'package:dartz/dartz.dart';
import 'package:hassel/core/data/network/error_handler.dart';
import 'package:hassel/core/domain/usecase/base_usecase.dart';
import 'package:hassel/features/auth/domain/model/use_model.dart';
import 'package:hassel/features/auth/domain/repository/user_repository.dart';


import 'package:injectable/injectable.dart';

@injectable
class UseCase implements BaseUseCase<void, UserModel> {
  final UserRepository _repository;

  UseCase(this._repository);

  @override
  Future<Either<Failure, UserModel>> execute(void input) async {
    return await _repository.login();
  }
}
