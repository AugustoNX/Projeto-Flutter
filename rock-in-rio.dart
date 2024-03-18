import 'package:flutter/material.dart';

void main() {
  runApp(const RockInRio());
  // aq ele rodou o app (RockInRio)
}

class RockInRio extends StatelessWidget {
  // deu inicio ao app, stateless fica a construçao do app
  const RockInRio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // metodo build é pra dizer oq ele vai retornar/construir

    return MaterialApp( // a raiz do app é o material app
      title: "Rock in Rio", // titulo do app
      debugShowCheckedModeBanner: false, // pra não aparecer a fita de debug 
      theme: ThemeData(primarySwatch: Colors.indigo), // tema da pag
      home: const HomePage(), // indica o ponto de partida do MaterialApp

    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
  // precisa criar um stado pra statefull
}

class _HomePageState extends State<HomePage> {
  // aq a gente ta criando o stado do obj HOMEPAGE
  
  final List<Atracao> _listaFavoritos = [];
  // cria a lista de favoritos

  @override
  Widget build(BuildContext context) { // ta fazendo a construção do obj
    return Scaffold( // usa o scaffold pq ele ja tem uma estrutura basica pra tela
      appBar: AppBar( // barra do topo dos app
        title: Text("Atraçoes"), // titulo da barra 
      ),
      body: ListView.builder( // para criar a lista
        itemCount: listaAtracoes.length, // dizer o tamanho dessa lista
        itemBuilder: (context, index){ // construir a lista
          final isFavorito = _listaFavoritos.contains(listaAtracoes[index]); // verifica se esta favoritado ou não
                                        // o contains verifica se o obj esta contido na lista ou não
          return ListTile( // widget pra trabalhar com lista
              onTap:(){ // add um clique ao item
                Navigator.push( // vai fazer aparecer uma nova tela 
                  context, MaterialPageRoute(
                    builder: (context) => //vai construir a nova tela
                      AtracaoPage(atracao: listaAtracoes[index])
                  ));
              },
              title: Text(listaAtracoes[index].nome), // colocar o texto, q no caso é o nome do show
              subtitle: // criar o subtitulo no caso as atraçoes
               Wrap( // distribui os filhos um de cada vez
                direction: Axis.horizontal, // diz a direçao dos itens
                alignment: WrapAlignment.start,
                spacing: 8, // espaço horizontal entre os subtitulos
                runSpacing: 4, // espaço vertical entre os itens
                children: listaAtracoes[index].tags.map((tag) => Chip(label: Text("#$tag"))).toList(),
                      // texto que aparece dentro dos subtitulos
              ),

              leading: // cria o item a esquerda
                CircleAvatar( // cria um circulo de avatar
                child: Text('${listaAtracoes[index].dia}'), // add um texto nesse circulo
              ),

              trailing: // cria o icone a direita
                IconButton( // cria o botao de icone
                onPressed: () { // quando clicar no botao
                  setState(() { // cria um estado
                    if (isFavorito) { // verifica se já esta favoritado ou não
                      _listaFavoritos.remove(listaAtracoes[index]);
                    } else {
                      _listaFavoritos.add(listaAtracoes[index]);
                    }
                  });
                }, // funçao de pressionar
                icon: isFavorito ? const Icon(Icons.favorite, color: Colors.red)
                : const Icon(Icons.favorite), // verifica e imprime o icone de acordo com seu estado
              ),
          );
        },
      ),
    ); 
  }
}

class AtracaoPage extends StatelessWidget { // cria a nova pag q vai aparecer ao clicar
  final Atracao atracao; 
  const AtracaoPage({Key? key, required this.atracao}) : super(key : key); // declara a atração

  @override
  Widget build(BuildContext context){ // construir a pag
    return Scaffold( // modelo ja pronto pra construir
      appBar: AppBar( // barra do topo da tela
        title: Text(atracao.nome),
      ),
      body: Padding( // espaçamento da borda
        padding: const EdgeInsets.all(16), // espaçamento lateral
        child: Column( // cria uma coluna
          crossAxisAlignment: CrossAxisAlignment.stretch, // propriedade pra esticar os itens
          children: [ // cria o filho
            for(var tag in atracao.tags) Chip(label: Text('#$tag')), // faz uma varredura nos itens e imprime eles
            const SizedBox(height: 16), // espaçamento acima do botão
            ElevatedButton( // botão
              onPressed: (){ // função de pressionar
                Navigator.pop(context); // pra voltar a tela 
              },
              child: const Text("voltar"), // texto do botao
            ),
          ],
        ),
      ),
    );
  }
}

class Atracao { // aq estamos criando a classe das atrações
  final String nome;
  final int dia;        // o FINAL indica que essses atributos não podem ser mudados dps de atribuidos
  final List<String> tags;

   const Atracao(this.nome, this.dia, this.tags); // esse é o constructor
}

const listaAtracoes = [ // criou a lista de atrações
  Atracao("Iron Maiden", 2, ["Espetaculo", "Fas", "NovoAlbum"]),
  Atracao("Alok", 3, ["Influente", "Top", "Show"]),
  Atracao("Justin Bieber", 4, ["TopCharts", "Hits", "PríncipeDoPOP"]),
  Atracao("Guns N’ Roses", 8, ["Sucesso", "Espetáculo", "Fas"]),
  Atracao("Capital Inicial", 9, ["2019", "Novo Álbum", "Fas"]),
  Atracao("Green Day", 9, ["Sucesso", "Reconhecimento", "Show"]),
  Atracao("Cold Play", 10, ["NovoAlbum", "Sucesso", "2011"]),
  Atracao("Ivete Sangalo", 10, ["Unica", "Carreiras", "Fas"]),
  Atracao("Racionais", 3, ["Hits", "Prêmios", "Respeito"]),
  Atracao("Gloria Groove", 8, ["Streams", "Representatividade", "Sucesso"]),
  Atracao("Avril Lavigne", 9, ["Estreia", "Sucesso", "Lançamento"]),
  Atracao("Ludmilla", 10, ["Representativade", "Sucesso", "Parcerias"]),
];