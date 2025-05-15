
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart'as http;
import 'package:html/dom.dart' as dom;
import 'package:html/parser.dart' as parser;
import 'package:web_scrapping_example/methode3/get.dart';


class HomePage3 extends StatefulWidget {
  const HomePage3({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _HomePage3State createState() => _HomePage3State();
}

class _HomePage3State extends State<HomePage3> {
  DataController dataController = Get.put(DataController());
  @override
  void initState() {
    getData();
    super.initState();
  }


  getData() async {
  var response = await http.get(
    Uri.parse('https://en.wikipedia.org/wiki/List_of_universities_in_Pakistan'),
  );
  dom.Document document = parser.parse(response.body);

  var tables = document.querySelectorAll('table > tbody');
  print("Total tables found: ${tables.length}");

  for (int k = 0; k < tables.length; k++) {
    var rows = tables[k].querySelectorAll('tr');
    for (int i = 1; i < rows.length; i++) {
      var columns = rows[i].children;
      if (columns.length >= 2) {
        dataController.addName(columns[0].text.trim());
        dataController.addLocation(columns[1].text.trim());
      }
    }
  }
}



  @override
  Widget build(BuildContext context) {
    return GetBuilder<DataController>(builder: (_) => Scaffold(
      appBar: AppBar(
        title: Text('Data Scrap'),
      ),
      body: SafeArea(
        child: ListView.builder(
          shrinkWrap: true,
            itemCount: dataController.name.length,
            itemBuilder: (BuildContext context,int index)
          {
            return Card(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                 children: [
                   Expanded(child: Text(dataController.name[index].toString().trim(),style: const TextStyle(fontSize: 20,color: Colors.black,fontWeight: FontWeight.bold),)),
                   Text(dataController.location[index].toString().trim(),style: const TextStyle(fontSize: 15,color: Colors.blueGrey),),
                 ],
                ),
              ),
            );
          }
        ),
      ),
    ));
  }

}
