import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:validators/validators.dart';

import '../models/custom_error.dart';
import '../providers/signup/signup_provider.dart';
import '../providers/signup/signup_state.dart';
import '../utils/error_dialog.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);
  static const String routeName = '/signup';

  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final _formKey = GlobalKey<FormState>();
  AutovalidateMode _autovalidateMode = AutovalidateMode.disabled;
  String? _name, _email, _password;
  final _passwordController = TextEditingController();

  void _submit() async {
    setState(() {
      _autovalidateMode = AutovalidateMode.always;
    });

    final form = _formKey.currentState;

    if (form == null || !form.validate()) return;

    form.save();

    print('[디버깅] name: $_name, email: $_email, password: $_password');

    try {
      await context
          .read<SignupProvider>()
          .signup(name: _name!, email: _email!, password: _password!);
    } on CustomError catch (e) {
      errorDialog(context, e);
    }
  }

  @override
  Widget build(BuildContext context) {
    final signupState = context.watch<SignupState>();

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30.0),
            child: Form(
              key: _formKey,
              autovalidateMode: _autovalidateMode,
              child: ListView(
                reverse: true,
                shrinkWrap: true,
                children: [
                  Image.asset(
                    'assets/images/flutter_logo.png',
                    width: 250,
                    height: 250,
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: '이름',
                      prefixIcon: Icon(Icons.account_box),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return '이름은 필수입력해야합니다.';
                      }
                      if (value.trim().length < 2) {
                        return '이름은 2글자 이상이어야 합니다.';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _name = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    keyboardType: TextInputType.emailAddress,
                    autocorrect: false,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: '이메일',
                      prefixIcon: Icon(Icons.email),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return '이메일은 필수입력해야합니다.';
                      }
                      if (!isEmail(value.trim())) {
                        return '이메일이 올바르지 않습니다.';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _email = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: '비밀번호',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (String? value) {
                      if (value == null || value.trim().isEmpty) {
                        return '비밀번호가 필요합니다.';
                      }
                      if (value.trim().length < 6) {
                        return '비밀번호는 6글자 이상이어야 합니다.';
                      }
                      return null;
                    },
                    onSaved: (String? value) {
                      _password = value;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  TextFormField(
                    obscureText: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      filled: true,
                      labelText: '패스워드확인',
                      prefixIcon: Icon(Icons.lock),
                    ),
                    validator: (String? value) {
                      if (_passwordController.text != value) {
                        return '패스워드가 일치하지 않습니다.';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 20.0),
                  ElevatedButton(
                    onPressed:
                        signupState.signupStatus == SignupStatus.submitting
                            ? null
                            : _submit,
                    child: Text(
                        signupState.signupStatus == SignupStatus.submitting
                            ? '가입중...'
                            : '가입'),
                    style: ElevatedButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        fontWeight: FontWeight.w600,
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  TextButton(
                    onPressed:
                        signupState.signupStatus == SignupStatus.submitting
                            ? null
                            : () {
                                Navigator.pop(context);
                              },
                    child: const Text('회원가입을 했었다면, 로그인하세요.'),
                    style: TextButton.styleFrom(
                      textStyle: const TextStyle(
                        fontSize: 20.0,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ].reversed.toList(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
