import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:moonlit/screens/store_product.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import '../constants.dart';
import '../provider/add_to_cart_provider.dart';

class StoreCart extends StatefulWidget {
  const StoreCart({super.key});

  @override
  State<StoreCart> createState() => _StoreCartState();
}

class _StoreCartState extends State<StoreCart> {
  @override
  void dispose() {
    Provider.of<CartProvider>(context, listen: false).dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Scaffold(
      backgroundColor: kcontentColor,
      bottomSheet: const CheckOutBox(),
      body: Scaffold(
        appBar: AppBar(
          backgroundColor: kcontentColor,
          title: const Text(
            "My Cart",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 25,
            ),
          ),
          centerTitle: true,
        ),
        body: ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.5),
          child: Consumer<CartProvider>(
            builder: (context, provider, child) {
              final finalList = provider.cart;
              return ListView.builder(
                shrinkWrap: true,
                controller: ScrollController(),
                itemCount: finalList.length,
                itemBuilder: (context, index) {
                  final cartItems = finalList[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => StoreProduct(
                            product: finalList[index],
                          ),
                        ),
                      );
                    },
                    child: Stack(children: [
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: isWideScreen ? 20 : 10,
                          vertical: isWideScreen ? 15 : 10,
                        ),
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(isWideScreen ? 25 : 20),
                            color: Colors.white,
                          ),
                          padding: EdgeInsets.all(isWideScreen ? 25 : 20),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: isWideScreen ? 150 : 100,
                                width: isWideScreen ? 120 : 90,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(
                                      isWideScreen ? 25 : 20),
                                  color: kcontentColor,
                                ),
                                child: Image.asset(cartItems.image1,
                                    fit: BoxFit.cover),
                              ),
                              SizedBox(width: isWideScreen ? 15 : 10),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      cartItems.title,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isWideScreen ? 20 : 16,
                                      ),
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    SizedBox(height: isWideScreen ? 10 : 5),
                                    Text(
                                      cartItems.category,
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isWideScreen ? 16 : 14,
                                        color: Colors.grey.shade400,
                                      ),
                                    ),
                                    SizedBox(height: isWideScreen ? 15 : 10),
                                    Text(
                                      //add here
                                      "₹ ${cartItems.price}",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: isWideScreen ? 16 : 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: isWideScreen ? 15 : 10),
                              Column(
                                children: [
                                  IconButton(
                                    onPressed: () {
                                      setState(() {
                                        finalList.removeAt(index);
                                      });
                                    },
                                    icon: Icon(
                                      Icons.delete,
                                      color: Colors.red,
                                      size: isWideScreen ? 25 : 20,
                                    ),
                                  ),
                                  SizedBox(height: isWideScreen ? 15 : 10),
                                  Container(
                                    height: 40,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(
                                          isWideScreen ? 25 : 20),
                                      color: kcontentColor,
                                      border: Border.all(
                                        color: Colors.grey.shade400,
                                        width: 2,
                                      ),
                                    ),
                                    child: Row(
                                      children: [
                                        SizedBox(width: isWideScreen ? 15 : 10),
                                        productQuantity(
                                            Icons.add, index, provider),
                                        SizedBox(width: isWideScreen ? 15 : 10),
                                        Text(
                                          cartItems.quantity.toString(),
                                          style: const TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.black,
                                          ),
                                        ),
                                        SizedBox(width: isWideScreen ? 15 : 10),
                                        productQuantity(
                                            Icons.remove, index, provider),
                                        SizedBox(width: isWideScreen ? 15 : 10),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ]),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }

  Widget productQuantity(IconData icon, int index, CartProvider provider) {
    return InkWell(
      onTap: () {
        icon == Icons.add
            ? provider.incrementQtn(index)
            : provider.decrementQtn(index);
      },
      child: Icon(
        icon,
        size: 20,
      ),
    );
  }
}

class CheckOutBox extends StatefulWidget {
  const CheckOutBox({super.key});

  @override
  State<CheckOutBox> createState() => _CheckOutBoxState();
}

