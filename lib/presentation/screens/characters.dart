import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_offline/flutter_offline.dart';
import 'package:testa/businesslogic/cubit/characters_cubit.dart';
import 'package:testa/constant/my_colors.dart';
import 'package:testa/data/model/characters.dart';
import 'package:testa/presentation/widget/character_item.dart';
class CharactersScreens extends StatefulWidget {
  const CharactersScreens({Key? key}) : super(key: key);

  @override
  State<CharactersScreens> createState() => _CharactersScreensState();
}

class _CharactersScreensState extends State<CharactersScreens> {
 late List<Character>allCharacters;
late List<Character>serchedforCharacters;
bool isSearched=false;
final _searchTextController= TextEditingController();
//
Widget buildSearchField(){
  return TextField(
    controller:_searchTextController ,
    cursorColor: MyColors.myGrey,
    decoration: InputDecoration(
      hintText: 'Find Characters',
      border: InputBorder.none,
      hintStyle: TextStyle(color: MyColors.myGrey,fontSize: 18),

    ),
    onChanged: (searchedCharacters){
      addSearchedforItemsSearch(searchedCharacters);
    },
  );
}
// filter list
void addSearchedforItemsSearch(String searchCharacters){
  serchedforCharacters=allCharacters.where((character) =>character.name!.toLowerCase().startsWith(searchCharacters)).toList();
    setState(() {
      serchedforCharacters;
    });
}
List <Widget> _buildAppBarActions(){
  if(isSearched){
    return [
      IconButton(onPressed: (){
        _clearSearch();
        Navigator.pop(context);
      }, icon: Icon(Icons.clear,color: MyColors.myGrey,))
    ];}
        else{
          return [
            IconButton(onPressed: (){
              _startSearch();
            }, icon: Icon(Icons.search,color: MyColors.myGrey,))
          ];
  }
  }
 void _clearSearch(){
   _searchTextController.clear();
   setState(() {
     isSearched= false;
   });
 }
 void _startSearch(){
  ModalRoute.of(context)!.addLocalHistoryEntry(LocalHistoryEntry(onRemove: _stopSearching));
  setState(() {
    isSearched=true;
  });
 }
 void _stopSearching(){
  _clearSearch();
  setState(() {
    isSearched=false;
  });
 }



 @override
  void initState() {
    // TODO: implement initState
    super.initState();
   BlocProvider.of<CharactersCubit>(context).getAllCharacters();
  }
  Widget buildBlocWidget(){
   return BlocBuilder<CharactersCubit,CharactersState>(builder: (context,state){
     if(state is CharactersLoaded){
       allCharacters=(state).characters;
       return buildLoadedListWidget();
     }else{
        return showLoadingIndecator();
     }
   });
  }
  Widget showLoadingIndecator(){
   return Center(
     child: CircularProgressIndicator(
       color: MyColors.myYellow,
     ),
   );
  }
  Widget buildLoadedListWidget(){
return SingleChildScrollView(
  child: Container(
    color: MyColors.myGrey,
    child: Column(
      children: [
        buildCharactersList()
      ],
    ),
  ),
);
  }
  Widget buildCharactersList(){
   return GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
     crossAxisCount: 2,childAspectRatio: 2/3,crossAxisSpacing: 1,mainAxisSpacing: 1,
   ),
       shrinkWrap: true,
       physics: const ClampingScrollPhysics(),
       padding: EdgeInsets.zero,
       itemCount: _searchTextController.text.isEmpty? allCharacters.length:serchedforCharacters.length
       , itemBuilder: (context,index){
     return CharacterItem(character: _searchTextController.text.isEmpty? allCharacters[index]:serchedforCharacters[index],);
   });
  }

  Widget _buildAppBarTitle(){
  return Text('Characters',style: TextStyle(color: MyColors.myGrey),);
  }
  Widget  buildNointernetwidget(){
  return Center(
    child: Container(
      margin: EdgeInsets.all(20),
      color: Colors.white,
      child: Column(
        children: [
          SizedBox(height: 20,),
          Text('Check Internet',style: TextStyle(fontSize: 22,color: MyColors.myGrey),),
         Image.asset('assets/images/undraw_warning_cyit.png'),
        ],
      ),
    ),
  );
  }
  @override

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearched?buildSearchField():_buildAppBarTitle(),
        actions: _buildAppBarActions(),
        leading: isSearched?BackButton(color:MyColors.myGrey,): Container(),

        backgroundColor: MyColors.myYellow,
      ),
      body: OfflineBuilder(
      connectivityBuilder: (
      BuildContext context,
      ConnectivityResult connectivity,
      Widget child,
    ) {
      final bool connected = connectivity!= ConnectivityResult.none;
      if(connected){
        return buildBlocWidget();
      }else {
        return buildNointernetwidget();
      }
     // buildBlocWidget(),
    },child: showLoadingIndecator(),
    )
    );
  }
}
