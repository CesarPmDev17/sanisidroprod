import 'dart:math' as math;
import 'dart:ui';

import 'package:agora_rtc_engine/rtc_local_view.dart' as rtc_local_view;
import 'package:agora_rtc_engine/rtc_remote_view.dart' as rtc_remote_view;
import 'package:animate_do/animate_do.dart';
import 'package:app_san_isidro/data/models/agora_user_type.dart';
import 'package:app_san_isidro/modules/salud/videocall/salud_videocall_controller.dart';
import 'package:app_san_isidro/modules/salud/videocall/widgets/glass_button.dart';
import 'package:app_san_isidro/themes/ak_ui.dart';
import 'package:app_san_isidro/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SaludVideoCallPage extends StatelessWidget {
  final _conX = Get.put(SaludVideoCallController());

  final buttonColors = Colors.white;

  Widget _buildFocusView() {
    return InkWell(
      onTap: _conX.onFocusViewTap,
      child: _ImproveLayerSurface(
        conX: _conX,
        channelName: _conX.channelName,
        agoraUser: _conX.focusUser,
        isSmall: false,
      ),
    );
  }

  Widget _buildThumbnailsView() {
    final List<AgoraUserGeneric> list = [];

    // Si el focus es un remoto, añado el local a las miniaturas
    if (_conX.focusUser is AgoraUserRemote) {
      // Agrego como primer usuario al localUser
      list.add(AgoraUserLocal());
    }

    for (var user in _conX.remoteUsers) {
      if (_conX.focusUser is AgoraUserRemote) {
        if ((_conX.focusUser as AgoraUserRemote).uid != user.uid) {
          list.add(AgoraUserRemote(user.uid));
        }
      } else {
        list.add(AgoraUserRemote(user.uid));
      }
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          height: 120.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ListView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.all(0),
                reverse: true,
                scrollDirection: Axis.horizontal,
                itemCount: list.length,
                itemBuilder: (c, i) {
                  return InkWell(
                    onTap: () {
                      if (list[i].isRemote) {
                        _conX.asignSpeakerAndRefresh(list[i]);
                      } else {
                        _conX.asignSpeakerAndRefresh(AgoraUserLocal());
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.only(right: i == 0 ? 5.0 : 10.0),
                      decoration: BoxDecoration(
                        border: Border.all(
                            width: 2.0, color: Colors.black.withOpacity(.45)),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Container(
                          width: 80.0,
                          color: Colors.black,
                          child: _ImproveLayerSurface(
                            conX: _conX,
                            channelName: _conX.channelName,
                            agoraUser: list[i],
                            isSmall: true,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        Obx(
          () => AnimatedContainer(
            duration: Duration(milliseconds: 150),
            curve: Curves.fastOutSlowIn,
            height: _conX.showButtons.value ? 100.0 : akContentPadding * 0.5,
            width: 30.0, // Es necesario establecer un width
            color: Colors.transparent,
          ),
        ),
      ],
    );
  }

  Widget _topToolbar() {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(vertical: 48, horizontal: 20),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GetBuilder<SaludVideoCallController>(
                id: _conX.gbDrName,
                builder: (c) {
                  return _conX.focusUser is AgoraUserLocal
                      ? Expanded(child: SizedBox())
                      : Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              AkText(
                                'Dr. / Dra.',
                                style: TextStyle(
                                  color: akWhiteColor.withOpacity(.65),
                                  fontWeight: FontWeight.w300,
                                  fontSize: akFontSize - 1.0,
                                ),
                              ),
                              SizedBox(height: 4.0),
                              AkText(
                                _conX.shortName,
                                style: TextStyle(
                                  color: akWhiteColor,
                                  fontWeight: FontWeight.w500,
                                  fontSize: akFontSize + 4.0,
                                ),
                              ),
                            ],
                          ),
                        );
                }),
            SizedBox(width: 15.0),
            Column(
              children: [
                GlassButton(
                  btnMinSize: 40,
                  child: Icon(
                    Icons.switch_camera_outlined,
                    color: buttonColors,
                  ),
                  onTap: _conX.onSwitchCameraTap,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _bottomToolbar() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.symmetric(vertical: 20),
        margin: EdgeInsets.symmetric(horizontal: akContentPadding * 1.5),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Obx(
              () => GlassButton(
                onTap: _conX.onMutedTap,
                child: Icon(
                  _conX.muted.value ? Icons.mic_off : Icons.mic,
                  color: buttonColors,
                ),
                btnColor: _conX.muted.value ? Color(0xFF0E78F9) : null,
              ),
            ),
            GlassButton(
              onTap: _conX.onCallEndTap,
              btnMinSize: 60.0,
              child: Icon(Icons.call_end, color: buttonColors),
              btnColor: Color(0xFFDE3D3D),
            ),
            Obx(
              () => GlassButton(
                onTap: _conX.onHideCamTap,
                child: Icon(
                  _conX.hidecam.value
                      ? Icons.videocam_off_rounded
                      : Icons.videocam_rounded,
                  color: buttonColors,
                ),
                btnColor: _conX.hidecam.value ? Color(0xFF0E78F9) : null,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _conX.setContext(context);

    return WillPopScope(
      onWillPop: () async => await _conX.handleBack(),
      child: Scaffold(
        backgroundColor: Colors.black,
        body: GetBuilder<SaludVideoCallController>(
          id: _conX.gbScaffold,
          builder: (c) {
            if (!_conX.engineCreated) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SpinLoadingIcon(
                      color: Colors.white,
                    ),
                    SizedBox(height: 15.0),
                    AkText(
                      'Conectando',
                      style: TextStyle(
                        color: akWhiteColor,
                      ),
                    ),
                  ],
                ),
              );
            }
            return Stack(
              children: [
                GetBuilder<SaludVideoCallController>(
                  id: _conX.gbFocus,
                  builder: (c) {
                    return FadeIn(
                      duration: Duration(milliseconds: 800),
                      key: ValueKey('vkGBFocus_${_conX.focusUser.hashCode}'),
                      child: _buildFocusView(),
                    );
                  },
                ),
                GetBuilder<SaludVideoCallController>(
                  id: _conX.gbThumbnails,
                  builder: (c) {
                    return Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeIn(
                            key: ValueKey(
                                'vkGBThumbnails_${_conX.focusUser.hashCode}'),
                            delay: Duration(milliseconds: 800),
                            child: _buildThumbnailsView(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                GetBuilder<SaludVideoCallController>(
                  id: _conX.gbThumbnails,
                  builder: (c) {
                    return Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          FadeIn(
                            key: ValueKey(
                                'vkGBThumbnails_${_conX.focusUser.hashCode}'),
                            delay: Duration(milliseconds: 800),
                            child: _buildThumbnailsView(),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                Obx(
                  () => _conX.showButtons.value ? _topToolbar() : SizedBox(),
                ),
                Obx(
                  () => _conX.showButtons.value ? _bottomToolbar() : SizedBox(),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _ImproveLayerSurface extends StatelessWidget {
  final SaludVideoCallController conX;
  final String channelName;
  final AgoraUserGeneric agoraUser;
  final bool isSmall;
  const _ImproveLayerSurface({
    Key? key,
    required this.conX,
    required this.channelName,
    required this.agoraUser,
    required this.isSmall,
  }) : super(key: key);

  Widget bottomAndTopShadow(double height) {
    Color bgColorShadow = Colors.black;
    Widget viewShadow = Container(
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            bgColorShadow.withOpacity(.70),
            bgColorShadow.withOpacity(.50),
            bgColorShadow.withOpacity(.35),
            bgColorShadow.withOpacity(.10),
            bgColorShadow.withOpacity(0)
          ],
        ),
      ),
    );
    return viewShadow;
  }

  @override
  Widget build(BuildContext context) {
    String gbId = conX.prefixCallStatus;
    if (agoraUser is AgoraUserRemote) {
      gbId += '_${(agoraUser as AgoraUserRemote).uid}';
    } else {
      gbId += '_local';
    }

    return Container(
      child: Stack(
        children: [
          agoraUser is AgoraUserRemote
              ? rtc_remote_view.SurfaceView(
                  uid: (agoraUser as AgoraUserRemote).uid,
                  channelId: channelName,
                )
              : const rtc_local_view.SurfaceView(),
          if (!isSmall)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: bottomAndTopShadow(Get.height * 0.20),
            ),
          if (!isSmall)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Transform.rotate(
                angle: math.pi,
                child: bottomAndTopShadow(Get.height * 0.25),
              ),
            ),
          GetBuilder<SaludVideoCallController>(
              id: gbId,
              builder: (c) {
                bool isMuted = false;
                bool isHideCam = false;
                try {
                  if (agoraUser is AgoraUserRemote) {
                    final rFound = conX.remoteUsers.firstWhere(
                        (r) => r.uid == (agoraUser as AgoraUserRemote).uid);
                    isMuted = rFound.muted;
                    isHideCam = rFound.hidecam;
                  } else if (agoraUser is AgoraUserLocal) {
                    isMuted = conX.muted.value;
                    isHideCam = conX.hidecam.value;
                  }
                } catch (e) {
                  print('error find in gbId');
                }

                String message = '';
                if (!isSmall) {
                  if (isHideCam && isMuted) {
                    message = agoraUser.isRemote
                        ? 'Usuario apagó la cámara y silenció el micrófono'
                        : 'Micrófono y cámara apagados';
                  } else if (isHideCam) {
                    message = agoraUser.isRemote
                        ? 'Usuario apagó su cámara'
                        : 'Cámara apagada';
                  } else if (isMuted) {
                    message = agoraUser.isRemote
                        ? 'Usuario silenció la llamada'
                        : 'Micrófono silenciado';
                  }
                }

                Widget mutedIcon = Icon(
                  Icons.mic_off_rounded,
                  color: Colors.white,
                  size: isSmall ? akFontSize + 3 : akFontSize + 10,
                );

                Widget cameraOffIcon = Icon(
                  Icons.videocam_off_rounded,
                  color: Colors.white,
                  size: isSmall ? akFontSize + 3 : akFontSize + 10,
                );

                Color overlayColor = Colors.transparent;

                if (isHideCam && isMuted || isHideCam) {
                  if (agoraUser.isRemote) {
                    overlayColor = Colors.black.withOpacity(0.50);
                  } else {
                    overlayColor = Colors.black;
                  }
                } else if (isMuted) {
                  overlayColor = Colors.black.withOpacity(0.25);
                }

                Widget bodyStatus = Container(
                  color: overlayColor,
                  child: Container(
                    width: double.infinity,
                    margin: EdgeInsets.symmetric(
                      vertical: isSmall ? 10.0 : 0.0,
                      horizontal: !isSmall ? akContentPadding * 2.50 : 0.0,
                    ),
                    child: Column(
                      mainAxisAlignment: !isSmall
                          ? MainAxisAlignment.center
                          : MainAxisAlignment.start,
                      children: [
                        if (isHideCam && isSmall) cameraOffIcon,
                        if (isSmall) Expanded(child: SizedBox()),
                        if (!isSmall)
                          Column(
                            children: [
                              if (isMuted) mutedIcon,
                              SizedBox(height: 6),
                              AkText(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  color: akWhiteColor.withOpacity(.75),
                                  fontSize: akFontSize + 1.0,
                                  height: 1.4,
                                ),
                              )
                            ],
                          ),
                        if (isMuted && isSmall) mutedIcon,
                      ],
                    ),
                  ),
                );

                return isHideCam || isMuted
                    ? Positioned.fill(
                        child: isHideCam
                            ? BackdropFilter(
                                filter: ImageFilter.blur(
                                    sigmaX: 13.0, sigmaY: 13.0),
                                child: bodyStatus,
                              )
                            : bodyStatus,
                      )
                    : SizedBox();
              }),
        ],
      ),
    );
  }
}
