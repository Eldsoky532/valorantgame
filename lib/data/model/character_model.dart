import 'package:valorantgame/data/model/abilite__model.dart';
import 'package:valorantgame/data/model/role_model.dart';
import 'package:valorantgame/data/model/voice_line.dart';

class CharacterModel
{
  String description,displayName,fullPortrait,displayIcon;

  List<Ability> ability;

  VoiceLine voice_line;
  Role role;

  CharacterModel({required this.description, required this.displayName, required this.fullPortrait,
    required this.displayIcon, required this.ability, required this.voice_line,required this.role});
}