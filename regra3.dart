import 'dart:io';

void main() {
  print('=== Regra de três simples ===');
  print(
      'Digite abaixo os numeradores e denominadores das frações.\nPara o valor desejado digite x.');
  print('Digite o numerador da primeira fração: ');
  String? numerador1Str = stdin.readLineSync();
  double? numerador1;
  if (numerador1Str == 'X' || numerador1Str == 'x') {
    numerador1 = null;
  } else {
    numerador1 = double.parse(numerador1Str!);
  }
  print('Digite o denominador da primeira fração: ');
  String? denominador1Str = stdin.readLineSync();
  double? denominador1;
  if (denominador1Str == 'X' || denominador1Str == 'x') {
    denominador1 = null;
  } else {
    denominador1 = double.parse(denominador1Str!);
  }
  print('Digite o numerador da segunda fração: ');
  String? numerador2Str = stdin.readLineSync();
  double? numerador2;
  if (numerador2Str == 'X' || numerador2Str == 'x') {
    numerador2 = null;
  } else {
    numerador2 = double.parse(numerador2Str!);
  }
  print('Digite o denominador da segunda fração: ');
  String? denominador2Str = stdin.readLineSync();
  double? denominador2;
  if (denominador2Str == 'X' || denominador2Str == 'x') {
    denominador2 = null;
  } else {
    denominador2 = double.parse(denominador2Str!);
  }
  var resultado =
      calcRegra3(numerador1, numerador2, denominador1, denominador2);
  print("\x1B[2J\x1B[0;0H");
  print('=== Resultado ===');
  print('O valor de x é: $resultado');
}

double calcRegra3(double? n1, double? n2, double? d1, double? d2) {
  if (n1 == null) {
    return n2! * d1! / d2!;
  } else if (n2 == null) {
    return n1 * d2! / d1!;
  } else if (d1 == null) {
    return d2! * n1 / n2;
  } else {
    return d1 * n2 / n1;
  }
}
