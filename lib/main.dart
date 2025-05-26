import 'package:doctor_appointment/approutes.dart';
import 'package:doctor_appointment/business_logic/auth/login_cubit.dart';
import 'package:doctor_appointment/business_logic/auth/signup_cubit.dart';
import 'package:doctor_appointment/business_logic/chat/chat_cubit.dart';
import 'package:doctor_appointment/business_logic/doctors/doctor_cubit.dart';
import 'package:doctor_appointment/business_logic/homepage/appointment_cubit.dart';
import 'package:doctor_appointment/business_logic/homepage/categories_cubit.dart';
import 'package:doctor_appointment/business_logic/payment/payment_cubit.dart';
import 'package:doctor_appointment/constants/const.dart';
import 'package:doctor_appointment/data/repositary/appointments.dart';
import 'package:doctor_appointment/data/repositary/auth_repositary.dart';
import 'package:doctor_appointment/data/repositary/categories_repositary.dart';
import 'package:doctor_appointment/data/repositary/chat_repositary.dart';
import 'package:doctor_appointment/data/repositary/doctor_repositary.dart';
import 'package:doctor_appointment/data/repositary/payment.dart';
import 'package:doctor_appointment/presentation/screens/localnotify.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paymob/flutter_paymob.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:zego_uikit_prebuilt_call/zego_uikit_prebuilt_call.dart';
import 'package:zego_uikit_signaling_plugin/zego_uikit_signaling_plugin.dart';
import 'data/web_services(API)/crud.dart';
import 'firebase_options.dart';

Box? myBox;
GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
Future<Box> initBoxHive(boxName) async {
  if (!Hive.isBoxOpen(boxName)) {
    print("Box is not open");
    Hive.init((await getApplicationDocumentsDirectory()).path);
  } else {
    print("Box is already open");
  }
  return Hive.openBox(boxName);
}

intialZego() {
  ZegoUIKitPrebuiltCallInvitationService().setNavigatorKey(navigatorKey);
  ZegoUIKit().initLog().then((value) {
    ZegoUIKitPrebuiltCallInvitationService().useSystemCallingUI([
      ZegoUIKitSignalingPlugin(),
    ]);
  });
}

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  if (message.notification != null) {
    print("==================================== onBackgroundMessage");
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  myBox = await initBoxHive("fares");
  await NotificationService().init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  intialZego();

  // flutter paymob
  FlutterPaymob.instance.initialize(
    apiKey:
        MyConst
            .apiKeyPaymob, //  // from dashboard Select Settings -> Account Info -> API Key
    integrationID:
        MyConst
            .integrationCardId, // // from dashboard Select Developers -> Payment Integrations -> Online Card ID
    walletIntegrationId:
        MyConst
            .integrationMobileWalletId, // // from dashboard Select Developers -> Payment Integrations -> Online wallet
    iFrameID: MyConst.iframeId,
  );

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<CategoriesCubit>(
          create: (context) => CategoriesCubit(CategoriesRepositary(Crud())),
        ),
        BlocProvider<SignUpCubit>(
          create: (context) => SignUpCubit(AuthRepositary(Crud())),
        ),
        BlocProvider<LoginCubit>(
          create: (context) => LoginCubit(AuthRepositary(Crud())),
        ),
        BlocProvider<AppointmentCubit>(
          create: (context) => AppointmentCubit(AppointmentsRepositary(Crud())),
        ),

        BlocProvider<DoctorCubit>(
          create: (context) => DoctorCubit(DoctorRepositary(Crud())),
        ),

        BlocProvider<ChatCubit>(
          create: (context) => ChatCubit(ChatRepositary(Crud())),
        ),
        BlocProvider<PaymentCubit>(
          create: (context) => PaymentCubit(PaymentRepository(Crud())),
        ),
      ],

      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      debugShowMaterialGrid: false,
      // onGenerateRoute: AppRoute().generateRoute,
      routes: routes,
    );
  }
}
