import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/pages/personal_detailsPage.dart';
import '../providers/cart_provider.dart';

class TotalBill extends StatelessWidget {
  const TotalBill({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<CartProvider>(context).cart;

    // Calculate the total amount
    double totalAmount = 0;
    for (var item in cart) {
      totalAmount += item['price'];
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Your Total Bill',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
      ),
      body: ListView.builder(
          itemCount: cart.length,
          itemBuilder: (context,index){
            final cartItem=cart[index];
            return ListTile(
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(cartItem['imageURL']as String),
                backgroundColor: Colors.blue,
              ),
              title: Text(
                cartItem['title']as String,
                style: Theme.of(context).textTheme.bodySmall,
              ),
              subtitle: Text(
                'Size: ${cartItem['size']}'
                '                               '
                'Price:Rs ${cartItem['price']}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('Above are your selected items'),
            SizedBox(height: 20,),
            Text('Total Amount',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold)
            ),

            Text(' Rs ${totalAmount.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold)
            ),
          SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>PersonalDetails()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                minimumSize: const Size(double.infinity, 50),
              ),
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.person,  // Replace with your cart icon
                    size: 24,
                  ),
                  SizedBox(width: 8), // Add some spacing between the icon and text
                  Text(
                    'Proceed for Details',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
    );

  }
}

