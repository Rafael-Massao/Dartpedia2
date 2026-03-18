import 'dart:io';
import 'package:command_runner/command_runner.dart';
import 'package:http/http.dart' as http;

const version = '0.0.1'; // GLOBAL


void main(List<String> args) async {
  var commandRunner = CommandRunner(
    onOutput: (String output) async {
    },
    onError: (Object error){
      if (error is Error){
        throw error;
      }
      if (error is Exception){
        print(error);
      }
    },
  )..addCommand(HelpCommand());
  commandRunner.run(args);
}

void printusage() {
  print("Comandos Validos: 'help', 'version', 'search <ARTICLE-TITLE>'");
}

// Metodo Principal

// ? - Pode ou não receber valores
void searchWikipedia(List<String>? args) async{
  final String? tituloArtigo;

  if (args == null || args.isEmpty){
    print('Por favor forneça um assunto');
    final inputStdin = stdin.readLineSync();
    if(inputStdin == null || inputStdin.isEmpty){
      print('Erro, pesquisa em branco');
      return;
    }
    tituloArtigo = inputStdin;
  } else {
    tituloArtigo = args.join(' ');
  }
  print('Procurando artigos sobre $tituloArtigo. Aguarde');
  var conteudoArtigo = await (getWikipediaArticle(tituloArtigo));
  print('Aqui Está');
  print('$conteudoArtigo');
}

Future<String> getWikipediaArticle(String tituloArtigo) async{
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$tituloArtigo',
    );
    
  final response = await http.get(url); // Enquanto esse comando não terminar o código não continua.
  
  if(response.statusCode == 200){
    return response.body;
  }
  return 'Erro, falha ao acessar o $tituloArtigo'; // Não se usa um else nessa parte, por que se der erro ele nem continua lendo
}