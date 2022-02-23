import 'package:flutter/material.dart';
import 'package:news/search.dart';

import 'dio helper.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {

  List<dynamic> search = [];

  var x;

  Future gitSearch()async {
    return await DioHelper.getData(
        url:
        'https://newsapi.org/v2/everything?q=$x&from=2022-01-22&sortBy=publishedAt&apiKey=56b046ae4425469dafde690acf2b8fd7',
        query: {

          'apikey': '56b046ae4425469dafde690acf2b8fd7',
        }).then((value) {
      // print(value.data.toString());
      search = value.data['articles'];
      print(search[0]['title']);
    }).catchError((error) {
      print(error.toString());
    });
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
                    ("${search[index]['urlToImage']}"),
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
                      "${search[index]['title']}",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Text(
                    "${search[index]['publishedAt']}",
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
      appBar: AppBar(
        backgroundColor:Color.fromARGB(255, 214, 77, 96),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (context){
                return Search();
              })).then((valueFromTextField){
                // use your valueFromTextField from the second page
                setState(() {
                  x=valueFromTextField;

                });

              });
            },
            icon: Icon(Icons.search),
            color: Colors.black,
          )
        ],

      ),
      body:search.length==0?myContainer(
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
            gitSearch();
          });
        },
        child: Icon(
            Icons.refresh
        ),
      ),
    );
  }
}


