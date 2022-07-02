import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  String _Resultado = 'Resultado';
  TextEditingController _TextEditingControllerCep = new TextEditingController();

  //Existe dois tipos de busca a Assincrona e Sincrona...
  //Assincrona - envia -> espera retorno..
  //Sincrona - Envia -> No mesmo momento já recebe o retorno..
  _BuscarCep() async {
    String vUrl =
        "http://viacep.com.br/ws/${_TextEditingControllerCep.text}/json/";

    /// Crio uma variável do tipo response;
    http.Response vResponse;

    /// (BUSCA DADOS DA API) somente passando a URL para o metódo GET -- await - define que irá agurdar a resposta da API...
    vResponse = await http.get(Uri.parse(vUrl));

    ///CONVERTE MEU RETORNO PARA UM OBJETO DO TIPO JSON e esse objeto é atribuido para um MAP que amarmazena <Chave,Valor>
    if (vResponse.statusCode.toString() == "200") {
      Map<String, dynamic> vObjetoRetorno = json.decode(vResponse.body);

      setState(() {
        _Resultado = 'Logradouro: ${vObjetoRetorno["logradouro"]},'
            'complemento: ${vObjetoRetorno["complemento"]},'
            'bairro: ${vObjetoRetorno["bairro"]},'
            'localidade: ${vObjetoRetorno["localidade"]},'
            'UF: ${vObjetoRetorno["uf"]},';
      });
    } else
      setState(() {
        _Resultado = 'Erro ao buscar informações';
      });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title: Title(color: Colors.white, child: Text("Consumo API")),
      ),
      body: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            TextField(
                keyboardType: TextInputType.number,
                decoration:
                    InputDecoration(labelText: "Digite um Cep (Ex: 89874000)"),
                controller: _TextEditingControllerCep),
            ElevatedButton(
                onPressed: _BuscarCep, child: Text("Buscar Endereço")),
            Text(_Resultado),
          ],
        ),
      ),
    );
  }
}
