import 'package:testa/data/model/characters.dart';
import 'package:testa/data/web_services/characters_web_services.dart';

class CharactersRepository{
 final CharactersWebServices  charactersWebServices;
 CharactersRepository(this.charactersWebServices);
 Future<List<Character>>getAllCharacters()async{
   final characters= await charactersWebServices.getAllCharacters();
  return characters.map((e) => Character.fromJson(e)).toList();

 }
}