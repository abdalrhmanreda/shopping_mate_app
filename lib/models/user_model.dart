class UserModel
{
  bool ? status ;
  String?message ;
  UserDataModel?data ;
  UserModel.formjson(Map<String,dynamic>json)
  {
    status = json["status"];
    message = json["message"];
    data = json["data"] !=null? UserDataModel.formjson(json["data"]):null;
  }
}

class UserDataModel
{
  int?id ;
  String ?name ;
  String?image  ;
  String?email ;
  int?points ;
  int?credit ;
  String?token ;
  String?phone ;
  UserDataModel.formjson(Map<String,dynamic>json)
  {
    id = json["id"] ;
    name = json["name"] ;
    image = json["image"] ;
    email = json["email"] ;
    points =  json["points"] ;
    credit  = json["credit"];
    token =json["token"] ;
    phone = json["phone"] ;


  }

}