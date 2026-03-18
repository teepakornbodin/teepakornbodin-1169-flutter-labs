class Contact {
  final String name;
  final String phone;
  final String email;

  Contact({required this.name, required this.phone, required this.email});

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      name: json['name'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
    );
  }

  Map<String, dynamic> toJson() => {
    'name': name,
    'phone': phone,
    'email': email,
  };
}
