import 'dart:convert';

import 'package:cartify_web/global_variable.dart';
import 'package:cartify_web/models/banner.dart';
import 'package:cartify_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;


class BannerController {
  final String cloudName =
        dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? 'default_cloud';
    final String uploadPreset =
        dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? 'default_preset';

  uploadBanner({required dynamic pickedImage, required context}) async{
    try {
      final cloudinary = CloudinaryPublic(cloudName, uploadPreset);
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage, identifier: "pickedImage", folder: "banners"),
      );
      String image = imageResponse.secureUrl;
      BannerModel banner = BannerModel(id: "", image: image);
      http.Response response = await http.post(Uri.parse("$uri/api/banner"),
        body: banner.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      manageHttpResponse(response: response, context: context, onSuccess: (){
        showSnackBar(context, "Uploaded Banner Successfully");
      });
    } catch (e) {
      print("error: $e");
      
    }

  }
  // fetch banner
  Future <List<BannerModel>> loadBanners() async {
    try {
      // http get request to fetch banners
      http.Response response = await http.get(Uri.parse("$uri/api/banner"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        }
      );
      print(response.body);
      if (response.statusCode == 200){
        List<dynamic> data = jsonDecode(response.body);
        List <BannerModel> banners = data.map((banner)=>BannerModel.fromJson(banner)).toList();
        return banners;
      }
      else{
        throw Exception("Failed to load banners");
      }

    } catch (e) {
      throw Exception("Error fetching banners: $e");
    }
  }
}