import 'package:doctor_appointment/business_logic/auth/signup_cubit.dart';
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

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  bool _isPasswordVisible = false;
  late TextEditingController userNameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;

  @override
  void initState() {
    userNameController = TextEditingController();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    phoneController = TextEditingController();

    super.initState();
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    phoneController.dispose();
    formState.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    //final cubit = BlocProvider.of<SignUpCubit>(context, listen: true);

    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      // Use a Stack to layer the background elements and the content
      body: Stack(
        children: [
          // --- Dark Base Background ---
          Container(color: Color(0xFF1A3E5A)),

          // --- Lighter Curved Background Overlay ---
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
                  // --- Title Text ---
                  Text("Create your account", style: largeStyle),
                  const SizedBox(height: 10),

                  Wrap(
                    alignment: WrapAlignment.center,
                    // mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CustomText(
                        title: "Sign up to enjoy the best managing experience",
                        textStyle: smallStyle.copyWith(
                          // ignore: deprecated_member_use
                          color: MyColors.grey01.withOpacity(0.8),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushReplacementNamed(
                            context,
                            AppRotes.login,
                          );
                        },
                        child: CustomText(
                          title: "Sign in!",
                          textStyle: smallStyle.copyWith(
                            decorationColor: MyColors.bg03,
                            fontStyle: FontStyle.italic,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: screenSize.height * 0.1),
                  Form(
                    key: formState,
                    child: Container(
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
                          CustomTextFormField(
                            labelText: "UserName",
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.person,
                            validator: (value) {
                              return validInput(value!, 4, 20, "username");
                            },
                            obscureText: false,
                            controller: userNameController,
                            suffixIcon: null,
                          ),
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

                          CustomTextFormField(
                            labelText: "Phone",
                            keyboardType: TextInputType.emailAddress,
                            icon: Icons.phone,
                            validator: (value) {
                              return validInput(value!, 4, 20, "phone");
                            },
                            obscureText: false,
                            controller: phoneController,
                            suffixIcon: null,
                          ),

                          const SizedBox(height: 20), // Space before button

                          CustomMaterialButton(
                            color: MyColors.header01,
                            minWidth: MediaQuery.of(context).size.width - 80,
                            onPressed: () {
                              context.read<SignUpCubit>().signup(
                                context,
                                userNameController.text,
                                emailController.text,
                                passwordController.text,
                                phoneController.text,
                              );
                            },
                            radius: 15.0,
                            child: Text(
                              "Register",
                              style: kTitleStyle.copyWith(color: MyColors.bg),
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
    );
  }
}
