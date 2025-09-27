import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrdersScreen extends StatelessWidget {
  static const String id = 'orders-screen';
  const OrdersScreen({super.key});

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
                  'Manage Orders',
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
                rowHeader(2, "Product Image"),
                rowHeader(3, "Product Name"),
                rowHeader(2, "Product Price"),
                rowHeader(2, "Category"),
                rowHeader(3, "Buyer Name"),
                rowHeader(2, "Buyer Email"),
                rowHeader(2, "Buyer Address"),
                rowHeader(1, "Status"),
              ],
            ),
            SizedBox(height: 15,),
            
          ],
        ),
      ),
    );
  }
}
