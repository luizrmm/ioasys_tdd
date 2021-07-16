import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ioasys_tdd/features/login/presentation/bloc/authentication_bloc.dart';

class FormBody extends StatefulWidget {
  final String message;
  const FormBody({
    Key? key,
    required this.message,
  }) : super(key: key);

  @override
  _FormBodyState createState() => _FormBodyState();
}

class _FormBodyState extends State<FormBody> {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final FocusNode passwordFocusNode;
  @override
  void initState() {
    emailController = TextEditingController();
    passwordController = TextEditingController();

    passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();

    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text('Email'),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFE5E5E5),
              border: InputBorder.none,
            ),
            textInputAction: TextInputAction.next,
            onEditingComplete: () {
              FocusScope.of(context).requestFocus(passwordFocusNode);
            },
            controller: emailController,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Text('Senha'),
          ),
          TextField(
            decoration: InputDecoration(
              filled: true,
              fillColor: Color(0xFFE5E5E5),
              border: InputBorder.none,
              errorBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.red),
              ),
            ),
            focusNode: passwordFocusNode,
            obscureText: true,
            controller: passwordController,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 32.0),
            child: Text(
              widget.message,
              textAlign: TextAlign.end,
              style: TextStyle(
                color: Colors.red,
              ),
            ),
          ),
          MaterialButton(
            height: 46,
            onPressed: dispatchAuthenticate,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            color: Color(0xFFE01E69),
            child: Text(
              'ENTRAR',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  void dispatchAuthenticate() {
    BlocProvider.of<AuthenticationBloc>(context).add(
      Authenticate(emailController.text, passwordController.text),
    );
    emailController.clear();
    passwordController.clear();
  }
}
