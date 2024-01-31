import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import 'package:dio/dio.dart' as dio;

import '../../../data/provider/storage_provider.dart';
import '../../../routes/app_pages.dart';

class RegisterController extends GetxController {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController namaController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController telpController = TextEditingController();
  final TextEditingController alamatController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final loading = false.obs;
  //TODO: Implement RegisterController


  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  register() async {loading(true);
  try{
    FocusScope.of(Get.context!).unfocus(); //ngeclose keyboard
    formKey.currentState?.save();
    if(formKey.currentState!.validate()) {
      final response = await ApiProvider.instance().post(Endpoint.register,
          data: {
            "nama": namaController.text.toString(),
            "username": usernameController.text.toString(),
            "telp": telpController.text.toString(),
            "alamat": alamatController.text.toString(),
            "password": passwordController.text.toString(),
          });
      if(response.statusCode == 201) {
        Get.snackbar("Registrasi", "Berhasil", backgroundColor: Colors.green);
        Get.toNamed(Routes.LOGIN);
      } else {
        Get.snackbar("Sorry", "Penambahan Gagal", backgroundColor: Colors.orange);
      }
    }loading(false);
  } on dio.DioException catch (e) {loading(false);
  if (e.response != null){
    if(e.response?.data != null){
      Get.snackbar("Sorry", "${e.response?.data['message']}", backgroundColor: Colors.orange);
    }
  } else {
    Get.snackbar("Sorry", e.message ?? "", backgroundColor: Colors.red);
  }
  } catch (e) {loading(false);
  Get.snackbar("Error", e.toString(), backgroundColor: Colors.red);
  }
  }
}
