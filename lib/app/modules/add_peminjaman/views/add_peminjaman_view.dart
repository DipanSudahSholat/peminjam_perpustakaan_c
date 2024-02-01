import 'package:flutter/material.dart';
import 'package:date_time_picker/date_time_picker.dart';

import 'package:get/get.dart';
import 'package:peminjam_perpustakaan_c/app/data/provider/storage_provider.dart';

import '../controllers/add_peminjaman_controller.dart';

class AddPeminjamanView extends GetView<AddPeminjamanController> {
  const AddPeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('AddPeminjamanView'),
        centerTitle: true,
      ),
      body:  Form(
          key: controller.formKey,
          child: Column(
            children: [
              Text('Buku Yang Dipinjam : ${Get.parameters['judul']}'),
              // DateTimePicker
              DateTimePicker(
                icon: Icon(Icons.date_range_outlined),
                controller: controller.tanggal_pinjamController,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Pilih Tanggal Pinjam',
                dateMask: 'yyyy-MM-dd',
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              DateTimePicker(
                icon: Icon(Icons.date_range_outlined),
                controller: controller.tanggal_kembaliController,
                firstDate: DateTime(2000),
                lastDate: DateTime(2100),
                dateLabelText: 'Pilih Tanggal Kembali',
                dateMask: 'yyyy-MM-dd',
                onChanged: (val) => print(val),
                validator: (val) {
                  print(val);
                  return null;
                },
                onSaved: (val) => print(val),
              ),
              SizedBox(height: 20,),
              Obx(() => controller.loading.value
                  ? CircularProgressIndicator()
                  : ElevatedButton(
                  onPressed: () {
                    controller.addpinjam();
                  },
                  child: Text('Tambah'))),
            ],
          )),
    );
  }
}
