import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testa/businesslogic/cubit/characters_cubit.dart';
import 'package:testa/constant/string.dart';
import 'package:testa/data/repository/charactersrepository.dart';
import 'package:testa/data/web_services/characters_web_services.dart';
import 'package:testa/presentation/screens/character_details.dart';
import 'package:testa/presentation/screens/characters.dart';
class AppRouter{
 late  CharactersRepository charactersRepository;
  late CharactersCubit charactersCubit;
  AppRouter(){
    charactersRepository= CharactersRepository(CharactersWebServices());
    charactersCubit =CharactersCubit(charactersRepository);
  }
  Route? generateroute (RouteSettings settings){
switch(settings.name){
  case charactersScreen:
    return MaterialPageRoute(builder: (_)=>BlocProvider(create: (BuildContext context)=>
    charactersCubit,
      child:CharactersScreens(),
    ));
  case charactersDetalisScreen:
    return MaterialPageRoute(builder: (_)=>CharactersDetalisScreen());
}

  }
}