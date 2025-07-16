import 'dart:convert';

import 'package:cartify_web/global_variable.dart';
import 'package:cartify_web/models/category.dart';
import 'package:cartify_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class CategoryController {
  uploadCategory({
    required dynamic pickedImage,
    required dynamic pickedBanner,
    required String name,
    required context,
  }) async {
    final String cloudName =
        dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? 'default_cloud';
    final String uploadPreset =
        dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? 'default_preset';

    try {
      final cloudinary = CloudinaryPublic(cloudName, uploadPreset);
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedImage,
          identifier: "pickedImage",
          folder: "categoryImages",
        ),
      );
      String image = imageResponse.secureUrl;
      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(
          pickedBanner,
          identifier: "pickedBanner",
          folder: "categoryImages",
        ),
      );
      String banner = bannerResponse.secureUrl;
      Category category = Category("", name, image, banner);
      http.Response response =await http.post(Uri.parse("$uri/api/categories"),
        body: category.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, "Uploaded Category Successfully");
      });
    } catch (e) {
      print("error: $e");
    }
  }
  // load the uploaded categories
  Future<List<Category>> loadCategories() async {
    try {
      http.Response response = await http.get(Uri.parse("$uri/api/categories"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print(response.body);
      if (response.statusCode == 200) {
        final List<dynamic> data = jsonDecode(response.body);
        List<Category> categories = data.map((category)=>Category.fromJson(category)).toList();
        return categories;
      }
      else {
        throw Exception("Failed to load categories");
      }
    } catch (e) {
      throw Exception("Error loading categories: $e");
    }
  }
}
