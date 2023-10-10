/* class AgoraUserType {
  final bool isRemote;
  final int? uid;
  bool _muted = false;
  bool get muted => this._muted;
  set setMuted(bool m) => this._muted = m;

  bool _hidecam = false;
  bool get hidecam => this._hidecam;
  set setHideCam(bool hc) => this._hidecam = hc;

  AgoraUserType({this.isRemote = true, this.uid})
      : assert(
          isRemote == false || uid != null,
          'Se debe asignar un uid si el usuario es Remoto',
        ),
        assert(isRemote == true || uid == null,
            'Si el usuario es local, no se debe asignar un uid');
} */

class AgoraUserGeneric {
  final bool isRemote;

  AgoraUserGeneric(this.isRemote);

  bool _muted = false;
  bool get muted => this._muted;
  void setMuted(bool m) => this._muted = m;

  bool _hidecam = false;
  bool get hidecam => this._hidecam;
  void setHideCam(bool hc) => this._hidecam = hc;
}

class AgoraUserLocal extends AgoraUserGeneric {
  AgoraUserLocal() : super(false);
}

class AgoraUserRemote extends AgoraUserGeneric {
  final int uid;
  AgoraUserRemote(this.uid) : super(true);
}
