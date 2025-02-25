main() {
  var pessoa = Pessoa(nome: 'João', altura: 1.80, peso: 70);

  String result = pessoa.calcularIMC(altura: pessoa.altura, peso: pessoa.peso);
  print('IMC de ${pessoa.nome}:');
  print(result);
}

class Pessoa {
  String nome;
  double altura;
  double peso;

  Pessoa({required this.nome, required this.altura, required this.peso});

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
}
