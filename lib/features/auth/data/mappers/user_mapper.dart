import 'package:hassel/shared/app_utils/app_constants.dart';
import 'package:hassel/shared/app_utils/app_extensions.dart';
import 'package:hassel/core/data/mapper/mapper.dart';

import 'package:hassel/features/auth/data/responce/entity.dart';
import 'package:hassel/features/auth/domain/model/use_model.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserMapper extends EntityMapper<UserEntity, UserModel> {
  @override
  UserModel mapFromEntity(UserEntity? entity) {
    return UserModel(
      id: entity?.id.orZero() ?? AppConstants.zero,
      name: entity?.name.orEmpty() ?? AppConstants.empty,
      isLog: entity?.isLog.orFalse() ?? false,
    );
  }

  @override
  List<UserModel> mapFromEntityList(List<UserEntity> entities) {
    return entities.map((entity) => mapFromEntity(entity)).toList();
  }

  @override
  UserEntity? mapToEntity(UserModel domainModel) {
    throw UnimplementedError();
  }
}
