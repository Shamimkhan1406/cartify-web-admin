import 'package:cartify_web/controller/subcategory_controller.dart';
import 'package:cartify_web/models/sub_category.dart';
import 'package:flutter/material.dart';

class SubcategoryWidget extends StatefulWidget {
  const SubcategoryWidget({super.key});

  @override
  State<SubcategoryWidget> createState() => _SubcategoryWidgetState();
}

class _SubcategoryWidgetState extends State<SubcategoryWidget> {
  // a future that will hold the list of categories once loaded from the api
  late Future<List<SubCategory>> futureSubCategories;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureSubCategories = SubcategoryController().loadSubCategories();
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(future: futureSubCategories, builder: (context, snapshot){
      if(snapshot.connectionState == ConnectionState.waiting){
        return const Center(child: CircularProgressIndicator());
      }
      else if(snapshot.hasError){
        return Center(child: Text('Error: ${snapshot.error}'));
      }
      else if(!snapshot.hasData || snapshot.data!.isEmpty){
        return const Center(child: Text('No sub categories available'));
      }
      else{
        final subcategories = snapshot.data!;
        return GridView.builder(
          shrinkWrap: true,
          itemCount: subcategories.length,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 6,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
          ),
          itemBuilder: (context, index) {
            final subcategory = subcategories[index];
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (subcategory.image.isNotEmpty)
                  Image.network(subcategory.image,height: 100,width: 100,),
                Text(subcategory.subCategoryName, textAlign: TextAlign.center),
              ],
            );
          },
        ); 
      }
    });
  }
}