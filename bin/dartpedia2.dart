import 'dart:io';
import 'package:http/http.dart' as http;

const String version = "0.0.1"; //Global
// Metodo principal
void main(List<String> args) {
  if (args.isEmpty || args.first == 'help') {
    printUsage();
  } 
  else if (args.first == 'version'){
     print('Dartpedia CLI - versão $version');
  } 
  else if (args.first == 'search')  {
    final inputArgs = args.length > 1 ? args.sublist(1) : null; // Verifica se há argumentos adicionais
    searchWikipedia(inputArgs); 
  }
  else {
    printUsage();
  }
// Print Secundário 
}
void printUsage() {
  print("Comandos válidos: 'help', 'version', 'search <ARTICLE-TITLE>'");
}
// ? - Pode ou Não receber valores 
void searchWikipedia(List<String>? args) async {
  final String? tituloArtigo;

  if (args == null || args.isEmpty) {
    print('Por favor, forneça o título do artigo para pesquisa.\n');
    final inputStdin = stdin.readLineSync();
    if(inputStdin == null || inputStdin.isEmpty) {
      print('Erro. Nenhum título foi fornecido\n');
      return;
    }
  tituloArtigo = inputStdin; // Atribui o valor do título do artigo a partir da entrada do usuário
  } 
  else {
    tituloArtigo = args.join(' '); // Junta os argumentos para formar o título completo (retira os espaços do titulo do Artigo)
  }
  print('\nPesquisando por "$tituloArtigo" aguarde...\n');
  var conteudoArtigo = await (getWikipediaArticle(tituloArtigo));

  print('Aqui está\n');
  print('$conteudoArtigo\n');
}

Future<String> getWikipediaArticle(String tituloArtigo) async{
  final url = Uri.https(
    'en.wikipedia.org',
    '/api/rest_v1/page/summary/$tituloArtigo',
);
  final response = await http.get(url);

  if (response.statusCode == 200) {
    return response.body;
  }
  return 'Erro: Falha ao buscar o artigo:$tituloArtigo';
}