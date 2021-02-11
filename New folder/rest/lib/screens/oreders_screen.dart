import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';
import '../widgets/app_drawer.dart';

class OrdersSceren extends StatelessWidget {
  static const routeName = '/orders';

  // @override
  // void initState() {
  //   // Future.delayed(Duration.zero).then((_) async {
  //   //   setState(() {
  //   //     _isLoading = true;
  //   //   });
  //   //   await Provider.of<Orders>(context, listen: false).fetchAndSetOreders();
  //   //   setState(() {
  //   //     _isLoading = false;
  //   //   });
  //   // });
  //   // TODO: implement initState
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    // final orederData = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      // body: _isLoading
      //     ? Center(
      //         child: CircularProgressIndicator(
      //           backgroundColor: Colors.amber,
      //         ),
      //       )
      //     : ListView.builder(
      //         itemBuilder: (ctx, i) => OrderItem(orederData.orders[i]),
      //         itemCount: orederData.orders.length,
      //       ),

      body: FutureBuilder(
        future:
            Provider.of<Orders>(context, listen: false).fetchAndSetOreders(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.error != null) {
              return Center(
                child: Text('An error occured'),
              );
            } else {
              return Consumer<Orders>(
                builder: (ctx, orderData, child) {
                  return ListView.builder(
                    itemBuilder: (ctx, i) => OrderItem(orderData.orders[i]),
                    itemCount: orderData.orders.length,
                  );
                },
              );
            }
          }
        },
      ),
      drawer: AppDrawer(),
    );
  }
}
