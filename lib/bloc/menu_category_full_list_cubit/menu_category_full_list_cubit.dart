import 'package:coozy_cafe/AppLocalization.dart';
import 'package:coozy_cafe/model/category.dart';
import 'package:coozy_cafe/model/sub_category.dart';
import 'package:coozy_cafe/repositories/components/restaurant_repository.dart';
import 'package:coozy_cafe/utlis/components/constants.dart';
import 'package:coozy_cafe/utlis/components/string_value.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rxdart/rxdart.dart';

part 'menu_category_full_list_state.dart';

class MenuCategoryFullListCubit extends Cubit<MenuCategoryFullListState> {
  MenuCategoryFullListCubit() : super(InitialState());

  final BehaviorSubject<MenuCategoryFullListState> _stateSubject =
      BehaviorSubject();

  Stream<MenuCategoryFullListState> get stateStream => _stateSubject.stream;

  Future<void> loadData() async {
    try {
      // Simulate loading data
      emit(LoadingState());

      // Replace this with your actual data loading logic
      Map<String, dynamic>? data = await fetchDataFromApi();
      if (data == null || data.isEmpty) {
        emit(LoadedState(
            data: null,
            expansionTileKeys: null,
            expandedTitleControllerList: null));
      } else {
        List<GlobalKey?>? expansionTileKeys = List.generate(
            data == null ? 0 : data['categories'].length ?? 0,
            (index) => GlobalKey());
        List<ExpansionTileController>? expandedTitleControllerList =
            List.generate(data == null ? 0 : data['categories'].length ?? 0,
                (index) => ExpansionTileController());

        emit(LoadedState(
            data: data,
            expansionTileKeys: expansionTileKeys,
            expandedTitleControllerList: expandedTitleControllerList));
      }
      //   emit(NoInternetState());
    } catch (e) {
      emit(ErrorState('An error occurred: $e'));
    }
  }

  Future<Map<String, dynamic>?> fetchDataFromApi() async {
    try {
      List<Category>? categoryList =
          await RestaurantRepository().getCategories();
      List<SubCategory>? subCategoryList =
          await RestaurantRepository().getSubcategories();

      var result = {
        "categories": categoryList?.map((category) {
              List<Map<String, dynamic>> subCategories = subCategoryList
                      ?.where((subCategory) =>
                          subCategory.categoryId == category.id)
                      .map((subCategory) => subCategory.toJson())
                      .toList() ??
                  [];
              return {
                "id": category.id!,
                "name": category.name!,
                "isActive": category.isActive!,
                "createdDate": category.createdDate,
                "subCategories": subCategories,
              };
            }).toList() ??
            [],
      };

      return result;
    } catch (e) {
      Constants.debugLog(
          MenuCategoryFullListCubit, "fetchDataFromApi:catchError:$e");
      return null;
    }
  }

  Future<void> handleIsEnableCategory(
      BuildContext context, Category category, bool isEnable) async {
    try {
      Constants.debugLog(MenuCategoryFullListCubit,
          "handleIsEnableCategory:initialCategory:${category.toJson()}");

      try {
        category.isActive = isEnable == false ? 0 : 1;

        Constants.debugLog(MenuCategoryFullListCubit,
            "handleIsEnableCategory:Category:${category.toJson()}");
        var resCategory = await RestaurantRepository().updateCategory(category);
        Constants.debugLog(MenuCategoryFullListCubit,
            "handleIsEnableCategory:updateCategory:res:$resCategory");

        if (isEnable == false) {
          Constants.showToastMsg(
              msg: AppLocalizations.of(context)?.translate(StringValue
                      .menu_category_full_list_unable_to_update_category_msg) ??
                  "Your selected Category has been deactivated, and you will no longer receive orders for it.");
        } else {
          Constants.showToastMsg(
              msg: AppLocalizations.of(context)?.translate(StringValue
                      .menu_category_full_list_enable_to_update_category_msg) ??
                  "Your selected Category has been activated, and you are able to accept orders for it.");
        }
      } catch (error) {
        Constants.debugLog(
            MenuCategoryFullListCubit, "handleIsEnableCategory:Error:${error}");

        Constants.showToastMsg(
            msg: AppLocalizations.of(context)?.translate(StringValue
                    .menu_category_full_list_failed_to_update_category_msg) ??
                "Failed to enable your selected category! Please try again.");
        return;
      }

      Map<String, dynamic>? data = await fetchDataFromApi();
      if (data == null || data.isEmpty) {
        emit(LoadedState(
            data: null,
            expansionTileKeys: null,
            expandedTitleControllerList: null));
      } else {
        List<GlobalKey?>? expansionTileKeys = List.generate(
            data == null ? 0 : data['categories'].length ?? 0,
            (index) => GlobalKey());
        List<ExpansionTileController>? expandedTitleControllerList =
            List.generate(data == null ? 0 : data['categories'].length ?? 0,
                (index) => ExpansionTileController());

        // emit(LoadedState(
        //     data: data,
        //     expansionTileKeys: expansionTileKeys,
        //     expandedTitleControllerList: expandedTitleControllerList));
        //
        final currentState = state as LoadedState;

        final newExpansionTileKeys =
            List<GlobalKey?>.from(currentState.expansionTileKeys!);
        final newExpandedTitleControllerList =
            List<ExpansionTileController>.from(
                currentState.expandedTitleControllerList!);

        emit(LoadedState(
            data: data,
            expansionTileKeys: newExpansionTileKeys,
            expandedTitleControllerList: newExpandedTitleControllerList));
      }
      //   emit(NoInternetState());
    } catch (e) {
      emit(ErrorState('An error occurred: $e'));
    }
  }

