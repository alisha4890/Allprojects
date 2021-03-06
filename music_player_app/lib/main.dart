
import 'package:flutter/material.dart';
import 'package:flute_music_player/flute_music_player.dart';

void main() => runApp(new MyApp());

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => new _MyAppState();
}

class _MyAppState extends State<MyApp>{
  List<Song> _songs;
  MusicFinder audioPlayer;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initPlayer();
  }

 void initPlayer() async {
    audioPlayer = new MusicFinder();
   var songs= await MusicFinder.allSongs();
   songs = new List.from(songs);

   setState(() {
     _songs = songs ;
   });
 }

Future _playLocal(String url) async {
  final result = await audioPlayer.play(url, isLocal: true);

}
  @override
  Widget build(BuildContext context) {
   Widget home() {
     new Scaffold(
         appBar: new AppBar(title: new Text("Music App"),
         ),
         body : new ListView.builder(
             itemCount:  _songs.length,
             itemBuilder: (context,int index){
               return new ListTile(
                 leading: new CircleAvatar(
                   child : new Text(_songs[index].title[0]),),
                 title: new Text(_songs[index].title),
                 onTap: ()=> _playLocal(_songs[index].uri),
               );
             })
     );
   }
    return new MaterialApp(
      home : home(),
    );
  }
}