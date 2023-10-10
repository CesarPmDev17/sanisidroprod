class CentralCategoria {
  final String nombre;
  final List<CentralTelefonica> centrales;

  CentralCategoria({required this.nombre, this.centrales = const []});
}

class CentralTelefonica {
  final String nombre;
  final List<NumeroTelefono> telefonos;

  CentralTelefonica({required this.nombre, this.telefonos = const []});
}

class NumeroTelefono {
  final String codCiudad;
  final String numero;
  final String? anexo;
  final String? opcion;

  NumeroTelefono(this.numero, {this.codCiudad = '01', this.anexo, this.opcion});
}
