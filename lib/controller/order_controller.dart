import 'dart:convert';

import 'package:cartify_web/global_variable.dart';
import 'package:cartify_web/models/order.dart';
import 'package:http/http.dart' as http;

class OrderController {
  Future <List<Order>> loadOrders() async {
    try {
      // http get request to fetch Orders
      http.Response response = await http.get(Uri.parse("$uri/api/orders"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      print(response.body);
      if (response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List <Order> orders = data.map((order)=>Order.fromJson(order)).toList();
        return orders;
      }
      else{
        throw Exception("Failed to load Orders");
      }

    } catch (e) {
      throw Exception("Error fetching Orders: $e");
    }
  }
}