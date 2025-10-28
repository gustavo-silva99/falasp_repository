import 'package:falasp/components/button_square_component.dart';
import 'package:falasp/controllers/denuncias_controller.dart';
import 'package:falasp/controllers/mapa_controller.dart';
import 'package:falasp/widgets/drawer_menu_widget.dart';
import 'package:flutter/material.dart';
import 'package:signals/signals_flutter.dart';
import '../controllers/home_controller.dart';
import '../widgets/appbar_widget.dart';
import '../widgets/bottom_buttons_widget.dart';
import '../widgets/map_widget.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _homeController = HomeController();
  final _mapaController = MapaController();
  final _denunciaController = DenunciasController();

  @override
  void initState() {
    super.initState();
    // Busca denúncias próximas ao usuário
    _homeController.getDenuncias(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      endDrawer: DrawerMenuWidget(),
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // AppBar
              Container(
                //color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: AppBarWidget(context, _scaffoldKey),
                ),
              ),

              /// MAPA
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    height: MediaQuery.of(context).size.height * 0.8,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withAlpha(25),
                          blurRadius: 20,
                          spreadRadius: 1,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(40),
                      child: Mapa(context),
                    ),
                  ),
                  if (_mapaController.isLoading.watch(context))
                    Positioned(
                      top: 20,
                      right: 20,
                      child: ButtonSquareComponent(
                        backgroundColor: Colors.white,
                        loading: false,
                        texto: '',
                        icone: SizedBox(
                          width: 30,
                          height: 30,
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                      ),
                    ),
                ],
              ),

              /// BOTTOM BUTTONS
              Container(
                //color: Colors.red,
                height: MediaQuery.of(context).size.height * 0.08,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 10.0,
                    horizontal: 10.0,
                  ),
                  child: BottomButtonsWidget(context),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
