// Version for Null Safety

part of 'utils.dart';

@freezed
class ApiResult<T> with _$ApiResult<T> {
  const factory ApiResult.success({required T data}) = Success<T>;

  const factory ApiResult.failure({required NetworkExceptions error}) =
      Failure<T>;
}

@freezed
abstract class NetworkExceptions with _$NetworkExceptions {
  const factory NetworkExceptions.requestCancelled() = RequestCancelled;

  const factory NetworkExceptions.unauthorisedRequest() = UnauthorisedRequest;

  const factory NetworkExceptions.badRequest() = BadRequest;

  const factory NetworkExceptions.notFound(String reason) = NotFound;

  const factory NetworkExceptions.methodNotAllowed() = MethodNotAllowed;

  const factory NetworkExceptions.notAcceptable() = NotAcceptable;

  const factory NetworkExceptions.requestTimeout() = RequestTimeout;

  const factory NetworkExceptions.sendTimeout() = SendTimeout;

  const factory NetworkExceptions.conflict() = Conflict;

  const factory NetworkExceptions.internalServerError() = InternalServerError;

  const factory NetworkExceptions.notImplemented() = NotImplemented;

  const factory NetworkExceptions.serviceUnavailable() = ServiceUnavailable;

  const factory NetworkExceptions.noInternetConnection() = NoInternetConnection;

  const factory NetworkExceptions.formatException() = FormatException;

  const factory NetworkExceptions.unableToProcess() = UnableToProcess;

  const factory NetworkExceptions.defaultError(String error) = DefaultError;

  const factory NetworkExceptions.unexpectedError() = UnexpectedError;

  static NetworkExceptions getDioException(error) {
    if (error is Exception) {
      try {
        NetworkExceptions networkExceptions =
            NetworkExceptions.unexpectedError();
        if (error is DioError) {
          switch (error.type) {
            case DioErrorType.cancel:
              networkExceptions = NetworkExceptions.requestCancelled();
              break;
            case DioErrorType.connectTimeout:
              networkExceptions = NetworkExceptions.requestTimeout();
              break;
            case DioErrorType.other:
              networkExceptions = NetworkExceptions.noInternetConnection();
              break;
            case DioErrorType.receiveTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
            case DioErrorType.response:
              switch (error.response?.statusCode) {
                case 400:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 401:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 403:
                  networkExceptions = NetworkExceptions.unauthorisedRequest();
                  break;
                case 404:
                  networkExceptions =
                      NetworkExceptions.notFound("Página no encontrada.");
                  break;
                case 409:
                  networkExceptions = NetworkExceptions.conflict();
                  break;
                case 408:
                  networkExceptions = NetworkExceptions.requestTimeout();
                  break;
                case 500:
                  networkExceptions = NetworkExceptions.internalServerError();
                  break;
                case 503:
                  networkExceptions = NetworkExceptions.serviceUnavailable();
                  break;
                default:
                  var responseCode = error.response?.statusCode;
                  networkExceptions = NetworkExceptions.defaultError(
                    "Received invalid status code: $responseCode",
                  );
              }
              break;
            case DioErrorType.sendTimeout:
              networkExceptions = NetworkExceptions.sendTimeout();
              break;
          }
        } else if (error is SocketException) {
          networkExceptions = NetworkExceptions.noInternetConnection();
        } else {
          networkExceptions = NetworkExceptions.unexpectedError();
        }
        return networkExceptions;
      } on FormatException catch (_) {
        // Helper.printError(e.toString());
        return NetworkExceptions.formatException();
      } catch (_) {
        return NetworkExceptions.unexpectedError();
      }
    } else {
      if (error.toString().contains("is not a subtype of")) {
        return NetworkExceptions.unableToProcess();
      } else {
        return NetworkExceptions.unexpectedError();
      }
    }
  }

