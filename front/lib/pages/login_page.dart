import 'package:asuka/asuka.dart';
import 'package:dio/dio.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import "package:flutter/material.dart";
import 'package:flutter_application_1/constants/api.dart';
import 'package:flutter_application_1/main.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    setState(() { isLoading = true; });
    final Dio dio = Dio(BaseOptions(baseUrl: Api.baseUrl));
    Map<String, String> payload = {
      "login": emailController.text,
      "password": passwordController.text,
    };
    try {
      var response = await dio.post(Api.loginEndpoint, data: payload);
      if (response.statusCode == 200) {
        storage['access_token'] = response.data['accessToken'];
        Navigator.of(context).pushReplacementNamed("/home");
      } else {
        setState(() { isLoading = false; });
        AsukaSnackbar.alert("Erro ao relizar o login, verifique seus dados.").show();
      } 
    } catch (e) {
      setState(() { isLoading = false; });
      AsukaSnackbar.alert("Erro ao relizar o login, tente novamente mais tarde").show();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Login")
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : Stack(
        fit: StackFit.expand,
        children: [
          _background(),
          _loginCard(screenSize),
        ],
      ),
    );
  }

  Widget _loginCard(Size screenSize) => Align(
    alignment: Alignment(0,-0.5),
    child: Card(
      elevation: 20,
      child: SizedBox(
        height: 0.5 * screenSize.height,
        width: 0.3 * screenSize.width,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        hintText: "Login"
                      ),
                      validator: (value) {
                        if (value == null || value.isEmpty || !value.contains('@')) {
                          return 'Insira o email corretamente';
                        }
                      },
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      controller: passwordController,
                      decoration: const InputDecoration(
                        hintText: "Senha"
                      ),
                      obscureText: true,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Insira a senha corretamente';
                        }
                      },
                    )
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState?.validate() == true) {
                      login();
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: const Color(0xFFEE7300)),
                  child: const Text("Logar-se")
                )
              ],
            ),
          ),
        ),
      )
    ),
  );

  Widget _background() => Column(
    children: [
      Expanded(flex: 2, child: Container(color: Colors.white,)),
      Expanded(flex: 3, child: Container(color: const Color(0xFFEE7300),))
    ],
  );
}