import 'package:cartify_web/views/side_bar_screens/widgets/buyer_widgets.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyersScreen extends StatelessWidget {
  static const String id = '\buyers-screen';
  const BuyersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    Widget _rowHeader(int flex, String text){
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
                  'Manage Buyers',
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
                _rowHeader(1, "Image"),
                _rowHeader(3, "Full Name"),
                _rowHeader(2, "Email"),
                _rowHeader(2, "Address"),
                _rowHeader(1, "Delete"),
              ],
            ),
            SizedBox(height: 15,),
            BuyerWidgets(),
          ],
        ),
      ),
    );
  }
}
