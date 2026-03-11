import 'package:command_runner/command_runner.dart';

enum OptionType {flag, option}

abstract class Args {
  
  String get name;
  String? get help;

  Object? get defaultValue;
  String? get valueHelp;

  String get usage;
}
class Option extends Args {
  Option (
    this.name, {
      required this.type, 
      this.help, 
      this.abbr, 
      this.defaultValue, 
      this.valueHelp
      }
  );
  @override
  final String name;
  final OptionType type;
  @override
  final String? help;
  final String? abbr;
  @override
  final Object? defaultValue;
  final String? valueHelp;
  @override
  String get usage {
    if (abbr != null){
      return '-$abbr, --$name: $help'; 
    }
    return '--$name: $help';
  }
}
abstract class command extends Args {
  @override
  String get name;
  String get description;
  bool get requiredArgs => false;
  late CommandRunner runner;
  @override
  String? help;
  @override
  String? defaultValue;
  @override
  String? valueHelp;
}