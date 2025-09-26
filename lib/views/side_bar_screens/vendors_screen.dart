import 'package:cartify_web/views/side_bar_screens/widgets/vendor_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';



class VendorsScreen extends StatelessWidget {
  static const String id = '\vendors-screen';
  const VendorsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget rowHeader(int flex, String text){
      return Expanded(
        flex: flex,
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey),
            color: const Color.fromARGB(255, 176, 125, 185)
          ),
          child: Padding(padding: const EdgeInsets.all(8.0),
            child: Text(text, style: GoogleFonts.montserrat(fontSize: 15 ,fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
        ),
      );
    }
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Manage Vendors',
                  style: GoogleFonts.montserrat(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple
                  ),
                ),
              ),
            ),
            SizedBox(height: 15,),
            Row(
              children: [
                rowHeader(1, "Image"),
                rowHeader(3, "Full Name"),
                rowHeader(2, "Email"),
                rowHeader(2, "Address"),
                rowHeader(1, "Delete"),
              ],
            ),
            SizedBox(height: 15,),
            VendorWidget(),
          ],
        ),
      ),
    );
  }
}
