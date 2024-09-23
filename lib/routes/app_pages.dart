import 'package:crew_app/binding/about_us_binding.dart';
import 'package:crew_app/binding/account_binding.dart';
import 'package:crew_app/binding/availability_binding.dart';
import 'package:crew_app/binding/calendar_bindings.dart';
import 'package:crew_app/binding/dashboard_binding.dart';
import 'package:crew_app/binding/faq_binding.dart';
import 'package:crew_app/binding/forgot_binding.dart';
import 'package:crew_app/binding/google_login_binding.dart';
import 'package:crew_app/binding/help_binding.dart';
import 'package:crew_app/binding/language_binding.dart';
import 'package:crew_app/binding/message_binding.dart';
import 'package:crew_app/binding/notification_binding.dart';
import 'package:crew_app/binding/profile_binding.dart';
import 'package:crew_app/binding/reset_password_binding.dart';
import 'package:crew_app/binding/verification_binding.dart';
import 'package:crew_app/middlewares/auth_middleware.dart';
import 'package:crew_app/modules/aboutUs/about_us.dart';
import 'package:crew_app/modules/account/account.dart';
import 'package:crew_app/modules/availability/availability_screen.dart';
import 'package:crew_app/modules/calendar/calendar.dart';
import 'package:crew_app/modules/dashboard/dashboard.dart';
import 'package:crew_app/modules/faq/faq.dart';
import 'package:crew_app/modules/forgot/forgot.dart';
import 'package:crew_app/modules/help/help.dart';
import 'package:crew_app/modules/language/language.dart';
import 'package:crew_app/modules/login/login.dart';
import 'package:crew_app/modules/message/message.dart';
import 'package:crew_app/modules/notification/notification.dart';
import 'package:crew_app/modules/profile/profile.dart';
import 'package:crew_app/modules/reset_password/reset_password.dart';
import 'package:crew_app/modules/reset_password/reset_password_with_old.dart';

import 'package:crew_app/modules/verification/verification.dart';

import 'package:get/get.dart';

part 'app_routes.dart';

class AppPages {
  static const initial = Routes.home;

  static final routes = [
    GetPage(
      name: Routes.login,
      page: () => const Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.forgot,
      page: () => const ForgotScreen(),
      binding: ForgotBinding(),
    ),
    GetPage(
      name: Routes.verification,
      page: () => const Verification(),
      binding: VerificationBinding(),
    ),
    GetPage(
      name: Routes.resetPassword,
      page: () => const ResetPassword(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
        name: Routes.home,
        page: () => const Dashboard(),
        middlewares: [AuthMiddleware()],
        binding: DashboardBinding(),
        transition: Transition.noTransition),
    GetPage(
        name: Routes.account,
        page: () => const Account(),
        binding: AccountBinding(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
      name: Routes.resetPasswordWithOld,
      page: () => const ResetPasswordWithOld(),
      binding: AccountBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
        name: Routes.calendar,
        page: () => const Calendar(),
        binding: CalendarBinding(),
        middlewares: [AuthMiddleware()],
        transition: Transition.noTransition),
    GetPage(
        name: Routes.notification,
        page: () => const Notification(),
        binding: NotificationBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.availability,
        page: () => const AvailabilityScreen(),
        binding: AvailabilityBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.profile,
        page: () => const Profile(),
        binding: ProfileBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
        name: Routes.faq,
        page: () => const FAQ(),
        binding: FaqBinding(),
        middlewares: [AuthMiddleware()]),
    GetPage(
      name: Routes.help,
      page: () => const Help(),
      binding: HelpBinding(),
      middlewares: [AuthMiddleware()],
    ),
    GetPage(
      name: Routes.message,
      page: () => const Message(),
      binding: MessageBinding(),
      middlewares: [AuthMiddleware()],
      transition: Transition.noTransition,
    ),
    GetPage(
      name: Routes.aboutUs,
      page: () => const AboutUs(),
      binding: AboutUsBinding(),
    ),
    GetPage(
      name: Routes.language,
      page: () => const Language(),
      binding: LanguageBinding(),
    ),
  ];
}
