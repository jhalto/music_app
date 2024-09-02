import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:music_app/common_widgets.dart';
import 'package:music_app/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(PlayerController());
    return Scaffold(
      backgroundColor: darkColor,
      appBar:  AppBar(
        actions: [
          IconButton(onPressed: (){}, icon: Icon(Icons.search,color: bgColor,))
        ],
        leading: Icon(Icons.sort_rounded,color: bgColor,),
        title: Text("Musics",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),centerTitle: true,
      ),
      body: FutureBuilder<List<SongModel>>(

        future: controller.audioQuery.querySongs(
        ignoreCase: true,
        orderType: OrderType.ASC_OR_SMALLER,
        sortType: null,
        uriType: UriType.EXTERNAL
        ),
        builder: (BuildContext context, snapshot){
          if (snapshot.data == null){
            return Center(
              child: CircularProgressIndicator(),
            );
          }else if(snapshot.data!.isEmpty){
            return Center(child: Text("No Song Found"));
          }else{
            print(snapshot.data);
            return Padding(
              padding: EdgeInsets.all(5),
              child: ListView.builder(
                physics: BouncingScrollPhysics(),

                itemCount: 100,
                itemBuilder: (context, index) => Container(
                  margin: EdgeInsets.only(bottom: 2),
                  decoration: BoxDecoration(
                    color: bgColor,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                    title: Text("${snapshot.data![index].title}",style: texStyle(),),
                    subtitle: Text("${snapshot.data![index].artist}",style: TextStyle(fontSize: 12),),
                    leading: Icon(Icons.music_note,color: whiteColor,size: 32,),
                    trailing: Icon(Icons.play_arrow,color: whiteColor,),
                  ),
                ),),
            );
          }
        },
      )
    );
  }
}
