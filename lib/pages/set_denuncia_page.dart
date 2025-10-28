import 'package:falasp/components/button_component.dart';
import 'package:falasp/controllers/geolocation_controller.dart';
import 'package:falasp/controllers/set_denuncia_controller.dart';
import 'package:flutter/material.dart';
import 'package:latlong2/latlong.dart';
import 'package:signals/signals_flutter.dart';

import '../components/choose_point_map_component.dart';
import '../components/dropdown_component.dart';
import '../components/time_picker_component.dart';
import '../utils/denuncia_types.dart';

class SetDenunciaPage extends StatefulWidget {
  const SetDenunciaPage({super.key});

  @override
  State<SetDenunciaPage> createState() => _SetDenunciaPageState();
}

class _SetDenunciaPageState extends State<SetDenunciaPage> {
  final _denunciaTypes = DenunciaTypes();
  final _geolocationController = GeolocationController();
  final _setDenunciasController = SetDenunciaController();
  String _typeSelected = 'Festa ou evento particular';
  String _adress = '';
  double _localLat = 0.0;
  double _localLng = 0.0;
  DateTime? _startTime = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_rounded),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            spacing: 25.0,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Qual a origem da perturbação?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownComponent(
                  onChanged: (value) {
                    _typeSelected = value;
                  },
                  items: _denunciaTypes.types,
                  backgroundColor: Colors.white,
                  fontColor: Colors.black,
                ),
              ),
              Text(
                'Selecionar local',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              ButtonComponent(
                onPressed: () async {
                  LatLng? _local = await showMapSelectionPopup(context);
                  if (_local != null) {
                    _localLat = _local.latitude;
                    _localLng = _local.longitude;
                    String? _retornoAdress =
                        await _geolocationController
                            .getAddressFromSetedPosition(
                              _localLat,
                              _localLng,
                            ) ??
                        null;
                    if (_retornoAdress != null) {
                      setState(() {
                        _adress = _retornoAdress;
                      });
                    }
                  }
                },
                iconeEsquerda: Icon(Icons.place_rounded, color: Colors.black),
                loading: false,
                texto: _adress.isEmpty ? 'Selecionar endereço' : _adress,
                backgroundColor: Colors.white,
                fontColor: Colors.black,
              ),
              Text(
                'Qual o horário de início?',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                softWrap: true,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
              ),
              ButtonComponent(
                iconeEsquerda: Icon(Icons.watch_later, color: Colors.black),
                loading: false,
                texto: _setDenunciasController.starTimeToText(_startTime!),
                backgroundColor: Colors.white,
                fontColor: Colors.black,
                onPressed: () async {
                  DateTime? _return = await timePickerComponent(
                    context,
                    initialDateTime: _startTime,
                  );
                  if (_return != null) {
                    setState(() {
                      _startTime = _return;
                    });
                  }
                },
              ),
              const SizedBox(height: 20),
              ButtonComponent(
                onPressed: () {
                  _setDenunciasController.checkIfDenunciaIsCorrect(
                    _typeSelected,
                    _localLat,
                    _localLng,
                    _startTime,
                    context,
                  );
                },
                iconeEsquerda: Icon(Icons.info_rounded, color: Colors.white),
                loading: _setDenunciasController.isLoading.watch(context),
                texto: 'Denunciar',
                backgroundColor: Colors.black,
                fontColor: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
