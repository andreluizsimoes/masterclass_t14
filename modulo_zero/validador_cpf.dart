void main() {
  var pessoa1 = Pessoa(nome: 'José', cpf: '123.456.789-09');
  print(pessoa1.nome);
  print(pessoa1.validarCPF(pessoa1.cpf));

  var pessoa2 = Pessoa(nome: 'Maria', cpf: '123.456.789-10');
  print(pessoa2.nome);
  print(pessoa2.validarCPF(pessoa2.cpf));
}

class Pessoa {
  String nome;
  String cpf;

  Pessoa({required this.nome, required this.cpf});

  String validarCPF(String cpf) {
    var listCPF = tratarCPF(cpf);

    var digito1 = calcDigito(List.from(listCPF), 1);
    var digito2 = calcDigito(List.from(listCPF), 2);

    if (digito1 && digito2) {
      return 'CPF válido!';
    } else {
      return 'CPF inválido!';
    }
  }

  List<int> tratarCPF(String cpfString) {
    return cpfString
        .replaceAll('.', '')
        .replaceAll('-', '')
        .split('')
        .map((num) => int.parse(num))
        .toList();
  }

  bool calcDigito(List<int> listStringCPF, int digitoVerificador) {
    int soma = 0;
    int digito1;
    int digito1Calculado;
    int digito2;
    int digito2Calculado;

    if (digitoVerificador == 1) {
      listStringCPF.removeAt(10);
      digito1 = listStringCPF.removeAt(9);

      for (int i = 0; i < listStringCPF.length; i++) {
        soma += listStringCPF[i] * (10 - i);
      }

      int resto = soma % 11;

      if (resto < 2) {
        digito1Calculado = 0;
      } else {
        digito1Calculado = (11 - resto);
      }

      if (digito1 == digito1Calculado) {
        return true;
      } else {
        return false;
      }
    }

    if (digitoVerificador == 2) {
      digito2 = listStringCPF.removeAt(10);

      for (int i = 0; i < listStringCPF.length; i++) {
        soma += listStringCPF[i] * (11 - i);
      }

      int resto = soma % 11;

      if (resto < 2) {
        digito2Calculado = 0;
      } else {
        digito2Calculado = (11 - resto);
      }

      if (digito2 == digito2Calculado) {
        return true;
      } else {
        return false;
      }
    }

    return false;
  }
}
