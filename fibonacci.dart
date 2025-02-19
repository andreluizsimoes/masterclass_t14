import 'dart:io';

int fibonacci(int n) {
  if (n <= 0) return 0;
  if (n == 1) return 1;
  return fibonacci(n - 1) + fibonacci(n - 2);
}

void main() {
  print('Digite o número desejado: ');
  var numero = int.parse(stdin.readLineSync()!);
  print("O ${numero}º termo de Fibonacci é: ${fibonacci(numero)}");
}
