import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_c/app/data/model/response_pinjam.dart';
import 'package:peminjam_perpustakaan_c/app/data/provider/storage_provider.dart';

import '../../../data/constant/endpoint.dart';
import '../../../data/provider/api_provider.dart';
import 'package:dio/dio.dart' as dio;

class PeminjamanController extends GetxController
with StateMixin<List<DataPinjam>>{
  //TODO: Implement PeminjamanController


  @override
  void onInit() {
    super.onInit();
    getData();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }
  getData() async {
    change(null, status: RxStatus.loading());
    try{
      final response =
      await ApiProvider.instance().get("${Endpoint.pinjam}/${StorageProvider.read(StorageKey.idUser)}");
      if(response.statusCode == 200) {
        final ResponsePinjam responseBook = ResponsePinjam.fromJson(response.data);
        if(responseBook.data!.isEmpty){
          change(null,status: RxStatus.empty());
        }else{
          change(responseBook.data, status: RxStatus.success());
        }
      } else {
        change(null, status: RxStatus.error("${response.data['message']}"));
      }

    } on dio.DioException catch (e) {
      if (e.response != null){
        if(e.response?.data != null){
          change(null, status: RxStatus.error("${e.response?.data['message']}"));
        }
      } else {
        change(null, status: RxStatus.error(e.message?? ""));
      }
    } catch (e) {
      change(null, status: RxStatus.error(e.toString()));
    }
  }

}
