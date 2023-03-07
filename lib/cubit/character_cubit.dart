import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorantgame/data/model/abilite__model.dart';
import 'package:valorantgame/data/model/character_model.dart';
import 'package:valorantgame/data/model/role_model.dart';
import 'package:valorantgame/data/model/voice_line.dart';
import 'package:valorantgame/data/repo/repo_layer.dart';
part 'character_state.dart';

class CharacterCubit extends Cubit<CharacterState> {
  CharacterCubit(this.repoLayer) : super(CharacterInitial());

  RepoLayer repoLayer;




  Future<void> getCharacter()
  async{
    try{
      emit(CharacterLoading());
      final instant=await request();
      emit(CharacterLoaded(listCharacter: instant));
    }catch(e)
    {
      emit(CharacterError(message: e.toString()));
    }

  }

  Future<List<CharacterModel>>request()async{

    final response=await repoLayer.getAgent();
    try
    {
      if(response == null)
        {
          return [];
        }
      final  responsedecoded=jsonDecode(response.body);
      final data=responsedecoded['data']as List;
      final list=data.map((e){
        final role = e['role'] ?? {};
        final roleinfo=Role(
            uuid: role['uuid']?? " ",
            displayIcon: role['displayIcon']?? " ",
            description: role['description']?? " ",
            displayName: role['displayName']?? " "
        );

      final ability=e['abilities']as List;
      final abilityinfo=ability.map((e){
        return Ability(
            slot: e['slot']??"",
            displatIcon: e['displayIcon']??"",
            description: e['description']??"",
            displayName: e['displayName']??""
        );
      }).toList();

      abilityinfo.retainWhere((element) => element.displatIcon.isNotEmpty);

       final voiceline=e['voiceLine']??{};
       final voiceinfo=voiceline["mediaList"]as List;
       final voiceMedia=VoiceLine(voiceline:voiceinfo[0]['wave']?? "");


         return CharacterModel(
           description: e['description']??"",
           displayName:  e['displayName']??"",
           fullPortrait:  e['fullPortrait']??"",
           displayIcon:  e['displayIcon']??"",
           ability: abilityinfo,
           voice_line: voiceMedia,
           role: roleinfo
         );


      }).toSet().toList();
      list.retainWhere((element) => element.fullPortrait.isNotEmpty);
      return list;
    }catch(e)
    {
      if(kDebugMode)
        {
          print("error ${e.toString()}");

        }

      throw Exception(e.toString());
    }

  }



}
