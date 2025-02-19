import 'dart:io';

main() {
  String nome = getName();
  double altura = getHeight();
  double peso = getWeight();

  print("\x1B[2J\x1B[0;0H");
  String result = calcularIMC(altura: altura, peso: peso);
  print('IMC de $nome:');
  print(result);
}

double getWeight() {
  print('Digite seu peso: ');
  var pesoStdin = stdin.readLineSync();
  var peso = double.parse(pesoStdin!);
  return peso;
}

double getHeight() {
  print('Digite sua altura: ');
  var alturaStdin = stdin.readLineSync();
  var altura = double.parse(alturaStdin!);
  return altura;
}

String getName() {
  print('Digite o seu nome: ');
  final String? nome = stdin.readLineSync();

  if (nome == null) {
    return 'Nome não informado';
  } else {
    return nome;
  }
}

String calcularIMC({required double altura, required double peso}) {
  String result;
  if (altura <= 0.0 || peso <= 0.0) {
    result = 'Altura ou peso inválidos';
  } else {
    var imc = peso / (altura * altura);
    var imcString = imc.toStringAsFixed(2);
    if (imc < 18.5) {
      result = '$imcString - Abaixo do peso';
    } else if (imc < 24.9) {
      result = '$imcString - Peso normal';
    } else if (imc < 29.9) {
      result = '$imcString - Sobrepeso';
    } else if (imc < 34.9) {
      result = '$imcString - Obesidade grau 1';
    } else if (imc < 39.9) {
      result = '$imcString - Obesidade grau 2';
    } else {
      result = '$imcString - Obesidade grau 3';
    }
  }
  return result;
}
