// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i11;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../features/auth/data/data_source/remote_data_source.dart' as _i14;
import '../../features/auth/data/mappers/user_mapper.dart' as _i9;
import '../../features/auth/data/network/api.dart' as _i12;
import '../../features/auth/data/repository_impl/user_impl.dart' as _i16;
import '../../features/auth/domain/repository/user_repository.dart' as _i15;
import '../../features/auth/domain/usecase/user_usecase.dart' as _i17;
import '../../features/auth/presentation/cubit/user_cubit.dart' as _i18;
import '../../features/intro/presentation/cubits/intro_cubit.dart' as _i5;
import '../../shared/app_utils/app_prefs.dart' as _i10;
import '../app_business_logic/app_cubit/app_cubit.dart' as _i13;
import '../data/mapper/base_response_mapper.dart' as _i3;
import '../data/network/network_info.dart' as _i6;
import '../data/network/save_api.dart' as _i7;
import 'module/di_module.dart' as _i19;
import 'module/dio_module.dart' as _i20; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
Future<_i1.GetIt> $initGetIt(
  _i1.GetIt get, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) async {
  final gh = _i2.GetItHelper(
    get,
    environment,
    environmentFilter,
  );
  final dIModule = _$DIModule();
  final dioModule = _$DioModule();
  gh.factory<_i3.BaseResponseMapper>(() => _i3.BaseResponseMapper());
  gh.factory<_i4.InternetConnectionChecker>(() => dIModule.connectionChecker);
  gh.factory<_i5.IntroCubit>(() => _i5.IntroCubit());
  gh.factory<_i6.NetworkInfo>(
      () => _i6.NetworkInfoImpl(get<_i4.InternetConnectionChecker>()));
  gh.factory<_i7.SafeApi>(() => _i7.SafeApi(get<_i6.NetworkInfo>()));
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => dIModule.prefs,
    preResolve: true,
  );
  gh.factory<_i9.UserMapper>(() => _i9.UserMapper());
  gh.factory<_i10.AppPreferences>(
      () => _i10.AppPreferences(get<_i8.SharedPreferences>()));
  await gh.factoryAsync<_i11.Dio>(
    () => dioModule.getDio(get<_i10.AppPreferences>()),
    preResolve: true,
  );
  gh.factory<_i12.ServiceClient>(
      () => dIModule.getServiceClient(get<_i11.Dio>()));
  gh.factory<_i13.AppCubit>(() => _i13.AppCubit(get<_i10.AppPreferences>()));
  gh.factory<_i14.RemoteDataSource>(
      () => _i14.RemoteDataSourceImpl(get<_i12.ServiceClient>()));
  gh.factory<_i15.UserRepository>(() => _i16.UserRepositoryImpl(
        get<_i7.SafeApi>(),
        get<_i14.RemoteDataSource>(),
        get<_i9.UserMapper>(),
      ));
  gh.factory<_i17.UseCase>(() => _i17.UseCase(get<_i15.UserRepository>()));
  gh.factory<_i18.UserCubit>(() => _i18.UserCubit(get<_i17.UseCase>()));
  return get;
}

class _$DIModule extends _i19.DIModule {}

class _$DioModule extends _i20.DioModule {}
