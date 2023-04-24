import 'package:flutter/material.dart' ;
import 'package:shop_app_first/network/local/cache_helper.dart';
import 'package:shop_app_first/shared/asset_images.dart';
import 'package:shop_app_first/shared/components/components.dart';
import 'package:shop_app_first/shared/style/colors.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/animated_transaction.dart';
import '../login/login_screen.dart';

class OnBoarding
{
  final String image  ; 
  final String title ; 
  final String description ;

  OnBoarding({required this.image, required this.title,required this.description});
  
}

class OnBoardingScreen extends StatefulWidget {
  OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {

  var pageController = PageController() ;
  void submit()
  {
    CacheHelper.SaveData(key: 'onBoarding', value: true)?.then((value)
    {
      NavigatAndFinshWithTrans(context, LoginScreen()) ;
    }) ;
  }

  List<OnBoarding>items = [
    OnBoarding(
      image: AssetImages.OnBoardingImage1,
      title: 'Shopping Mate',
      description: 'is a shopping program designed to make your shopping experience easier, faster, and more convenient. ' ,
    ) ,
    OnBoarding(
     image: AssetImages.OnBoardingImage2,
     title: 'Shopping Offers',
     description: ' offers a clean and intuitive interface that \nmakes it easy to find the products you\n need.' ,
  ) ,
    OnBoarding(
      image: AssetImages.OnBoardingImage2,
      title: 'Payment',
      description: 'Once you\'ve found the products you want\n, you can add them to your cart and check \nout with just a few clicks' ,
    ) ,
  ] ;

  bool isLast = false ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
              onPressed: submit,
              child: const Text(
                'Skip'
              ) ,
          ) ,
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
                child:Column(
                  children: [
                    const Text(
                      'Shopping Mate'  ,
                      style: TextStyle(
                        color: Color(0xffff7e54) ,
                        fontSize: 30 ,
                        fontWeight: FontWeight.bold ,
                      ),
                    ) ,
                    Expanded(
                      child: PageView.builder(
                        itemBuilder:(context , index)=>OnBoardingItem(items[index]) ,
                        itemCount: items.length,
                        controller: pageController,
                        physics: const BouncingScrollPhysics(),
                        onPageChanged: (index)
                        {
                          if(index == items.length-1)
                          {
                            setState(() {
                              isLast = true;
                            });
                          }else
                          {
                            setState(() {
                              isLast = false;
                            });
                          }
                        },
                        scrollDirection: Axis.horizontal,

                      ),
                    ) ,
                    Padding(
                      padding: const EdgeInsets.only(bottom: 60),
                      child: SmoothPageIndicator(
                        controller: pageController,
                        count:  items.length,
                        axisDirection: Axis.horizontal,
                        effect:  const ExpandingDotsEffect(
                            spacing:  8.0,
                            radius:  4.0,
                            dotWidth:  8.0,
                            dotHeight:  8.0,
                            paintStyle:  PaintingStyle.fill,
                            strokeWidth:  1.5,
                            dotColor:  Colors.grey,
                            activeDotColor:  Colors.deepOrangeAccent
                        ),
                      ),
                    ),
                  ],
                ) ,
            ) ,
            Button(
                text: 'Next',
                onpressed: ()
                {
                  if(isLast)
                  {
                    submit() ;

                  }else
                  {
                    pageController.nextPage(duration: const Duration(milliseconds: 750), curve: Curves.fastOutSlowIn) ;
                  }
                },
                width: double.infinity,
                height: 55,
                ButtonColor: primaryColor ,
              borderRadius: 25
            ) ,


          ],
        ),
      ),
    );
  }

  Widget OnBoardingItem(OnBoarding onBoarding)=> Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      Image.asset(onBoarding.image) ,
      const SizedBox(height: 15,) ,
      Text(onBoarding.title , style: const TextStyle(fontSize: 20),) ,
      const SizedBox(height: 15,) ,
      Text(onBoarding.description , maxLines: 3,) ,
    ],
  ) ;
}
