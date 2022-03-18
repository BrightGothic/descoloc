///This class works along the page "pages/page_profil.dart"
///It's content is deprecated for the connexion with CloudFirestore
///Please now refer to models/user.dart

class UserProfil {
  final String name;
  final String pseudo;
  final int abonnes;
  final int abonnements;
  final int points;
  final String apropos;

  const UserProfil({
    required this.name,
    required this.pseudo,
    required this.abonnes,
    required this.abonnements,
    required this.points,
    required this. apropos,
  });
}

