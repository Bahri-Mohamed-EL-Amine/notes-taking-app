import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:notes_taking_app/src/features/notes/data/repository/notes_repository_impl.dart';
import 'package:notes_taking_app/src/features/notes/domain/usecase/get_categories_usecase.dart';
import 'package:notes_taking_app/src/features/notes/domain/usecase/insert_category_usecase.dart';
import 'package:notes_taking_app/src/features/notes/presentation/bloc/categories/categories_events.dart';

import 'categories_states.dart';

class CategorieBloc extends Bloc<CategorieEvent, CategoriesState> {
  GetCategoriesUsecase getCategoriesUsecase =
      GetCategoriesUsecase(repository: NoteRepositoryImpl());
  InsertCategoryUsecase insertCategoryUsecase =
      InsertCategoryUsecase(repository: NoteRepositoryImpl());
  List<String> categories = ['All'];
  CategorieBloc() : super(CategoriesInitialState()) {
    on<CategorieAddEvent>(onCategorieAddEvent);
    on<CategorieFecthAllEvent>(onCategorieFetchAllEvent);
  }
  bool isCategoriesFetched = false;
  onCategorieFetchAllEvent(
      CategorieFecthAllEvent event, Emitter<CategoriesState> emit) async {
    if (!isCategoriesFetched) {
      final savedCategories = await getCategoriesUsecase.execute();
      categories.addAll(savedCategories);
      isCategoriesFetched = true;
    }
    emit(CategoriesUpdateState(categories: categories));
  }

  onCategorieAddEvent(
      CategorieAddEvent event, Emitter<CategoriesState> emit) async {
    if (!categories.contains(event.categorie)) {
      categories.add(event.categorie);
      insertCategoryUsecase.execute(event.categorie);
    }
    emit(CategoriesUpdateState(categories: categories));
  }
}
