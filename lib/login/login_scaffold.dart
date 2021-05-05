import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login_cubit.dart';
import 'login_form.dart';

class LoginScaffold extends StatelessWidget {
  const LoginScaffold({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Text('Login'),
      ),
      body: SafeArea(
        child: BlocProvider(
          create: (_) => LoginCubit(),
          child: LoginForm(),
        ),
      ),
    );
  }
}
