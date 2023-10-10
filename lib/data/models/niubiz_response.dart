// To parse this JSON data, do
//
//     final niubizSuccessResponse = niubizSuccessResponseFromJson(jsonString);

import 'dart:convert';

NiubizSuccessResponse niubizSuccessResponseFromJson(String str) =>
    NiubizSuccessResponse.fromJson(json.decode(str));

String niubizSuccessResponseToJson(NiubizSuccessResponse data) =>
    json.encode(data.toJson());

class NiubizSuccessResponse {
  NiubizSuccessResponse({
    required this.header,
    required this.order,
    required this.dataMap,
  });

  final Header header;
  final Order order;
  final DataMap dataMap;

  factory NiubizSuccessResponse.fromJson(Map<String, dynamic> json) =>
      NiubizSuccessResponse(
        header: Header.fromJson(json["header"]),
        order: Order.fromJson(json["order"]),
        dataMap: DataMap.fromJson(json["dataMap"]),
      );

  Map<String, dynamic> toJson() => {
        "header": header.toJson(),
        "order": order.toJson(),
        "dataMap": dataMap.toJson(),
      };
}

class DataMap {
  DataMap({
    required this.terminal,
    required this.brandActionCode,
    required this.brandHostDateTime,
    required this.traceNumber,
    required this.cardType,
    required this.eciDescription,
    required this.signature,
    required this.card,
    required this.merchant,
    required this.status,
    required this.actionDescription,
    required this.idUnico,
    required this.amount,
    required this.brandHostId,
    required this.authorizationCode,
    required this.yapeId,
    required this.currency,
    required this.transactionDate,
    required this.actionCode,
    required this.eci,
    required this.idResolutor,
    required this.brand,
    required this.adquirente,
    required this.brandName,
    required this.processCode,
    required this.transactionId,
  });

  final String terminal;
  final String brandActionCode;
  final String brandHostDateTime;
  final String traceNumber;
  final String cardType;
  final String eciDescription;
  final String signature;
  final String card;
  final String merchant;
  final String status;
  final String actionDescription;
  final String idUnico;
  final String amount;
  final String brandHostId;
  final String authorizationCode;
  final String yapeId;
  final String currency;
  final String transactionDate;
  final String actionCode;
  final String eci;
  final String idResolutor;
  final String brand;
  final String adquirente;
  final String brandName;
  final String processCode;
  final String transactionId;

  // Aquí sí gestiomos los null ya que en su documentación no dicen si los campos son nullables.
  factory DataMap.fromJson(Map<String, dynamic> json) => DataMap(
        terminal: json["TERMINAL"] ?? '',
        brandActionCode: json["BRAND_ACTION_CODE"] ?? '',
        brandHostDateTime: json["BRAND_HOST_DATE_TIME"] ?? '',
        traceNumber: json["TRACE_NUMBER"] ?? '',
        cardType: json["CARD_TYPE"] ?? '',
        eciDescription: json["ECI_DESCRIPTION"] ?? '',
        signature: json["SIGNATURE"] ?? '',
        card: json["CARD"] ?? '',
        merchant: json["MERCHANT"] ?? '',
        status: json["STATUS"] ?? '',
        actionDescription: json["ACTION_DESCRIPTION"] ?? '',
        idUnico: json["ID_UNICO"] ?? '',
        amount: json["AMOUNT"] ?? '',
        brandHostId: json["BRAND_HOST_ID"] ?? '',
        authorizationCode: json["AUTHORIZATION_CODE"] ?? '',
        yapeId: json["YAPE_ID"] ?? '',
        currency: json["CURRENCY"] ?? '',
        transactionDate: json["TRANSACTION_DATE"] ?? '',
        actionCode: json["ACTION_CODE"] ?? '',
        eci: json["ECI"] ?? '',
        idResolutor: json["ID_RESOLUTOR"] ?? '',
        brand: json["BRAND"] ?? '',
        adquirente: json["ADQUIRENTE"] ?? '',
        brandName: json["BRAND_NAME"] ?? '',
        processCode: json["PROCESS_CODE"] ?? '',
        transactionId: json["TRANSACTION_ID"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "TERMINAL": terminal,
        "BRAND_ACTION_CODE": brandActionCode,
        "BRAND_HOST_DATE_TIME": brandHostDateTime,
        "TRACE_NUMBER": traceNumber,
        "CARD_TYPE": cardType,
        "ECI_DESCRIPTION": eciDescription,
        "SIGNATURE": signature,
        "CARD": card,
        "MERCHANT": merchant,
        "STATUS": status,
        "ACTION_DESCRIPTION": actionDescription,
        "ID_UNICO": idUnico,
        "AMOUNT": amount,
        "BRAND_HOST_ID": brandHostId,
        "AUTHORIZATION_CODE": authorizationCode,
        "YAPE_ID": yapeId,
        "CURRENCY": currency,
        "TRANSACTION_DATE": transactionDate,
        "ACTION_CODE": actionCode,
        "ECI": eci,
        "ID_RESOLUTOR": idResolutor,
        "BRAND": brand,
        "ADQUIRENTE": adquirente,
        "BRAND_NAME": brandName,
        "PROCESS_CODE": processCode,
        "TRANSACTION_ID": transactionId,
      };
}

class Header {
  Header({
    required this.ecoreTransactionUuid,
    required this.ecoreTransactionDate,
    required this.millis,
  });

