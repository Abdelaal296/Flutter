import 'package:flutter/material.dart';

class MessengerScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
    appBar: AppBar(
      backgroundColor:Colors.black,
      elevation: 0.0,
      title: Row(
        children: [
           CircleAvatar(
             radius: 25,
             backgroundImage: NetworkImage(
                 'https://th.bing.com/th/id/OIP.VkwR3zJhroQBAOagRDlnzwHaHa?w=170&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
             ),
              ),
          SizedBox(
            width: 15.0,
          ),
          Text(
            'Chats',
            style: TextStyle(
              color: Colors.white,
              fontSize: 25 ,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
      actions: [
        IconButton(
          onPressed: (){},
          icon: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(
              Icons.camera_alt ,
              color : Colors.white,
            ),
          ),
        ),
        IconButton(
          onPressed: (){},
          icon: CircleAvatar(
            backgroundColor: Colors.grey,
            child: Icon(
              color : Colors.white,
              Icons.edit ,
            ),
          ),
        ),
      ],
    ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.0,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.0),
                  color: Colors.grey,
                ),
                height: 40,
                child: Row(
                  children: [
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      Icons.search ,
                      color: Colors.white,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text(
                      'Search',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 5.0,
              ),
              Container(
                height: 100,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context,index) => buildStory(),
                  separatorBuilder: (context,index) => SizedBox(
                    width: 15.0,
                  ),
                  itemCount: 10,
                ),
              ),
              ListView.separated(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (context,index) => buildChat(),
                separatorBuilder: (context,index) => SizedBox(
                  height: 15.0,
                ),
                itemCount: 10,
              ),



            ],
          ),
        ),
      ),
  );
  }
  Widget buildStory() => Container(
    width: 60,
    child: Column(
      children: [
        Stack(
          alignment: Alignment.bottomRight,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage:NetworkImage(
                  'https://th.bing.com/th/id/OIP.VkwR3zJhroQBAOagRDlnzwHaHa?w=170&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                bottom: 3,
                right: 3,
              ),
              child: CircleAvatar(
                radius: 7,
                backgroundColor: Colors.green,
              ),
            ),
          ],
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          'CR7',
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,

          ),
        ),
      ],
    ),
  );
  Widget buildChat() => Row(
    children: [
      Stack(
        alignment: Alignment.bottomRight,
        children: [
          CircleAvatar(
            radius: 35,
            backgroundImage:NetworkImage(
                'https://th.bing.com/th/id/OIP.VkwR3zJhroQBAOagRDlnzwHaHa?w=170&h=180&c=7&r=0&o=5&dpr=1.25&pid=1.7'
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
              bottom: 3,
              right: 3,
            ),
            child: CircleAvatar(
              radius: 7,
              backgroundColor: Colors.green,
            ),
          ),
        ],
      ),
      SizedBox(
        width: 20.0,
      ),
      Expanded(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'CR7',
              style: TextStyle(
                fontSize: 20,
                color: Colors.white,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    'Hi mohamed ,How are you akhooia ?',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.white,
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.circle,
                  color: Colors.cyan,
                  size: 10,
                ),
                SizedBox(
                  width: 10.0,
                ),
                Text(
                  '02:00 pm',
                  style: TextStyle(
                    fontSize: 13,
                    color: Colors.white,
                  ),
                ),
              ],
            ),

          ],
        ),
      ),
    ],
  );

}