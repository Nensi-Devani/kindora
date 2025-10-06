import 'dart:async';
import 'package:flutter/material.dart';
import 'package:kindora/screens/reset_password_screen.dart';
import 'package:kindora/widgets/custom_scaffold.dart';
import '../app_theme/app_colors.dart';

class OtpVarificationScreen extends StatefulWidget {
  const OtpVarificationScreen({super.key});

  @override
  State<OtpVarificationScreen> createState() => _OtpVarificationScreenState();
}

class _OtpVarificationScreenState extends State<OtpVarificationScreen> {
  late Timer _timer;
  int _start = 30;
  final List<FocusNode> _focusNodes = List.generate(4, (_) => FocusNode());
  final List<TextEditingController> _controllers = List.generate(
    4,
    (_) => TextEditingController(),
  );

  @override
  void initState() {
    super.initState();
    startTimer();
    _focusNodes[0].requestFocus();
  }

  void startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_start == 0) {
        timer.cancel();
      } else {
        setState(() {
          _start--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    for (var node in _focusNodes) {
      node.dispose();
    }
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void verifyOtp() {
    String otp = _controllers.map((c) => c.text).join();
    if (otp.length == 4) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(const SnackBar(content: Text('OTP Verified!')));
      // Navigate to next screen or perform action here
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter complete OTP')),
      );
    }
  }

  void resendOtp() {
    setState(() {
      _start = 30;
    });
    startTimer();
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('OTP Resent')));
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Column(
        children: [
          const Expanded(flex: 1, child: SizedBox(height: 0)),
          Expanded(
            flex: 7,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30),
                  topRight: Radius.circular(30),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Enter OTP',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFB24C63),
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    'Enter OTP code',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(4, (index) {
                      return SizedBox(
                        width: 50,
                        child: TextField(
                          controller: _controllers[index],
                          focusNode: _focusNodes[index],
                          keyboardType: TextInputType.number,
                          maxLength: 1,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                          decoration: InputDecoration(
                            counterText: '',
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black26,
                                width: 1.5,
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black26,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                              borderSide: const BorderSide(
                                color: Colors.black,
                                width: 2,
                              ),
                            ),
                          ),

                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_focusNodes[index + 1]);
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(
                                context,
                              ).requestFocus(_focusNodes[index - 1]);
                            }
                          },
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '00:${_start.toString().padLeft(2, '0')}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // button
                  SizedBox(
                    width: 250,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryButton,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Verifying OTP...')),
                        );

                        // Navigate to ResetPassword after successful validation
                        Future.delayed(const Duration(seconds: 1), () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ResetPasswordScreen(),
                            ),
                          );
                        });
                      },
                      child: const Text('Verify OTP'),
                    ),
                  ),
                  const SizedBox(height: 20),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.7,
                          color: Colors.grey.withOpacity(0.5),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: _start == 0 ? resendOtp : null,
                    child: RichText(
                      text: TextSpan(
                        text: 'Resend ',
                        style: const TextStyle(
                          color: Colors.black45,
                          fontSize: 14,
                        ),
                        children: const [
                          TextSpan(
                            text: 'OTP',
                            style: TextStyle(
                              color: Color(0xFFB24C63),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      // ),
    );
  }
}