  final String ecoreTransactionUuid;
  final int ecoreTransactionDate;
  final int millis;

  // Evitamos gestionar el null para asegurarnos que Niubiz esté enviando
  // una respuesta según su documentación
  factory Header.fromJson(Map<String, dynamic> json) => Header(
        ecoreTransactionUuid: json["ecoreTransactionUUID"],
        ecoreTransactionDate: json["ecoreTransactionDate"],
        millis: json["millis"],
      );

  Map<String, dynamic> toJson() => {
        "ecoreTransactionUUID": ecoreTransactionUuid,
        "ecoreTransactionDate": ecoreTransactionDate,
        "millis": millis,
      };
}

class Order {
  Order({
    required this.tokenId,
    required this.purchaseNumber,
    required this.amount,
    required this.installment,
    required this.currency,
    required this.authorizedAmount,
    required this.authorizationCode,
    required this.actionCode,
    required this.traceNumber,
    required this.transactionDate,
    required this.transactionId,
  });

  final String tokenId;
  final String purchaseNumber;
  final String
      amount; // Como a veces se recibe un int o double. mejor lo seteamos a String
  final String installment;
  final String currency;
  final String
      authorizedAmount; // Como a veces se recibe un int o double. mejor lo seteamos a String
  final String authorizationCode;
  final String actionCode;
  final String traceNumber;
  final String transactionDate;
  final String transactionId;

  // Aquí sí gestiomos los null ya que en su documentación no dicen si los campos son nullables.
  factory Order.fromJson(Map<String, dynamic> json) => Order(
        tokenId: json["tokenId"] ?? '',
        purchaseNumber: json["purchaseNumber"] ?? '',
        amount: (json["amount"] ?? '').toString(),
        installment: (json["installment"] ?? '').toString(),
        currency: json["currency"] ?? '',
        authorizedAmount: (json["authorizedAmount"] ?? '').toString(),
        authorizationCode: json["authorizationCode"] ?? '',
        actionCode: json["actionCode"] ?? '',
        traceNumber: json["traceNumber"] ?? '',
        transactionDate: json["transactionDate"] ?? '',
        transactionId: json["transactionId"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "tokenId": tokenId,
        "purchaseNumber": purchaseNumber,
        "amount": amount,
        "installment": installment,
        "currency": currency,
        "authorizedAmount": authorizedAmount,
        "authorizationCode": authorizationCode,
        "actionCode": actionCode,
        "traceNumber": traceNumber,
        "transactionDate": transactionDate,
        "transactionId": transactionId,
      };
}

// To parse this JSON data, do
//
//     final niubizErrorResponse = niubizErrorResponseFromJson(jsonString);

NiubizErrorResponse niubizErrorResponseFromJson(String str) =>
    NiubizErrorResponse.fromJson(json.decode(str));

String niubizErrorResponseToJson(NiubizErrorResponse data) =>
    json.encode(data.toJson());

class NiubizErrorResponse {
  NiubizErrorResponse({
    required this.errorCode,
    required this.errorMessage,
    required this.header,
    required this.data,
  });

