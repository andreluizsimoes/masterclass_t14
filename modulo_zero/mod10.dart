import 'dart:io';

void main() {
  var cartao1 = Cartao(numero: '4532 8778 1234 5678');
  var cartao2 = Cartao(numero: '4532 8778 1234 5670');
  var cartao3 = Cartao(numero: '4916 6418 5936 9080');

  print(cartao1.verificarCartao(cartao1.numero));
  print(cartao2.verificarCartao(cartao2.numero));
  print(cartao3.verificarCartao(cartao3.numero));
}

class Cartao {
  String numero;

  Cartao({required this.numero});

  List<int> tratarNumCartao(String cartao) {
    return cartao
        .replaceAll(' ', '')
        .split('')
        .map((num) => int.parse(num))
        .toList();
  }

  String verificarCartao(String cartao) {
    var listNumCartao = tratarNumCartao(cartao);

    if (listNumCartao.length != 16) {
      return 'Cartão inválido!';
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
      return 'Cartão válido!';
    } else {
      return 'Cartão inválido!';
    }
  }
}
