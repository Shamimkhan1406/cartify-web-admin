import 'package:cartify_web/controller/buyer_controller.dart';
import 'package:cartify_web/models/buyer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BuyerWidgets extends StatefulWidget {
  const BuyerWidgets({super.key});

  @override
  State<BuyerWidgets> createState() => _BuyerWidgetsState();
}

class _BuyerWidgetsState extends State<BuyerWidgets> {
  // a future that will hold the list of buyers once loaded from the api
  late Future<List<Buyer>> futureBuyers;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureBuyers = BuyerController().loadBuyers();
  }

  @override
  Widget build(BuildContext context) {
    Widget _buyerData(int flex, Widget widget) {
      return Expanded(flex: flex, child: widget);
    }

    return FutureBuilder(
      future: futureBuyers,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No buyers available'));
        } else {
          final buyers = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: buyers.length,

            itemBuilder: (context, index) {
              final buyer = buyers[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    _buyerData(
                      1,
                      CircleAvatar(
                        child:
                            buyer.fullName.isNotEmpty
                                ? Text(
                                  buyer.fullName[0],
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                                : Icon(Icons.person),
                      ),
                    ),
                    _buyerData(
                      3,
                      buyer.fullName.isNotEmpty
                          ? Text(
                            buyer.fullName,
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    _buyerData(
                      2,
                      buyer.fullName.isNotEmpty
                          ? Text(
                            buyer.email,
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    _buyerData(
                      2,
                      buyer.state.isNotEmpty
                          ? Text(
                            '${buyer.state}, ${buyer.city}',
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    _buyerData(
                      1,
                      TextButton(onPressed: (){}, child: Text('Delete', style: GoogleFonts.montserrat(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.red
                      ),)),
                    ),
                  ],
                ),
              );
            },
          );
        }
      },
    );
  }
}
