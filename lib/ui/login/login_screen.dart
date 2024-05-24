import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:test_project/utils/color.dart';
import '../../utils/app_dialogs.dart';
import 'login_bloc.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _loginForm = GlobalKey<FormBuilderState>();
  late final LoginBloc bloc;

  // final sharedPreferences = GetIt.I<SharedPreferences>();

  @override
  void initState() {
    super.initState();
    bloc = context.read<LoginBloc>();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title:Text(
          'Login',
          // style: Theme.of(context).textTheme.headlineLarge,
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 15.0, left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height:15),
                FormBuilder(
                    key: _loginForm,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height:15),
                        FormBuilderTextField(
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          name: 'user_name',
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'UserName is required.';
                            }
                            return null;
                          },
                          decoration: const InputDecoration(
                              icon: Icon(Icons.mail_outline_sharp,color: AppColors.primary,),
                              labelText: 'UserName'),
                        ),
                        const SizedBox(height:15),
                        BlocBuilder<LoginBloc, LoginState>(
                            buildWhen: (previousState, state) =>
                                previousState.isPasswordVisible !=
                                state.isPasswordVisible,
                            builder: (context, state) {
                              return FormBuilderTextField(
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                name: 'password',
                                obscureText: state.isPasswordVisible,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is required';
                                  } /* else if (!RegexValidation.isPasswordValid(
                                      value)) {
                                    return 'Enter valid password containing 8 character including one upper case ,one lower, one digit. ';
                                  }*/
                                  return null;
                                },
                                decoration: InputDecoration(
                                    icon: const Icon(Icons.lock_outline,color: AppColors.primary,),
                                    labelText: 'Password',
                                    suffixIcon: GestureDetector(
                                      onTap: () {
                                        bloc.add(PasswordVisibleEvent());
                                      },
                                      child: state.isPasswordVisible
                                          ? Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              runAlignment: WrapAlignment.end,
                                              children: [
                                                const Icon(Icons.visibility),
                                                const SizedBox(width: 5,height: 15,),
                                                Text(
                                                  'Show',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                )
                                              ],
                                            )
                                          : Wrap(
                                              crossAxisAlignment:
                                                  WrapCrossAlignment.center,
                                              runAlignment: WrapAlignment.end,
                                              children: [
                                                const Icon(
                                                    Icons.visibility_off),
                                                const SizedBox(width: 5,height: 15,),
                                                Text(
                                                  'Hide',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .bodySmall,
                                                )
                                              ],
                                            ),
                                    )),
                              );
                            }),
                        const SizedBox(height:30),
                        BlocConsumer<LoginBloc, LoginState>(
                          listener: (context, state) {
                            _loginButtonClicked(state);
                          },
                          // buildWhen: (previousState, state) {
                          //   return previousState.loginState != state.loginState;
                          // },
                          // listenWhen: (previousState, state) {
                          //   return previousState.loginState != state.loginState;
                          // },
                          builder: (context, state) {
                            return ElevatedButton(
                                onPressed: () async {
                                  _loginForm.currentState?.saveAndValidate();
                                  if (_loginForm.currentState!.validate()) {
                                    bloc.add(SignInButtonEvent(
                                        _loginForm.currentState!.value['user_name'].toString().trim(),
                                        _loginForm.currentState!.value['password'].toString().trim()));
                                  }
                                },
                                child: state.isLoading== true
                                    ? const CircularProgressIndicator(
                                        color: Colors.white,
                                      )
                                    : const Text('Login'));
                          },
                        ),
                      ],
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    bloc.reset();
    super.dispose();
  }


  void _loginButtonClicked(LoginState state) {
    if (state.isSuccess != null) {
      Navigator.pushReplacementNamed(context, '/HomeScreen');
    }else if(state.isError!=''||state.isError.isNotEmpty){
      AppsDialogs.statusDialog(context, 'error_dialog', state.isError);
      bloc.reset();
    }
  }

}
