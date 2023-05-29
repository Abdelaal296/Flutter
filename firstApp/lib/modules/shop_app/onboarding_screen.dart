import 'package:firstapp/modules/shop_app/onboarding_screen.dart';
import 'package:firstapp/modules/shop_app/shop_login_screen.dart';
import 'package:firstapp/shared/components/components.dart';
import 'package:firstapp/shared/network/local/cache_helper.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
class BoardingModel{
  final String image;
  final String title;
  final String body;
  BoardingModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnBoardingScreen extends StatefulWidget {
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  var controller =PageController();

  List<BoardingModel> board =[
    BoardingModel(
      image:'assets/images/shop.jpg',
      title: 'On board 1 title',
      body: 'On board 1 body'
    ),
    BoardingModel(
        image:'assets/images/shop.jpg',
        title: 'On board 2 title',
        body: 'On board 2 body'
    ),
    BoardingModel(
        image:'assets/images/shop.jpg',
        title: 'On board 3 title',
        body: 'On board 3 body'
    ),
  ];
  bool isLast=false;

  void submit(){
    CacheHelper.saveData(key: 'onBoarding', value: true).then((value) {
      if(value!) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        actions: [
          TextButton(
            child: Text('SKIP'),
            onPressed: (){
              submit();
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                controller: controller,
                physics: BouncingScrollPhysics(),
                  onPageChanged: (index){
                    if(index ==board.length-1){
                      setState(() {
                        isLast =true;
                      });
                    }else{
                      setState(() {
                        isLast=false;
                      });

                    }
                  },
                  itemBuilder:(context,index)=> buildBoardingItem(board[index]),
                  itemCount: board.length,
              ),
            ),
            SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: controller,
                  count: board.length,
                  effect: ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    dotHeight: 10.0,
                    expansionFactor: 4,
                    dotWidth: 10.0,
                    spacing: 5,
                    activeDotColor: Colors.deepOrange,
                  ),
                ),
                Spacer(),
                FloatingActionButton(
                  child: Icon(
                    Icons.arrow_forward_ios,
                  ),
                  onPressed: (){
                    if(isLast){
                      submit();
                    }else {
                      controller.nextPage(
                        duration: Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget buildBoardingItem(BoardingModel model)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Expanded(
        child: Image(image : AssetImage('${model.image}'),
        ),
      ),
      Text(
        '${model.title}',
        style: TextStyle(
          fontSize: 34.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
      Text(
        '${model.body}',
        style: TextStyle(
          fontSize: 18.0,
          fontWeight: FontWeight.bold,
        ),
      ),
      SizedBox(
        height: 20.0,
      ),
    ],
  );
}
