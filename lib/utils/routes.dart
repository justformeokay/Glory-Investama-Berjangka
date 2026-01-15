import 'package:get/get.dart';
import 'package:gifx/app/bindings/dashboard_binding.dart';
import 'package:gifx/app/bindings/deposit_binding.dart';
import 'package:gifx/app/bindings/forgot_password_binding.dart';
import 'package:gifx/app/bindings/internal_transfer_binding.dart';
import 'package:gifx/app/bindings/notification_binding.dart';
import 'package:gifx/app/bindings/otp_binding.dart';
import 'package:gifx/app/bindings/passcode_binding.dart';
import 'package:gifx/app/bindings/sign_in_binding.dart';
import 'package:gifx/app/bindings/trade_binding.dart';
import 'package:gifx/app/bindings/withdrawal_binding.dart';
import 'package:gifx/app/views/pages/dashboard_page.dart';
import 'package:gifx/app/views/pages/deposit_page.dart';
import 'package:gifx/app/views/pages/forgot_password_page.dart';
import 'package:gifx/app/views/pages/internal_transfer_page.dart';
import 'package:gifx/app/views/pages/notification_page.dart';
import 'package:gifx/app/views/pages/otp_page.dart';
import 'package:gifx/app/views/pages/passcode_page.dart';
import 'package:gifx/app/views/pages/sign_in_page.dart';
import 'package:gifx/app/views/pages/textfield_demo_page.dart';
import 'package:gifx/app/views/pages/trade_page.dart';
import 'package:gifx/app/views/pages/withdrawal_page.dart';

class Routes {
  static List<GetPage<dynamic>> getPages = [
    GetPage(
      name: '/sign-in',
      page: () => const SignInPage(),
      binding: SignInBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/passcode',
      page: () => const PasscodePage(),
      binding: PasscodeBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/dashboard',
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/textfield-demo',
      page: () => const TextFieldDemoPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/forgot-password',
      binding: ForgotPasswordBinding(),
      page: () => const ForgotPasswordPage(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/otp',
      page: () => const OtpPage(),
      binding: OtpBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/deposit',
      page: () => const DepositPage(),
      binding: DepositBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/withdrawal',
      page: () => const WithdrawalPage(),
      binding: WithdrawalBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/internal-transfer',
      page: () => const InternalTransferPage(),
      binding: InternalTransferBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/notifications',
      page: () => const NotificationPage(),
      binding: NotificationBinding(),
      transition: Transition.cupertino,
    ),
    GetPage(
      name: '/trade',
      page: () => TradePage(),
      binding: TradeBinding(),
      transition: Transition.fadeIn,
    ),
  ];
}