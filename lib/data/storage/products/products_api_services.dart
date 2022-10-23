import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';


part 'products_api_services.g.dart';

@RestApi(baseUrl: '')
abstract class ProductsServiceClient {
  factory ProductsServiceClient(Dio dio, {String baseUrl}) =
  _ProductsServiceClient;


}
