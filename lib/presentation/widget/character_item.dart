
import 'package:flutter/material.dart';
import 'package:testa/constant/my_colors.dart';
import 'package:testa/data/model/characters.dart';

class CharacterItem extends StatelessWidget {
  final Character character;
  const CharacterItem({Key? key,required this.character}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsetsDirectional.fromSTEB(8, 8, 8, 8),
      padding: EdgeInsetsDirectional.all(4),
      decoration: BoxDecoration(
        color: MyColors.myWhite,
        borderRadius: BorderRadius.circular(8)
      ),
      child: GridTile(
        child: Container(
          color: MyColors.myGrey,
          child: character.img!.isNotEmpty?
                FadeInImage.assetNetwork(
                  width: double.infinity,
                    height: double.infinity,
                    placeholder: 'assets/images/loading.gif' , image:character.img! ,fit: BoxFit.cover,):Image.asset('assets/images/icon.jpg'),
          ),
        footer: Container(
          width: double.infinity,
           padding: EdgeInsets.symmetric(horizontal: 15,vertical: 10),
          color: Colors.black54,
          alignment: Alignment.bottomCenter,
          child: Text('${character.name}',style: TextStyle(
              height: 1.3,
            fontSize: 16,
            color: MyColors.myWhite,fontWeight: FontWeight.bold,
          ),
            overflow: TextOverflow.ellipsis,
            maxLines: 2,
            textAlign: TextAlign.center,
          ),
        ),
        ),
      );

  }
}
