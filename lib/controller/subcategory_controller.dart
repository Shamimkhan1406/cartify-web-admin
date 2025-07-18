import 'package:cartify_web/global_variable.dart';
import 'package:cartify_web/models/sub_category.dart';
import 'package:cartify_web/services/manage_http_response.dart';
import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;

class SubcategoryController {
  uploadSubCategory({
    required String categoryId,
    required String categoryName,
    required dynamic pickedImage,
    required String subCategoryName,
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
      SubCategory subCategory = SubCategory(
        id: "",
        categoryId: categoryId,
        categoryName: categoryName,
        image: image,
        subCategoryName: subCategoryName,
      );
      http.Response response = await http.post(
        Uri.parse("$uri/api/subcategories"),

        body: subCategory.toJson(),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, "Uploaded SubCategory Successfully");
        },
      );
    } catch (e) {
      print("error: $e");
    }
  }
}
