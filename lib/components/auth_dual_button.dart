import 'package:flutter/material.dart';

class AuthDualButton extends StatelessWidget {
  final String currentPath;
  final Color orange;
  final VoidCallback onLogin;
  final VoidCallback onSignup;

  const AuthDualButton({
    super.key,
    required this.currentPath,
    required this.orange,
    required this.onLogin,
    required this.onSignup,
  });

  @override
  Widget build(BuildContext context) {
    final double buttonHeight = MediaQuery.of(context).size.height * 36 / 650;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: SizedBox(
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: onLogin,
              child: Text("Log In"),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  currentPath == '/login'
                      ? Colors.transparent
                      : Colors.grey[300],
                ),
                side: WidgetStateProperty.all(
                  BorderSide(color: Colors.grey[300]!, width: 2),
                ),
                foregroundColor: WidgetStateProperty.all(
                  currentPath == '/login' ? Colors.black : orange,
                ),
                textStyle: WidgetStateProperty.all(
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(10),
                      right: Radius.circular(0),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: SizedBox(
            height: buttonHeight,
            child: ElevatedButton(
              onPressed: onSignup,
              child: Text("Sign Up"),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(
                  currentPath == '/signup'
                      ? Colors.transparent
                      : Colors.grey[300],
                ),
                side: WidgetStateProperty.all(
                  BorderSide(color: Colors.grey[300]!, width: 2),
                ),
                foregroundColor: WidgetStateProperty.all(
                  currentPath == '/signup' ? Colors.black : orange,
                ),
                textStyle: WidgetStateProperty.all(
                  TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                shape: WidgetStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(0),
                      right: Radius.circular(10),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
