import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/pages/total_bill.dart';
import 'package:shopping_app/providers/cart_provider.dart';


class CartPage extends StatelessWidget {
  const CartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart=(Provider.of<CartProvider>(context).cart);
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text('Cart',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
      ),
      body: Column(
        children:<Widget> [
          Expanded(
            child: ListView.builder(
              itemCount: cart.length,
                itemBuilder: (context,index){
                  final cartItem=cart[index];
                  return ListTile(
                    leading: CircleAvatar(
                      radius: 30,
                      backgroundImage: AssetImage(cartItem['imageURL']as String),
                      backgroundColor: Colors.blue,
                    ),
                    trailing: IconButton(
                      onPressed: (){
                        showDialog(
                            context: context,
                            builder: (context){
                              return AlertDialog(
                                title: Text('Delete Product',
                                style: Theme.of(context).textTheme.titleMedium,
                                ),
                                content: const Text('Are you sure you want to delete this product?'),
                                actions: [
                                  TextButton(
                                    onPressed:(){
                                      Provider.of<CartProvider>(context, listen: false).removeProduct(cartItem);
                                      Navigator.of(context).pop();
                                    } ,
                                    child: const Text('Yes',
                                    style: TextStyle(
                                      color: Colors.blue,
                                      fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                    onPressed:(){
                                      Navigator.of(context).pop();
                                    } ,
                                    child: const Text('No',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                        );
                      },
                      icon: const Icon(
                        Icons.delete,
                      color: Colors.red,
                      ),
                    ),
                    title: Text(
                      cartItem['title']as String,
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    subtitle: Text(
                      'Size: ${cartItem['size']}',
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  );
                }),
          ),
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: ElevatedButton(
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context)=>TotalBill()));
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                minimumSize: const Size(double.infinity, 50),
              ),
              child:const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.currency_rupee,  // Replace with your cart icon
                    size: 24,
                  ),
                  SizedBox(width: 8), // Add some spacing between the icon and text
                  Text(
                    'Buy NOW',
                    style: TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );

  }
}


