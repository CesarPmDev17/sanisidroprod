import 'package:app_san_isidro/data/models/central_telefonica.dart';

final List<CentralCategoria> directorioStore = [
  CentralCategoria(
    nombre: 'Bomberos',
    centrales: [
      CentralTelefonica(nombre: 'Emergencias', telefonos: [
        NumeroTelefono('116', codCiudad: ''),
      ]),
      CentralTelefonica(nombre: 'Bomberos San Isidro 100', telefonos: [
        NumeroTelefono('264-0339'),
      ]),
      CentralTelefonica(nombre: 'Bomberos San Isidro 100', telefonos: [
        NumeroTelefono('445-7447'),
      ]),
      CentralTelefonica(nombre: 'Bomberos San Isidro 100', telefonos: [
        NumeroTelefono('266-0893'),
        NumeroTelefono('471-6442'),
      ]),
    ],
  ),
  CentralCategoria(
    nombre: 'Municipalidad',
    centrales: [
      CentralTelefonica(nombre: 'Serenazgo / Alerta San Isidro', telefonos: [
        NumeroTelefono('319-0450'),
      ]),
      CentralTelefonica(nombre: 'Defensa Civil', telefonos: [
        NumeroTelefono('513-9000', anexo: '2931'),
      ]),
      CentralTelefonica(nombre: 'Central Telefónica', telefonos: [
        NumeroTelefono('513-9000'),
      ]),
    ],
  ),
  CentralCategoria(
    nombre: 'San Isidro Contigo',
    centrales: [
      CentralTelefonica(nombre: 'Médicos en linea', telefonos: [
        NumeroTelefono('513-9008', opcion: '1'),
      ]),
      CentralTelefonica(nombre: 'Abastecimiento de oxigeno', telefonos: [
        NumeroTelefono('513-9008', opcion: '2'),
      ]),
      CentralTelefonica(nombre: 'Desinfección de calles', telefonos: [
        NumeroTelefono('513-9008', opcion: '3'),
      ]),
      CentralTelefonica(nombre: 'Talleres virtuales', telefonos: [
        NumeroTelefono('513-9008', opcion: '4'),
      ]),
      CentralTelefonica(nombre: 'Reserva de citas medicas', telefonos: [
        NumeroTelefono('513-9008', opcion: '5'),
      ]),
      CentralTelefonica(nombre: 'Asesoría en nutrición', telefonos: [
        NumeroTelefono('513-9008', opcion: '6'),
      ]),
      CentralTelefonica(
          nombre: 'Reserva de gimnasio, campo de tenis y frontón',
          telefonos: [
            NumeroTelefono('513-9008', opcion: '7'),
          ]),
      CentralTelefonica(nombre: 'Policlínico Municipal', telefonos: [
        NumeroTelefono('513-9008', opcion: '8'),
      ]),
      CentralTelefonica(nombre: 'Orientación psicológica', telefonos: [
        NumeroTelefono('513-9008', opcion: '9'),
      ]),
    ],
  ),
  CentralCategoria(
    nombre: 'Policía Nacional',
    centrales: [
      CentralTelefonica(nombre: 'Emergencias', telefonos: [
        NumeroTelefono('105', codCiudad: ''),
      ]),
      CentralTelefonica(nombre: 'Comisaría San Isidro', telefonos: [
        NumeroTelefono('441-1275'),
      ]),
      CentralTelefonica(nombre: 'Comisaría Orrantia', telefonos: [
        NumeroTelefono('264-1932'),
        NumeroTelefono('264-6561'),
      ]),
      CentralTelefonica(nombre: 'Comisaría Mujeres', telefonos: [
        NumeroTelefono('428-1556'),
        NumeroTelefono('428-1804'),
      ]),
      CentralTelefonica(nombre: 'UDEX-Explosivos', telefonos: [
        NumeroTelefono('433-3333'),
      ]),
      CentralTelefonica(nombre: 'UDEX-DIROVE-Robos Vehículos', telefonos: [
        NumeroTelefono('328-0351'),
        NumeroTelefono('328-0207'),
      ]),
      CentralTelefonica(nombre: 'DIRINCRI-Crímenes', telefonos: [
        NumeroTelefono('221-1523'),
      ]),
      CentralTelefonica(nombre: 'DINCOTE-Terrorismo', telefonos: [
        NumeroTelefono('475-2995'),
      ]),
    ],
  ),
  CentralCategoria(
    nombre: 'Urgencia-Emergencias Médicas',
    centrales: [
      CentralTelefonica(
          nombre: 'SAMU-Sistema atención Médica Urgencia',
          telefonos: [
            NumeroTelefono('106', codCiudad: ''),
          ]),
      CentralTelefonica(nombre: 'Cruz Roja Peruana', telefonos: [
        NumeroTelefono('268-8109'),
      ]),
      CentralTelefonica(nombre: 'Clínica Javier Prado', telefonos: [
        NumeroTelefono('440-2000'),
        NumeroTelefono('211-4141'),
      ]),
      CentralTelefonica(nombre: 'Clínica Anglo Peruana', telefonos: [
        NumeroTelefono('616-8900', anexo: '1132'),
      ]),
      CentralTelefonica(nombre: 'Clínica Ricardo Palma', telefonos: [
        NumeroTelefono('224-2224'),
      ]),
      CentralTelefonica(nombre: 'Hospital Casimiro Ulloa', telefonos: [
        NumeroTelefono('204-0900'),
      ]),
      CentralTelefonica(nombre: 'Clínica El Golf', telefonos: [
        NumeroTelefono('631-0000'),
      ]),
      CentralTelefonica(nombre: 'Central Hospital FAP', telefonos: [
        NumeroTelefono('440-2749'),
      ]),
      CentralTelefonica(
          nombre: 'Emergencias médicas (ambulancia municipal)',
          telefonos: [
            NumeroTelefono('513 9008', opcion: '1'),
          ]),
      CentralTelefonica(
        nombre:
            'AMBULANCIAS-EMERGENCIA ESSALUD STAE (Sistema de Transporte Asistido de Emergencias)',
        telefonos: [
          NumeroTelefono('117', codCiudad: ''),
        ],
      ),
    ],
  ),
  CentralCategoria(
    nombre: 'Compañía de seguros',
    centrales: [
      CentralTelefonica(nombre: 'Pacífico', telefonos: [
        NumeroTelefono('415-1515'),
        NumeroTelefono('513-5000'),
      ]),
      CentralTelefonica(nombre: 'Rímac', telefonos: [
        NumeroTelefono('411-1111'),
      ]),
      CentralTelefonica(nombre: 'Mapfre', telefonos: [
        NumeroTelefono('213-3333'),
      ]),
      CentralTelefonica(nombre: 'La Positiva', telefonos: [
        NumeroTelefono('211-0211'),
      ]),
    ],
  ),
  CentralCategoria(
    nombre: 'Servicios',
    centrales: [
      CentralTelefonica(
        nombre: 'Defensa Civil - INDECI Emergencias',
        telefonos: [
          NumeroTelefono('115', codCiudad: ''),
        ],
      ),
      CentralTelefonica(
        nombre: 'Mensaje de voz-Emergencia por Desastre',
        telefonos: [
          NumeroTelefono('119', codCiudad: ''),
        ],
      ),
      CentralTelefonica(
        nombre: 'INDECI- Instituto de Defensa Civil',
        telefonos: [
          NumeroTelefono('225-9898'),
        ],
      ),
      CentralTelefonica(nombre: 'Luz del Sur', telefonos: [
        NumeroTelefono('617-5000'),
      ]),
      CentralTelefonica(nombre: 'EDELNOR', telefonos: [
        NumeroTelefono('517-1717'),
      ]),
      CentralTelefonica(nombre: 'CALIDDA-Gas Natural', telefonos: [
        NumeroTelefono('614-9000', anexo: '1808'),
      ]),
      CentralTelefonica(nombre: 'SEDAPAL-Red de Agua y Desagüe', telefonos: [
        NumeroTelefono('317-8000'),
      ]),
      CentralTelefonica(nombre: 'Centro Antirrábico-San Isidro', telefonos: [
        NumeroTelefono('513-9000', anexo: '4110'),
      ]),
      CentralTelefonica(nombre: 'Morgue-Lima', telefonos: [
        NumeroTelefono('328-8204'),
      ]),
      CentralTelefonica(nombre: 'La voz amiga', telefonos: [
        NumeroTelefono('436-1212'),
      ]),
    ],
  ),
];
