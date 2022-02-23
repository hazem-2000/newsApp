import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({Key? key}) : super(key: key);

  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {

  TextEditingController textEditingController = TextEditingController();
  void submit(){
    Navigator.of(context).pop(textEditingController.text);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: <Widget>[
            Padding(

              padding: EdgeInsets.all(20),
              child: TextField(
                controller: textEditingController,
                obscureText: false,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                      const Radius.circular(12.0),
                    ),
                  ),
                  labelText: 'Enter words to search',
                  labelStyle: TextStyle(
                      color: Colors.black.withOpacity(0.8)
                  ),
                ),
              ),
            ),
            ElevatedButton(
              child: Text("search"),
              onPressed: () => submit(),
            ),
          ],
        ),
      ),
    );
  }
}
