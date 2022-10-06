import 'package:dartz/dartz.dart';

import '../../data/network/error_handler.dart';

abstract class BaseUseCase<In, Out> {
  Future<Either<Failure, Out>> execute(In input);
}