  static String getErrorMessage(NetworkExceptions networkExceptions) {
    var errorMessage = "";
    networkExceptions.when(notImplemented: () {
      errorMessage = "No implementado.";
    }, requestCancelled: () {
      errorMessage = "Solicitud cancelada.";
    }, internalServerError: () {
      errorMessage = "Error interno del servidor.";
    }, notFound: (String reason) {
      errorMessage = reason;
    }, serviceUnavailable: () {
      errorMessage = "Servicio no disponible.";
    }, methodNotAllowed: () {
      errorMessage = "Método no permitido.";
    }, badRequest: () {
      errorMessage = "Solicitud mal formada.";
    }, unauthorisedRequest: () {
      errorMessage = "Solicitud no autorizada.";
    }, unexpectedError: () {
      errorMessage = "Ocurrió un error inesperado.";
    }, requestTimeout: () {
      errorMessage = "Excedió el tiempo de espera de la solicitud.";
    }, noInternetConnection: () {
      errorMessage = "No hay conexión a internet.";
    }, conflict: () {
      errorMessage = "Error debido a un conflicto.";
    }, sendTimeout: () {
      errorMessage =
          "Excedió tiempo de espera de envío en conexión con el servidor.";
    }, unableToProcess: () {
      errorMessage = "No se puede procesar la data.";
    }, defaultError: (String error) {
      errorMessage = error;
    }, formatException: () {
      errorMessage = "Ocurrió un error inesperado de formato.";
    }, notAcceptable: () {
      errorMessage = "Inaceptable.";
    });
    return errorMessage;
  }
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

// part of 'api_result.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$ApiResultTearOff {
  const _$ApiResultTearOff();

  Success<T> success<T>({required T data}) {
    return Success<T>(
      data: data,
    );
  }

  Failure<T> failure<T>({required NetworkExceptions error}) {
    return Failure<T>(
      error: error,
    );
  }
}

/// @nodoc
const $ApiResult = _$ApiResultTearOff();

/// @nodoc
mixin _$ApiResult<T> {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(NetworkExceptions error) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(NetworkExceptions error)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResultCopyWith<T, $Res> {
  factory $ApiResultCopyWith(
          ApiResult<T> value, $Res Function(ApiResult<T>) then) =
      _$ApiResultCopyWithImpl<T, $Res>;
}

/// @nodoc
class _$ApiResultCopyWithImpl<T, $Res> implements $ApiResultCopyWith<T, $Res> {
  _$ApiResultCopyWithImpl(this._value, this._then);

  final ApiResult<T> _value;
  // ignore: unused_field
  final $Res Function(ApiResult<T>) _then;
}

/// @nodoc
abstract class $SuccessCopyWith<T, $Res> {
  factory $SuccessCopyWith(Success<T> value, $Res Function(Success<T>) then) =
      _$SuccessCopyWithImpl<T, $Res>;
  $Res call({T data});
}

/// @nodoc
class _$SuccessCopyWithImpl<T, $Res> extends _$ApiResultCopyWithImpl<T, $Res>
    implements $SuccessCopyWith<T, $Res> {
  _$SuccessCopyWithImpl(Success<T> _value, $Res Function(Success<T>) _then)
      : super(_value, (v) => _then(v as Success<T>));

  @override
  Success<T> get _value => super._value as Success<T>;

  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(Success<T>(
      data: data == freezed
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as T,
    ));
  }
}

/// @nodoc
class _$Success<T> implements Success<T> {
  const _$Success({required this.data});

  @override
  final T data;

  @override
  String toString() {
    return 'ApiResult<$T>.success(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Success<T> &&
            (identical(other.data, data) ||
                const DeepCollectionEquality().equals(other.data, data)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(data);

  @JsonKey(ignore: true)
  @override
  $SuccessCopyWith<T, Success<T>> get copyWith =>
      _$SuccessCopyWithImpl<T, Success<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(NetworkExceptions error) failure,
  }) {
    return success(data);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(NetworkExceptions error)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(data);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
  }) {
    return success(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (success != null) {
      return success(this);
    }
    return orElse();
  }
}

abstract class Success<T> implements ApiResult<T> {
  const factory Success({required T data}) = _$Success<T>;

  T get data => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SuccessCopyWith<T, Success<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FailureCopyWith<T, $Res> {
  factory $FailureCopyWith(Failure<T> value, $Res Function(Failure<T>) then) =
      _$FailureCopyWithImpl<T, $Res>;
  $Res call({NetworkExceptions error});

  $NetworkExceptionsCopyWith<$Res> get error;
}

/// @nodoc
class _$FailureCopyWithImpl<T, $Res> extends _$ApiResultCopyWithImpl<T, $Res>
    implements $FailureCopyWith<T, $Res> {
  _$FailureCopyWithImpl(Failure<T> _value, $Res Function(Failure<T>) _then)
      : super(_value, (v) => _then(v as Failure<T>));

  @override
  Failure<T> get _value => super._value as Failure<T>;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(Failure<T>(
      error: error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as NetworkExceptions,
    ));
  }

  @override
  $NetworkExceptionsCopyWith<$Res> get error {
    return $NetworkExceptionsCopyWith<$Res>(_value.error, (value) {
      return _then(_value.copyWith(error: value));
    });
  }
}

