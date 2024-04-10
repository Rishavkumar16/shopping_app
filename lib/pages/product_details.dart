import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_app/providers/cart_provider.dart';

class ProductDetailsPage extends StatefulWidget {
  final Map<String,Object> product;
  const ProductDetailsPage({
    super.key,
    required this.product,
  }) ;

  @override
  State<ProductDetailsPage> createState() => _ProductDetailsPageState();
}

class _ProductDetailsPageState extends State<ProductDetailsPage> {
  int selectedSize=0;


  void onTap() {
    if(selectedSize!=0) {
      Provider.of<CartProvider>(context, listen: false).addProduct(
        {
          'id': widget.product['id'],
          'title': widget.product ['title'],
          'price': widget.product ['price'],
          'size': selectedSize,
          'company': widget.product['company'],
          'imageURL': widget.product['imageURL'],
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content:
        Text('Product Added Successfully'),
        ),
      );
    }
    else{
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content:
            Text('Please Select the Size'),
          ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Details')),
      ),
      body: Column(
        children: [
          Center(
            child: Text(widget.product['title']as String? ?? 'Default Title',
            style: Theme.of(context).textTheme.titleLarge,),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Image.asset(widget.product['imageURL']as String),
          ),
          const Spacer(flex: 2,),
          Container(
            height: 250,
            decoration: BoxDecoration(
              color:const Color.fromRGBO(245, 247, 249, 1),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Column(
              children: [
                Text('Rs ${widget.product['price']}',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 30,),
                SizedBox(
                  height: 50,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                      itemCount: (widget.product['sizes']as List<int>).length,
                      itemBuilder: (context,index){
                        final size=(widget.product['sizes']as List<int>)[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                selectedSize=size;
                              });
                            },
                            child: Chip(label: Text(size.toString()),
                              backgroundColor: selectedSize==size?Colors.yellow:null,
                            ),
                          ),
                        );
                  }),
                ),
                const SizedBox(height: 25,),

                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: ElevatedButton(
                    onPressed: onTap,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.yellow,
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child:const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.shopping_cart,  // Replace with your cart icon
                          size: 24,
                        ),
                        SizedBox(width: 8), // Add some spacing between the icon and text
                        Text(
                          'Add to Cart',
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
          )
        ],
      ),
    );
  }
}

