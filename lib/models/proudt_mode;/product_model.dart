class HomeModel {
  bool? status  ;
  HomeModelData?data ;
  HomeModel.formjson(Map<String , dynamic>json)
  {
    status = json["status"] ;
    data = HomeModelData.formjson(json["data"] );
  }
}

class HomeModelData
{
  List<ProductInfo>products = [] ;
  List<BannersInfo>banners = [] ;
  HomeModelData.formjson(Map<String , dynamic>json)
  {
    json["products"].forEach((product)
    {
      products.add(ProductInfo.formjson(product)) ;
    }) ;

    json["banners"].forEach((banner)
    {
      banners.add(BannersInfo.formjson(banner)) ;
    }) ;

  }
}

class BannersInfo
{
  int?id ;
  String?image ;
  BannersInfo.formjson(Map<String , dynamic>json)
  {
    id = json["id"]  ;
    image = json["image"] ;
  }
}
class ProductInfo
{
  int ?id ;
  String ?name ;
  String ?image ;
  dynamic ?price ;
  dynamic?discount ;
  dynamic?old_price ;
  bool?in_favorites ;
  bool?in_cart ;
  String?description ;
  ProductInfo.formjson(Map<String , dynamic>json)
  {
    id = json["id"] ;
    name = json["name"] ;
    image = json["image"] ;
    price = json["price"] ;
    discount = json["discount"] ;
    old_price = json["old_price"] ;
    in_cart = json["in_cart"] ;
    in_favorites = json["in_favorites"] ;
    description = json["description"] ;
  }
}