/// @nodoc
class _$Failure<T> implements Failure<T> {
  const _$Failure({required this.error});

  @override
  final NetworkExceptions error;

  @override
  String toString() {
    return 'ApiResult<$T>.failure(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is Failure<T> &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $FailureCopyWith<T, Failure<T>> get copyWith =>
      _$FailureCopyWithImpl<T, Failure<T>>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function(T data) success,
    required TResult Function(NetworkExceptions error) failure,
  }) {
    return failure(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function(T data)? success,
    TResult Function(NetworkExceptions error)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(Success<T> value) success,
    required TResult Function(Failure<T> value) failure,
  }) {
    return failure(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(Success<T> value)? success,
    TResult Function(Failure<T> value)? failure,
    required TResult orElse(),
  }) {
    if (failure != null) {
      return failure(this);
    }
    return orElse();
  }
}

abstract class Failure<T> implements ApiResult<T> {
  const factory Failure({required NetworkExceptions error}) = _$Failure<T>;

  NetworkExceptions get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FailureCopyWith<T, Failure<T>> get copyWith =>
      throw _privateConstructorUsedError;
}

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore: duplicate_ignore
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides

// part of 'network_exceptions.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// T _$identity<T>(T value) => value;

// final _privateConstructorUsedError = UnsupportedError(
//    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
class _$NetworkExceptionsTearOff {
  const _$NetworkExceptionsTearOff();

  RequestCancelled requestCancelled() {
    return const RequestCancelled();
  }

  UnauthorisedRequest unauthorisedRequest() {
    return const UnauthorisedRequest();
  }

  BadRequest badRequest() {
    return const BadRequest();
  }

  NotFound notFound(String reason) {
    return NotFound(
      reason,
    );
  }

  MethodNotAllowed methodNotAllowed() {
    return const MethodNotAllowed();
  }

  NotAcceptable notAcceptable() {
    return const NotAcceptable();
  }

  RequestTimeout requestTimeout() {
    return const RequestTimeout();
  }

  SendTimeout sendTimeout() {
    return const SendTimeout();
  }

  Conflict conflict() {
    return const Conflict();
  }

  InternalServerError internalServerError() {
    return const InternalServerError();
  }

  NotImplemented notImplemented() {
    return const NotImplemented();
  }

  ServiceUnavailable serviceUnavailable() {
    return const ServiceUnavailable();
  }

  NoInternetConnection noInternetConnection() {
    return const NoInternetConnection();
  }

  FormatException formatException() {
    return const FormatException();
  }

  UnableToProcess unableToProcess() {
    return const UnableToProcess();
  }

  DefaultError defaultError(String error) {
    return DefaultError(
      error,
    );
  }

  UnexpectedError unexpectedError() {
    return const UnexpectedError();
  }
}

/// @nodoc
const $NetworkExceptions = _$NetworkExceptionsTearOff();

