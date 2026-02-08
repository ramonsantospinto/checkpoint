// Detecta o error no mason, comando -dart run tool/check_yaml.dart

import 'dart:io';
import 'package:yaml/yaml.dart';

void main() {
  final root = Directory.current;

  final yamls = <File>[];
  for (final e in root.listSync(recursive: true)) {
    if (e is File && (e.path.endsWith('.yaml') || e.path.endsWith('.yml'))) {
      yamls.add(e);
    }
  }

  for (final f in yamls) {
    try {
      loadYaml(f.readAsStringSync());
    } catch (e) {
      stderr.writeln('YAML inválido: ${f.path}');
      stderr.writeln(e);
      exit(1);
    }
  }

  stdout.writeln('OK: ${yamls.length} YAML files parsed.');
}
