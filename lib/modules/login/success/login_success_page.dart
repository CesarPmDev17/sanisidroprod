import 'package:app_san_isidro/modules/login/success/login_success_controller.dart';
import 'package:app_san_isidro/routes/app_pages.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginSuccessPage extends StatelessWidget {
  final _conX = Get.put(LoginSuccessController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ElevatedButton(
          child: Text('Fin ${_conX.firstString}'),
          onPressed: () {
            Get.offAllNamed(AppRoutes.SPLASH);
          },
        ),
      ),
    );
  }
}
