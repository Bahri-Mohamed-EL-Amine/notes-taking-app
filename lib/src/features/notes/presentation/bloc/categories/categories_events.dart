abstract class CategorieEvent {}

class CategorieAddEvent extends CategorieEvent {
  String categorie;
  CategorieAddEvent({required this.categorie});
}

class CategorieFecthAllEvent extends CategorieEvent {}
