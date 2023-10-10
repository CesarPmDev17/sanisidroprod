class Config {
  Config._internal();
  static final Config _singleton = Config._internal();
  factory Config() {
    return _singleton;
  }

  void initialize({
    required bool isProduction,
    required String urlAPI,
    required String urlAPIQA,
    required String urlAPICitas,
    required String urlPasarela,
    required String urlAmbulancia,
    //
    required String youtuApiKey,

    //
    required String agoraAppID,

    //
    required String urlCanchaGimnasio,
  }) {
    this.isProduction = isProduction;
    this.urlAPI = urlAPI;
    this.urlAPIQA = urlAPIQA;
    this.urlAPICitas = urlAPICitas;
    this.urlPasarela = urlPasarela;
    this.urlAmbulancia = urlAmbulancia;

    this.youtuApiKey = youtuApiKey;

    this.agoraAppID = agoraAppID;

    this.urlCanchaGimnasio = urlCanchaGimnasio;
  }

  late final bool isProduction;
  late final String urlAPI;
  late final String urlAPIQA;
  late final String urlAPICitas;
  late final String urlPasarela;
  late final String urlAmbulancia;

  // Youtube
  final String urlYoutubeApi = 'https://www.googleapis.com/youtube/v3';
  late final String youtuApiKey;

  // Formularios
  final int photoQuality = 30;
  final double photoMaxWidth = 960.0;
  final double photoMaxHeight = 1280.0;

  // Agora
  late final String agoraAppID;

  // Plataf.Virtual Cancha - Gimnasio
  late final String urlCanchaGimnasio;
}
