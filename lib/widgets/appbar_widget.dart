import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';

import '../components/button_square_component.dart';
import '../components/text_bubble.dart';
import '../globals/user_location_global.dart';

Widget AppBarWidget(
  BuildContext context,
  GlobalKey<ScaffoldState> scaffoldKey,
) {
  final _userPos = UserLocationGlobal();

  return Row(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceAround,
    children: [
      TextBubble(
        fontColor: Colors.black,
        backgroundColor: Colors.white,
        iconeEsquerda: Icon(Icons.place_rounded, color: Colors.black, size: 12),
        texto: _userPos.adress.watch(context),
        fontSize: 12,
      ),
      Image.asset('assets/icones/logo.png', width: 100),
      ButtonSquareComponent(
        onPressed: () {
          scaffoldKey.currentState!.openEndDrawer();
        },
        backgroundColor: Colors.white,
        icone: Icon(Icons.settings, size: 25, color: Colors.black),
        loading: false,
        texto: '',
      ),
    ],
  );
}
