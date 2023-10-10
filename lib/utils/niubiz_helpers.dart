part of 'utils.dart';

class NiubizHelpers {
  static String? errorMessageFromCode(String actionCode) {
    String? msg;
    if (actionCode == '101') {
      msg =
          'Operación Denegada. Tarjeta Vencida. Verifique los datos en su tarjeta e ingréselos correctamente.';
    } else if (actionCode == '102') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '104') {
      msg =
          'Operación Denegada. Operación no permitida para esta tarjeta. Contactar con la entidad emisora de su tarjeta.';
    } else if (actionCode == '106') {
      msg =
          'Operación Denegada. Intentos de clave secreta excedidos. Contactar con la entidad emisora de su tarjeta.';
    } else if (actionCode == '107') {
      msg =
          'Operación Denegada. Contactar con la entidad emisora de su tarjeta.';
    } else if (actionCode == '108') {
      msg =
          'Operación Denegada. Contactar con la entidad emisora de su tarjeta.';
    } else if (actionCode == '109') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '110') {
      msg =
          'Operación Denegada. Operación no permitida para esta tarjeta. Contactar con la entidad emisora de su tarjeta.';
    } else if (actionCode == '111') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '112') {
      msg = 'Operación Denegada. Se requiere clave secreta.';
    } else if (actionCode == '116') {
      msg =
          'Operación Denegada. Fondos insuficientes. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '117') {
      msg = 'Operación Denegada. Clave secreta incorrecta.';
    } else if (actionCode == '118') {
      msg =
          'Operación Denegada. Tarjeta Inválida. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '119') {
      msg =
          'Operación Denegada. Intentos de clave secreta excedidos. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '121') {
      msg = 'Operación Denegada. Clave secreta inválida.';
    } else if (actionCode == '129') {
      msg =
          'Operación Denegada. Código de seguridad invalido. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '180') {
      msg =
          'Operación Denegada. Tarjeta Inválida. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '181') {
      msg =
          'Operación Denegada. Tarjeta con restricciones de débito. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '182') {
      msg =
          'Operación Denegada. Tarjeta con restricciones de crédito. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '183') {
      msg = 'Operación Denegada. Problemas de comunicación. Intente más tarde.';
    } else if (actionCode == '190') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '191') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '192') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '199') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '201') {
      msg =
          'Operación Denegada. Tarjeta vencida. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '202') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '204') {
      msg =
          'Operación Denegada. Operación no permitida para esta tarjeta. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '206') {
      msg =
          'Operación Denegada. Intentos de clave secreta excedidos. Contactar con la entidad emisora de su tarjeta.';
    } else if (actionCode == '207') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '208') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '209') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '263') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '264') {
      msg =
          'Operación Denegada. Entidad emisora de la tarjeta no está disponible para realizar la autenticación.';
    } else if (actionCode == '265') {
      msg =
          'Operación Denegada. Clave secreta del tarjetahabiente incorrecta. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '266') {
      msg =
          'Operación Denegada. Tarjeta Vencida. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '280') {
      msg =
          'Operación Denegada. Clave secreta errónea. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '290') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '300') {
      msg =
          'Operación Denegada. Número de pedido del comercio duplicado. Favor no atender.';
    } else if (actionCode == '306') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '401') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '402') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '403') {
      msg = 'Operación Denegada. Tarjeta no autenticada.';
    } else if (actionCode == '404') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '405') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '406') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '407') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '408') {
      msg =
          'Operación Denegada. Código de seguridad no coincide. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '409') {
      msg =
          'Operación Denegada. Código de seguridad no procesado por la entidad emisora de la tarjeta.';
    } else if (actionCode == '410') {
      msg = 'Operación Denegada. Código de seguridad no ingresado.';
    } else if (actionCode == '411') {
      msg =
          'Operación Denegada. Código de seguridad no procesado por la entidad emisora de la tarjeta.';
    } else if (actionCode == '412') {
      msg =
          'Operación Denegada. Código de seguridad no reconocido por la entidad emisora de la tarjeta.';
    } else if (actionCode == '413') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '414') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '415') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '416') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '417') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '418') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '419') {
      msg = 'Operación Denegada. Tarjeta no es VISA.';
    } else if (actionCode == '421') {
      msg = 'Operación Denegada. Contactar con entidad emisora de su tarjeta.';
    } else if (actionCode == '422') {
      msg =
          'Operación Denegada. El comercio no está configurado para usar este medio de pago. Contactar con el comercio.';
    } else if (actionCode == '423') {
      msg = 'Operación Denegada. Se canceló el proceso de pago.';
    } else if (actionCode == '424') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '666') {
      msg = 'Operación Denegada. Problemas de comunicación. Intente más tarde.';
    } else if (actionCode == '667') {
      msg =
          'Operación Denegada. Transacción sin respuesta de Verified by Visa.';
    } else if (actionCode == '668') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '669') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '670') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '672') {
      msg = 'Operación Denegada. Módulo antifraude.';
    } else if (actionCode == '673') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '674') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '675') {
      msg = 'Inicialización de transacción.';
    } else if (actionCode == '676') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '677') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '678') {
      msg = 'Operación Denegada. Contactar con el comercio.';
    } else if (actionCode == '682') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '683') {
      msg = 'Operación Denegada. Registro incorrecto de sesión.';
    } else if (actionCode == '684') {
      msg = 'Operación Denegada Registro Incorrecto Antifraude.';
    } else if (actionCode == '685') {
      msg = 'Operación Denegada Registro Incorrecto Autorizador.';
    } else if (actionCode == '904') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '909') {
      msg = 'Operación Denegada. Problemas de comunicación. Intente más tarde.';
    } else if (actionCode == '910') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '912') {
      msg = 'Operación Denegada. Entidad emisora de la tarjeta no disponible.';
    } else if (actionCode == '913') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '916') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '928') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '940') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '941') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '942') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '943') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '945') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '946') {
      msg = 'Operación Denegada. Operación de anulación en proceso.';
    } else if (actionCode == '947') {
      msg = 'Operación Denegada. Problemas de comunicación. Intente más tarde.';
    } else if (actionCode == '948') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '949') {
      msg = 'Operación Denegada.';
    } else if (actionCode == '965') {
      msg = 'Operación Denegada.';
    }

    return msg;
  }
}
