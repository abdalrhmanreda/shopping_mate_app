import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app_first/models/search_model/search_model.dart';
import 'package:shop_app_first/moduls/search_screen/search_cubit/state.dart';

import '../../../models/favorite_model/favorite_model.dart';
import '../../../network/remote/dio_helper.dart';
import '../../../shared/components/constant.dart';
import '../../../shared/endpoints.dart';

class SearchCubit extends Cubit<SearchStates> {
  SearchCubit() : super(IntialSearchState());

  static SearchCubit get(context) => BlocProvider.of(context);
   SearchModel ?searchData;

  void getSearchData({required String value}) {
    emit(SearchLoadingState());
    DioHelper.PostData(
            url: SEARCH,
            data: {
              'text': value,
            },
            token: token ,
    )
        .then((value) {
      searchData = SearchModel.fromjson(value.data);
      print(searchData!.data!.products[1].discount) ;
      emit(SearchSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SearchErorrState());
    });
  }
}
