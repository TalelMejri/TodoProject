

    
class User{
  int id;
  String Nom;
  String Email;
  String Password;
  String ImageProfile;



  User({
    required this.id,
    required this.Nom,
    required this.Email,
    required this.Password,
    required this.ImageProfile
  });

  factory User.fromJson(Map<String,dynamic> json){
    return User(
      id: json['id'],
      Nom: json['nom'],
      Email: json['email'],
      Password: json['password'],
      ImageProfile: json['imageProfile']
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id':id,
      'nom': Nom,
      'email': Email,
      'password': Password,
      'imageProfile': ImageProfile,
    };
  }

   @override
  String toString() {
    return 'User{id: $id, Nom: $Nom, Email: $Email, Password: $Password, ImageProfile: $ImageProfile}';
  }
 
}