  final int errorCode;
  final String errorMessage;
  final Header header;
  final Data data;

  factory NiubizErrorResponse.fromJson(Map<String, dynamic> json) =>
      NiubizErrorResponse(
        errorCode: json["errorCode"],
        errorMessage: json["errorMessage"],
        header: Header.fromJson(json["header"]),
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorMessage": errorMessage,
        "header": header.toJson(),
        "data": data.toJson(),
      };
}

class Data {
  Data({
    required this.yapeId,
    required this.currency,
    required this.terminal,
    required this.transactionDate,
    required this.actionCode,
    required this.traceNumber,
    required this.cardType,
    required this.eciDescription,
    required this.eci,
    required this.signature,
    required this.card,
    required this.merchant,
    required this.brand,
    required this.status,
    required this.actionDescription,
    required this.adquirente,
    required this.idUnico,
    required this.amount,
    required this.processCode,
    required this.transactionId,
  });

  final String yapeId;
  final String currency;
  final String terminal;
  final String transactionDate;
  final String actionCode;
  final String traceNumber;
  final String cardType;
  final String eciDescription;
  final String eci;
  final String signature;
  final String card;
  final String merchant;
  final String brand;
  final String status;
  final String actionDescription;
  final String adquirente;
  final String idUnico;
  final String amount;
  final String processCode;
  final String transactionId;

  // Aquí sí gestiomos los null ya que en su documentación no dicen si los campos son nullables.
  factory Data.fromJson(Map<String, dynamic> json) => Data(
        yapeId: json["YAPE_ID"] ?? '',
        currency: json["CURRENCY"] ?? '',
        terminal: json["TERMINAL"] ?? '',
        transactionDate: json["TRANSACTION_DATE"] ?? '',
        actionCode: json["ACTION_CODE"] ?? '',
        traceNumber: json["TRACE_NUMBER"] ?? '',
        cardType: json["CARD_TYPE"] ?? '',
        eciDescription: json["ECI_DESCRIPTION"] ?? '',
        eci: json["ECI"] ?? '',
        signature: json["SIGNATURE"] ?? '',
        card: json["CARD"] ?? '',
        merchant: json["MERCHANT"] ?? '',
        brand: json["BRAND"] ?? '',
        status: json["STATUS"] ?? '',
        actionDescription: json["ACTION_DESCRIPTION"] ?? '',
        adquirente: json["ADQUIRENTE"] ?? '',
        idUnico: json["ID_UNICO"] ?? '',
        amount: json["AMOUNT"] ?? '',
        processCode: json["PROCESS_CODE"] ?? '',
        transactionId: json["TRANSACTION_ID"] ?? '',
      );

  Map<String, dynamic> toJson() => {
        "YAPE_ID": yapeId,
        "CURRENCY": currency,
        "TERMINAL": terminal,
        "TRANSACTION_DATE": transactionDate,
        "ACTION_CODE": actionCode,
        "TRACE_NUMBER": traceNumber,
        "CARD_TYPE": cardType,
        "ECI_DESCRIPTION": eciDescription,
        "ECI": eci,
        "SIGNATURE": signature,
        "CARD": card,
        "MERCHANT": merchant,
        "BRAND": brand,
        "STATUS": status,
        "ACTION_DESCRIPTION": actionDescription,
        "ADQUIRENTE": adquirente,
        "ID_UNICO": idUnico,
        "AMOUNT": amount,
        "PROCESS_CODE": processCode,
        "TRANSACTION_ID": transactionId,
      };
}
