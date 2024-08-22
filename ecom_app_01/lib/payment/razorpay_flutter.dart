// import 'package:flutter/material.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// class PaymentGateway extends StatefulWidget {
//   const PaymentGateway({super.key});

//   @override
//   State<PaymentGateway> createState() => _PaymentGatewayState();
// }

// class _PaymentGatewayState extends State<PaymentGateway> {

//   late Razorpay _razorpay;
//   TextEditingController amtController = TextEditingController();

//   void openCheckOut(amount) async {
//     amount = amount * 100;
//     var option = {
//       'key' : '/key/',
//       'amount' : amount,
//       'name' : 'Moonlit',
//       'prefill' : {'contact' : '1234567890', 'email' : 'test@gmail.com'},
//       'external' : {
//         'wallets' : ['paytm']
//       },
//     };
//     try {
//       _razorpay.open(option);
//     } catch(e) {
//       debugPrint('Error : e');
//     }
//   }

//   void handlePaymentSuccess(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(msg: "Payement Successful " + response.paymentId!, toastLength: Toast.LENGTH_SHORT);
//   }

//   void handlePaymentError(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(msg: "Payement Fail " + response.message!, toastLength: Toast.LENGTH_SHORT);
//   }

//   void handlePaymentWallet(PaymentSuccessResponse response) {
//     Fluttertoast.showToast(msg: "External Wallet " + response.walletName!, toastLength: Toast.LENGTH_SHORT);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }