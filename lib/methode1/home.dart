import 'package:flutter/material.dart';
import 'package:web_scrapping_example/methode1/Scrapping.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
 // Strings to store the extracted Article titles 
  String result1 = 'Result 1'; 
  String result2 = 'Result 2'; 
  String result3 = 'Result 3'; 
    
  // boolean to show CircularProgressIndication 
  // while Web Scraping awaits 
  bool isLoading = false; 
  
  @override 
  Widget build(BuildContext context) { 
    return Scaffold( 
      appBar: AppBar(title: Text('GeeksForGeeks')), 
      body: Padding( 
        padding: const EdgeInsets.all(16.0), 
        child: Center( 
            child: Column( 
          mainAxisAlignment: MainAxisAlignment.center, 
          children: [ 
              
            // if isLoading is true show loader 
            // else show Column of Texts 
            isLoading 
                ? CircularProgressIndicator() 
                : Column( 
                    children: [ 
                      Text(result1, 
                          style: TextStyle( 
                              fontSize: 20, fontWeight: FontWeight.bold)), 
                      SizedBox( 
                        height: MediaQuery.of(context).size.height * 0.05, 
                      ), 
                      Text(result2, 
                          style: TextStyle( 
                              fontSize: 20, fontWeight: FontWeight.bold)), 
                      SizedBox( 
                        height: MediaQuery.of(context).size.height * 0.05, 
                      ), 
                      Text(result3, 
                          style: TextStyle( 
                              fontSize: 20, fontWeight: FontWeight.bold)), 
                    ], 
                  ), 
            SizedBox(height: MediaQuery.of(context).size.height * 0.08), 
            MaterialButton( 
              onPressed: ()async { //Setting isLoading true to show the loader
                setState(() {
                  isLoading = true;
                });
                
                //Awaiting for web scraping function to return list of strings
                final response = await extractData();
                
                //Setting the received strings to be displayed and making isLoading false to hide the loader
                setState(() {
                  result1 = response[0];
                  result2 = response[1];
                  result3 = response[2];
                  isLoading = false;
                });}, 
              color: Colors.green, 
              child: Text( 
                'Scrap Data', 
                style: TextStyle(color: Colors.white), 
              ), 
            ) 
          ], 
        )), 
      ), 
    ); 
  } 
} 