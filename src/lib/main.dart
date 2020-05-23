import 'package:flutter/material.dart';
import 'package:iholder_app/blocs/distribuicao-por-tipo.bloc.dart';
import 'package:iholder_app/ui/android/screens/tab.screen.dart';
import 'package:provider/provider.dart';
import 'blocs/ativo.bloc.dart';
import 'blocs/distribuicao-por-ativo.bloc.dart';
import 'blocs/distribuicao-por-produto.bloc.dart';
import 'blocs/tema.bloc.dart';
import 'blocs/usuario.bloc.dart';

void main() {
  runApp(IoC());
}

class IoC extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UsuarioBloc>.value(
          value: UsuarioBloc(),
        ),
        ChangeNotifierProvider<DistribuicaoPorTipoBloc>.value(
          value: DistribuicaoPorTipoBloc(),
        ),
        ChangeNotifierProvider<DistribuicaoPorAtivoBloc>.value(
          value: DistribuicaoPorAtivoBloc(),
        ),
        ChangeNotifierProvider<DistribuicaoPorProdutoBloc>.value(
          value: DistribuicaoPorProdutoBloc(),
        ),
        ChangeNotifierProvider<AtivoBloc>.value(
          value: AtivoBloc(),
        ),
        ChangeNotifierProvider<TemaBloc>.value(
          value: TemaBloc(),
        )
      ],
      child: Main(),
    );
  }
}

class Main extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var bloc = Provider.of<TemaBloc>(context);
    return MaterialApp(
      theme: bloc.tema,
      debugShowCheckedModeBanner: false,
      home: TabsScreen(),
    );
  }
}
