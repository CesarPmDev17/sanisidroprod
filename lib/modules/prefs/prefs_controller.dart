import 'dart:convert';

import 'package:app_san_isidro/constants/constants.dart';
import 'package:app_san_isidro/data/models/persona_registrada.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class PrefsController extends GetxController {
  final box = GetStorage();

  // Es la primera vez que abre la aplicación
  bool get firstRun => box.read(K_BOX_FIRSTRUN_KEY) ?? true;
  Future<void> setFirstRun(bool val) async =>
      await box.write(K_BOX_FIRSTRUN_KEY, val);

  // Ya ha visto la intro tabs antes
  bool get introViewed => box.read(K_BOX_INTROVIEWED_KEY) ?? false;
  Future<void> setIntroViewed(bool val) async =>
      await box.write(K_BOX_INTROVIEWED_KEY, val);

  /// Comprueba si el usuario selecciono cualquier tipo de usuario, sin importar si es con/sin registro.
  bool get isLoggedStatus => box.read(K_BOX_ISLOGGEDSTATUS_KEY) ?? false;
  Future<void> setIsLoggedStatus(bool val) async =>
      await box.write(K_BOX_ISLOGGEDSTATUS_KEY, val);

  // Obtiene la persona guardada desde el String en memoria
  PersonaRegistrada? get personaSavedInPhone {
    try {
      final personaEncoded = box.read(K_BOX_PERSONA_KEY);
      if (personaEncoded is String) {
        // print('From prefcontroller');
        // print(personaEncoded);
        final personaDecoded = jsonDecode(personaEncoded);
        final personaInstance = PersonaRegistrada.fromJson(personaDecoded);
        return personaInstance;
      } else {
        Helpers.logger.wtf('Guest User');
        return null;
      }
    } catch (e) {
      Helpers.logger.e(e.toString());
      Helpers.logger.e('No se pudo decodificar el usuario o no hay usuario');
      throw BusinessException(
          'No se pudo decodificar el usuario o no hay usuario');
    }
  }

  Future<void> setPersonaSavedInPhone(PersonaRegistrada? persona) async {
    if (persona != null) {
      final personaJsonString = jsonEncode(persona.toJson());
      await box.write(K_BOX_PERSONA_KEY, personaJsonString);
    } else {
      await box.remove(K_BOX_PERSONA_KEY);
    }
  }

  Future<void> deleteAll() async {
    await box.erase();
  }
}
