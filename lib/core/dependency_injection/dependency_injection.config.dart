// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i10;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;
import 'package:internet_connection_checker/internet_connection_checker.dart'
    as _i4;
import 'package:shared_preferences/shared_preferences.dart' as _i8;

import '../../data/storage/aurh/auth_api_services.dart' as _i14;
import '../../data/storage/home/home_api_services.dart' as _i11;
import '../../data/storage/home/home_local_data_source.dart' as _i3;
import '../../data/storage/products/products_api_services.dart' as _i12;
import '../../features/auth/presentation/cubit/register_cubit.dart' as _i25;
import '../../features/auth/presentation/cubit/user_cubit.dart' as _i24;
import '../../features/home/presentation/cubits/add_item_cubit.dart' as _i20;
import '../../features/home/presentation/cubits/categories_cubit.dart' as _i22;
import '../../features/home/presentation/cubits/category_product_cubit.dart'
    as _i23;
import '../../features/home/presentation/cubits/products_cubit.dart' as _i17;
import '../../features/home/presentation/cubits/single_product_cubit.dart'
    as _i18;
import '../../features/intro/presentation/cubits/intro_cubit.dart' as _i5;
import '../../features/profile/my_orders/cubits/orders_cubit.dart' as _i16;
import '../../features/profile/my_orders/cubits/track_order_cubit.dart' as _i19;
import '../../repository/auth_repository.dart' as _i21;
import '../../repository/home_repository.dart' as _i15;
import '../../shared/app_utils/app_prefs.dart' as _i9;
import '../app_business_logic/app_cubit/app_cubit.dart' as _i13;
import '../data/network/network_info.dart' as _i6;
import '../data/network/save_api.dart' as _i7;
import 'module/di_module.dart' as _i26;
import 'module/dio_module.dart' as _i27; // ignore_for_file: unnecessary_lambdas

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
  gh.singleton<_i3.HomeLocal>(_i3.CartLocalDataSourceImpl());
  gh.factory<_i4.InternetConnectionChecker>(() => dIModule.connectionChecker);
  gh.factory<_i5.IntroCubit>(() => _i5.IntroCubit());
  gh.factory<_i6.NetworkInfo>(
      () => _i6.NetworkInfoImpl(get<_i4.InternetConnectionChecker>()));
  gh.factory<_i7.SafeApi>(() => _i7.SafeApi(get<_i6.NetworkInfo>()));
  await gh.factoryAsync<_i8.SharedPreferences>(
    () => dIModule.prefs,
    preResolve: true,
  );
  gh.factory<_i9.AppPreferences>(
      () => _i9.AppPreferences(get<_i8.SharedPreferences>()));
  await gh.factoryAsync<_i10.Dio>(
    () => dioModule.getDio(get<_i9.AppPreferences>()),
    preResolve: true,
  );
  gh.factory<_i11.HomeServiceClient>(
      () => dIModule.getCategoryServiceClient(get<_i10.Dio>()));
  gh.factory<_i12.ProductsServiceClient>(
      () => dIModule.getProductsServiceClient(get<_i10.Dio>()));
  gh.factory<_i13.AppCubit>(() => _i13.AppCubit(get<_i9.AppPreferences>()));
  gh.factory<_i14.AuthServiceClient>(
      () => dIModule.getAuthServiceClient(get<_i10.Dio>()));
  gh.factory<_i15.HomeRepository>(() => _i15.HomeRepository(
        get<_i11.HomeServiceClient>(),
        get<_i7.SafeApi>(),
        get<_i9.AppPreferences>(),
        get<_i3.HomeLocal>(),
      ));
  gh.factory<_i16.OrdersCubit>(() => _i16.OrdersCubit(
        get<_i15.HomeRepository>(),
        get<_i9.AppPreferences>(),
      ));
  gh.factory<_i17.ProductsCubit>(() => _i17.ProductsCubit(
        get<_i15.HomeRepository>(),
        get<_i3.HomeLocal>(),
      ));
  gh.factory<_i18.SingleProductsCubit>(() => _i18.SingleProductsCubit(
        get<_i15.HomeRepository>(),
        get<_i9.AppPreferences>(),
      ));
  gh.factory<_i19.TrackOrderCubit>(() => _i19.TrackOrderCubit(
        get<_i15.HomeRepository>(),
        get<_i9.AppPreferences>(),
      ));
  gh.factory<_i20.AddItemToCartCubit>(() => _i20.AddItemToCartCubit(
        get<_i15.HomeRepository>(),
        get<_i9.AppPreferences>(),
      ));
  gh.factory<_i21.AuthRepository>(() => _i21.AuthRepository(
        get<_i14.AuthServiceClient>(),
        get<_i7.SafeApi>(),
        get<_i9.AppPreferences>(),
      ));
  gh.factory<_i22.CategoriesCubit>(() => _i22.CategoriesCubit(
        get<_i15.HomeRepository>(),
        get<_i3.HomeLocal>(),
      ));
  gh.factory<_i23.CategoryProductsCubit>(() => _i23.CategoryProductsCubit(
        get<_i15.HomeRepository>(),
        get<_i9.AppPreferences>(),
      ));
  gh.factory<_i24.LoginCubit>(() => _i24.LoginCubit(
        get<_i21.AuthRepository>(),
        get<_i9.AppPreferences>(),
      ));
  gh.factory<_i25.RegisterCubit>(() => _i25.RegisterCubit(
        get<_i21.AuthRepository>(),
        get<_i9.AppPreferences>(),
      ));
  return get;
}

class _$DIModule extends _i26.DIModule {}

class _$DioModule extends _i27.DioModule {}
