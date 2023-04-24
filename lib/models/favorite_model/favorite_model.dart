class ChangeFavoriteModel
{
  bool ?status ;
  String?message ;

  ChangeFavoriteModel.fromjson(Map<String,dynamic>json)
  {
    status = json["status"] ;
    message= json["message"] ;
  }
}

class FavoriteModel
{
  bool ?status ;
  FavoriteDataModel ?data ;
  FavoriteModel.formjson(Map<String,dynamic>json)
  {
    status = json["status"] ;
    data  =FavoriteDataModel.formjson(json["data"]) ;
  }
}

class FavoriteDataModel
{
  int ?current_page ;
  List<Data>productsList=[] ;
  FavoriteDataModel.formjson(Map<String,dynamic>json)
  {
    current_page = json["current_page"] ;
    json["data"].forEach(
        (element)
        {
          productsList.add(Data.formjson(element)) ;
        }
    ) ;
  }

}

class Data {
  int?id ;
  ProductSearchDataModel ?product;
  Data.formjson(Map<String,dynamic>json)
  {
    id = json["id"] ;
    product = ProductSearchDataModel.formjson(json["product"]) ;
  }
}


class ProductSearchDataModel
{
  int?id ;
  dynamic ?price ;
  dynamic?old_price ;
  dynamic?discount ;
  String?image;
  String?name ;
  String?description ;
  ProductSearchDataModel.formjson(Map<String,dynamic>json)
  {
    id = json["id"] ;
    price = json["price"] ;
    old_price = json["old_price"] ;
    discount = json["discount"] ;
    image = json["image"] ;
    name = json["name"] ;
    description = json["description"] ;
  }
}