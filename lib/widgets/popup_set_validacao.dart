import 'package:falasp/components/button_component.dart';
import 'package:falasp/controllers/geolocation_controller.dart';
import 'package:falasp/controllers/validacao_controller.dart';
import 'package:falasp/globals/user_location_global.dart';
import 'package:falasp/models/validacao_model.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../models/denuncia_model.dart';

/// Popup de validação de denúncia.
/// Retorna uma String indicando a escolha do usuário:
/// "ainda", "acabou" ou "nao_ouco"
Future<String?> showPopupSetValidacao(
  BuildContext context, {
  required Denuncia denuncia,
}) async {
  return await showDialog<String>(
    context: context,
    barrierDismissible: true,
    builder:
        (context) => Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(40),
          ),
          backgroundColor: Colors.white,
          insetPadding: const EdgeInsets.symmetric(
            horizontal: 24,
            vertical: 24,
          ),
          child: PopupSetValidacao(
            tipoDenuncia: denuncia.type,
            pessoasMarcaram: denuncia.validators!,
            denuncia: denuncia,
          ),
        ),
  );
}

class PopupSetValidacao extends StatefulWidget {
  final String tipoDenuncia;
  final int pessoasMarcaram;
  final Denuncia denuncia;

  const PopupSetValidacao({
    super.key,
    required this.tipoDenuncia,
    required this.pessoasMarcaram,
    required Denuncia this.denuncia,
  });

  @override
  State<PopupSetValidacao> createState() => _PopupSetValidacaoState();
}

class _PopupSetValidacaoState extends State<PopupSetValidacao> {
  final _validationController = ValidacaoController();
  final _userGlobal = UserLocationGlobal();
  final _geolocationController = GeolocationController();
  bool _isLoading = false;
  bool _isReady = false;
  bool _alreadyValidate = true;

  setNewValidation(TipoValidacao type) async {
    setState(() {
      _isLoading = true;
    });
    Validacao _newValidation = Validacao(
      denunciaId: widget.denuncia.id!,
      userId: Supabase.instance.client.auth.currentUser!.id,
      latitude: _userGlobal.latitude.value!,
      longitude: _userGlobal.longitude.value!,
      tipo: type,
    );
    await _validationController.setValidacao(_newValidation);
    Navigator.pop(context, 'true');
  }

  @override
  void initState() {
    _checkIfAlreadyValidate();
    super.initState();
  }

  /// Verifica se já validou ou se o usuário é o dono da validação, caso já o tenha ou seja dono, não permite validação
  _checkIfAlreadyValidate() async {
    bool checkAlreadyValidate = await _validationController
        .checkIfUserAlreadyAvaliou(widget.denuncia.id!);

    // Verifica distância
    double? _distance = await _geolocationController.checkDistance(
      widget.denuncia.latitude,
      widget.denuncia.longitude,
      _userGlobal.latitude.value!,
      _userGlobal.longitude.value!,
    );
    print(
      'Validou ou é o dono ${checkAlreadyValidate} e a distância: ${_distance}',
    );
    if (checkAlreadyValidate) {
      if (_distance! <= 60.0) {
        // Não pode validar
        setState(() {
          _alreadyValidate = true;
          _isReady = true;
        });
      } else {
        // Não pode validar
        setState(() {
          _alreadyValidate = true;
          _isReady = true;
        });
      }
    } else {
      // Pode validar
      setState(() {
        _alreadyValidate = false;
        _isReady = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Image.asset(
                      'assets/icones/denuncia_marker.png',
                      width: 30,
                      height: 30,
                    ),
                  ),
                ),
                TextSpan(
                  text: widget.tipoDenuncia,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          RichText(
            textAlign: TextAlign.start,
            text: TextSpan(
              children: [
                WidgetSpan(
                  alignment: PlaceholderAlignment.middle,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 6),
                    child: Icon(Icons.people, size: 14),
                  ),
                ),
                TextSpan(
                  text:
                      '${widget.pessoasMarcaram} pessoas marcaram essa denúncia como verdadeira.',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Colors.black38, // importante definir cor no TextSpan
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 4),
          if (_isReady && !_alreadyValidate)
            const Text(
              'Você está próximo do local. Por gentileza, ajude a validar a veracidade da denúncia:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
          _isLoading
              ? SizedBox(
                width: 30,
                height: 30,
                child: CircularProgressIndicator(color: Colors.black),
              )
              : _alreadyValidate
              ? ButtonComponent(
                loading: false,
                texto: 'Ok',
                fontSize: 16,
                onPressed: () {
                  Navigator.pop(context);
                },
              )
              : Column(
                spacing: 10,
                children: [
                  ButtonComponent(
                    iconeEsquerda: Icon(
                      Icons.check_circle,
                      color: Colors.green,
                    ),
                    loading: false,
                    texto: 'Está acontecendo',
                    backgroundColor: Colors.white,
                    fontColor: Colors.black,
                    fontSize: 16,
                    onPressed: () {
                      setNewValidation(TipoValidacao.aindaAcontecendo);
                    },
                  ),
                  ButtonComponent(
                    iconeEsquerda: Icon(
                      Icons.watch_later,
                      color: Colors.yellow,
                    ),
                    loading: false,
                    texto: 'Já terminou',
                    backgroundColor: Colors.white,
                    fontColor: Colors.black,
                    fontSize: 16,
                    onPressed: () {
                      setNewValidation(TipoValidacao.acabou);
                    },
                  ),
                  ButtonComponent(
                    iconeEsquerda: Icon(Icons.cancel, color: Colors.red),
                    loading: false,
                    texto: 'Não ouço nada daqui',
                    backgroundColor: Colors.white,
                    fontColor: Colors.black,
                    fontSize: 16,
                    onPressed: () {
                      setNewValidation(TipoValidacao.naoEscuto);
                    },
                  ),
                ],
              ),
        ],
      ),
    );
  }
}
