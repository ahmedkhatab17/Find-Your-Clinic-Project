/// Specialty domain entity — used in sign-up dropdown.
class Specialty {
  final String id;
  final String name;
  final String? iconUrl;

  const Specialty({
    required this.id,
    required this.name,
    this.iconUrl,
  });
}
