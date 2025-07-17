import 'package:cartify_web/controller/category_controller.dart';
import 'package:cartify_web/models/category.dart';
import 'package:flutter/material.dart';

class CategoryWidget extends StatefulWidget {
  const CategoryWidget({super.key});

  @override
  State<CategoryWidget> createState() => _CategoryWidgetState();
}

class _CategoryWidgetState extends State<CategoryWidget> {
  // a future that will hold the list of categories once loaded from the api
  late Future<List<Category>> futureCategories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureCategories = CategoryController().loadCategories();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: futureCategories, builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      else if(snapshot.hasError){
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      else if(!snapshot.hasData || snapshot.data!.isEmpty){
        return const Center(child: Text('No categories available'));
      }
      else{
        final categories = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          itemCount: categories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final category = categories[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (category.image.isNotEmpty)
                  Image.network(category.image,height: 100,width: 100,),
                Text(category.name, textAlign: TextAlign.center),
              ],
            );
          },
        ); 
      }
    });
  }
}