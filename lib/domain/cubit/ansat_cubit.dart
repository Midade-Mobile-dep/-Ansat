
import 'package:audiobook/presentation/main/main_view.dart';
import 'package:flutter/material.dart';

import '../models/Get_all_categories.dart';
import '../models/Get_category_items.dart';
import '../models/Serach_model.dart';
import '../network/remote/dio_helper.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'ansat_state.dart';

class AnsatCubit extends Cubit<AnsatState> {
  AnsatCubit() : super(AnsatInitial());

  static AnsatCubit get(context) => BlocProvider.of(context);
  // int currentIndex = 0;

  // List<Widget> bottomScreens = [MainView(), FavoritView()];

  // void changeBottom(int index) {
  //   currentIndex = index;

  //   emit(AnsatChangeBottomNavState());
  // }

 List<bool>  favoritColor = [];
//  favoritColor.addAll(false);
  List<dynamic> favoriteModel = [];
  void changeFavorit(int index ) {
    // if (favoritColor == true) {
    //   favoriteModel.add(FavoriteModel);
    //       favoritColor = !favoritColor;

    // }
    favoritColor[index] = !favoritColor[index];
    emit(AnsatChangeFavoritState());
  }

  void getModelData() {
    emit(AnsatLoadingHomeDataState());
    DioHelper.getData(url: 'http://islamicaudio.net/api/api-json/get-sections')
        .then((value) {
      category = GetAllCategory.fromJson(value.data);
      print(category!.data![1].bigThumbnail.toString());
      emit(AnsatSuccessHomeDataState());
    }).catchError((Error) {
      print(Error.toString());
      emit(AnsatErrorHomeDataState());
    });
  }

  GetAllCategory? category;

  void getCategoryItems(int id) {
    emit(AnsatLoadingCategoryItemsState());
    DioHelper.getData(
            url: 'http://islamicaudio.net/api/api-json/sections/topics/$id')
        .then((value) {
      categoryItems = GetCategoryItems.fromJson(value.data);
      print(categoryItems!.data![1].bigThumbnail.toString());
      emit(AnsatSuccessCategoryItemsState());
    }).catchError((Error) {
      print(Error.toString());
      emit(AnsatErrorCategoryItemsState());
    });
  }

  GetCategoryItems? categoryItems;

  void getSearch(String word) {
    emit(AnsatLoadingSerachState());
    DioHelper.getData(
            url: 'http://islamicaudio.net/api/api-json/search/3?word=$word')
        .then((value) {
      search = SearchModel.fromJson(value.data);
      print(search!.data![0].id);
      emit(AnsatSuccessSerachState());
    }).catchError((Error) {
      print(Error.toString());
      emit(AnsatErrorSerachState());
    });
  }

  SearchModel? search;
}
