import 'package:flutter/cupertino.dart';
import 'package:http/http.dart';
import 'package:http/src/response.dart';
import 'package:new_bloc_weather_app/data/dataprovider/remote_urls.dart';

import '../remote_service.dart';

class ApiService extends RemoteService{
  @override
  Future<Response> getWeatherData(String location) async{
    Map<String, dynamic> queryParameters = {
      'q':location,
      'key': '8904bd6425524a6e99032853231708',
      'days':'3'
    };
    // TODO: implement getWeatherData
   final response = await get(Uri.https(RemoteUrls.baseUrl, RemoteUrls.endPoint, queryParameters));
   return response;
  }

}