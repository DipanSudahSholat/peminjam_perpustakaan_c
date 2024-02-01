import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';


import '../../../data/model/response_pinjam.dart';
import '../../../routes/app_pages.dart';
import '../controllers/peminjaman_controller.dart';

class PeminjamanView extends GetView<PeminjamanController> {
  const PeminjamanView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PeminjamanView'),
        centerTitle: true,
      ),
      body: controller.obx(
            (state) => ListView.separated(
          itemCount: state!.length,
          itemBuilder: (context, index) {
            DataPinjam dataPinjam = state[index];
            return ListTile(
              title: Text('${dataPinjam.book?.judul}'),
              subtitle: Text(
                  'Penulis ${dataPinjam.book?.penulis} \n ${dataPinjam.book?.penerbit} - ${dataPinjam.book?.tahunTerbit}'),
              trailing: ElevatedButton(
                onPressed: () => Get.toNamed(Routes.ADD_PEMINJAMAN,
                    parameters: {
                      'id': (dataPinjam.book?.id ?? 0).toString(),
                      'judul': dataPinjam.book?.judul ?? '-'
                    }),
                child: Text("Pinjam"),
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
        ),
        onLoading: Center(child: CupertinoActivityIndicator()),
      ),
    );
  }
}
