import 'dart:convert';

import 'package:cartify_web/global_variable.dart';
import 'package:cartify_web/models/buyer.dart';
import 'package:http/http.dart' as http;

class BuyerController {

  Future <List<Buyer>> loadBuyers() async {
    try {
      // http get request to fetch Buyers
      http.Response response = await http.get(Uri.parse("$uri/api/users"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      print(response.body);
      if (response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List <Buyer> buyers = data.map((buyer)=>Buyer.fromMap(buyer)).toList();
        return buyers;
      }
      else{
        throw Exception("Failed to load Buyers");
      }

    } catch (e) {
      throw Exception("Error fetching Buyers: $e");
    }
  }
}