/// @nodoc
mixin _$NetworkExceptions {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NetworkExceptionsCopyWith<$Res> {
  factory $NetworkExceptionsCopyWith(
          NetworkExceptions value, $Res Function(NetworkExceptions) then) =
      _$NetworkExceptionsCopyWithImpl<$Res>;
}

/// @nodoc
class _$NetworkExceptionsCopyWithImpl<$Res>
    implements $NetworkExceptionsCopyWith<$Res> {
  _$NetworkExceptionsCopyWithImpl(this._value, this._then);

  final NetworkExceptions _value;
  // ignore: unused_field
  final $Res Function(NetworkExceptions) _then;
}

/// @nodoc
abstract class $RequestCancelledCopyWith<$Res> {
  factory $RequestCancelledCopyWith(
          RequestCancelled value, $Res Function(RequestCancelled) then) =
      _$RequestCancelledCopyWithImpl<$Res>;
}

/// @nodoc
class _$RequestCancelledCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $RequestCancelledCopyWith<$Res> {
  _$RequestCancelledCopyWithImpl(
      RequestCancelled _value, $Res Function(RequestCancelled) _then)
      : super(_value, (v) => _then(v as RequestCancelled));

  @override
  RequestCancelled get _value => super._value as RequestCancelled;
}

/// @nodoc
class _$RequestCancelled implements RequestCancelled {
  const _$RequestCancelled();

  @override
  String toString() {
    return 'NetworkExceptions.requestCancelled()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RequestCancelled);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return requestCancelled();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (requestCancelled != null) {
      return requestCancelled();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return requestCancelled(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (requestCancelled != null) {
      return requestCancelled(this);
    }
    return orElse();
  }
}

abstract class RequestCancelled implements NetworkExceptions {
  const factory RequestCancelled() = _$RequestCancelled;
}

/// @nodoc
abstract class $UnauthorisedRequestCopyWith<$Res> {
  factory $UnauthorisedRequestCopyWith(
          UnauthorisedRequest value, $Res Function(UnauthorisedRequest) then) =
      _$UnauthorisedRequestCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnauthorisedRequestCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $UnauthorisedRequestCopyWith<$Res> {
  _$UnauthorisedRequestCopyWithImpl(
      UnauthorisedRequest _value, $Res Function(UnauthorisedRequest) _then)
      : super(_value, (v) => _then(v as UnauthorisedRequest));

  @override
  UnauthorisedRequest get _value => super._value as UnauthorisedRequest;
}

/// @nodoc
class _$UnauthorisedRequest implements UnauthorisedRequest {
  const _$UnauthorisedRequest();

  @override
  String toString() {
    return 'NetworkExceptions.unauthorisedRequest()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is UnauthorisedRequest);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return unauthorisedRequest();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (unauthorisedRequest != null) {
      return unauthorisedRequest();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return unauthorisedRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (unauthorisedRequest != null) {
      return unauthorisedRequest(this);
    }
    return orElse();
  }
}

abstract class UnauthorisedRequest implements NetworkExceptions {
  const factory UnauthorisedRequest() = _$UnauthorisedRequest;
}

/// @nodoc
abstract class $BadRequestCopyWith<$Res> {
  factory $BadRequestCopyWith(
          BadRequest value, $Res Function(BadRequest) then) =
      _$BadRequestCopyWithImpl<$Res>;
}

/// @nodoc
class _$BadRequestCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $BadRequestCopyWith<$Res> {
  _$BadRequestCopyWithImpl(BadRequest _value, $Res Function(BadRequest) _then)
      : super(_value, (v) => _then(v as BadRequest));

  @override
  BadRequest get _value => super._value as BadRequest;
}

/// @nodoc
class _$BadRequest implements BadRequest {
  const _$BadRequest();

  @override
  String toString() {
    return 'NetworkExceptions.badRequest()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is BadRequest);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return badRequest();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (badRequest != null) {
      return badRequest();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return badRequest(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (badRequest != null) {
      return badRequest(this);
    }
    return orElse();
  }
}

abstract class BadRequest implements NetworkExceptions {
  const factory BadRequest() = _$BadRequest;
}

/// @nodoc
abstract class $NotFoundCopyWith<$Res> {
  factory $NotFoundCopyWith(NotFound value, $Res Function(NotFound) then) =
      _$NotFoundCopyWithImpl<$Res>;
  $Res call({String reason});
}

/// @nodoc
class _$NotFoundCopyWithImpl<$Res> extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $NotFoundCopyWith<$Res> {
  _$NotFoundCopyWithImpl(NotFound _value, $Res Function(NotFound) _then)
      : super(_value, (v) => _then(v as NotFound));

  @override
  NotFound get _value => super._value as NotFound;

  @override
  $Res call({
    Object? reason = freezed,
  }) {
    return _then(NotFound(
      reason == freezed
          ? _value.reason
          : reason // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$NotFound implements NotFound {
  const _$NotFound(this.reason);

  @override
  final String reason;

  @override
  String toString() {
    return 'NetworkExceptions.notFound(reason: $reason)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is NotFound &&
            (identical(other.reason, reason) ||
                const DeepCollectionEquality().equals(other.reason, reason)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(reason);

  @JsonKey(ignore: true)
  @override
  $NotFoundCopyWith<NotFound> get copyWith =>
      _$NotFoundCopyWithImpl<NotFound>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return notFound(reason);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(reason);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return notFound(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (notFound != null) {
      return notFound(this);
    }
    return orElse();
  }
}

abstract class NotFound implements NetworkExceptions {
  const factory NotFound(String reason) = _$NotFound;

  String get reason => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NotFoundCopyWith<NotFound> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MethodNotAllowedCopyWith<$Res> {
  factory $MethodNotAllowedCopyWith(
          MethodNotAllowed value, $Res Function(MethodNotAllowed) then) =
      _$MethodNotAllowedCopyWithImpl<$Res>;
}

/// @nodoc
class _$MethodNotAllowedCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $MethodNotAllowedCopyWith<$Res> {
  _$MethodNotAllowedCopyWithImpl(
      MethodNotAllowed _value, $Res Function(MethodNotAllowed) _then)
      : super(_value, (v) => _then(v as MethodNotAllowed));

  @override
  MethodNotAllowed get _value => super._value as MethodNotAllowed;
}

/// @nodoc
class _$MethodNotAllowed implements MethodNotAllowed {
  const _$MethodNotAllowed();

  @override
  String toString() {
    return 'NetworkExceptions.methodNotAllowed()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is MethodNotAllowed);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return methodNotAllowed();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (methodNotAllowed != null) {
      return methodNotAllowed();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return methodNotAllowed(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (methodNotAllowed != null) {
      return methodNotAllowed(this);
    }
    return orElse();
  }
}

abstract class MethodNotAllowed implements NetworkExceptions {
  const factory MethodNotAllowed() = _$MethodNotAllowed;
}

/// @nodoc
abstract class $NotAcceptableCopyWith<$Res> {
  factory $NotAcceptableCopyWith(
          NotAcceptable value, $Res Function(NotAcceptable) then) =
      _$NotAcceptableCopyWithImpl<$Res>;
}

/// @nodoc
class _$NotAcceptableCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $NotAcceptableCopyWith<$Res> {
  _$NotAcceptableCopyWithImpl(
      NotAcceptable _value, $Res Function(NotAcceptable) _then)
      : super(_value, (v) => _then(v as NotAcceptable));

  @override
  NotAcceptable get _value => super._value as NotAcceptable;
}

/// @nodoc
class _$NotAcceptable implements NotAcceptable {
  const _$NotAcceptable();

  @override
  String toString() {
    return 'NetworkExceptions.notAcceptable()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NotAcceptable);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return notAcceptable();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (notAcceptable != null) {
      return notAcceptable();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return notAcceptable(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (notAcceptable != null) {
      return notAcceptable(this);
    }
    return orElse();
  }
}

abstract class NotAcceptable implements NetworkExceptions {
  const factory NotAcceptable() = _$NotAcceptable;
}

/// @nodoc
abstract class $RequestTimeoutCopyWith<$Res> {
  factory $RequestTimeoutCopyWith(
          RequestTimeout value, $Res Function(RequestTimeout) then) =
      _$RequestTimeoutCopyWithImpl<$Res>;
}

/// @nodoc
class _$RequestTimeoutCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $RequestTimeoutCopyWith<$Res> {
  _$RequestTimeoutCopyWithImpl(
      RequestTimeout _value, $Res Function(RequestTimeout) _then)
      : super(_value, (v) => _then(v as RequestTimeout));

  @override
  RequestTimeout get _value => super._value as RequestTimeout;
}

/// @nodoc
class _$RequestTimeout implements RequestTimeout {
  const _$RequestTimeout();

  @override
  String toString() {
    return 'NetworkExceptions.requestTimeout()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is RequestTimeout);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return requestTimeout();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (requestTimeout != null) {
      return requestTimeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return requestTimeout(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (requestTimeout != null) {
      return requestTimeout(this);
    }
    return orElse();
  }
}

abstract class RequestTimeout implements NetworkExceptions {
  const factory RequestTimeout() = _$RequestTimeout;
}

/// @nodoc
abstract class $SendTimeoutCopyWith<$Res> {
  factory $SendTimeoutCopyWith(
          SendTimeout value, $Res Function(SendTimeout) then) =
      _$SendTimeoutCopyWithImpl<$Res>;
}

/// @nodoc
class _$SendTimeoutCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $SendTimeoutCopyWith<$Res> {
  _$SendTimeoutCopyWithImpl(
      SendTimeout _value, $Res Function(SendTimeout) _then)
      : super(_value, (v) => _then(v as SendTimeout));

  @override
  SendTimeout get _value => super._value as SendTimeout;
}

/// @nodoc
class _$SendTimeout implements SendTimeout {
  const _$SendTimeout();

  @override
  String toString() {
    return 'NetworkExceptions.sendTimeout()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is SendTimeout);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return sendTimeout();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (sendTimeout != null) {
      return sendTimeout();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return sendTimeout(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (sendTimeout != null) {
      return sendTimeout(this);
    }
    return orElse();
  }
}

abstract class SendTimeout implements NetworkExceptions {
  const factory SendTimeout() = _$SendTimeout;
}

/// @nodoc
abstract class $ConflictCopyWith<$Res> {
  factory $ConflictCopyWith(Conflict value, $Res Function(Conflict) then) =
      _$ConflictCopyWithImpl<$Res>;
}

/// @nodoc
class _$ConflictCopyWithImpl<$Res> extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $ConflictCopyWith<$Res> {
  _$ConflictCopyWithImpl(Conflict _value, $Res Function(Conflict) _then)
      : super(_value, (v) => _then(v as Conflict));

  @override
  Conflict get _value => super._value as Conflict;
}

/// @nodoc
class _$Conflict implements Conflict {
  const _$Conflict();

  @override
  String toString() {
    return 'NetworkExceptions.conflict()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is Conflict);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return conflict();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (conflict != null) {
      return conflict();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return conflict(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (conflict != null) {
      return conflict(this);
    }
    return orElse();
  }
}

abstract class Conflict implements NetworkExceptions {
  const factory Conflict() = _$Conflict;
}

/// @nodoc
abstract class $InternalServerErrorCopyWith<$Res> {
  factory $InternalServerErrorCopyWith(
          InternalServerError value, $Res Function(InternalServerError) then) =
      _$InternalServerErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$InternalServerErrorCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $InternalServerErrorCopyWith<$Res> {
  _$InternalServerErrorCopyWithImpl(
      InternalServerError _value, $Res Function(InternalServerError) _then)
      : super(_value, (v) => _then(v as InternalServerError));

  @override
  InternalServerError get _value => super._value as InternalServerError;
}

/// @nodoc
class _$InternalServerError implements InternalServerError {
  const _$InternalServerError();

  @override
  String toString() {
    return 'NetworkExceptions.internalServerError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is InternalServerError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return internalServerError();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (internalServerError != null) {
      return internalServerError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return internalServerError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (internalServerError != null) {
      return internalServerError(this);
    }
    return orElse();
  }
}

abstract class InternalServerError implements NetworkExceptions {
  const factory InternalServerError() = _$InternalServerError;
}

/// @nodoc
abstract class $NotImplementedCopyWith<$Res> {
  factory $NotImplementedCopyWith(
          NotImplemented value, $Res Function(NotImplemented) then) =
      _$NotImplementedCopyWithImpl<$Res>;
}

/// @nodoc
class _$NotImplementedCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $NotImplementedCopyWith<$Res> {
  _$NotImplementedCopyWithImpl(
      NotImplemented _value, $Res Function(NotImplemented) _then)
      : super(_value, (v) => _then(v as NotImplemented));

  @override
  NotImplemented get _value => super._value as NotImplemented;
}

/// @nodoc
class _$NotImplemented implements NotImplemented {
  const _$NotImplemented();

  @override
  String toString() {
    return 'NetworkExceptions.notImplemented()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NotImplemented);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return notImplemented();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (notImplemented != null) {
      return notImplemented();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return notImplemented(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (notImplemented != null) {
      return notImplemented(this);
    }
    return orElse();
  }
}

abstract class NotImplemented implements NetworkExceptions {
  const factory NotImplemented() = _$NotImplemented;
}

/// @nodoc
abstract class $ServiceUnavailableCopyWith<$Res> {
  factory $ServiceUnavailableCopyWith(
          ServiceUnavailable value, $Res Function(ServiceUnavailable) then) =
      _$ServiceUnavailableCopyWithImpl<$Res>;
}

/// @nodoc
class _$ServiceUnavailableCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $ServiceUnavailableCopyWith<$Res> {
  _$ServiceUnavailableCopyWithImpl(
      ServiceUnavailable _value, $Res Function(ServiceUnavailable) _then)
      : super(_value, (v) => _then(v as ServiceUnavailable));

  @override
  ServiceUnavailable get _value => super._value as ServiceUnavailable;
}

/// @nodoc
class _$ServiceUnavailable implements ServiceUnavailable {
  const _$ServiceUnavailable();

  @override
  String toString() {
    return 'NetworkExceptions.serviceUnavailable()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is ServiceUnavailable);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return serviceUnavailable();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (serviceUnavailable != null) {
      return serviceUnavailable();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return serviceUnavailable(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (serviceUnavailable != null) {
      return serviceUnavailable(this);
    }
    return orElse();
  }
}

abstract class ServiceUnavailable implements NetworkExceptions {
  const factory ServiceUnavailable() = _$ServiceUnavailable;
}

/// @nodoc
abstract class $NoInternetConnectionCopyWith<$Res> {
  factory $NoInternetConnectionCopyWith(NoInternetConnection value,
          $Res Function(NoInternetConnection) then) =
      _$NoInternetConnectionCopyWithImpl<$Res>;
}

/// @nodoc
class _$NoInternetConnectionCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $NoInternetConnectionCopyWith<$Res> {
  _$NoInternetConnectionCopyWithImpl(
      NoInternetConnection _value, $Res Function(NoInternetConnection) _then)
      : super(_value, (v) => _then(v as NoInternetConnection));

  @override
  NoInternetConnection get _value => super._value as NoInternetConnection;
}

/// @nodoc
class _$NoInternetConnection implements NoInternetConnection {
  const _$NoInternetConnection();

  @override
  String toString() {
    return 'NetworkExceptions.noInternetConnection()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is NoInternetConnection);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return noInternetConnection();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (noInternetConnection != null) {
      return noInternetConnection();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return noInternetConnection(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (noInternetConnection != null) {
      return noInternetConnection(this);
    }
    return orElse();
  }
}

abstract class NoInternetConnection implements NetworkExceptions {
  const factory NoInternetConnection() = _$NoInternetConnection;
}

/// @nodoc
abstract class $FormatExceptionCopyWith<$Res> {
  factory $FormatExceptionCopyWith(
          FormatException value, $Res Function(FormatException) then) =
      _$FormatExceptionCopyWithImpl<$Res>;
}

/// @nodoc
class _$FormatExceptionCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $FormatExceptionCopyWith<$Res> {
  _$FormatExceptionCopyWithImpl(
      FormatException _value, $Res Function(FormatException) _then)
      : super(_value, (v) => _then(v as FormatException));

  @override
  FormatException get _value => super._value as FormatException;
}

/// @nodoc
class _$FormatException implements FormatException {
  const _$FormatException();

  @override
  String toString() {
    return 'NetworkExceptions.formatException()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is FormatException);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return formatException();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (formatException != null) {
      return formatException();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return formatException(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (formatException != null) {
      return formatException(this);
    }
    return orElse();
  }
}

abstract class FormatException implements NetworkExceptions {
  const factory FormatException() = _$FormatException;
}

/// @nodoc
abstract class $UnableToProcessCopyWith<$Res> {
  factory $UnableToProcessCopyWith(
          UnableToProcess value, $Res Function(UnableToProcess) then) =
      _$UnableToProcessCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnableToProcessCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $UnableToProcessCopyWith<$Res> {
  _$UnableToProcessCopyWithImpl(
      UnableToProcess _value, $Res Function(UnableToProcess) _then)
      : super(_value, (v) => _then(v as UnableToProcess));

  @override
  UnableToProcess get _value => super._value as UnableToProcess;
}

/// @nodoc
class _$UnableToProcess implements UnableToProcess {
  const _$UnableToProcess();

  @override
  String toString() {
    return 'NetworkExceptions.unableToProcess()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is UnableToProcess);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return unableToProcess();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (unableToProcess != null) {
      return unableToProcess();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return unableToProcess(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (unableToProcess != null) {
      return unableToProcess(this);
    }
    return orElse();
  }
}

abstract class UnableToProcess implements NetworkExceptions {
  const factory UnableToProcess() = _$UnableToProcess;
}

/// @nodoc
abstract class $DefaultErrorCopyWith<$Res> {
  factory $DefaultErrorCopyWith(
          DefaultError value, $Res Function(DefaultError) then) =
      _$DefaultErrorCopyWithImpl<$Res>;
  $Res call({String error});
}

/// @nodoc
class _$DefaultErrorCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $DefaultErrorCopyWith<$Res> {
  _$DefaultErrorCopyWithImpl(
      DefaultError _value, $Res Function(DefaultError) _then)
      : super(_value, (v) => _then(v as DefaultError));

  @override
  DefaultError get _value => super._value as DefaultError;

  @override
  $Res call({
    Object? error = freezed,
  }) {
    return _then(DefaultError(
      error == freezed
          ? _value.error
          : error // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
class _$DefaultError implements DefaultError {
  const _$DefaultError(this.error);

  @override
  final String error;

  @override
  String toString() {
    return 'NetworkExceptions.defaultError(error: $error)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is DefaultError &&
            (identical(other.error, error) ||
                const DeepCollectionEquality().equals(other.error, error)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^ const DeepCollectionEquality().hash(error);

  @JsonKey(ignore: true)
  @override
  $DefaultErrorCopyWith<DefaultError> get copyWith =>
      _$DefaultErrorCopyWithImpl<DefaultError>(this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return defaultError(error);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (defaultError != null) {
      return defaultError(error);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return defaultError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (defaultError != null) {
      return defaultError(this);
    }
    return orElse();
  }
}

abstract class DefaultError implements NetworkExceptions {
  const factory DefaultError(String error) = _$DefaultError;

  String get error => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $DefaultErrorCopyWith<DefaultError> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnexpectedErrorCopyWith<$Res> {
  factory $UnexpectedErrorCopyWith(
          UnexpectedError value, $Res Function(UnexpectedError) then) =
      _$UnexpectedErrorCopyWithImpl<$Res>;
}

/// @nodoc
class _$UnexpectedErrorCopyWithImpl<$Res>
    extends _$NetworkExceptionsCopyWithImpl<$Res>
    implements $UnexpectedErrorCopyWith<$Res> {
  _$UnexpectedErrorCopyWithImpl(
      UnexpectedError _value, $Res Function(UnexpectedError) _then)
      : super(_value, (v) => _then(v as UnexpectedError));

  @override
  UnexpectedError get _value => super._value as UnexpectedError;
}

/// @nodoc
class _$UnexpectedError implements UnexpectedError {
  const _$UnexpectedError();

  @override
  String toString() {
    return 'NetworkExceptions.unexpectedError()';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) || (other is UnexpectedError);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() requestCancelled,
    required TResult Function() unauthorisedRequest,
    required TResult Function() badRequest,
    required TResult Function(String reason) notFound,
    required TResult Function() methodNotAllowed,
    required TResult Function() notAcceptable,
    required TResult Function() requestTimeout,
    required TResult Function() sendTimeout,
    required TResult Function() conflict,
    required TResult Function() internalServerError,
    required TResult Function() notImplemented,
    required TResult Function() serviceUnavailable,
    required TResult Function() noInternetConnection,
    required TResult Function() formatException,
    required TResult Function() unableToProcess,
    required TResult Function(String error) defaultError,
    required TResult Function() unexpectedError,
  }) {
    return unexpectedError();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? requestCancelled,
    TResult Function()? unauthorisedRequest,
    TResult Function()? badRequest,
    TResult Function(String reason)? notFound,
    TResult Function()? methodNotAllowed,
    TResult Function()? notAcceptable,
    TResult Function()? requestTimeout,
    TResult Function()? sendTimeout,
    TResult Function()? conflict,
    TResult Function()? internalServerError,
    TResult Function()? notImplemented,
    TResult Function()? serviceUnavailable,
    TResult Function()? noInternetConnection,
    TResult Function()? formatException,
    TResult Function()? unableToProcess,
    TResult Function(String error)? defaultError,
    TResult Function()? unexpectedError,
    required TResult orElse(),
  }) {
    if (unexpectedError != null) {
      return unexpectedError();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(RequestCancelled value) requestCancelled,
    required TResult Function(UnauthorisedRequest value) unauthorisedRequest,
    required TResult Function(BadRequest value) badRequest,
    required TResult Function(NotFound value) notFound,
    required TResult Function(MethodNotAllowed value) methodNotAllowed,
    required TResult Function(NotAcceptable value) notAcceptable,
    required TResult Function(RequestTimeout value) requestTimeout,
    required TResult Function(SendTimeout value) sendTimeout,
    required TResult Function(Conflict value) conflict,
    required TResult Function(InternalServerError value) internalServerError,
    required TResult Function(NotImplemented value) notImplemented,
    required TResult Function(ServiceUnavailable value) serviceUnavailable,
    required TResult Function(NoInternetConnection value) noInternetConnection,
    required TResult Function(FormatException value) formatException,
    required TResult Function(UnableToProcess value) unableToProcess,
    required TResult Function(DefaultError value) defaultError,
    required TResult Function(UnexpectedError value) unexpectedError,
  }) {
    return unexpectedError(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(RequestCancelled value)? requestCancelled,
    TResult Function(UnauthorisedRequest value)? unauthorisedRequest,
    TResult Function(BadRequest value)? badRequest,
    TResult Function(NotFound value)? notFound,
    TResult Function(MethodNotAllowed value)? methodNotAllowed,
    TResult Function(NotAcceptable value)? notAcceptable,
    TResult Function(RequestTimeout value)? requestTimeout,
    TResult Function(SendTimeout value)? sendTimeout,
    TResult Function(Conflict value)? conflict,
    TResult Function(InternalServerError value)? internalServerError,
    TResult Function(NotImplemented value)? notImplemented,
    TResult Function(ServiceUnavailable value)? serviceUnavailable,
    TResult Function(NoInternetConnection value)? noInternetConnection,
    TResult Function(FormatException value)? formatException,
    TResult Function(UnableToProcess value)? unableToProcess,
    TResult Function(DefaultError value)? defaultError,
    TResult Function(UnexpectedError value)? unexpectedError,
    required TResult orElse(),
  }) {
    if (unexpectedError != null) {
      return unexpectedError(this);
    }
    return orElse();
  }
}

abstract class UnexpectedError implements NetworkExceptions {
  const factory UnexpectedError() = _$UnexpectedError;
}
