import 'package:cloudinary_public/cloudinary_public.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class CategoryController {
  uploadCategory( { required dynamic pickedImage, required dynamic pickedBanner}) async {
    
  final String cloudName = dotenv.env['CLOUDINARY_CLOUD_NAME'] ?? 'default_cloud';
  final String uploadPreset = dotenv.env['CLOUDINARY_UPLOAD_PRESET'] ?? 'default_preset';


    try {
      final cloudinary = CloudinaryPublic(cloudName, uploadPreset);
      CloudinaryResponse imageResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedImage, identifier: "pickedImage", folder: "categoryImages"),
      );
      print(imageResponse);
      CloudinaryResponse bannerResponse = await cloudinary.uploadFile(
        CloudinaryFile.fromBytesData(pickedBanner, identifier: "pickedBanner", folder: "categoryImages"),
      );
      print(bannerResponse);
    } catch (e) {
      print("error: $e");
    }
  }
}