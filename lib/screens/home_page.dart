import 'package:flutter/material.dart';
import 'package:music_app/common_widgets.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: darkColor,
      appBar:  AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: bgColor,))
        ],
        leading: Icon(Icons.sort_rounded,color: bgColor,),
        title: Text("Musics",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),centerTitle: true,
      ),
      body: ListView.builder(

          itemCount: 100,
          itemBuilder: (context, index) => Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
            ),
            child: ListTile(
              title: Text("Music Name",style: texStyle(),),
              subtitle: Text("Artist Name",style: TextStyle(fontSize: 12),),
              leading: Icon(Icons.music_note,color: whiteColor,size: 32,),
              trailing: Icon(Icons.play_arrow),
            ),
          ),),
    );
  }
}
