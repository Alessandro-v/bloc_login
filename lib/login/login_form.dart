import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_article/common/auth_text_field.dart';
import 'login_cubit.dart';
import 'login_state.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc_article/auth_models/password.dart';
import 'package:flutter_bloc_article/auth_models/email.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            print('submission failure');
          } else if (state.status.isSubmissionSuccess) {
            print('success');
          }
        },
        builder: (context, state) => Stack(
          children: [
            Positioned.fill(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(38.0, 0, 38.0, 8.0),
                child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      _WelcomeText(),
                      _EmailInputField(),
                      _PasswordInputField(),
                      _LoginButton(),
                      _SignUpButton(),
                    ],
                  ),
                ),
              ),
            ),
            state.status.isSubmissionInProgress
                ? Positioned(
              child: Align(
                alignment: Alignment.center,
                child: CircularProgressIndicator(),
              ),
            ) : Container(),
          ],
        )
    );
  }
}

class _WelcomeText extends StatelessWidget {
  const _WelcomeText({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 30.0, top: 30.0),
      child: Text(
        'Welcome to Bloc tutorial!',
        textAlign: TextAlign.center,
        style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold
        ),
      ),
    );
  }
}

class _EmailInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return AuthTextField(
          hint: 'Email',
          key: const Key('loginForm_emailInput_textField'),
          keyboardType: TextInputType.emailAddress,
          error: state.email.error.name,
          onChanged: (email) => context.read<LoginCubit>().emailChanged(email),
        );
      },
    );
  }
}

class _PasswordInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return AuthTextField(
          padding: EdgeInsets.symmetric(vertical: 20),
          hint: 'Password',
          isPasswordField: true,
          key: const Key('loginForm_passwordInput_textField'),
          keyboardType: TextInputType.text,
          error: state.password.error.name,
          onChanged: (password) =>
              context.read<LoginCubit>().passwordChanged(password),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text('Login'),
            disabledColor: Colors.blueAccent.withOpacity(0.6),
            color: Colors.blueAccent,
            onPressed: state.status.isValidated
                ? () => context.read<LoginCubit>().logInWithCredentials()
                : null,
          ),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 30),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text(
              'Sign Up',
              style: TextStyle(color: Colors.black),
            ),
            color: Colors.transparent,
            onPressed: () => Navigator.of(context).pushNamed('/login/signUp'),
          ),
        );
      },
    );
  }
}
