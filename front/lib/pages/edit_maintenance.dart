import 'package:asuka/snackbars/asuka_snack_bar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/components/custom_text_form_field.dart';
import 'package:flutter_application_1/main.dart';

import '../constants/api.dart';

class EditMaintenancePage extends StatefulWidget {
  const EditMaintenancePage({Key? key}) : super(key: key);

  @override
  State<EditMaintenancePage> createState() => _EditMaintenancePageState();
}

class _EditMaintenancePageState extends State<EditMaintenancePage> {
  bool isLoading = false;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController descriptionController = TextEditingController();

  Future<void> saveMaintenance() async {
    setState(() { isLoading = true; });
    var accessToken = storage['access_token'];
    if (accessToken == null) {
      Navigator.of(context).pushReplacementNamed("/login");
      return;
    }
    final Dio dio = Dio(BaseOptions(baseUrl: Api.baseUrl, headers: {'Authorization': 'Bearer $accessToken'}));
    Map<String, String> payload = {
      "description": descriptionController.text,
    };

    try {
      var response = await dio.post(Api.maintenancesEndpoint, data: payload);

      if (response.statusCode == 201) {
        AsukaSnackbar.success("Manutenção inserida com sucesso").show();
        Navigator.of(context).pushReplacementNamed("/home");
      } else {
        setState(() { isLoading = false; });
        AsukaSnackbar.alert("Erro ao cadastrar manutenção, verifique seus dados.").show();
      }
    } catch (e) {
      setState(() { isLoading = false; });
      AsukaSnackbar.alert("Erro ao cadastrar manutenção, tente novamente mais tarde").show();
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        title: const Text("Cadastrar Manutenção")
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : Stack(
        fit: StackFit.expand,
        children: [
          _background(),
          _formCard(screenSize),
        ],
      ),
    );
  }

  Widget _formCard(Size screenSize) => Align(
    alignment: Alignment(0,-0.5),
    child: Card(
      elevation: 20,
      child: SizedBox(
        height: 0.5 * screenSize.height,
        width: 0.6 * screenSize.width,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Column(
                  children: [
                    CustomTextFormField(
                      controller: descriptionController,
                      hintText: "Descrição",
                      multilined: true,
                      required: true,
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: (){
                    if (_formKey.currentState?.validate() == true) {
                      saveMaintenance();
                    }
                  },
                  style: ElevatedButton.styleFrom(primary: const Color(0xFFEE7300)),
                  child: const Text("Cadastrar")
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