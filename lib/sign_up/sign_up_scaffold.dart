import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_article/sign_up/sign_up_bloc.dart';
import 'package:flutter_bloc_article/sign_up/sign_up_form.dart';

class SignUpScaffold extends StatelessWidget {
  const SignUpScaffold({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Sign Up'),
          elevation: 0,
        ),
        body: SafeArea(
          top: false,
          child: BlocProvider(
            create: (_) => SignUpBloc(),
            child: SignUpForm(),
          ),
        )
    );
  }
}