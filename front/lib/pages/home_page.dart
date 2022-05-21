import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/main.dart';
import 'package:flutter_application_1/models/maintenance.dart';

import '../constants/api.dart';
import '../constants/functions.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = true;
  List<Maintenance>? maintenances;

  @override
  void initState() {
    super.initState;
    getMaintenances();
  }

  Future<void> getMaintenances() async {
    //Metodo para forcar a espera da construção da tela de splashscreen
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var accessToken = storage['access_token'];
      if (accessToken == null) {
        Navigator.of(context).pushReplacementNamed("/login");
        return;
      } else {
        final Dio dio = Dio(BaseOptions(baseUrl: Api.baseUrl, headers: {'Authorization': 'Bearer $accessToken'}));
        try {
          var response = await dio.get(Api.maintenancesEndpoint);
          if (response.statusCode == 200) {
            setState(() { 
              maintenances = [];
              response.data.forEach((e) => maintenances!.add(Maintenance.fromJson(e)));
              isLoading = false;
            });
          } else {
            Navigator.of(context).pushReplacementNamed("/login");
          } 
        } catch (e) {
          Navigator.of(context).pushReplacementNamed("/login");
        }
      }
    });
  }

  Future<void> logout() async {
    storage.remove('access_token');
    Navigator.of(context).pushReplacementNamed("/login");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Manutenções"),
        leading: Container(),
        actions: [
          IconButton(onPressed: logout, icon: const Icon(Icons.logout))
        ],
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator()) : ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
        itemCount: maintenances?.length,
        itemBuilder: item
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.of(context).pushNamed("/edit_maintenance"),
        backgroundColor: const Color(0xFFEE7300),
        child: const Icon(Icons.add)
      ),
    );
  }

  Widget item(BuildContext context, int index) {
    var maintenance = maintenances?[index];
    return Card(
      elevation: 4,
      child: ListTile(
        title: Text("Manuntenção: ${maintenance?.description} - Criada em: ${datetimeToString(maintenance?.createdAt)}"),
        subtitle: Text(maintenance?.statusText ?? ""),
      ),
    );
  } 
}