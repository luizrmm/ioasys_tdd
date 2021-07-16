import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class Company extends StatelessWidget {
  const Company({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: Center(
          child: Text('Pagina de companias'),
        ),
      ),
    );
  }
}
