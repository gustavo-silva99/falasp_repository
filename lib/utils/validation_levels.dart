import 'package:flutter/material.dart';

int _pequeno = 1;
int _medio = 5;

/// SETA O TAMANHO DA DENÚNCIA
double validationLevels(int validator) {
  if (validator <= _pequeno) {
    return 40.0;
  } else if (validator <= _medio) {
    return 70.0;
  } else {
    return 100.0;
  }
}

/// SETA A COR DA DENÚNCIA
Color validationColorLevels(int validator) {
  if (validator <= _pequeno) {
    return Colors.green;
  } else if (validator <= _medio) {
    return Colors.orange;
  } else {
    return Colors.red;
  }
}
