import 'dart:convert';
import 'package:final_6207101388/models/Item.dart';
import 'package:final_6207101388/models/api_result.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'data.dart';


class ListPage extends StatefulWidget {
  const ListPage({Key? key}) : super(key: key);

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _LoadItem();
  }
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    var itemData = Data.list[_index];
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.center,
          child:
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Image.network(Data.list[_index].image),
              Column(
                children: [
                  for(int i = 0; i < itemData.choice.length; i++) _viewChoices(itemData, i),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  _LoadItem() async {
    Uri url = Uri.parse("https://cpsu-test-api.herokuapp.com/quizzes");
    var response = await http.get(url, headers: {'id': '620710138'});
    var json = jsonDecode(response.body);
    var apiResult = ApiResult.fromJson(json);

    setState(() {
      Data.list = apiResult.data.map<Item>((item) => Item.fromJson(item)).toList();

    });
  }

  Widget _viewChoices(Item itemData, int num) {
    return Card(
      child: Container(
        child: Expanded(
          child: ElevatedButton(
            onPressed: () {
              if(itemData.choice[num] == itemData.answer) {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Message'),
                        content: Text('ถูกต้อง'),
                        actions: [

                        ],
                      );
                    }
                );
              }
              else {
                showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Message'),
                        content: Text('ไม่ถูกต้อง'),
                        actions: [
                          ElevatedButton(
                              onPressed: () {

                              },
                              child: Text('Ok')
                          )
                        ],
                      );
                    }
                );
              }
            },
            child: Text(itemData.choice[num]),
          ),
        ),
      ),
    );
  }
}
