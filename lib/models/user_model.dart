

class UserModel {
  final int id;
  final String name;
  final String company;
  final String username;
  final String email;
  final String address;
  final String zip;
  final String state;
  final String country;
  final String phone;

  UserModel({
    required this.id,
    required this.name,
    required this.company,
    required this.username,
    required this.email,
    required this.address,
    required this.zip,
    required this.state,
    required this.country,
    required this.phone,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      company: json['company'],
      username: json['username'],
      email: json['email'],
      address: json['address'],
      zip: json['zip'],
      state: json['state'],
      country: json['country'],
      phone: json['phone'],
    );
  }
}
