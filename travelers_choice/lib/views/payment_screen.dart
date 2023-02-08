// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';

// import '../card_widgets/input_fields.dart';

// class Palette {
//   static const Color blueDark = Color(0xFF0a1d38);
//   static const Color blueMedium = Color(0xFF0848ef);
//   static const Color blue = Color(0xFF3395ff);
// }

// class Validator {
//   static String? amount(String? input) {
//     if (input == null || input.isEmpty) {
//       return 'Please enter an amount';
//     }

//     final value = double.tryParse(input) ?? 0.0;
//     if (value <= 0.0) {
//       return 'Enter an amount greater than 0';
//     }

//     return null;
//   }
// }

// class PaymentScreen extends StatefulWidget {
//   const PaymentScreen({Key? key}) : super(key: key);

//   @override
//   State<PaymentScreen> createState() => _PaymentScreenState();
// }

// class _PaymentScreenState extends State<PaymentScreen> {
//   final currencies = {
//     'USD': '\$',
//     'SGD': 'S\$',
//     'AUD': 'A\$',
//     'CAD': 'C\$',
//     'EUR': '€',
//     'GBP': '£',
//     'HKD': 'HK\$',
//     'INR': '₹',
//     'MYR': 'RM',
//   };

//   final int _choiceChipValue = 7;
//   @override
//   late final TextEditingController _amountController;
//   late final TextEditingController _businessNameController;
//   late final TextEditingController _receiptController;
//   late final TextEditingController _descriptionController;
//   late final TextEditingController _userNameController;
//   late final TextEditingController _userEmailController;
//   late final TextEditingController _userContactController;

//   @override
//   void initState() {
//     _amountController = TextEditingController();
//     _businessNameController = TextEditingController();
//     _receiptController = TextEditingController(text: 'receipt#001');
//     _descriptionController = TextEditingController();
//     _userNameController = TextEditingController();
//     _userEmailController = TextEditingController();
//     _userContactController = TextEditingController();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         backgroundColor: Colors.white,
//         appBar: AppBar(
//           elevation: 0,
//           backgroundColor: Colors.white,
//           title: Row(
//             children: [
//               Image.asset(
//                 'assets/images/full_apps/shopping/razorpay_logo.png',
//                 height: 36,
//               ),
//               const SizedBox(width: 6),
//               const Text(
//                 'Demo',
//                 style: TextStyle(
//                   color: Palette.blueDark,
//                   fontSize: 32,
//                   fontStyle: FontStyle.italic,
//                   fontWeight: FontWeight.w600,
//                 ),
//               )
//             ],
//           ),
//         ),
//         body: Stack(
//           children: [
//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16.0),
//               child: ListView(
//                 physics: const BouncingScrollPhysics(),
//                 children: [
//                   const SizedBox(height: 8),
//                   // Amount field
//                   InputField(
//                     controller: _amountController,
//                     label: 'Amount',
//                     hintText: 'Enter amount',
//                     inputType: TextInputType.number,
//                     inputAction: TextInputAction.next,
//                     leading: Text(
//                       currencies.values.elementAt(_choiceChipValue),
//                       style: const TextStyle(
//                         color: Palette.blueMedium,
//                         fontSize: 24,
//                         fontWeight: FontWeight.w500,
//                       ),
//                     ),
//                     // Allow only two decimals digits
//                     textInputFormatter: FilteringTextInputFormatter.allow(
//                       RegExp(r'^\d+\.?\d{0,2}'),
//                     ),
//                     validator: Validator.amount,
//                   ),

//                   // // Business Name field
//                   // InputField(...),
//                   // // Receipt field
//                   // InputField(...),
//                   // // Description field
//                   // InputField(...),
//                   // // User detail Inputs: Name, Email, Contact
//                   Container(
//                     decoration: BoxDecoration(
//                       borderRadius: BorderRadius.circular(12),
//                       color: Palette.blueDark,
//                     ),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(
//                         horizontal: 24.0,
//                         vertical: 16.0,
//                       ),
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: const [
//                           Text(
//                             'User details',
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontSize: 18,
//                               fontWeight: FontWeight.w500,
//                               letterSpacing: 0.6,
//                             ),
//                           ),
//                           // // User Name field
//                           // InputField(...),
//                           // // User Email field
//                           // InputField(...),
//                           // // User Contact field
//                           // InputField(...),
//                         ],
//                       ),
//                     ),
//                   ),
//                   // TODO: Add "Checkout" button
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
