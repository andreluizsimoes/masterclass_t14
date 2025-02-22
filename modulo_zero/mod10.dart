import 'dart:io';

void main() {
  print('Digite o número do Cartão de Crédito:');
  var cartaoString = stdin.readLineSync();

  var listNumCartao = tratarNumCartao(cartaoString!);

  var isValid = verificarCartao(listNumCartao);

  print('===================');
  if (isValid) {
    print('Cartão válido!');
  } else {
    print('Cartão inválido!');
  }
  print('===================');
}

bool verificarCartao(List<int> listNumCartao) {
  if (listNumCartao.length != 16) {
    return false;
  }

  List<int> listaSoma = [];
  var digitoVerificador = listNumCartao.removeLast();
  for (var i = 0; i < listNumCartao.length; i++) {
    if (i.isEven) {
      if ((listNumCartao[i] * 2) > 9) {
        listaSoma.add((listNumCartao[i] * 2) - 9);
      } else {
        listaSoma.add(listNumCartao[i] * 2);
      }
    } else {
      listaSoma.add(listNumCartao[i]);
    }
  }

  var somaTotal = listaSoma.reduce((soma, numero) => soma + numero);

  var digitoCalculado = 10 - (somaTotal % 10);
  if (digitoCalculado == 10) {
    digitoCalculado = 0;
  }

  if (digitoCalculado == digitoVerificador) {
    return true;
  } else {
    return false;
  }
}

List<int> tratarNumCartao(String cartao) {
  return cartao
      .replaceAll(' ', '')
      .split('')
      .map((num) => int.parse(num))
      .toList();
}
