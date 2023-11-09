import 'dart:convert';

import 'package:api_project_tutorial_4/model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});


  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

List<SamplePosts> samplePosts = [];

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
        body: FutureBuilder(
          future: getData(),
          builder: (context, snapshot) {
            if(snapshot.hasData){
              return ListView.builder(
                  itemCount: samplePosts.length,
                  itemBuilder: (context, index) {
                    return Container(
                      height: 180,
                      margin: const EdgeInsets.all(20),
                      //     padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.greenAccent,
                      ),

                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start, //  texts left se start hoga
                        mainAxisAlignment: MainAxisAlignment.spaceBetween, // texts ke bech me spacing
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text("User id: ${ samplePosts[index].userId } ",style: TextStyle(fontSize: 18),maxLines: 1,),
                         // maxLines 1 se agar 100 lines ho to 1 krne se sirf 1st line print hogi 100 lines print nhi hogi
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text("Id: ${ samplePosts[index].id } ",style: TextStyle(fontSize: 18),maxLines: 1,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text("Title: ${ samplePosts[index].title } ",style: TextStyle(fontSize: 18),maxLines: 1,),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                            child: Text("Body: ${ samplePosts[index].body } ",style: TextStyle(fontSize: 18),maxLines: 1,),
                          ),
                        ],
                      ),

                    );
                  }
              );
            }
            else{
              return Center(child: CircularProgressIndicator(),);
            }
          }
        ),

      // now we create a method which is calling the api


    );

  }

Future<List<SamplePosts>> getData() async{
  final response = await http.get( Uri.parse("https://jsonplaceholder.typicode.com/posts") );
  // get method ka use krke hum iss url ko hit kr rahe hai isse hit krne ke baad jo humme response milaga
  // usse hum final ke response variable me store karenge
  var data = jsonDecode( response.body.toString() );

  if(response.statusCode == 200){              // here 200 = total number of lists
    for(Map<String, dynamic> index in data ){  // Map (jisme key, value pair hote or keys unique or value kuch bhe ho sakti)
                                               // Map(key1:value, key2:value, ......) ke particular index me data ko one by one daal do
      samplePosts.add(SamplePosts.fromJson(index)); // samplePosts class me jakr add method ka use karke SamplePosts.fromJson wali class me ja kr
                                                    // list ke sabhi key value pairs ko index me one by one add kr lete ha
    }
    return samplePosts;
  }else{
    return samplePosts;
  }

}

}
