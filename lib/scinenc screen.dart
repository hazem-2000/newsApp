import 'package:flutter/material.dart';

import 'dio helper.dart';

class ScienceScreen extends StatefulWidget {
  const ScienceScreen({Key? key}) : super(key: key);

  @override
  _ScienceScreenState createState() => _ScienceScreenState();
}

class _ScienceScreenState extends State<ScienceScreen> {

  List<dynamic> science = [];


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

  Future gitScience()async {
    return await DioHelper.getData(
        url:
        'https://newsapi.org/v2/top-headlines?country=eg&apiKey=56b046ae4425469dafde690acf2b8fd7',
        query: {
          'country': 'eg',
          'category': 'science',
          'apikey': '56b046ae4425469dafde690acf2b8fd7',
        }).then((value) {
      // print(value.data.toString());
      science = value.data['articles'];
      print(science[0]['title']);
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
                    ("${science[index]['urlToImage']}"),
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
                      "${science[index]['title']}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${science[index]['publishedAt']}",
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

  Widget myDivider(){
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Divider(),
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:science.length==0?myContainer(
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
            gitScience();
          });
        },
        child: Icon(
            Icons.refresh
        ),
      ),
    );
  }
}
