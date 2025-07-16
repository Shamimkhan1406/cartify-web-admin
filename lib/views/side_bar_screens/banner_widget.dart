import 'package:cartify_web/controller/banner_controller.dart';
import 'package:cartify_web/models/banner.dart';
import 'package:flutter/material.dart';

class BannerWidget extends StatefulWidget {
  const BannerWidget({super.key});

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  // a future that will hold the list of banners once loaded from the api
  late Future<List<BannerModel>> futureBanners;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBanners = BannerController().loadBanners();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: futureBanners,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No banners available'));
        } else {
          final banners = snapshot.data!;
          return GridView.builder(
            shrinkWrap: true,
            itemCount: banners.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 6,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
            ),
            itemBuilder: (context, index) {
              final banner = banners[index];
              if (banner.image.isEmpty) {
                return Container(
                  color: Colors.grey[300],
                  child: Icon(
                    Icons.broken_image,
                    size: 48,
                    color: Colors.grey[700],
                  ),
                );
              }
              return Image.network(
                banner.image,
                fit: BoxFit.cover,
                errorBuilder:
                    (context, error, stackTrace) => Container(
                      color: Colors.grey[300],
                      child: Icon(
                        Icons.broken_image,
                        size: 48,
                        color: Colors.grey[700],
                      ),
                    ),
              );
            },
          );
        }
      },
    );
  }
}
