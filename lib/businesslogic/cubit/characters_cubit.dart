import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:testa/data/model/characters.dart';
import 'package:testa/data/repository/charactersrepository.dart';

part 'characters_state.dart';

class CharactersCubit extends Cubit<CharactersState> {
 final CharactersRepository charactersRepository;
 List<Character>characters=[];
  CharactersCubit(this.charactersRepository) : super(CharactersInitial());
  List<Character>getAllCharacters(){
    charactersRepository.getAllCharacters().then((characters){
      emit(CharactersLoaded(characters));
      this.characters=characters;
    });
    return characters;

  }
}
