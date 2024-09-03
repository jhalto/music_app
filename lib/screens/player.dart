import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:music_app/common_widgets.dart';
import 'package:music_app/controllers/player_controller.dart';
import 'package:on_audio_query/on_audio_query.dart';

class Player extends StatelessWidget {
  final List<SongModel> data;
  const Player({super.key,required this.data});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<PlayerController>();
    return Scaffold(
      backgroundColor: bgColor,
      appBar: AppBar(),
      body: Padding(padding: EdgeInsets.all(5),
      child: Column(
        children: [
          Obx(
            () =>  Expanded(child: Container(
              clipBehavior: Clip.antiAliasWithSaveLayer,
              height: 250,
              width: 250,

              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white12,
                shape: BoxShape.circle
              ),
              alignment: Alignment.center,
              child: Center(
                child: QueryArtworkWidget(
                    id: data[controller.playIndex.value].id,
                    artworkHeight: double.infinity,
                    artworkWidth: double.infinity,
                    type: ArtworkType.AUDIO,
                    nullArtworkWidget: Icon(Icons.music_note,size: 35,),

                ),
              ),
            )),
          ),
          Expanded(child: Container(
            alignment: Alignment.center,
            color: whiteColor,
            child: Obx(
              () =>  Column(
                children: [
                  Text("${data[controller.playIndex.value].displayNameWOExt}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(color: darkColor,fontSize: 24),),
                  Text("${data[controller.playIndex.value].artist}",
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(fontSize: 20),),
                  Spacer(),
                  Obx(
                    () =>  Row(
                      children: [
                        Text(controller.position.value),

                        Expanded(
                          child: Slider(
                            thumbColor: sliderColor,
                            inactiveColor: bgColor,
                            activeColor: sliderColor,
                            min: Duration(seconds: 0).inSeconds.toDouble(),
                            max: controller.max.value,
                            value: controller.value.value, onChanged: (newValue) {
                              controller.changeDurationToSeconds(newValue.toInt());
                              newValue = newValue;

                          },),
                        ),
                        Text(controller.duration.value),
                      ],
                    ),
                  ),
                  SizedBox(height: 12,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      IconButton(
                        onPressed: () {
                          int prevIndex = controller.playIndex.value - 1;
                          if (prevIndex < 0) {
                            prevIndex = data.length - 1;
                          }
                          controller.playSong(data[prevIndex].uri, prevIndex);
                        },
                        icon: const Icon(
                          Icons.skip_previous_rounded,
                          size: 48,
                          color: darkColor
                          ,
                        ),
                      ),
                      Obx(
                        () =>  IconButton(onPressed: (){
                          if(controller.isPlaying.value){
                            controller.audioPlayer.pause();
                            controller.isPlaying(false);
                          }else{
                            controller.audioPlayer.play();
                            controller.isPlaying(true);
                          }
                        }, icon:
                        controller.isPlaying.value ?Icon(Icons.pause,size: 45,)
                        :Icon(Icons.play_arrow_rounded,size: 45,) ),
                      ),
                      IconButton(
                        onPressed: () {
                          int nextIndex = controller.playIndex.value + 1;
                          if (nextIndex >= data.length) {
                            nextIndex = 0;
                          }
                          controller.playSong(data[nextIndex].uri, nextIndex);
                        },
                        icon: const Icon(
                          Icons.skip_next_rounded,
                          size: 40,
                          color: darkColor,
                        ),
                      ),
                    ],
                  )

                ],
              ),
            ),
          )),
        ],
      ),
      ),
    );
  }
}
