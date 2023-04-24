class SearchModel
{
  bool? status ;
  SearchDataModel ?data ;
  SearchModel.fromjson (Map<String , dynamic>json)
  {
    status = json["status"] ;
    data = SearchDataModel.fromjson(json["data"]);
  }

}

class SearchDataModel
{
List<SearchProductDataModel>products =[];

SearchDataModel.fromjson (Map<String , dynamic>json)
{
  json['data'].forEach ((element)
  {
    products.add(SearchProductDataModel.formjson(element)) ;
  });
}

}


class SearchProductDataModel
{
  int?id ;
  dynamic ?price ;
  dynamic?old_price ;
  dynamic?discount ;
  String?name ;
  String?image ;
  String?description ;
  bool?in_favorites ;
  bool?in_cart;

  SearchProductDataModel.formjson(Map<String , dynamic>json)
  {
    id = json["id"];
    price = json["price"] ;
    old_price = json["old_price"] ;
    discount = json["discount"] ;
    name = json["name"] ;
    image = json["image"] ;
    description = json["description"] ;
    in_favorites = json["in_favorites"] ;
    in_cart = json["in_cart"] ;
  }

}