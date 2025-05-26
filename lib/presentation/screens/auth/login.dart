import 'package:doctor_appointment/business_logic/auth/login_cubit.dart';
import 'package:doctor_appointment/constants/clippath.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/route.dart';
import 'package:doctor_appointment/constants/styles.dart';
import 'package:doctor_appointment/constants/validinput.dart';
import 'package:doctor_appointment/presentation/widgets/auth/custommaterialbutton.dart';
import 'package:doctor_appointment/presentation/widgets/auth/customtext.dart';
import 'package:doctor_appointment/presentation/widgets/auth/customtextformfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with WidgetsBindingObserver {
  bool _isPasswordVisible = false;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  GlobalKey<FormState> formState = GlobalKey<FormState>();

  @override
  void initState() {
    context.read<LoginCubit>().getUserToken();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    WidgetsBinding.instance.addObserver(this);

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    formState.currentState?.dispose();
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    print('Current state is: $state');
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Container(color: Color(0xFF1A3E5A)),
          ClipPath(
            clipper: BackgroundCurveClipper(),
            child: Container(
              height: screenSize.height * 0.55, // Adjust height as needed
              color: Color(0xFF3B8FBD),
            ),
          ),

          Positioned(
            top: screenSize.height * 0.15, // Start content lower down
            left: 0,
            right: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Go ahead and set up\nyour account", style: largeStyle),
                  const SizedBox(height: 10),

                  Wrap(
                    children: [
                      CustomText(
                        title: "Sign in to start discovering creatives",
                        textStyle: smallStyle.copyWith(
                          // ignore: deprecated_member_use
                          color: MyColors.grey01.withOpacity(0.8),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRotes.signup,
                          );
                        },
                        child: CustomText(
                          title: " Register!",
                          textStyle: smallStyle.copyWith(
                            color: MyColors.bg03,
                            decorationColor: MyColors.bg03,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.1),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 25.0,
                      vertical: 35.0,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        25.0,
                      ), // Rounded corners
                      boxShadow: [
                        BoxShadow(
                          // ignore: deprecated_member_use
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize:
                          MainAxisSize.min, // Make column height fit content
                      children: [
                        // --- Email Field ---
                        CustomTextFormField(
                          labelText: "E-mail ID",
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.email_outlined,
                          validator: (value) {
                            return validInput(value!, 4, 20, "email");
                          },
                          obscureText: false,
                          controller: emailController,
                          suffixIcon: null,
                        ),
                        const SizedBox(height: 20),

                        // --- Password Field ---
                        CustomTextFormField(
                          labelText: "Password",
                          keyboardType: TextInputType.emailAddress,
                          icon: Icons.lock_outline,
                          validator: (value) {
                            return validInput(value!, 4, 20, "password");
                          },
                          obscureText: !_isPasswordVisible,
                          controller: passwordController,
                          suffixIcon: IconButton(
                            icon: Icon(
                              _isPasswordVisible
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey.shade500,
                            ),
                            onPressed: () {
                              setState(() {
                                _isPasswordVisible = !_isPasswordVisible;
                              });
                            },
                          ),
                        ),

                        const SizedBox(height: 20), // Space before button
                        InkWell(
                          onTap: () {
                            Navigator.pushReplacementNamed(
                              context,
                              AppRotes.checkEmail,
                            );
                          },
                          child: CustomText(
                            textAlign: TextAlign.end,
                            title: "Forget Your Password?",
                            textStyle: smallStyle.copyWith(
                              color: MyColors.blueDark,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20), // Space before button
                        // --- Login Button ---
                        CustomMaterialButton(
                          color: MyColors.header01,
                          minWidth: MediaQuery.of(context).size.width - 80,
                          onPressed: () async {
                            context.read<LoginCubit>().login(
                              context,
                              emailController.text,
                              passwordController.text,
                            );
                          },
                          radius: 15.0,
                          child: Text(
                            "Login",
                            style: kTitleStyle.copyWith(color: MyColors.bg),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
