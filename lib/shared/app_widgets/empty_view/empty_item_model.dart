class EmptyItemModel {
  final String? mainHeader;
  final String? image;
  final String mainTextHeader;
  final String h1;
  final String? h2;
  final String? h3;

  EmptyItemModel({
    this.mainHeader,
    required this.mainTextHeader,
    required this.h1,
    this.image,
    this.h2,
    this.h3,
  });
}
