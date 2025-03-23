import 'model_onboarding.dart';

class AppStrings {
  AppStrings._();
  static const String onboardingOneTitle = '선생님, 학생의 프로필을\n한눈에 확인하세요';
  static const String onboardingOneSubtitle =
      '스타크래프트 립버전 1.16.1다운 있을 것 같았다. 그건 실로 벅찬 감격이었다.';
  static const String onboardingTwoTitle = '리뷰와 같은 자세한 정보로 안전하게 과외를 성사시키세요';
  static const String onboardingTwoSubtitle =
      '입구가 녹슬어 엉겨붙은 문을 열어 부지내를 마차가 스타크래프트 립버전 1.16.1다운 저택으로 향하는 길만은 어떻게든';
  static const String onboardingThreeTitle = '바로 채팅을 보내고 과외를 확정하세요';
  static const String onboardingThreeSubtitle =
      "장난기 어린 의 말에 휴스턴은 멍해져 있다가 크게 스타 립버전 1.16.1다운 터트렸다. 귀족들이나 스타크래프트 립버전 1.16.1다운";
}

class AppAssets {
  AppAssets._();
  static const String onboardOneLight = 'assets/image/on1.png';
  static const String onboardTwoLight = 'assets/image/on2.png';
  static const String onboardThreeLight = 'assets/image/on3.png';
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
