part of 'widgets.dart';
/* 
/// A widget to display the upgrade card.
class AppUpgradeCard extends UpgradeBase {
  /// The empty space that surrounds the card.
  ///
  /// The default margin is 4.0 logical pixels on all sides:
  /// `EdgeInsets.all(4.0)`.
  final EdgeInsetsGeometry margin;

  AppUpgradeCard({
    this.margin = const EdgeInsets.all(4.0),
    Key? key,
    AppcastConfiguration? appcastConfig,
    UpgraderMessages? messages,
    bool? debugAlwaysUpgrade,
    bool? debugDisplayOnce,
    bool? debugLogging,
    Duration? durationToAlertAgain,
    BoolCallback? onIgnore,
    BoolCallback? onLater,
    BoolCallback? onUpdate,
    http.Client? client,
    bool? showIgnore,
    bool? showLater,
    bool? showReleaseNotes,
    String? countryCode,
    String? minAppVersion,
  }) : super(
          key: key,
          appcastConfig: appcastConfig,
          messages: messages,
          debugDisplayAlways: debugAlwaysUpgrade,
          debugDisplayOnce: debugDisplayOnce,
          debugLogging: debugLogging,
          durationToAlertAgain: durationToAlertAgain,
          onIgnore: onIgnore,
          onLater: onLater,
          onUpdate: onUpdate,
          client: client,
          showIgnore: showIgnore,
          showLater: showLater,
          showReleaseNotes: showReleaseNotes,
          countryCode: countryCode,
          minAppVersion: minAppVersion,
        );

  @override
  Widget build(BuildContext context, UpgradeBaseState state) {
    if (Upgrader().debugLogging) {
      print('UpgradeCard: build UpgradeCard');
    }

    return FutureBuilder(
        future: state.initialized,
        builder: (BuildContext context, AsyncSnapshot<bool> processed) {
          if (processed.connectionState == ConnectionState.done &&
              processed.data != null &&
              processed.data!) {
            assert(Upgrader().messages != null);
            if (Upgrader().shouldDisplayUpgrade()) {
              final title = Upgrader().messages!.message(UpgraderMessage.title);
              final message = Upgrader().message();
              final releaseNotes = Upgrader().releaseNotes;
              final shouldDisplayReleaseNotes =
                  Upgrader().shouldDisplayReleaseNotes();
              if (Upgrader().debugLogging) {
                print('UpgradeCard: will display');
                print('UpgradeCard: showDialog title: $title');
                print('UpgradeCard: showDialog message: $message');
                print(
                    'UpgradeCard: shouldDisplayReleaseNotes: $shouldDisplayReleaseNotes');

                print('UpgradeCard: showDialog releaseNotes: $releaseNotes');
              }

              return Positioned.fill(
                child: FadeIn(
                  delay: Duration(seconds: 1),
                  child: Container(
                    color: akScaffoldBackgroundColor,
                    child: Center(
                      child: SingleChildScrollView(
                        physics: BouncingScrollPhysics(),
                        child: Content(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 30.0),
                              Opacity(
                                opacity: 1,
                                child: _IconUpdate(
                                  size: Get.width * 0.70,
                                ),
                              ),
                              SizedBox(height: 45.0),
                              AkText(
                                'Una nueva versión\nestá disponible!',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: akFontSize + 5.0,
                                  color: akTitleColor,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              SizedBox(height: 15.0),
                              AkText(
                                message,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: akFontSize,
                                  color: akTextColor,
                                  height: akFontSize * 0.11,
                                ),
                              ),
                              SizedBox(height: 20.0),
                              _MainButtonApp(
                                context: context,
                                state: state,
                                onTap: () {
                                  _onUpdateTap(context, state);
                                },
                              ),
                              if (Upgrader().showLater)
                                _SecondaryButtonApp(
                                  text: Upgrader().messages!.message(
                                          UpgraderMessage.buttonTitleLater) ??
                                      '',
                                  context: context,
                                  state: state,
                                  onTap: () {
                                    _onLaterTap(context, state);
                                  },
                                ),
                              if (Upgrader().showIgnore)
                                _SecondaryButtonApp(
                                  text: Upgrader().messages!.message(
                                          UpgraderMessage.buttonTitleIgnore) ??
                                      '',
                                  context: context,
                                  state: state,
                                  onTap: () {
                                    _onIgnoreTap(context, state);
                                  },
                                ),
                              SizedBox(height: 20.0),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            } else {
              if (Upgrader().debugLogging) {
                print('UpgradeCard: will not display');
              }
            }
          }
          return const SizedBox(width: 0.0, height: 0.0);
        });
  }

  void _onUpdateTap(BuildContext context, UpgradeBaseState state) {
    // Save the date/time as the last time alerted.
    Upgrader().saveLastAlerted();

    Upgrader().onUserUpdated(context, false);
    state.forceUpdateState();
  }

  void _onLaterTap(BuildContext context, UpgradeBaseState state) {
    // Save the date/time as the last time alerted.
    Upgrader().saveLastAlerted();

    Upgrader().onUserLater(context, false);
    state.forceUpdateState();
  }

  void _onIgnoreTap(BuildContext context, UpgradeBaseState state) {
    // Save the date/time as the last time alerted.
    Upgrader().saveLastAlerted();

    Upgrader().onUserIgnored(context, false);
    state.forceUpdateState();
  }
}

class _MainButtonApp extends StatelessWidget {
  final BuildContext context;
  final UpgradeBaseState state;
  final VoidCallback? onTap;

  const _MainButtonApp(
      {Key? key, required this.context, required this.state, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AkButton(
      onPressed: () {
        onTap?.call();
      },
      contentPadding: EdgeInsets.symmetric(
        horizontal: akFontSize * 3,
        vertical: akFontSize,
      ),
      text: 'Actualizar',
    );
  }
}

class _SecondaryButtonApp extends StatelessWidget {
  final BuildContext context;
  final UpgradeBaseState state;
  final VoidCallback? onTap;
  final String text;

  const _SecondaryButtonApp(
      {Key? key,
      required this.context,
      required this.state,
      this.onTap,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        borderRadius: BorderRadius.circular(20.0),
        onTap: () {
          onTap?.call();
        },
        child: Container(
          padding: EdgeInsets.symmetric(
            horizontal: akFontSize * 2.8,
            vertical: akFontSize * 0.9,
          ),
          child: AkText(
            text,
            style: TextStyle(
              fontSize: akFontSize + 1.0,
              color: akPrimaryColor,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class MySpanishMessages extends UpgraderMessages {
  /// Override the message function to provide custom language localization.
  @override
  String? message(UpgraderMessage messageKey) {
    if (languageCode == 'es') {
      switch (messageKey) {
        case UpgraderMessage.body:
          return 'La versión {{currentAppStoreVersion}} ya está disponible.\nUsted tiene {{currentInstalledVersion}}.';
        case UpgraderMessage.buttonTitleIgnore:
          return 'Ignorar';
        case UpgraderMessage.buttonTitleLater:
          return 'Más tarde';
        case UpgraderMessage.buttonTitleUpdate:
          return 'Actualizar';
        case UpgraderMessage.prompt:
          return '¿Desea actualizar ahora?';
        case UpgraderMessage.title:
          return 'Versión disponible';
      }
    }
    // Messages that are not provided above can still use the default values.
    return super.message(messageKey);
  }
}

class _IconUpdate extends StatelessWidget {
  final double size;

  const _IconUpdate({this.size = 100.0});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: size,
          height: size * 0.75,
        ),
        Positioned.fill(
          child: SvgPicture.asset(
            'assets/icons/update_bg.svg',
            color: Color(0xFFE1E1E2).withOpacity(0.65),
          ),
        ),
        Positioned(
          top: size * 0.60,
          left: size * 0.46,
          child: SvgPicture.asset(
            'assets/icons/update_shadow.svg',
            color: akPrimaryColor,
            width: size * 0.225,
          ),
        ),
        Positioned(
          top: size * 0.565,
          left: size * 0.35,
          child: SvgPicture.asset(
            'assets/icons/update_box.svg',
            color: Helpers.lighten(akPrimaryColor),
            width: size * 0.38,
          ),
        ),
        Positioned(
          top: size * 0.25,
          left: size * 0.35,
          child: SvgPicture.asset(
            'assets/icons/update_top.svg',
            color: akAccentColor,
            width: size * 0.35,
          ),
        ),
        Positioned(
          top: size * 0.365,
          left: size * 0.48,
          child: SvgPicture.asset(
            'assets/icons/update_mid.svg',
            width: size * 0.11,
            color: akScaffoldBackgroundColor,
          ),
        ),
      ],
    );
  }
}
 */