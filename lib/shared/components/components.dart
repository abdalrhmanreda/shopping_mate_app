import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app_first/shared/animated_transaction.dart';

void NavigatTo(context , widget)=>Navigator.push(context, MaterialPageRoute(builder: (context)=>widget)) ;


void NavigatAndFinsh(context , widget)=>Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (context)=>widget) ,
    (Route<dynamic>route)=>false  ,
) ;

void NavigatAndFinshWithTrans(context , widget)=>Navigator.pushAndRemoveUntil(
  context, CustomPageRoute(widget: widget),
      (Route<dynamic>route)=>false  ,
) ;

void NavigatorAndFinish(context , widget)=>Navigator.pushAndRemoveUntil(
    context, MaterialPageRoute(builder: (conetext)=>widget), (route) => false) ;




Widget Button({
  required String text ,
  required Function onpressed ,
  required double width ,
  required double height ,
  required int ButtonColor ,
  double? borderRadius ,
  String ?FontFamily ,
})=>Container(
  width: width,
  height: height ,
  decoration: BoxDecoration(
    color: Color(ButtonColor),
    borderRadius: BorderRadius.circular(borderRadius!) ,


  ),
  child: MaterialButton(
    onPressed: (){
      onpressed();
    },
    child: Text(
      text ,
      style: TextStyle(
        color: Colors.white ,
        fontFamily: '$FontFamily' ,

        fontSize:16 ,

      ),
      maxLines: 1,
    ),
  ) ,
) ;





Widget defaultTextFormFelid({
  required bool isPassword ,
  required TextInputType type ,
  required TextEditingController controller ,
  String? Function(String?)?onSubmitted ,
  String? Function(String?)?onChanged,
  String? Function(String?)?validate ,
  String? hint ,
  IconData? prefix ,
  IconData? sufffixIcon ,
  Function?ontap ,
  Function? SufficPressed ,
  bool?isclick = true ,
  InputBorder? border ,
  EdgeInsetsGeometry ?edgeInsetsGeometry ,



})=>TextFormField(

  obscureText: isPassword,
  keyboardType:type ,
  controller: controller,
  onFieldSubmitted: onSubmitted,
  onChanged: onChanged,
  validator: validate,
  onTap: ()
  {
    ontap ;
  },
  enabled:isclick ,

  decoration: InputDecoration(
    contentPadding: edgeInsetsGeometry,
    prefixIcon: Icon(
      prefix ,
      color: Colors.black45,
    ) ,
    border:border ,
    hintText: hint ,






  ),

);


Future<bool?> tost()=>Fluttertoast.showToast(
    msg: "This is Center Short Toast",
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.CENTER,
    timeInSecForIosWeb: 1,
    backgroundColor: Colors.red,
    textColor: Colors.white,
    fontSize: 16.0
);

enum ToastState  {SUCCESS, ERROR, WARNING}

void showToast({
  required String message,
  required ToastState state ,
})=>Fluttertoast.showToast(
    msg:message,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: stateColor(state),
    textColor: Colors.white,
    fontSize: 16.0
);


Color stateColor(ToastState state)
{
  Color?color  ;
  switch (state)
  {
      case ToastState.SUCCESS:
        color = Colors.green ;
        break ;
      case ToastState.ERROR:
        color = Colors.red ;
        break ;
    case ToastState.WARNING:
      color = Colors.amber ;
      break ;
  }
  return color ;
}
//
//
// void showToast({
//   required String message ,
//   required ToastStates state
//
// })=>  Fluttertoast.showToast(
//     msg:message ,
//     toastLength: Toast.LENGTH_SHORT,
//     gravity: ToastGravity.BOTTOM,
//     timeInSecForIosWeb: 1,
//     backgroundColor:ChooseToastColor(state),
//     textColor: Colors.white,
//     fontSize: 16.0
// )  ;
//
// enum ToastStates {success , warning , error}
//
// Color ChooseToastColor(ToastStates state)
// {
//     Color color  ;
//   switch (state)
//   {
//     case ToastStates.success :
//       color= Colors.green ;
//       break ;
//       case ToastStates.warning :
//         color= Colors.amber ;
//         break ;
//     case ToastStates.error :
//       color= Colors.red  ;
//       break ;
//   }
//   return color ;
//   }
