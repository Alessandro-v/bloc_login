import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc_article/common/add_image_form.dart';
import 'package:flutter_bloc_article/common/auth_text_field.dart';
import 'package:flutter_bloc_article/sign_up/sign_up_bloc.dart';
import 'package:flutter_bloc_article/sign_up/sign_up_event.dart';
import 'package:flutter_bloc_article/sign_up/sign_up_state.dart';
import 'package:formz/formz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_bloc_article/auth_models/confirm_password.dart';
import 'package:flutter_bloc_article/auth_models/password.dart';

class SignUpForm extends StatelessWidget {
  const SignUpForm({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignUpBloc, SignUpState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          print('submission failure');
        } else if (state.status.isSubmissionSuccess) {
          Navigator.of(context).pushNamed('/home');
        }
      },
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(38.0, 0, 38.0, 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _ImageInputField(),
            _NameInputField(),
            _EmailInputField(),
            _PasswordInputField(),
            _ConfirmPasswordInput(),
            _SignUpButton(),
          ],
        ),
      )
    );
  }
}

class _ImageInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.image != current.image,
      builder: (context, state) {
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 25),
            child: AddImageForm(
              key: const Key('signUpForm_imageInput_profileImage'),
              imagePath: state.image,
              onChanged: (image) => context.read<SignUpBloc>().add(ProfileImageChanged(image: image)),
            )
        );
      },
    );
  }
}

class _NameInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.name != current.name,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: AuthTextField(
            hint: 'Nome',
            key: const Key('signUpForm_nameInput_textField'),
            isRequiredField: true,
            keyboardType: TextInputType.text,
            onChanged: (name) => context.read<SignUpBloc>().add(NameChanged(name: name)),
          ),
        );
      },
    );
  }
}

class _EmailInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: AuthTextField(
            hint: 'Email',
            key: const Key('signUpForm_emailInput_textField'),
            isRequiredField: true,
            keyboardType: TextInputType.emailAddress,
            onChanged: (email) => context.read<SignUpBloc>().add(EmailChanged(email: email)),
          ),
        );
      },
    );
  }
}

class _PasswordInputField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 16.0),
          child: AuthTextField(
            hint: 'Password',
            key: const Key('signUpForm_passwordInput_textField'),
            isPasswordField: true,
            isRequiredField: true,
            keyboardType: TextInputType.text,
            error: state.password.error.name,
            onChanged: (password) =>
                context.read<SignUpBloc>().add(PasswordChanged(password: password)),
          ),
        );
      },
    );
  }
}

class _ConfirmPasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) =>
      previous.password != current.password ||
          previous.confirmPassword != current.confirmPassword,
      builder: (context, state) {
        return AuthTextField(
          hint: 'Conferma Password',
          isRequiredField: true,
          key: const Key('signUpForm_confirmedPasswordInput_textField'),
          isPasswordField: true,
          keyboardType: TextInputType.text,
          error: state.confirmPassword.error.name,
          onChanged: (confirmPassword) => context
              .read<SignUpBloc>()
              .add(ConfirmPasswordChanged(confirmPassword: confirmPassword)),
        );
      },
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.only(top: 20),
          child: CupertinoButton(
            padding: EdgeInsets.zero,
            child: Text('Sign Up'),
            disabledColor: Colors.blueAccent.withOpacity(0.6),
            color: Colors.blueAccent,
            onPressed: state.status.isValidated
                ? () => context.read<SignUpBloc>().add(FormSubmitted())
                : null,
          ),
        );
      },
    );
  }
}