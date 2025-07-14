import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class CategoryScreen extends StatefulWidget {
  static const String id = '\category-screen';
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  late String categoryName;
  dynamic _image;
  pickImage() async {
    FilePickerResult? result =  await FilePicker.platform.pickFiles(
      type: FileType.image,
      allowMultiple: false,
    );
    if (result != null){
      setState(() {
        _image = result.files.first.bytes;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Categories',
                      style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Divider(color: Colors.grey),
                ),
                Row(
                  children: [
                    Container(
                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Center(
                        child: _image != null ? Image.memory(_image) : Text('Image'),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 200,
                        child: TextFormField(
                          onChanged: (value){
                            categoryName = value;
                          },
                          validator: (value){
                            if(value == null || value.isEmpty){
                              return 'Please Enter Category Name';
                            }
                            else{
                              return null;
                            }
                          },
                          decoration: const InputDecoration(
                            labelText: 'Enter Category Name',
                          ),
                        ),
                      ),
                    ),
                    TextButton(onPressed: () {}, child: Text('Cancel')),
                    ElevatedButton(
                      onPressed: () {
                        if(_formKey.currentState!.validate()){
                          print(categoryName);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xff051247),
                      ),
                      child: Text('Save', style: TextStyle(color: Colors.white)),
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(onPressed: (){
                    pickImage();
                  }, child: Text('Upload Image')),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Divider(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
