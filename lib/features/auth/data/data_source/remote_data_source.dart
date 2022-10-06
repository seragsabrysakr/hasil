import 'package:hassel/core/data/response/base_response.dart';
import 'package:injectable/injectable.dart';


import '../network/api.dart';
import '../responce/entity.dart';

abstract class RemoteDataSource {
  Future<BaseResponse<UserEntity>> login();
}

@Injectable(as: RemoteDataSource)
class RemoteDataSourceImpl implements RemoteDataSource {
  final ServiceClient _appServiceClient;

  RemoteDataSourceImpl(this._appServiceClient);

  @override
  Future<BaseResponse<UserEntity>> login() async {
    return await _appServiceClient.login();
  }
}
