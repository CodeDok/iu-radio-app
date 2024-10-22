class ModeratorDto {
  final int id;
  final String firstName;
  final String lastName;
  final String image;

  ModeratorDto({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.image,
  });

  factory ModeratorDto.fromJson(Map<dynamic, dynamic> json) {
    return ModeratorDto(
      id: json['id'],
      firstName: json['firstName'],
      lastName: json['lastName'],
      image: json['image'],
    );
  }
}