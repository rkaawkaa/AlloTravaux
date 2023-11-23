class Artisan {
  final String id;
  final String firstName, lastName;
  final String job;
  final String? description;
  final String? address;
  final String? image;
  final int? projectsNb;
  final int? likesNb;
  final bool? isLiked;
  Artisan(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.job,
      this.description,
      this.address,
      this.image,
      this.projectsNb,
      this.likesNb,
      this.isLiked});
}
