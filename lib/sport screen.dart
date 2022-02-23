import 'package:flutter/material.dart';

import 'dio helper.dart';
class SportScreen extends StatefulWidget {
  const SportScreen({Key? key}) : super(key: key);

  @override
  _SportScreenState createState() => _SportScreenState();
}

class _SportScreenState extends State<SportScreen> {
  List<dynamic> sport = [];


  Future gitSport()async {

    return await DioHelper.getData(
        url:
        'https://newsapi.org/v2/top-headlines?country=eg&apiKey=56b046ae4425469dafde690acf2b8fd7',
        query: {
          'country': 'eg',
          'category': 'sport',
          'apikey': '56b046ae4425469dafde690acf2b8fd7',
        }).then((value) {
      // print(value.data.toString());
      sport = value.data['articles'];
      print(sport[0]['title']);
    }).catchError((error) {
      print(error.toString());
    });
  }

  Widget buildItem(int index) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                image: DecorationImage(
                  image: NetworkImage
                    ("${sport[index]['urlToImage']}"),
                  fit: BoxFit.cover,
                )),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Container(
              height: 120,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Text(
                      "${sport[index]['title']}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${sport[index]['publishedAt']}",
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget myContainer({child}){
    return Container(
      child: child,
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 214, 77, 96),
                Color.fromARGB(0, 214, 77, 96),
              ]
          )
      ),
    );
  }

  Widget myDivider(){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Divider(),
    );
  }
  @override
  Widget build(BuildContext context) {

    return  Scaffold(
      body:sport.length==0?myContainer(
        child: Center(child: CircularProgressIndicator(
          color: Colors.red,
        )),
      ): Stack(
        children: [

         myContainer(),
          ListView.separated(
              physics: BouncingScrollPhysics(),
              itemBuilder: (context, index) => buildItem(index),
              separatorBuilder: (context, index) => myDivider(),
              itemCount: 10),

        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.red.shade300,
        onPressed: () {
          setState(() {
            gitSport();
          });
        },
        child: Icon(
            Icons.refresh
        ),
      ),
    );
  }
}
