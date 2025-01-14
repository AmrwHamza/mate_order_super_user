import 'package:flutter/material.dart';
import 'package:mate_order_super_user/constants.dart';

class RegisterOrLogInText extends StatelessWidget {
  const RegisterOrLogInText({
    super.key,
    required this.data,
  });
  final String data;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 27),
      child: Row(
        children: [
          Text(
            data,
            style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: kPrimaryColor1),
          ),
        ],
      ),
    );
  }
}
