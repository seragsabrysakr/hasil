import 'package:dio/dio.dart';
import 'package:hassel/data/model/category_model.dart';
import 'package:hassel/data/model/productModel.dart';
import 'package:hassel/shared/app_utils/app_urls.dart';
import 'package:retrofit/http.dart';

part 'home_api_services.g.dart';

@RestApi(baseUrl: '')
abstract class HomeServiceClient {
  factory HomeServiceClient(Dio dio, {String baseUrl}) = _HomeServiceClient;
  @GET(AppUrls.categories)
  Future<List<CategoryModel>> getCategories({
    @Query(AppUrls.consumerKey) required String consumerKey,
    @Query(AppUrls.consumerSecret) required String consumerSecret,
  });
  @GET(AppUrls.products)
  Future<List<ProductModel>> geAllProducts({
    @Query(AppUrls.consumerKey) required String consumerKey,
    @Query(AppUrls.consumerSecret) required String consumerSecret,
  });
  @GET('https://hasseal.com/wp-json/wc/v3/products/{id}')
  Future<ProductModel> geSingleProducts({
    @Path("id") required String id,
    @Query(AppUrls.consumerKey) required String consumerKey,
    @Query(AppUrls.consumerSecret) required String consumerSecret,
  });
}
