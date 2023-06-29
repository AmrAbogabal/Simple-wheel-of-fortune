import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fortune_wheel/flutter_fortune_wheel.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'Fun.dart';
import 'Function.dart';

class Play extends StatefulWidget {
  const Play({Key? key}) : super(key: key);

  @override
  State<Play> createState() => _PlayState();
}

class _PlayState extends State<Play> {
  StreamController<int> selected = StreamController<int>();
  List<String> Items = [] ;
  var addItem = TextEditingController() ;
  List<Color> ColorS = [Colors.red,Colors.amber,Colors.deepOrangeAccent,Colors.red,Colors.indigo,Colors.pink,] ;
  bool Start = false ;
  @override
  initState() {
    super.initState();
    //selected.close();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.greenAccent,
          title: Textstylee(Colors.black,"Amr Abo Gabal",30),
          centerTitle: true ,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              //top: Radius.circular(30),
              bottom: Radius.circular(30),
            ),
          ),
        ),
        body: Container(
          decoration: const BoxDecoration(image: DecorationImage(image: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSz3HgOr04xMNRxiQbGlzqjnfRtq8uVZYiU0Q&usqp=CAU"),fit: BoxFit.fill)),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: Start?MainAxisAlignment.start:MainAxisAlignment.center ,
              children: [
                TextFormField(controller:addItem,),
                SizedBox(height: 5,),
                Container(
                  decoration: BoxDecoration(color: Colors.green ,borderRadius: BorderRadius.circular(20)),
                  child: MaterialButton(onPressed: () {
                    if(addItem.text.trim().isEmpty){
                      Fluttertoast.showToast(
                          msg: "Empty text cannot be added",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else if(Items.contains(addItem.text)){
                      Fluttertoast.showToast(
                          msg: "This item already exists and cannot be added again",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 3,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0
                      );
                    }
                    else {
                      setState(() {
                        Items.add(addItem.text);
                        if(Items.length>1){
                          Start = true ;
                        }
                        addItem.text = "";

                      });
                    }
                  },child: Textstylee(Colors.white,"Add",25),),),
                SizedBox(height: 10,),
                Start?Expanded(
                  child: FortuneWheel(
                    selected: selected.stream,
                    items: [
                      for (int i = 0 ;i<Items.length;i++) FortuneItem(child:Textstylee(CupertinoColors.opaqueSeparator,Items[i],20),
                        style:   FortuneItemStyle(
                          color: ColorS[i%ColorS.length], // <-- custom circle slice fill color
                          borderColor: Colors.green, // <-- custom circle slice stroke color
                          borderWidth: 10, // <-- custom circle slice stroke width
                        ),
                      ),
                    ],
                    onAnimationStart: (){
                      print("Start");
                    },
                    onAnimationEnd: (){
                      print("End");
                    },
                  ),
                ): const Expanded(child: Image(image: NetworkImage("https://media.istockphoto.com/id/1272796053/photo/attention-please-text-written-on-a-piece-of-paper-cork-board-background.webp?b=1&s=170667a&w=0&k=20&c=yzZa0FjBzbEdmf-bj0QTbC6mKm93Iy2hhpZ5QS3Z3sU="),fit: BoxFit.fill,)),
                SizedBox(height: 10,),
                Container(
                  color: Colors.red,child: MaterialButton(onPressed: (){
                  setState(() {
                    selected.add(
                      Fortune.randomInt(0, Items.length),
                    );
                  });
                },
                  child: Textstylee(Colors.white,"Start",25),
                ),
                ),
              ],
            ),
          ),
        ));
  }
}
