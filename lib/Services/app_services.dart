import 'dart:convert';
import 'package:covid_app/Models/world_stats_%20model.dart';
import 'package:covid_app/Services/utilities/app_urls.dart';
import 'package:http/http.dart' as http;

class AppServices {
  static final client = http.Client();

// ! Get all the world's Data with model
  static Future<world_stats_model> fetchWorldStats() async {
    final url = Uri.https(AppUrl.baseUri, AppUrl.worldStateApi);
    final response = await client.get(url);

    if (response.statusCode == 200) {
      var data = jsonDecode(response.body);
      return world_stats_model.fromJson(data);
    } else {
      throw Exception("Error has been occurred");
    }
  }

  // ! get the data of the countries without model

  static Future<List<dynamic>> fetchCountriesStats() async {
    final url = Uri.https(AppUrl.baseUri, AppUrl.allCountries);
    final response = await client.get(url);
    if (response.statusCode == 200) {
      List<dynamic> data = jsonDecode(response.body);
      return data;
    } else {
      throw Exception("Error has been occurred");
    }
  }
}


//! API CHECKING (K aaya call ho bhi rhi hai ya nhi!)
// void main(List<String> args) async {
//   var data = await AppServices.fetchCountriesStats();
//   for (var i in data) {
//     print(i["country"]);
//   }
// }
