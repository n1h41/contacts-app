import 'package:capcee/models/user_model.dart';
import 'package:dio/dio.dart';

final url = "https://jsonplaceholder.typicode.com/users";

class Webservices {
  Future getData() async {
    final response = await Dio().get(url);
    /* print(response.statusCode); */
    return response;
  }
}
