import 'model_onboarding.dart';

class AppStrings {
  AppStrings._();
  static const String onboardingOneTitle =
      'Empower Your Home, Simplify Your Life';
  static const String onboardingOneSubtitle =
      'Transform your living space into a smarter, more connected home with Smartome. All at your fingertips.';
  static const String onboardingTwoTitle =
      'Effortless Control, Automate, & Secure';
  static const String onboardingTwoSubtitle =
      'Smartome empowers you to control your devices, & automate your routines. Embrace a world where your home adapts to your needs';
  static const String onboardingThreeTitle =
      'Efficiency that Saves, Comfort that Lasts.';
  static const String onboardingThreeSubtitle =
      "Take control of your home's energy usage, set preferences, and enjoy a space that adapts to your needs while saving power.";
}

class AppAssets {
  AppAssets._();
  static const String onboardOneLight = 'assets/image/onboard1Light.png';
  static const String onboardTwoLight = 'assets/image/onboard2Light.png';
  static const String onboardThreeLight = 'assets/image/onboard3Light.png';
}

final List<OnboardingModel> onboardingData = [
  const OnboardingModel(
    assetPathLight: AppAssets.onboardOneLight,
    title: AppStrings.onboardingOneTitle,
    subTitle: AppStrings.onboardingOneSubtitle,
  ),
  const OnboardingModel(
    assetPathLight: AppAssets.onboardTwoLight,
    title: AppStrings.onboardingTwoTitle,
    subTitle: AppStrings.onboardingTwoSubtitle,
  ),
  const OnboardingModel(
    assetPathLight: AppAssets.onboardThreeLight,
    title: AppStrings.onboardingThreeTitle,
    subTitle: AppStrings.onboardingThreeSubtitle,
  ),
];
