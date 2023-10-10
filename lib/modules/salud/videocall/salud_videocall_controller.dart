import 'package:agora_rtc_engine/rtc_engine.dart';
import 'package:app_san_isidro/config/config.dart';
import 'package:app_san_isidro/data/models/agora_user_type.dart';
import 'package:app_san_isidro/data/models/cita.dart';
import 'package:app_san_isidro/modules/salud/videocall/widgets/modal_confirm_close.dart';
import 'package:app_san_isidro/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:permission_handler/permission_handler.dart';

enum ViewType { speaker, gallery }

class SaludVideoCallController extends GetxController {
  late CitaReserva cita;

  String channelName = '';
  String agoraTokenRoom = '';
  // final channelName = 'CitasWeb';

  late RtcEngine _engine;
  late BuildContext _context;

  final viewType = Rx<ViewType>(ViewType.speaker);

  AgoraUserGeneric focusUser = AgoraUserLocal();
  final remoteUsers = <AgoraUserRemote>[];

  final infoStrings = <String>[].obs;

  bool engineCreated = false;
  final gbScaffold = 'gbScaffold';
  final gbFocus = 'gbFocus';
  final gbThumbnails = 'gbThumbnails';
  final gbDrName = 'gbDrName';

  final prefixCallStatus = 'gbCallStatus';

  final showButtons = true.obs;
  final muted = false.obs;
  final hidecam = false.obs;

  final nombreCompleto = '';
  String shortName = '';

  @override
  void onInit() {
    super.onInit();
    _initAgora();

    if (!(Get.arguments is SaludVideoCallArguments)) {
      Helpers.showError('Error recibiendo los argumentos');
      return;
    }

    final arguments = Get.arguments as SaludVideoCallArguments;
    cita = arguments.cita;

    // EVITAR DUPLICACIÓN DE VALIDACIÓN
    if (cita.codsala == null || cita.txttoken == null) {
      Helpers.showError('El doctor aún no ha iniciado a la sala.');
      return;
    }

    channelName = cita.codsala ?? '';
    agoraTokenRoom = cita.txttoken ?? '';

    ever(infoStrings, (t) {
      Helpers.logger.wtf(t);
    });

    try {
      shortName = Helpers.nameFormatCase(nombreCompleto);
      final separate = shortName.split(' ');
      if (separate.length >= 2) {
        shortName = separate[0] + ' ' + separate[1];
      } else {
        shortName = separate[0];
      }
    } catch (e) {
      Helpers.logger.e('No se pudo acortar el nombre');
    }
  }

  @override
  void onClose() {
    super.onClose();
    remoteUsers.clear();
    _destroyEngine();
  }

  void setContext(BuildContext c) {
    this._context = c;
  }

  void _destroyEngine() async {
    await _engine.leaveChannel();
    await _engine.destroy();
  }

  Future<void> _initAgora() async {
    // Retrieve permissions
    await [Permission.microphone, Permission.camera].request();

    // Delay para que el engine no ralentize la navegación a esta página
    await Helpers.sleep(600);

    // Create the engine
    _engine = await RtcEngine.create(Config().agoraAppID);

    // https://github.com/AgoraIO/Agora-Flutter-SDK/issues/374#issuecomment-881836680
    engineCreated = true;
    update([gbScaffold]);

    await _engine.enableVideo();

    _addAgoraEventHandlers();
    VideoEncoderConfiguration configuration = VideoEncoderConfiguration();
    configuration.dimensions = VideoDimensions(width: 1920, height: 1080);
    await _engine.setVideoEncoderConfiguration(configuration);
    await _engine.joinChannel(
      agoraTokenRoom,
      channelName,
      null,
      0,
    );
  }

