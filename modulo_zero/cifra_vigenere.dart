import 'dart:io';
import 'dart:math';

void main() {
  var vigenere = CifraVigenere();
  print('Digite o texto:');
  var texto = stdin.readLineSync();

  var key = vigenere.generateKey(texto!.length);

  var encryptedText = vigenere.encrypt(texto, key);
  var decryptedText = vigenere.decrypt(encryptedText, key);

  print(
      'Texto criptografado: $encryptedText\nChave: $key\nTexto descriptografado: $decryptedText');
}

class CifraVigenere {
  String generateKey(int textLength) {
    String letras = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ';
    String key = '';

    Random random = Random();
    for (int i = 0; i < textLength; i++) {
      key += letras[random.nextInt(letras.length)];
    }

    return key;
  }

  String encrypt(String text, String key) {
    String encryptedText = '';
    for (int i = 0; i < text.length; i++) {
      if (isUpperCaseLetter(text[i])) {
        int x = (text.codeUnitAt(i) + key.codeUnitAt(i)) % 26;
        x += 'A'.codeUnitAt(0);
        encryptedText += String.fromCharCode(x);
      } else {
        encryptedText += text[i];
      }
    }
    return encryptedText;
  }

  String decrypt(String text, String key) {
    String decryptedText = '';
    for (int i = 0; i < text.length; i++) {
      if (isUpperCaseLetter(text[i])) {
        int x = (text.codeUnitAt(i) - key.codeUnitAt(i) + 26) % 26;
        x += 'A'.codeUnitAt(0);
        decryptedText += String.fromCharCode(x);
      } else {
        decryptedText += text[i];
      }
    }
    return decryptedText;
  }

  bool isUpperCaseLetter(String char) {
    if (char.isEmpty) return false;
    int code = char.codeUnitAt(0);
    return (code >= 65 && code <= 90);
  }
}
