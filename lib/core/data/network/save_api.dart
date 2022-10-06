import 'package:dartz/dartz.dart';
import 'package:flutter/rendering.dart';
import 'package:injectable/injectable.dart';

import '/../core/data/network/error_handler.dart';
import '/../core/data/network/network_info.dart';
import '/../core/data/response/base_response.dart';

@injectable
class SafeApi {
  final NetworkInfo _networkInfo;

  SafeApi(this._networkInfo);

  Future<Either<Failure, T>> call<T, M>(
      {required Future<dynamic> apiCall,
      VoidCallback? clearCash,
      T Function(BaseResponse<M>)? onMap}) async {
    if (await _networkInfo.isConnected) {
      try {
        // its safe to call API
        final response = await apiCall;
        if (response.success) {
          // success
          // return right
          if (onMap != null) {
            // return Right(mapper.mapFromEntity(response.data));

            return Right(onMap.call(response));
          } else {
            if (clearCash != null) clearCash.call();
            return Right(response.message);
          }
        } else {
          // failure
          // return left

          return Left(Failure(
              response.hashCode, response.message ?? ResponseMessage.DEFAULT));
        }
      } catch (error, s) {
        print("SafeApi Error: $error");
        print("SafeApi Error: $s");
        return Left(ErrorHandler.handle(error).failure);
      }
    } else {
      // return network connection error
      // return left
      return Left(DataSource.NO_INTERNET_CONNECTION.getFailure());
    }
  }
}
