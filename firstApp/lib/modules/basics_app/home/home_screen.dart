import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading:Icon(
          Icons.menu,
        ) ,
        title: Text(
            'Course',
        ),
        actions: [
          IconButton(onPressed: (){
            print('HELLO') ;

          },
            icon: Icon(
            Icons.search,
          ),),
          IconButton(onPressed: (){
            print('notification ') ;
          }, icon: Icon(
            Icons.notification_important,
          ),),

        ],
        centerTitle: true,
        backgroundColor: Colors.indigoAccent,
      ),
      body:Column(
          
          children: [
            Padding(
              padding: const EdgeInsets.all(50.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(
                    20.0
                  ),

                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: Stack(
                  alignment: Alignment.bottomCenter,
                  children: [
                    Image(
                      image: NetworkImage(
                        'https://th.bing.com/th/id/OIP.VkwR3zJhroQBAOagRDlnzwHaHa?w=170&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
                      ),
                      height: 300,
                      width: 300,
                      fit: BoxFit.cover,
                    ),
                    Container(
                      width: 300,
                      child: Text(
                        'Siiiiiiiiiiiiiiiiiii',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.amber,
                          fontSize: 50 ,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
              // Text(
              //   'first',
              //   style: TextStyle(
              //     fontSize: 40 ,
              //   ),
              //
              // ),



            ],
        ),
    );
  }
}

