import 'package:cartify_web/controller/order_controller.dart';
import 'package:cartify_web/models/order.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({super.key});

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  // a future that will hold the list of Orders once loaded from the api
  late Future<List<Order>> futureOrders;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureOrders = OrderController().loadOrders();
  }

  @override
  Widget build(BuildContext context) {
    Widget orderData(int flex, Widget widget) {
      return Expanded(flex: flex, child: widget);
    }

    return FutureBuilder(
      future: futureOrders,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text('No Orders available'));
        } else {
          final orders = snapshot.data!;
          return ListView.builder(
            shrinkWrap: true,
            itemCount: orders.length,

            itemBuilder: (context, index) {
              final order = orders[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    orderData(
                      2,
                      Image.network(
                        order.image,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                    orderData(
                      3,
                      order.productName.isNotEmpty
                          ? Text(
                            order.productName,
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    orderData(
                      2,
                      Text(
                        '₹${order.productPrice}',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 15,
                          color: Colors.green,
                        ),
                      ),
                    ),
                    orderData(
                      2,
                      order.category.isNotEmpty
                          ? Text(
                            order.category,
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    orderData(
                      3,
                      order.fullName.isNotEmpty
                          ? Text(
                            order.fullName,
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    orderData(
                      2,
                      order.email.isNotEmpty
                          ? Text(
                            order.email,
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    orderData(
                      2,
                      order.state.isNotEmpty
                          ? Text(
                            '${order.state}, ${order.city}',
                            style: GoogleFonts.montserrat(
                              //fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                          : Icon(Icons.person),
                    ),
                    orderData(
                      1,
                      Text(
                        order.delivered
                            ? 'Delivered'
                            : order.processing
                            ? 'Processing'
                            : 'Cancelled',
                        style: GoogleFonts.montserrat(
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                          color:
                              order.delivered
                                  ? Colors.green
                                  : order.processing
                                  ? Colors.orange
                                  : Colors.red,
                        ),
                      ),
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
