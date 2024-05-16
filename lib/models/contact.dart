


class Contact {
  int id;
  String name;
  String mail;
  String telephone;

  Contact({required this.id, required this.name, required this.mail, required this.telephone});
  
  factory Contact.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'mail': String mail,
        'telephone': String telephone,
      } =>
        Contact(
          id: id,
          name: name,
          mail: mail,
          telephone: telephone,
        ),
      _ => throw const FormatException('Failed to load album.'),
    };
  }
}