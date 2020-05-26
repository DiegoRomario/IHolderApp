import 'package:flutter/material.dart';
import 'package:iholder_app/settings.dart';
import 'package:iholder_app/ui/android/screens/ativos.screen.dart';
import 'package:iholder_app/ui/shared/widgets/usuario-nao-autorizado.widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class LancamentosScreen extends StatefulWidget {
  @override
  _LancamentosScreenState createState() => _LancamentosScreenState();
}

class _LancamentosScreenState extends State<LancamentosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Lançamentos"),
        centerTitle: true,
      ),
      body: Settings.usuario != null
          ? OpcoesLancamentos()
          : UsuarioNaoAutorizado(),
    );
  }
}

class OpcoesLancamentos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (ctx) => AtivosScreen(),
            ),
          );
        },
        child: ListTile(
          leading: Icon(MdiIcons.plusCircle),
          title: Text('Ativos'),
        ),
      ),
    );
  }
}
