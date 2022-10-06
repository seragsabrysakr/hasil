import 'package:hassel/shared/app_utils/app_constants.dart';
import 'package:injectable/injectable.dart';

import '/../shared/app_utils/app_extensions.dart';
import '../../domain/model/base_model.dart';
import '../response/base_response.dart';
import 'mapper.dart';

@injectable
class BaseResponseMapper {
  BaseDM<M> mapFromEntity<M>(BaseResponse? entity, {EntityMapper? dataMapper}) {
    return BaseDM(
        status: entity?.success.orFalse() ?? false,
        message: entity?.message.orEmpty() ?? AppConstants.empty,
        data: dataMapper == null
            ? entity?.message.orEmpty()
            : mapData(entity?.data, dataMapper));
  }

  List<BaseDM> mapFromEntityList(List<BaseResponse> entities) {
    return entities.map((entity) => mapFromEntity(entity)).toList();
  }

  dynamic mapData(dynamic data, EntityMapper dataMapper) {
    if (data is List) {
      return dataMapper.mapFromEntityList(data);
    } else {
      return dataMapper.mapFromEntity(data);
    }
  }
}
