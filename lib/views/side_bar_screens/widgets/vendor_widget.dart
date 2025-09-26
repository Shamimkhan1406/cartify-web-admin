import 'package:cartify_web/controller/vendor_controller.dart';
import 'package:cartify_web/models/vendor.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class VendorWidget extends StatefulWidget {
  const VendorWidget({super.key});

  @override
  State<VendorWidget> createState() => _VendorWidgetState();
}

class _VendorWidgetState extends State<VendorWidget> {
  // a future that will hold the list of vendors once loaded from the api
  late Future<List<Vendor>> futureVendors;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureVendors = VendorController().loadVendors();
  }

  @override
  Widget build(BuildContext context) {
    Widget _vendorData(int flex, Widget widget) {
      return Expanded(flex: flex, child: widget);
    }

    return FutureBuilder(
      future: futureVendors,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No vendors available'));
        } else {
          final vendors = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: vendors.length,

            itemBuilder: (context, index) {
              final vendor = vendors[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    _vendorData(
                      1,
                      CircleAvatar(
                        child:
                            vendor.fullName.isNotEmpty
                                ? Text(
                                  vendor.fullName[0],
                                  style: GoogleFonts.montserrat(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                )
                                : Icon(Icons.person),
                      ),
                    ),
                    _vendorData(
                      3,
                      vendor.fullName.isNotEmpty
                          ? Text(
                            vendor.fullName,
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    _vendorData(
                      2,
                      vendor.fullName.isNotEmpty
                          ? Text(
                            vendor.email,
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    _vendorData(
                      2,
                      vendor.state.isNotEmpty
                          ? Text(
                            '${vendor.state}, ${vendor.city}',
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    _vendorData(
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
