import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shopping_app/pages/home_page.dart';
class PaymentPage extends StatelessWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    void handlePaymentErrorResponse(){
      Text('Payment Unsuccessful');
    }
    void handlePaymentSuccessResponse(){
      Text('Payment Successful');
    }
    void handleExternalWalletSelected(){
      Text('External Wallet Selected');
    }
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightGreen,
        title: Text(
          'Payments Page',
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Text('Choose a Payment Method',
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 28
              ),
            ),
            SizedBox(
              height: 150,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: (){
              Razorpay razorpay = Razorpay();
              var options = {
                'key': 'E9uou9ZjHwaemqmSjlIvIKbA',
                'amount': 100,
                'name': 'Acme Corp.',
                'description': 'Fine T-Shirt',
                'retry': {'enabled': true, 'max_count': 1},
                'send_sms_hash': true,
                'prefill': {'contact': '9910618531', 'email': 't.guptacool1909@gmail.com'},
                'external': {
                  'wallets': ['paytm']
                }
              };
              razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
              razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
              razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
              razorpay.open(options);
            },
                child: const Text("Pay with Razorpay",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                )
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.yellow,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: (){
                  showDialog(
                    context: context,
                    builder: (context) {
                      return SuccessNotification();
                    },
                  );
                  },
                child: const Text("Cash on Delivery",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold
                  ),
                )
            ),


          ],
        ),
      ),
      bottomNavigationBar:Padding(
        padding: const EdgeInsets.all(20.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            minimumSize:  const Size(double.infinity, 50),
          ),
          onPressed: () {
            showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  title: Text('Cancel Order',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                    ),
                  ),
                  content: Text('Are you sure you want to cancel your order?'),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // User confirmed the cancellation
                        Navigator.of(context).pop(); // Close the dialog
                        showDialog(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('Order Canceled'),
                              content: Text('Your order has been canceled.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the success dialog
                                    Navigator.push(context,MaterialPageRoute(builder:(context)=> HomePage())); // Go back to the previous page
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      },
                      child: Text('Yes',
                        style: TextStyle(
                            color: Colors.green
                        ),),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Close the dialog
                      },
                      child: Text('No',
                        style: TextStyle(
                            color: Colors.red
                        ),
                      ),
                    ),
                  ],
                );
              },
            );
          },
          child: const Text(
            'Cancel Order',
            style: TextStyle(
              fontSize: 20,
            ),
          ),
        ),
      ),
    );
  }
}


class SuccessNotification extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: Colors.green,
            child: Icon(
              Icons.check,
              color: Colors.white,
              size: 36.0,
            ),
          ),
          SizedBox(height: 16.0),
          Text(
            'Your order is placed',
            style: TextStyle(fontSize: 18.0),
          ),
        ],
      ),
    );
  }
}
