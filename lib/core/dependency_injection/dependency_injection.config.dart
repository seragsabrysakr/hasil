// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i9;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i3;
import 'package:shared_preferences/shared_preferences.dart' as _i7;

import '../../data/storage/aurh/auth_api_services.dart' as _i13;
import '../../data/storage/home/home_api_services.dart' as _i10;
import '../../data/storage/products/products_api_services.dart' as _i11;
import '../../features/home/presentation/cubits/categories_cubit.dart' as _i20;
import '../../features/home/presentation/cubits/category_product_cubit.dart'
    as _i21;
import '../../features/home/presentation/cubits/products_cubit.dart' as _i16;
import '../../features/home/presentation/cubits/single_product_cubit.dart'
    as _i17;
import '../../features/intro/presentation/cubits/intro_cubit.dart' as _i4;
import '../../features/profile/my_orders/cubits/orders_cubit.dart' as _i15;
import '../../features/profile/my_orders/cubits/track_order_cubit.dart' as _i18;
import '../../repository/auth_repository.dart' as _i19;
import '../../repository/home_repository.dart' as _i14;
import '../../shared/app_utils/app_prefs.dart' as _i8;
import '../app_business_logic/app_cubit/app_cubit.dart' as _i12;
import '../data/network/network_info.dart' as _i5;
import '../data/network/save_api.dart' as _i6;
import 'module/di_module.dart' as _i22;
import 'module/dio_module.dart' as _i23; // ignore_for_file: unnecessary_lambdas

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
  gh.factory<_i3.InternetConnectionChecker>(() => dIModule.connectionChecker);
  gh.factory<_i4.IntroCubit>(() => _i4.IntroCubit());
  gh.factory<_i5.NetworkInfo>(
      () => _i5.NetworkInfoImpl(get<_i3.InternetConnectionChecker>()));
  gh.factory<_i6.SafeApi>(() => _i6.SafeApi(get<_i5.NetworkInfo>()));
  await gh.factoryAsync<_i7.SharedPreferences>(
    () => dIModule.prefs,
    preResolve: true,
  );
  gh.factory<_i8.AppPreferences>(
      () => _i8.AppPreferences(get<_i7.SharedPreferences>()));
  await gh.factoryAsync<_i9.Dio>(
    () => dioModule.getDio(get<_i8.AppPreferences>()),
    preResolve: true,
  );
  gh.factory<_i10.HomeServiceClient>(
      () => dIModule.getCategoryServiceClient(get<_i9.Dio>()));
  gh.factory<_i11.ProductsServiceClient>(
      () => dIModule.getProductsServiceClient(get<_i9.Dio>()));
  gh.factory<_i12.AppCubit>(() => _i12.AppCubit(get<_i8.AppPreferences>()));
  gh.factory<_i13.AuthServiceClient>(
      () => dIModule.getAuthServiceClient(get<_i9.Dio>()));
  gh.factory<_i14.HomeRepository>(() => _i14.HomeRepository(
        get<_i10.HomeServiceClient>(),
        get<_i6.SafeApi>(),
        get<_i8.AppPreferences>(),
      ));
  gh.factory<_i15.OrdersCubit>(() => _i15.OrdersCubit(
        get<_i14.HomeRepository>(),
        get<_i8.AppPreferences>(),
      ));
  gh.factory<_i16.ProductsCubit>(() => _i16.ProductsCubit(
        get<_i14.HomeRepository>(),
        get<_i8.AppPreferences>(),
      ));
  gh.factory<_i17.SingleProductsCubit>(() => _i17.SingleProductsCubit(
        get<_i14.HomeRepository>(),
        get<_i8.AppPreferences>(),
      ));
  gh.factory<_i18.TrackOrderCubit>(() => _i18.TrackOrderCubit(
        get<_i14.HomeRepository>(),
        get<_i8.AppPreferences>(),
      ));
  gh.factory<_i19.AuthRepository>(() => _i19.AuthRepository(
        get<_i13.AuthServiceClient>(),
        get<_i6.SafeApi>(),
        get<_i8.AppPreferences>(),
      ));
  gh.factory<_i20.CategoriesCubit>(() => _i20.CategoriesCubit(
        get<_i14.HomeRepository>(),
        get<_i8.AppPreferences>(),
      ));
  gh.factory<_i21.CategoryProductsCubit>(() => _i21.CategoryProductsCubit(
        get<_i14.HomeRepository>(),
        get<_i8.AppPreferences>(),
      ));
  return get;
}

class _$DIModule extends _i22.DIModule {}

class _$DioModule extends _i23.DioModule {}
