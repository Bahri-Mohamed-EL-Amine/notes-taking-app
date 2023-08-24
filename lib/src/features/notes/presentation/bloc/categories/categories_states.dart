abstract class CategoriesState {}

class CategoriesInitialState extends CategoriesState {}

class CategoriesUpdateState extends CategoriesState {
  List<String> categories;
  CategoriesUpdateState({required this.categories});
}
