import 'dart:io';
import 'package:doctor_appointment/business_logic/auth/signup_cubit.dart';
import 'package:doctor_appointment/business_logic/auth/signup_state.dart';
import 'package:doctor_appointment/constants/callservices.dart';
import 'package:doctor_appointment/constants/colors.dart';
import 'package:doctor_appointment/constants/fileupload.dart';
import 'package:doctor_appointment/link_api.dart';
import 'package:doctor_appointment/main.dart';
import 'package:doctor_appointment/presentation/screens/auth/login.dart';
import 'package:doctor_appointment/presentation/screens/settings/settingsdetails.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late TextEditingController phoneController;

  File? file;
  bool isType = false;
  bool isShowPassword = true;
  GlobalKey<FormState> formState = GlobalKey<FormState>();
  CallServices callServices = CallServices();

  @override
  void initState() {
    context.read<SignUpCubit>().getCurrentUser();
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController = TextEditingController();
    nameController.text = myBox!.get("userName").toString();
    emailController.text = myBox!.get("userEmail").toString();
    passwordController.text = myBox!.get("userPassword").toString();
    phoneController.text = myBox!.get("userPhone").toString();

    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose();
    //twonController.dispose();
    super.dispose();
  }

  chooseImageGallery() async {
    file = await takePhotoWithGallery();
    print('file from gallery ================ $file');
    setState(() {});
  }

  chooseImageCamera() async {
    file = await takePhotoWithCamera();
    print('file from gallery ================ $file');
    setState(() {});
  }

  removeFile() {
    if (file != null) {
      file = null;
      print('file from remove ================ $file');
    } else {
      print('no file to remove');
    }
    setState(() {});
  }

  chooseImageOption() {
    showAttachmentOptions(
      context,
      chooseImageGallery,
      chooseImageCamera,
      removeFile,
    );
  }

  Widget _buildInfoCard(
    String text,
    TextEditingController controller, {
    bool obscureText = false, // Default to false for non-password fields
    IconData? iconData,
    void Function()? onPressedIcon,
    bool? enabled,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 8.0),
      child: TextField(
        obscureText: obscureText,
        controller: controller,
        enabled: enabled,
        onChanged: (value) {
          if (value.isEmpty) {
            isType = false; // Check if the field is empty
          } else {
            isType = true; // Check if the field is not empty
          }
          setState(() {});
        },
        decoration: InputDecoration(
          suffixIcon: IconButton(
            onPressed: onPressedIcon,
            icon: Icon(iconData),
          ),
          filled: true,
          fillColor: MyColors.bg,
          hintText: controller.text,
          hintStyle: const TextStyle(color: MyColors.greyDark),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none, // No border
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 18.0,
            horizontal: 15.0,
          ),
        ),
        style: const TextStyle(fontSize: 16.0, color: Colors.black87),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<SignUpCubit>(context);
    // Define the light blue background color
    // final Color backgroundColor = Colors.blue[50] ?? const Color(0xFFE3F2FD);
    final Color settingsIconColor = Theme.of(context).primaryColor;

    return Scaffold(
      //  backgroundColor: backgroundColor, // Set the background color here
      appBar: AppBar(
        //backgroundColor: Colors.white, // White AppBar
        elevation: 0, // No shadow for a flatter look
        title: const Text(
          'Profile',
          style: TextStyle(
            color: Colors.black87, // Darker text color
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.settings_outlined, color: settingsIconColor),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const SettingsDetailsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: BlocBuilder<SignUpCubit, SignUpState>(
        builder: (context, state) {
          if (state is SignUpStateLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is SignUpStateLoaded) {
            return Form(
              key: formState,
              child: Column(
                // Use ListView for scrollability
                children: <Widget>[
                  // Row(
                  //   children: [
                  //     // This Expanded pushes both the center and end widgets to their positions
                  //     Expanded(
                  //       child: Center(
                  //         child: Padding(
                  //           padding: const EdgeInsets.only(left: 35.0),
                  //           child: Text(
                  //             'Profile',
                  //             style: TextStyle(
                  //               color: Colors.black87,
                  //               fontWeight: FontWeight.bold,
                  //             ),
                  //           ),
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  const SizedBox(height: 30.0), // Space above profile picture
                  // Profile Picture
                  Center(
                    child: GestureDetector(
                      onTap: () {
                        //_showImageSourceActionSheet(context);

                        chooseImageOption();
                      },

                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(
                          15.0,
                        ), // Rounded corners
                        child:
                            file != null
                                ? Image.file(
                                  file!,
                                  height: 120.0,
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                )
                                : Image.network(
                                  "${AppLink.viewUserImages}/${cubit.getUserImage}",

                                  // Apply ColorFiltered for B&W effect (optional)
                                  // ignore: deprecated_member_use
                                  color: Colors.grey.withOpacity(0.5),
                                  colorBlendMode:
                                      BlendMode.saturation, // Makes it B&W
                                  height: 120.0,
                                  width: 120.0,
                                  fit: BoxFit.cover,
                                  errorBuilder:
                                      (context, error, stacktrace) => Column(
                                        children: [
                                          Container(
                                            // Fallback
                                            height: 120.0,
                                            width: 120.0,
                                            decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius:
                                                  BorderRadius.circular(15.0),
                                            ),
                                            child: Icon(
                                              Icons.person,
                                              size: 60,
                                              color: Colors.grey[600],
                                            ),
                                          ),
                                        ],
                                      ),
                                ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30.0), // Space below profile picture
                  // Info Cards
                  _buildInfoCard(
                    nameController.text,
                    nameController,
                    enabled: false,
                  ),
                  _buildInfoCard(
                    emailController.text,
                    emailController,
                    enabled: false,
                  ),
                  _buildInfoCard(
                    passwordController.text,
                    passwordController,
                    obscureText: isShowPassword,
                    iconData: Icons.remove_red_eye_outlined,
                    onPressedIcon: () {
                      setState(() {
                        isShowPassword = isShowPassword == true ? false : true;
                      });
                    },
                    enabled: false,
                  ),
                  _buildInfoCard(
                    phoneController.text,
                    phoneController,
                    enabled: false,
                  ),

                  //_buildInfoCard(twonController.text, twonController),
                  const SizedBox(
                    height: 60.0,
                  ), // Extra space at the bottom if needed
                  // Save Button
                  if (isType ||
                      file !=
                          null) // Show button if typing or image is selected
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Handle save action

                          cubit.updateUserData(file!);

                          setState(() {
                            file = null;
                            isShowPassword = true;
                            isType = false; // Reset the typing state
                          });
                          print("value of imageFile ===============$file");
                          print("Save button pressed");
                          // Add your save logic here
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: MyColors.header01, // Button color
                          padding: const EdgeInsets.symmetric(vertical: 15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 16.0, color: Colors.white),
                        ),
                      ),
                    ),

                  Spacer(),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Card(
                      margin: EdgeInsets.all(20.0),
                      child: ListTile(
                        title: const Text(
                          "Logout",
                          style: TextStyle(
                            fontSize: 16.0,
                            color: MyColors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        trailing: IconButton(
                          onPressed: () async {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Login()),
                              (route) => false,
                            );
                            await myBox!.clear();
                            callServices.onUserLogout();
                          },
                          icon: const Icon(Icons.logout),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text(" Something Wrong ... "));
          }
        },
      ),
    );
  }
}