  void handleIsEnableSubCategory(
      BuildContext context, SubCategory subCategory, bool isEnable) async {
    try {
      Constants.debugLog(MenuCategoryFullListCubit,
          "handleIsEnableCategory:initialCategory:${subCategory.toJson()}");

      try {
        subCategory.isActive = isEnable == false ? 0 : 1;

        Constants.debugLog(MenuCategoryFullListCubit,
            "handleIsEnableCategory:Category:${subCategory.toJson()}");
        var resCategory =
            await RestaurantRepository().updateSubcategory(subCategory);
        Constants.debugLog(MenuCategoryFullListCubit,
            "handleIsEnableCategory:updateCategory:res:$resCategory");

        if (isEnable == false) {
          Constants.showToastMsg(
              msg: AppLocalizations.of(context)?.translate(StringValue
                      .menu_category_full_list_unable_to_update_sub_category_msg) ??
                  "Your selected sub-category has been deactivated, and you will no longer receive orders for it.");
        } else {
          Constants.showToastMsg(
              msg: AppLocalizations.of(context)?.translate(StringValue
                      .menu_category_full_list_enable_to_update_sub_category_msg) ??
                  "Your selected sub-category has been activated, and you are able to accept orders for it.");
        }
      } catch (error) {
        Constants.debugLog(
            MenuCategoryFullListCubit, "handleIsEnableCategory:Error:${error}");

        Constants.showToastMsg(
            msg: AppLocalizations.of(context)?.translate(StringValue
                    .menu_category_full_list_failed_to_update_sub_category_msg) ??
                "Failed to enable your selected sub-category! Please try again.");
        return;
      }

      Map<String, dynamic>? data = await fetchDataFromApi();
      if (data == null || data.isEmpty) {
        emit(LoadedState(
            data: null,
            expansionTileKeys: null,
            expandedTitleControllerList: null));
      } else {
        List<GlobalKey?>? expansionTileKeys = List.generate(
            data == null ? 0 : data['categories'].length ?? 0,
            (index) => GlobalKey());
        List<ExpansionTileController>? expandedTitleControllerList =
            List.generate(data == null ? 0 : data['categories'].length ?? 0,
                (index) => ExpansionTileController());
        //
        // emit(LoadedState(
        //     data: data,
        //     expansionTileKeys: expansionTileKeys,
        //     expandedTitleControllerList: expandedTitleControllerList));


        final currentState = state as LoadedState;

        final newExpansionTileKeys =
        List<GlobalKey?>.from(currentState.expansionTileKeys!);
        final newExpandedTitleControllerList =
        List<ExpansionTileController>.from(
            currentState.expandedTitleControllerList!);

        emit(LoadedState(
            data: data,
            expansionTileKeys: newExpansionTileKeys,
            expandedTitleControllerList: newExpandedTitleControllerList));

      }
      //   emit(NoInternetState());
    } catch (e) {
      emit(ErrorState('An error occurred: $e'));
    }
  }

  @override
  Future<void> close() {
    _stateSubject.close();
    return super.close();
  }
}
