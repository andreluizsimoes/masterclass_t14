import 'dart:io';

void main(List<String> args) {
  final env = DotEnv('modulo_zero/.env');

  final apiKey = env.getValue('URL_API');
  print(apiKey == 'https://api.github.com');

  final apiToken = env.getValue('API_TOKEN');
  print(apiToken == 'DksdlakdjlakdjIJdlsa');

  final expirationToken = env.getValue('EXPIRATION_TOKEN');
  print(expirationToken == 3600);

  final debug = env.getValue('DEBUG');
  print(debug == true);
}

class DotEnv {
  final String _pathFile;
  final _env = <String, dynamic>{};

  DotEnv(this._pathFile) {
    _load();
  }

  void _load() {
    // 0. check se o arquivo existe.
    // 1. ler o arquivo .env que esta na varial _pathFile
    // 2. Separar as linhas
    // 3. separar por =
    // 4. atribuir ao map _env
    var file = File(_pathFile);

    if (file.existsSync()) {
      var lines = file.readAsLinesSync();
      for (var line in lines) {
        final parts = line.split('=');
        String key = parts[0].trim();
        var valueNoComments = excludeComments(parts[1]);
        var value = sanitValue(valueNoComments);
        _env[key] = value;
      }
    } else {
      throw Exception("Arquivo inexistente");
    }
  }

  dynamic getValue(String key) {
    return _env[key];
  }

  dynamic sanitValue(String value) {
    if (value.toLowerCase() == 'true' || value.toLowerCase() == 'false') {
      return value.toLowerCase() == 'true' ? true : false;
    }

    if (int.tryParse(value) != null) {
      return int.parse(value);
    }

    if (double.tryParse(value) != null) {
      return double.parse(value);
    }

    if ((value.startsWith("'") && value.endsWith("'")) ||
        (value.startsWith('"') && value.endsWith('"'))) {
      return value.substring(1, value.length - 1);
    }

    return value;
  }

  excludeComments(String part) {
    return part.split('#')[0].trim();
  }
}
