import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:valorantgame/cubit/character_cubit.dart';
import 'package:valorantgame/data/model/character_model.dart';
import 'package:valorantgame/view/widget/agents_list.dart';
class AgentsScreen extends StatefulWidget {
  const AgentsScreen({Key? key}) : super(key: key);

  @override
  State<AgentsScreen> createState() => _AgentsScreenState();
}

class _AgentsScreenState extends State<AgentsScreen> {
  List<CharacterModel> characters = [];

  @override
  Widget build(BuildContext context) {
    return AgentList(data: characters, count: 2);
  }

  @override
  void initState() {
    // context.read<CharactersCubit>().getCharacters();
    final cubiData = context.read<CharacterCubit>();
    if (cubiData.state is CharacterLoaded) {
      characters = (cubiData.state as CharacterLoaded).listCharacter;
      // print(characters);
    }
    super.initState();
  }
}