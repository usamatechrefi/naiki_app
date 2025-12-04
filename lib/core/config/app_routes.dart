import 'package:flutter/material.dart';
import '../../features/auth/ui/login/sign_in_screen.dart';
import '../../features/auth/ui/registration/recipient_signup_screen.dart';
import '../../features/auth/ui/registration/donor_signup_screen.dart';
import '../../features/auth/ui/splash/splash_screen.dart';
import '../../features/auth/ui/onboarding/onboarding_screen.dart';
import '../../features/auth/ui/welcome/welcome_screen.dart';
import '../../features/auth/ui/registration/otp_verification_screen.dart';
import '../../features/recipient/ui/profile_creation/contact_info_screen.dart';
import '../../features/recipient/ui/profile_creation/personal_info_screen.dart';
import '../../features/recipient/ui/profile_creation/story_writing_screen.dart';
import '../../features/recipient/ui/dashboard/dashboard_screen.dart';
import '../../features/recipient/ui/request_creation/create_request_screen.dart';
import '../../features/donor/ui/dashboard/donor_dashboard_screen.dart';
import '../../features/donor/ui/browse/browse_women_screen.dart';
import '../../features/donor/ui/donation/donation_amount_screen.dart';
import '../../features/donor/ui/donation/payment_screen.dart';

class AppRoutes {
  static const String splash = '/';
  static const String onboarding = '/onboarding';
  static const String welcome = '/welcome';
  static const String signIn = '/sign-in';
  static const String donorRegistration = '/donor-registration';
  static const String donorSignup = '/donor-signup';
  static const String recipientRegistration = '/recipient-registration';
  static const String verifyOtp = '/verify-otp';

  // Dashboard Routes
  static const String recipientDashboard = '/recipient/dashboard';
  static const String donorDashboard = '/donor/dashboard';

  // Legacy route for backward compatibility
  static const String dashboard = '/dashboard';

  // Recipient Routes
  static const String recipientPersonalInfo = '/recipient/profile-creation/personal';
  static const String recipientContactInfo = '/recipient/profile-creation/contact';
  static const String recipientStory = '/recipient/profile-creation/story';
  static const String recipientReview = '/recipient/profile-creation/review';
  static const String createRequest = '/recipient/create-request';

  // Donor Routes
  static const String donorProfileCreation = '/donor/profile-creation';
  static const String browseWomen = '/donor/browse-women';

  // Donation Routes
  static const String donationAmount = '/donor/donation-amount';
  static const String payment = '/donor/payment';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case onboarding:
        return MaterialPageRoute(builder: (_) => const OnboardingScreen());

      case welcome:
        return MaterialPageRoute(builder: (_) => const WelcomeScreen());

      case signIn:
        return MaterialPageRoute(builder: (_) => const SignInScreen());

      case donorRegistration:
        return MaterialPageRoute(
          builder: (_) => const RegistrationPhoneScreen(userType: 'donor'),
        );

      case donorSignup:
        return MaterialPageRoute(builder: (_) => const DonorSignupScreen());

      case recipientRegistration:
        return MaterialPageRoute(
          builder: (_) => const RegistrationPhoneScreen(userType: 'recipient'),
        );

      // case recipientPersonalInfo:
      //   return MaterialPageRoute(builder: (_) => const PersonalInfoScreen());
      //
      // case recipientContactInfo:
      //   return MaterialPageRoute(builder: (_) => const ContactInfoScreen());
      //
      // case recipientStory:
      //   return MaterialPageRoute(builder: (_) => const StoryWritingScreen());

      case recipientDashboard:
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case donorDashboard:
        return MaterialPageRoute(builder: (_) => const DonorDashboardScreen());

      case browseWomen:
        return MaterialPageRoute(builder: (_) => const BrowseWomenScreen());

      case dashboard:
      // Legacy route - defaults to recipient dashboard
        return MaterialPageRoute(builder: (_) => const DashboardScreen());

      case createRequest:
        return MaterialPageRoute(builder: (_) => const CreateRequestScreen());

      // Donation Amount Screen
      case donationAmount:
        final args = settings.arguments as Map<String, dynamic>?;

        if (args == null) {
          return _errorRoute('Missing donation arguments');
        }

        return MaterialPageRoute(
          builder: (_) => DonationAmountScreen(
            recipientName: args['recipientName'] as String,
            recipientLocation: args['recipientLocation'] as String,
            requestTitle: args['requestTitle'] as String,
            targetAmount: args['targetAmount'] as int,
            currentAmount: args['currentAmount'] as int,
            isVerified: args['isVerified'] as bool? ?? false,
            recipientImageUrl: args['recipientImageUrl'] as String?,
          ),
        );

      // Payment Screen
      case payment:
        final args = settings.arguments as Map<String, dynamic>?;

        if (args == null) {
          return _errorRoute('Missing payment arguments');
        }

        return MaterialPageRoute(
          builder: (_) => PaymentScreen(
            donationAmount: args['donationAmount'] as int,
            donationType: args['donationType'] as String,
            recipientName: args['recipientName'] as String,
            recipientLocation: args['recipientLocation'] as String,
            requestTitle: args['requestTitle'] as String,
            isVerified: args['isVerified'] as bool? ?? false,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(
              child: Text('No route defined for ${settings.name}'),
            ),
          ),
        );
    }
  }

  static Route<dynamic> _errorRoute(String message) {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('Error')),
        body: Center(
          child: Text(message),
        ),
      ),
    );
  }

  static Map<String, WidgetBuilder> get routes => {
    splash: (context) => const SplashScreen(),
    onboarding: (context) => const OnboardingScreen(),
    welcome: (context) => const WelcomeScreen(),
  };
}