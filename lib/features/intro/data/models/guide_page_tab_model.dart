// ignore_for_file: public_member_api_docs, sort_constructors_first

class GuidePageTabModel {
  final String? title;
  final String? description;
  final String? image;

  const GuidePageTabModel({
    this.title,
    this.description,
    this.image,
  });

  static final guidePageTabs = [
    const GuidePageTabModel(
      description: 'guide1_description',
      title: 'guide1_title',
      image: 'assets/images/Onboarding1.png',
    ),
    const GuidePageTabModel(
      description: 'guide2_description',
      title: 'guide2_title',
      image: 'assets/images/Onboarding2.png',
    ),
    const GuidePageTabModel(
      description: 'guide3_description',
      title: 'guide3_title',
      image: 'assets/images/Onboarding3.png',
    ),
  ];
}