  void _addAgoraEventHandlers() {
    _engine.setEventHandler(RtcEngineEventHandler(
      error: (code) {
        final info = 'Error: $code';
        infoStrings.add(info);
      },
      joinChannelSuccess: (channel, uid, elapsed) {
        final info = 'Join Channel: $channel, uid: $uid';
        infoStrings.add(info);
      },
      leaveChannel: (state) {
        infoStrings.add('Leave Channel');
        remoteUsers.clear();
      },
      userJoined: (uid, elapsed) {
        final info = 'User Joined: $uid';
        infoStrings.add(info);

        remoteUsers.add(AgoraUserRemote(uid));
        // Si el speaker es local, se asignará el primer usuario remoto
        if (focusUser is AgoraUserLocal) {
          asignSpeakerAndRefresh(
              AgoraUserRemote(uid)); // crear un objeto y añadir
        } else {
          // Aquí, ya existe un usuario remoto;
          _refreshThumbnails();
        }
      },
      userOffline: (uid, elapsed) {
        final info = 'User Offline: $uid';
        infoStrings.add(info);
        remoteUsers.removeWhere((r) => r.uid == uid);

        // Valida si el focusUser es remoto y salió de la sala
        if (focusUser is AgoraUserRemote &&
            uid == (focusUser as AgoraUserRemote).uid) {
          // Busca si hay otros usuarios remotos disponibles
          // Si lo hay, toma el primero y lo pone como focusUser(pantalla grande)
          if (remoteUsers.isNotEmpty) {
            asignSpeakerAndRefresh(remoteUsers.first);
          } else {
            // Si no hay usuarios remotos, pone al local como focus.
            asignSpeakerAndRefresh(AgoraUserLocal());
          }
        } else {
          // Si se retira un remoto que no es focus
          // solo refresco la lista de thumbnails
          _refreshThumbnails();
        }
      },
      userMuteVideo: (uid, muted) {
        try {
          final rFound = remoteUsers.firstWhere((r) => r.uid == uid);
          rFound.setHideCam(muted);
          update(['${prefixCallStatus}_${rFound.uid}']);
        } catch (e) {
          print('No se encontró el usuario remoto');
        }
      },
      userMuteAudio: (uid, muted) {
        try {
          final rFound = remoteUsers.firstWhere((r) => r.uid == uid);
          rFound.setMuted(muted);
          update(['${prefixCallStatus}_${rFound.uid}']);
        } catch (e) {
          print('No se encontró el usuario remoto');
        }
      },
      firstRemoteVideoFrame: (uid, width, height, elapsed) {
        final info = 'First Remote Video: $uid ${width}x$height';
        infoStrings.add(info);
      },
    ));
  }

  void onBackTap() {
    onCallEndTap();
  }

  void asignSpeakerAndRefresh(AgoraUserGeneric type) {
    focusUser = type;
    _refreshViews();
  }

  void _refreshViews() async {
    update([gbFocus, gbThumbnails, gbDrName]);
  }

  void _refreshThumbnails() {
    update([gbThumbnails]);
  }

  //****** ACTIONS *********/
  void onMutedTap() {
    muted.value = !muted.value;
    _engine.muteLocalAudioStream(muted.value);
    update(['${prefixCallStatus}_local']);
  }

  void onHideCamTap() {
    hidecam.value = !hidecam.value;
    _engine.muteLocalVideoStream(hidecam.value);
    update(['${prefixCallStatus}_local']);
  }

  void onSwitchCameraTap() {
    _engine.switchCamera();
  }

  void onFocusViewTap() {
    showButtons.value = !showButtons.value;
  }

  Future<bool> showConfirmClose() async {
    final closeVideoCall = await showDialog(
      context: _context,
      useSafeArea: true,
      barrierColor: Colors.black.withOpacity(0),
      barrierDismissible: false,
      builder: (_) {
        return ModalConfirmClose();
      },
    );
    return closeVideoCall == true;
  }

  Future<void> onCallEndTap() async {
    if (await showConfirmClose()) {
      Get.back();
    }
  }

  Future<bool> handleBack() async {
    if (engineCreated) {
      return await showConfirmClose();
    }
    return true;
  }
}

class SaludVideoCallArguments {
  final CitaReserva cita;

  SaludVideoCallArguments(this.cita);
}
