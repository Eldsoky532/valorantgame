import 'package:flutter/material.dart';
import 'package:valorantgame/data/model/abilite__model.dart';
import 'package:valorantgame/data/model/character_model.dart';
import 'package:valorantgame/data/model/voice_line.dart';
import 'package:valorantgame/view/widget/voice_widget.dart';

class AgentList extends StatefulWidget {
   AgentList({required this.data,required this.count});
  List<CharacterModel> data;
  int count=2;

  @override
  State<AgentList> createState() => _AgentListState();
}

class _AgentListState extends State<AgentList> {
  @override
  Widget build(BuildContext context) {
    return Material(child: screen(widget.data),);
  }

  screen(dynamic data)
  {
   return Container(
     color: Color(0xffbd3944),
     child: GridView.builder(
         cacheExtent: 180000000,
         gridDelegate:SliverGridDelegateWithFixedCrossAxisCount(
           childAspectRatio: 0.8,
           crossAxisCount: widget.count
         ),
         itemCount: data.length,
         itemBuilder: (context,index){
           if(data[index]!=null)
             {
               return GestureDetector(
                 onTap: (){
                   Navigator.of(context).push(MaterialPageRoute(
                       builder: (context) => dataAbilitie(data, index)));
                 },
                 child: Container(

                   child: Column(
                     children: [
                       Stack(
                         children: [
                           Image.network(data[index].fullPortrait),
                           Padding(
                               padding: EdgeInsets.all(16.0),
                             child: Image.network(
                               data[index].role.displayIcon ?? '',
                               width: 0.08*MediaQuery.of(context).size.width,
                               height: 0.08*MediaQuery.of(context).size.height,
                             ),
                           )
                         ],
                       ),
                       Text(
                         data[index].displayName ?? 'No name',
                         style: TextStyle(
                           color: Colors.white,
                           fontWeight: FontWeight.w600,
                           fontSize: 25
                         ),
                       ),
                     ],
                   ),
                 ),
               );
             }
           return Center(child: CircularProgressIndicator(color: Colors.red,),);
         }
     ),
   );
  }
  dataAbilitie(data, index) {
    List<Ability> listAbilitie = data[index].ability;
    VoiceLine voiceLinePlay = data[index].voice_line;
    return Material(
        child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios,
                  // size: 30,
                  color: Color.fromARGB(255, 211, 101, 110),
                ),
                onPressed: () => Navigator.of(context).pop()),
            leadingWidth: 50,
            elevation: 0,
            backgroundColor: const Color(0xFF53212B),
            title: Padding(
              padding: const EdgeInsets.only(right: 50.0, top: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  iconInfo(data, index),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      data[index].displayName ?? 'No name',
                      style: const TextStyle(
                          color: Color(0xFFFFFBF5),
                          fontWeight: FontWeight.w600,
                          fontSize: 40),
                    ),
                  )
                ],
              ),
            ),
          ),
          body: ListView(
            children: [
              Container(
                color: const Color(0xFF53212B),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        // color: Colors.red,
                        //   image: DecorationImage(
                        //       fit: BoxFit.cover,
                        //       image: NetworkImage(data[index].background))
                      ),
                      child: Image.network(data[index].fullPortrait, fit: BoxFit.cover),
                    ),
                    Column(
                      children: [
                        PlayerWidget(url: voiceLinePlay.voiceline),
                        GridView.builder(
                          shrinkWrap: true,
                          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: listAbilitie.length == 4 ? 4 : 5,
                          ),
                          itemCount: listAbilitie.length,
                          itemBuilder: ((context, index) => ListTile(
                            title: GestureDetector(
                              onTap: (() {
                                showDialog(
                                    context: context,
                                    builder: (context) {
                                      return AlertDialog(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                            BorderRadius.circular(20)),
                                        title: Text(listAbilitie[index].displayName,
                                            style: const TextStyle(
                                                color: Color(0xFFFD4556),
                                                fontSize: 20,
                                                fontWeight: FontWeight.w800)),
                                        content:
                                        Text(listAbilitie[index].description),
                                        backgroundColor: const Color(0xFF53212B),
                                        contentTextStyle:
                                        const TextStyle(color: Colors.white),
                                        elevation: 2,
                                      );
                                    });
                              }),
                              child: Container(
                                // width: 50,
                                // height: 50,
                                  color: Colors.transparent,
                                  child: Image.network(
                                      listAbilitie[index].displatIcon)),
                            ),
                          )),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        ));
  }
  iconInfo(data, index) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
          color: Colors.transparent,
          child: GestureDetector(
              onTap: () {
                showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(data[index].role.displayName ?? '',
                            style: const TextStyle(
                                color: Color(0xFFFD4556),
                                fontSize: 20,
                                fontWeight: FontWeight.w800)),
                        content: Text(data[index].role.description ?? ''),
                        backgroundColor: const Color(0xFF53212B),
                        contentTextStyle: const TextStyle(color: Colors.white),
                        elevation: 2,
                      );
                    });
              },
              child: Image.network(
                data[index].role.displayIcon ?? '',
                width: 0.1 * MediaQuery.of(context).size.width,
                height: 0.1 * MediaQuery.of(context).size.width,
              ))),
    );
  }

}