class _CheckOutBoxState extends State<CheckOutBox> {
  late Razorpay _razorpay;

  void openCheckout(amount) async {
    amount = amount * 100;
    var options = {
      'key': 'rzp_test_B93NMv5P48O7Ml',
      'amount': amount,
      'name': 'Test',
      "prefil": {"contact": '8920800490', 'email': 'ishaanj2612@gmail.com'},
      "external": {
        "wallet": ["paytm"]
      }
    };
    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error : e');
    }
  }

  void handlePaymentSuccess(PaymentSuccessResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Successful ${response.paymentId!}",
        toastLength: Toast.LENGTH_SHORT);
    final user = FirebaseAuth.instance.currentUser;
    try {
      if (user != null) {
        DocumentReference _documentReference =
            FirebaseFirestore.instance.collection('users').doc(user.uid);
        CollectionReference order = _documentReference.collection("orders");
        final orderData = {
          // 'orderId': orderId,
          'products': Provider.of<CartProvider>(context, listen: false)
              .cart
              .map((product) => {
                    'productName': product.title,
                    'productPrice': product.price,
                    'productQuantity': product.quantity,
                    'productImage': product.image1,
                    'productCategory': product.category
                  })
              .toList(),
          'totalPrice':
              Provider.of<CartProvider>(context, listen: false).totalPrice(),
          'paymentId': response.paymentId,
          'paymentStatus': 'success',
        };
        order.add(orderData);
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "The error is $e");
    }
    //Clear the cart
    Provider.of<CartProvider>(context, listen: false).clearCart();
  }

  void handlePaymentError(PaymentFailureResponse response) {
    Fluttertoast.showToast(
        msg: "Payment Fail ${response.message!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  void handleExternalWallet(ExternalWalletResponse response) {
    Fluttertoast.showToast(
        msg: "External Wallet ${response.walletName!}",
        toastLength: Toast.LENGTH_SHORT);
  }

  @override
  void dispose() {
    super.dispose();
    _razorpay.clear();
  }

  @override
  void initState() {
    super.initState();
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  @override
  Widget build(BuildContext context) {
    final provider = CartProvider.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final isWideScreen = screenWidth > 600;

    return Container(
      height: MediaQuery.of(context).size.height * 0.35,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(isWideScreen ? 40 : 30),
      ),
      padding: EdgeInsets.all(isWideScreen ? 30 : 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(isWideScreen ? 40 : 30),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                vertical: isWideScreen ? 10 : 5,
                horizontal: isWideScreen ? 20 : 15,
              ),
              filled: true,
              fillColor: kcontentColor,
              hintText: "Enter Discount Code",
              hintStyle: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.w600,
                fontSize: isWideScreen ? 16 : 14,
              ),
              suffixIcon: TextButton(
                onPressed: () {},
                child: Text(
                  "Apply",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: isWideScreen ? 22 : 20,
                    color: kprimaryColor,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: isWideScreen ? 30 : 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SubTotal",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                  fontSize: isWideScreen ? 18 : 16,
                ),
              ),
              Text(
                "₹${provider.totalPrice()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isWideScreen ? 18 : 16,
                ),
              )
            ],
          ),
          SizedBox(height: isWideScreen ? 15 : 10),
          const Divider(),
          SizedBox(height: isWideScreen ? 15 : 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isWideScreen ? 20 : 18,
                ),
              ),
              Text(
                "₹${provider.totalPrice()}",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: isWideScreen ? 20 : 18,
                ),
              )
            ],
          ),
          SizedBox(height: isWideScreen ? 30 : 20),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              minimumSize: Size(double.infinity, isWideScreen ? 60 : 55),
            ),
            onPressed: () {
              setState(() {
                if (provider.totalPrice() > 0) {
                  openCheckout(provider.totalPrice());
                }
              });
            },
            child: Text(
              "Check Out",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: isWideScreen ? 18 : 16,
                color: Colors.white,
              ),
            ),
          )
        ],
      ),
    );
  }
}
