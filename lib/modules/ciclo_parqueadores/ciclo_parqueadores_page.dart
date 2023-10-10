import 'package:app_san_isidro/data/models/map_place_data.dart';
import 'package:app_san_isidro/modules/map_wrapper/map_wrapper.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CicloParqueadoresPage extends StatelessWidget {
  final data = [
    MapPlaceData(
      title: '01 - Ciclo parqueadero',
      latlng: LatLng(-12.09190820824292, -77.04211132198061),
    ),
    MapPlaceData(
      title: '02 - Ciclo parqueadero',
      latlng: LatLng(-12.09378626073726, -77.05776397445086),
    ),
    MapPlaceData(
      title: '03 - Ciclo parqueadero',
      latlng: LatLng(-12.09225520135923, -77.0453304755311),
    ),
    MapPlaceData(
      title: '04 - Ciclo parqueadero',
      latlng: LatLng(-12.09132966536362, -77.03895137989426),
    ),
    MapPlaceData(
      title: '05 - Ciclo parqueadero',
      latlng: LatLng(-12.09194045350213, -77.04226701543539),
    ),
    MapPlaceData(
      title: '06 - Ciclo parqueadero',
      latlng: LatLng(-12.0921981392987, -77.04404947417837),
    ),
    MapPlaceData(
      title: '07 - Ciclo parqueadero',
      latlng: LatLng(-12.09693520791201, -77.05533119964481),
    ),
    MapPlaceData(
      title: '08 - Ciclo parqueadero',
      latlng: LatLng(-12.09536352078206, -77.04889054722763),
    ),
    MapPlaceData(
      title: '09 - Ciclo parqueadero',
      latlng: LatLng(-12.09394529703107, -77.03838680718452),
    ),
    MapPlaceData(
      title: '10 - Ciclo parqueadero',
      latlng: LatLng(-12.09441951641133, -77.05623392814154),
    ),
    MapPlaceData(
      title: '100 - Ciclo parqueadero',
      latlng: LatLng(-12.10813386293325, -77.03892564699335),
    ),
    MapPlaceData(
      title: '101 - Ciclo parqueadero',
      latlng: LatLng(-12.10830404148144, -77.03877947379365),
    ),
    MapPlaceData(
      title: '102 - Ciclo parqueadero',
      latlng: LatLng(-12.10532104377609, -77.03728478302554),
    ),
    MapPlaceData(
      title: '103 - Ciclo parqueadero',
      latlng: LatLng(-12.10503451489708, -77.0372660612706),
    ),
    MapPlaceData(
      title: '104 - Ciclo parqueadero',
      latlng: LatLng(-12.1030596057788, -77.03683745584314),
    ),
    MapPlaceData(
      title: '105 - Ciclo parqueadero',
      latlng: LatLng(-12.09621195615887, -77.03630948120696),
    ),
    MapPlaceData(
      title: '106 - Ciclo parqueadero',
      latlng: LatLng(-12.09609281174975, -77.03686515994931),
    ),
    MapPlaceData(
      title: '107 - Ciclo parqueadero',
      latlng: LatLng(-12.0945812396341, -77.03502533104978),
    ),
    MapPlaceData(
      title: '108 - Ciclo parqueadero',
      latlng: LatLng(-12.0985439549058, -77.03624472919903),
    ),
    MapPlaceData(
      title: '109 - Ciclo parqueadero',
      latlng: LatLng(-12.09996746432367, -77.03661735726256),
    ),
    MapPlaceData(
      title: '11 - Ciclo parqueadero',
      latlng: LatLng(-12.0918770146771, -77.04175296385314),
    ),
    MapPlaceData(
      title: '110 - Ciclo parqueadero',
      latlng: LatLng(-12.10260373528247, -77.03676659332197),
    ),
    MapPlaceData(
      title: '111 - Ciclo parqueadero',
      latlng: LatLng(-12.10245420858839, -77.03677115384413),
    ),
    MapPlaceData(
      title: '112 - Ciclo parqueadero',
      latlng: LatLng(-12.10401612734416, -77.03691246862047),
    ),
    MapPlaceData(
      title: '113 - Ciclo parqueadero',
      latlng: LatLng(-12.10535802558133, -77.03706282463018),
    ),
    MapPlaceData(
      title: '114 - Ciclo parqueadero',
      latlng: LatLng(-12.10640607321195, -77.03703893695733),
    ),
    MapPlaceData(
      title: '115 - Ciclo parqueadero',
      latlng: LatLng(-12.10716451399282, -77.03697402625535),
    ),
    MapPlaceData(
      title: '116 - Ciclo parqueadero',
      latlng: LatLng(-12.09845564474806, -77.03699940711039),
    ),
    MapPlaceData(
      title: '117 - Ciclo parqueadero',
      latlng: LatLng(-12.09400206320293, -77.03499609592269),
    ),
    MapPlaceData(
      title: '118 - Ciclo parqueadero',
      latlng: LatLng(-12.09502977955088, -77.03731221274387),
    ),
    MapPlaceData(
      title: '119 - Ciclo parqueadero',
      latlng: LatLng(-12.0944259508989, -77.03327310316271),
    ),
    MapPlaceData(
      title: '12 - Ciclo parqueadero',
      latlng: LatLng(-12.0923413522975, -77.04636312177576),
    ),
    MapPlaceData(
      title: '120 - Ciclo parqueadero',
      latlng: LatLng(-12.10553044947495, -77.03504500110009),
    ),
    MapPlaceData(
      title: '121 - Ciclo parqueadero',
      latlng: LatLng(-12.10710489394121, -77.03944106173037),
    ),
    MapPlaceData(
      title: '122 - Ciclo parqueadero',
      latlng: LatLng(-12.10679936356208, -77.0393507365559),
    ),
    MapPlaceData(
      title: '123 - Ciclo parqueadero',
      latlng: LatLng(-12.1064629797837, -77.03920461818092),
    ),
    MapPlaceData(
      title: '124 - Ciclo parqueadero',
      latlng: LatLng(-12.10734301035934, -77.03777397444004),
    ),
    MapPlaceData(
      title: '125 - Ciclo parqueadero',
      latlng: LatLng(-12.10835187957998, -77.03910063575036),
    ),
    MapPlaceData(
      title: '126 - Ciclo parqueadero',
      latlng: LatLng(-12.10902251643575, -77.03809109727),
    ),
    MapPlaceData(
      title: '127 - Ciclo parqueadero',
      latlng: LatLng(-12.10202355844888, -77.03300468782432),
    ),
    MapPlaceData(
      title: '128 - Ciclo parqueadero',
      latlng: LatLng(-12.09422373249972, -77.03389311757414),
    ),
    MapPlaceData(
      title: '129 - Ciclo parqueadero',
      latlng: LatLng(-12.1077815501234, -77.03500040659341),
    ),
    MapPlaceData(
      title: '13 - Ciclo parqueadero',
      latlng: LatLng(-12.09253417475688, -77.04762451718206),
    ),
    MapPlaceData(
      title: '130 - Ciclo parqueadero',
      latlng: LatLng(-12.09417366423343, -77.03473949643613),
    ),
    MapPlaceData(
      title: '131 - Ciclo parqueadero',
      latlng: LatLng(-12.0941729040331, -77.03504986498029),
    ),
    MapPlaceData(
      title: '132 - Ciclo parqueadero',
      latlng: LatLng(-12.10475947695405, -77.03696128162355),
    ),
    MapPlaceData(
      title: '133 - Ciclo parqueadero',
      latlng: LatLng(-12.09228048082506, -77.03463849701296),
    ),
    MapPlaceData(
      title: '134 - Ciclo parqueadero',
      latlng: LatLng(-12.09911727417874, -77.03652713142908),
    ),
    MapPlaceData(
      title: '135 - Ciclo parqueadero',
      latlng: LatLng(-12.0990743424462, -77.03588925134882),
    ),
    MapPlaceData(
      title: '136 - Ciclo parqueadero',
      latlng: LatLng(-12.10497311031798, -77.03892342168776),
    ),
    MapPlaceData(
      title: '137 - Ciclo parqueadero',
      latlng: LatLng(-12.10364685515164, -77.03141384419823),
    ),
    MapPlaceData(
      title: '138 - Ciclo parqueadero',
      latlng: LatLng(-12.10121044309176, -77.03571725146234),
    ),
    MapPlaceData(
      title: '139 - Ciclo parqueadero',
      latlng: LatLng(-12.09880783493275, -77.0347116682461),
    ),
    MapPlaceData(
      title: '14 - Ciclo parqueadero',
      latlng: LatLng(-12.09758681174629, -77.04577221708406),
    ),
    MapPlaceData(
      title: '140 - Ciclo parqueadero',
      latlng: LatLng(-12.10119490587185, -77.03391736488932),
    ),
    MapPlaceData(
      title: '141 - Ciclo parqueadero',
      latlng: LatLng(-12.09106014834217, -77.03600331963158),
    ),
    MapPlaceData(
      title: '142 - Ciclo parqueadero',
      latlng: LatLng(-12.09936866071591, -77.03723394204529),
    ),
    MapPlaceData(
      title: '143 - Ciclo parqueadero',
      latlng: LatLng(-12.09375836358333, -77.03370638557541),
    ),
    MapPlaceData(
      title: '144 - Ciclo parqueadero',
      latlng: LatLng(-12.10049267952272, -77.02338106457714),
    ),
    MapPlaceData(
      title: '145 - Ciclo parqueadero',
      latlng: LatLng(-12.09387055067142, -77.02563370496367),
    ),
    MapPlaceData(
      title: '146 - Ciclo parqueadero',
      latlng: LatLng(-12.09529396989917, -77.02567767065162),
    ),
    MapPlaceData(
      title: '147 - Ciclo parqueadero',
      latlng: LatLng(-12.09658664641569, -77.02635971790342),
    ),
    MapPlaceData(
      title: '148 - Ciclo parqueadero',
      latlng: LatLng(-12.09441567453437, -77.02526405951204),
    ),
    MapPlaceData(
      title: '149 - Ciclo parqueadero',
      latlng: LatLng(-12.09487837126457, -77.0254950285014),
    ),
    MapPlaceData(
      title: '15 - Ciclo parqueadero',
      latlng: LatLng(-12.09161848371719, -77.05226991879931),
    ),
    MapPlaceData(
      title: '150 - Ciclo parqueadero',
      latlng: LatLng(-12.09615568781198, -77.0262835003857),
    ),
    MapPlaceData(
      title: '151 - Ciclo parqueadero',
      latlng: LatLng(-12.09558010063662, -77.02655303107734),
    ),
    MapPlaceData(
      title: '152 - Ciclo parqueadero',
      latlng: LatLng(-12.09455121854819, -77.02678794048636),
    ),
    MapPlaceData(
      title: '153 - Ciclo parqueadero',
      latlng: LatLng(-12.09530836345478, -77.02664721861549),
    ),
    MapPlaceData(
      title: '154 - Ciclo parqueadero',
      latlng: LatLng(-12.09392312859123, -77.0268975737249),
    ),
    MapPlaceData(
      title: '155 - Ciclo parqueadero',
      latlng: LatLng(-12.09333519375972, -77.02689773480431),
    ),
    MapPlaceData(
      title: '156 - Ciclo parqueadero',
      latlng: LatLng(-12.09214710197843, -77.02679632636047),
    ),
    MapPlaceData(
      title: '157 - Ciclo parqueadero',
      latlng: LatLng(-12.09254842463298, -77.02679798998568),
    ),
    MapPlaceData(
      title: '158 - Ciclo parqueadero',
      latlng: LatLng(-12.0931268015907, -77.02670307327203),
    ),
    MapPlaceData(
      title: '159 - Ciclo parqueadero',
      latlng: LatLng(-12.0938634893013, -77.02659997897716),
    ),
    MapPlaceData(
      title: '16 - Ciclo parqueadero',
      latlng: LatLng(-12.08968762966563, -77.0480330207661),
    ),
    MapPlaceData(
      title: '160 - Ciclo parqueadero',
      latlng: LatLng(-12.09479325078472, -77.02644345818499),
    ),
    MapPlaceData(
      title: '161 - Ciclo parqueadero',
      latlng: LatLng(-12.09533354228264, -77.02634558874146),
    ),
    MapPlaceData(
      title: '162 - Ciclo parqueadero',
      latlng: LatLng(-12.09557181779065, -77.02631217350913),
    ),
    MapPlaceData(
      title: '163 - Ciclo parqueadero',
      latlng: LatLng(-12.09623004228007, -77.02659721052974),
    ),
    MapPlaceData(
      title: '164 - Ciclo parqueadero',
      latlng: LatLng(-12.09448415748963, -77.0264282996046),
    ),
    MapPlaceData(
      title: '165 - Ciclo parqueadero',
      latlng: LatLng(-12.09495008739288, -77.02670000439333),
    ),
    MapPlaceData(
      title: '166 - Ciclo parqueadero',
      latlng: LatLng(-12.09419641320662, -77.02651573446383),
    ),
    MapPlaceData(
      title: '167 - Ciclo parqueadero',
      latlng: LatLng(-12.09940191316611, -77.03107400937468),
    ),
    MapPlaceData(
      title: '168 - Ciclo parqueadero',
      latlng: LatLng(-12.10047814531951, -77.030899951062),
    ),
    MapPlaceData(
      title: '169 - Ciclo parqueadero',
      latlng: LatLng(-12.09998730086151, -77.03097983204883),
    ),
    MapPlaceData(
      title: '17 - Ciclo parqueadero',
      latlng: LatLng(-12.08985536604151, -77.0492368921195),
    ),
    MapPlaceData(
      title: '170 - Ciclo parqueadero',
      latlng: LatLng(-12.10321823858393, -77.03042292814239),
    ),
    MapPlaceData(
      title: '171 - Ciclo parqueadero',
      latlng: LatLng(-12.09603955337397, -77.03159045195923),
    ),
    MapPlaceData(
      title: '172 - Ciclo parqueadero',
      latlng: LatLng(-12.09406414620234, -77.03181085924268),
    ),
    MapPlaceData(
      title: '173 - Ciclo parqueadero',
      latlng: LatLng(-12.09189096147934, -77.03172448980469),
    ),
    MapPlaceData(
      title: '174 - Ciclo parqueadero',
      latlng: LatLng(-12.09735699793665, -77.03153802042478),
    ),
    MapPlaceData(
      title: '175 - Ciclo parqueadero',
      latlng: LatLng(-12.09774776885693, -77.03151990668515),
    ),
    MapPlaceData(
      title: '176 - Ciclo parqueadero',
      latlng: LatLng(-12.10045388505067, -77.0310636547273),
    ),
    MapPlaceData(
      title: '177 - Ciclo parqueadero',
      latlng: LatLng(-12.09798833242474, -77.03132462876704),
    ),
    MapPlaceData(
      title: '178 - Ciclo parqueadero',
      latlng: LatLng(-12.09637754439282, -77.03153668082263),
    ),
    MapPlaceData(
      title: '179 - Ciclo parqueadero',
      latlng: LatLng(-12.09097893342709, -77.03234435238127),
    ),
    MapPlaceData(
      title: '18 - Ciclo parqueadero',
      latlng: LatLng(-12.08952881566521, -77.04745219780254),
    ),
    MapPlaceData(
      title: '180 - Ciclo parqueadero',
      latlng: LatLng(-12.09569845769946, -77.02900994079121),
    ),
    MapPlaceData(
      title: '181 - Ciclo parqueadero',
      latlng: LatLng(-12.09711629920942, -77.02875825247784),
    ),
    MapPlaceData(
      title: '182 - Ciclo parqueadero',
      latlng: LatLng(-12.09734920972668, -77.02867630529377),
    ),
    MapPlaceData(
      title: '183 - Ciclo parqueadero',
      latlng: LatLng(-12.09598167748451, -77.02887680571986),
    ),
    MapPlaceData(
      title: '184 - Ciclo parqueadero',
      latlng: LatLng(-12.09714136380687, -77.02088780282024),
    ),
    MapPlaceData(
      title: '185 - Ciclo parqueadero',
      latlng: LatLng(-12.09693331149385, -77.02258876690431),
    ),
    MapPlaceData(
      title: '186 - Ciclo parqueadero',
      latlng: LatLng(-12.09697293107963, -77.0245724046961),
    ),
    MapPlaceData(
      title: '187 - Ciclo parqueadero',
      latlng: LatLng(-12.09688781707452, -77.02326552207059),
    ),
    MapPlaceData(
      title: '188 - Ciclo parqueadero',
      latlng: LatLng(-12.09674751754851, -77.02438933842343),
    ),
    MapPlaceData(
      title: '189 - Ciclo parqueadero',
      latlng: LatLng(-12.09693230644357, -77.02249612314235),
    ),
    MapPlaceData(
      title: '19 - Ciclo parqueadero',
      latlng: LatLng(-12.09251194608057, -77.04644976809337),
    ),
    MapPlaceData(
      title: '190 - Ciclo parqueadero',
      latlng: LatLng(-12.0976500003745, -77.02062899450544),
    ),
    MapPlaceData(
      title: '191 - Ciclo parqueadero',
      latlng: LatLng(-12.0976604692339, -77.02022643227407),
    ),
    MapPlaceData(
      title: '192 - Ciclo parqueadero',
      latlng: LatLng(-12.10140999292762, -77.01891307537069),
    ),
    MapPlaceData(
      title: '193 - Ciclo parqueadero',
      latlng: LatLng(-12.09147482614348, -77.02603264378594),
    ),
    MapPlaceData(
      title: '194 - Ciclo parqueadero',
      latlng: LatLng(-12.09254609074897, -77.03210024336657),
    ),
    MapPlaceData(
      title: '195 - Ciclo parqueadero',
      latlng: LatLng(-12.09322883191878, -77.02788415509096),
    ),
    MapPlaceData(
      title: '196 - Ciclo parqueadero',
      latlng: LatLng(-12.09873785431836, -77.03205828090645),
    ),
    MapPlaceData(
      title: '197 - Ciclo parqueadero',
      latlng: LatLng(-12.09894578492304, -77.03199615341269),
    ),
    MapPlaceData(
      title: '198 - Ciclo parqueadero',
      latlng: LatLng(-12.09889215428119, -77.03168323938502),
    ),
    MapPlaceData(
      title: '199 - Ciclo parqueadero',
      latlng: LatLng(-12.09458012560115, -77.03087921984709),
    ),
    MapPlaceData(
      title: '20 - Ciclo parqueadero',
      latlng: LatLng(-12.09175011770016, -77.04168200562336),
    ),
    MapPlaceData(
      title: '200 - Ciclo parqueadero',
      latlng: LatLng(-12.10089528785424, -77.0289272226271),
    ),
    MapPlaceData(
      title: '201 - Ciclo parqueadero',
      latlng: LatLng(-12.09594078680632, -77.02161192575008),
    ),
    MapPlaceData(
      title: '202 - Ciclo parqueadero',
      latlng: LatLng(-12.09704131849801, -77.02187460701971),
    ),
    MapPlaceData(
      title: '203 - Ciclo parqueadero',
      latlng: LatLng(-12.09570177204625, -77.02138159919738),
    ),
    MapPlaceData(
      title: '204 - Ciclo parqueadero',
      latlng: LatLng(-12.0942993038984, -77.02900788161277),
    ),
    MapPlaceData(
      title: '205 - Ciclo parqueadero',
      latlng: LatLng(-12.09423703833294, -77.02768589647792),
    ),
    MapPlaceData(
      title: '207 - Ciclo parqueadero',
      latlng: LatLng(-12.09417168898355, -77.02794402189926),
    ),
    MapPlaceData(
      title: '208 - Ciclo parqueadero',
      latlng: LatLng(-12.09454325114219, -77.0299267842248),
    ),
    MapPlaceData(
      title: '209 - Ciclo parqueadero',
      latlng: LatLng(-12.09565916937216, -77.02771240294356),
    ),
    MapPlaceData(
      title: '21 - Ciclo parqueadero',
      latlng: LatLng(-12.09181538058332, -77.04125904635046),
    ),
    MapPlaceData(
      title: '210 - Ciclo parqueadero',
      latlng: LatLng(-12.09552920911194, -77.02759795600986),
    ),
    MapPlaceData(
      title: '211 - Ciclo parqueadero',
      latlng: LatLng(-12.09569734529515, -77.02821095956327),
    ),
    MapPlaceData(
      title: '212 - Ciclo parqueadero',
      latlng: LatLng(-12.09567591627884, -77.02867241503493),
    ),
    MapPlaceData(
      title: '213 - Ciclo parqueadero',
      latlng: LatLng(-12.09491712372794, -77.02615872996786),
    ),
    MapPlaceData(
      title: '214 - Ciclo parqueadero',
      latlng: LatLng(-12.09582337739586, -77.02983130290188),
    ),
    MapPlaceData(
      title: '215 - Ciclo parqueadero',
      latlng: LatLng(-12.09518424585206, -77.02887408090508),
    ),
    MapPlaceData(
      title: '216 - Ciclo parqueadero',
      latlng: LatLng(-12.09214020993781, -77.02494915169241),
    ),
    MapPlaceData(
      title: '217 - Ciclo parqueadero',
      latlng: LatLng(-12.09244092078, -77.02795970639477),
    ),
    MapPlaceData(
      title: '218 - Ciclo parqueadero',
      latlng: LatLng(-12.09257664014438, -77.02786070979042),
    ),
    MapPlaceData(
      title: '219 - Ciclo parqueadero',
      latlng: LatLng(-12.09805269365143, -77.03099566427338),
    ),
    MapPlaceData(
      title: '22 - Ciclo parqueadero',
      latlng: LatLng(-12.09156415085415, -77.04054510084941),
    ),
    MapPlaceData(
      title: '220 - Ciclo parqueadero',
      latlng: LatLng(-12.09546647901357, -77.02256850918745),
    ),
    MapPlaceData(
      title: '221 - Ciclo parqueadero',
      latlng: LatLng(-12.09455939237552, -77.03215468995319),
    ),
    MapPlaceData(
      title: '222 - Ciclo parqueadero',
      latlng: LatLng(-12.09803778485311, -77.02018000930576),
    ),
    MapPlaceData(
      title: '223 - Ciclo parqueadero',
      latlng: LatLng(-12.09666819203719, -77.02456160650092),
    ),
    MapPlaceData(
      title: '224 - Ciclo parqueadero',
      latlng: LatLng(-12.0975435083763, -77.02716708181872),
    ),
    MapPlaceData(
      title: '225 - Ciclo parqueadero',
      latlng: LatLng(-12.09664012984245, -77.02694515901047),
    ),
    MapPlaceData(
      title: '226 - Ciclo parqueadero',
      latlng: LatLng(-12.09939970231348, -77.0258012647446),
    ),
    MapPlaceData(
      title: '227 - Ciclo parqueadero',
      latlng: LatLng(-12.09354109143329, -77.02389676916314),
    ),
    MapPlaceData(
      title: '228 - Ciclo parqueadero',
      latlng: LatLng(-12.10212145021564, -77.02119087143578),
    ),
    MapPlaceData(
      title: '229 - Ciclo parqueadero',
      latlng: LatLng(-12.09762771001216, -77.0313507003424),
    ),
    MapPlaceData(
      title: '23 - Ciclo parqueadero',
      latlng: LatLng(-12.09161308304043, -77.03879207055452),
    ),
    MapPlaceData(
      title: '230 - Ciclo parqueadero',
      latlng: LatLng(-12.10240589408721, -77.01658475496512),
    ),
    MapPlaceData(
      title: '231 - Ciclo parqueadero',
      latlng: LatLng(-12.09060335144333, -77.01903634252733),
    ),
    MapPlaceData(
      title: '232 - Ciclo parqueadero',
      latlng: LatLng(-12.09469156686856, -77.01599458986045),
    ),
    MapPlaceData(
      title: '233 - Ciclo parqueadero',
      latlng: LatLng(-12.09748327015172, -77.01412796810567),
    ),
    MapPlaceData(
      title: '234 - Ciclo parqueadero',
      latlng: LatLng(-12.101605262629, -77.01278736525443),
    ),
    MapPlaceData(
      title: '235 - Ciclo parqueadero',
      latlng: LatLng(-12.09388591008245, -77.01203411932069),
    ),
    MapPlaceData(
      title: '236 - Ciclo parqueadero',
      latlng: LatLng(-12.09452519973501, -77.01199143079556),
    ),
    MapPlaceData(
      title: '237 - Ciclo parqueadero',
      latlng: LatLng(-12.0943215821125, -77.0191609009165),
    ),
    MapPlaceData(
      title: '238 - Ciclo parqueadero',
      latlng: LatLng(-12.09742422697819, -77.01351355359421),
    ),
    MapPlaceData(
      title: '239 - Ciclo parqueadero',
      latlng: LatLng(-12.09707826542504, -77.01292802090822),
    ),
    MapPlaceData(
      title: '24 - Ciclo parqueadero',
      latlng: LatLng(-12.09126709451448, -77.03676631960616),
    ),
    MapPlaceData(
      title: '240 - Ciclo parqueadero',
      latlng: LatLng(-12.09914014771408, -77.01234622048479),
    ),
    MapPlaceData(
      title: '241 - Ciclo parqueadero',
      latlng: LatLng(-12.1019962575114, -77.01609288123896),
    ),
    MapPlaceData(
      title: '242 - Ciclo parqueadero',
      latlng: LatLng(-12.10224553059852, -77.01591727856434),
    ),
    MapPlaceData(
      title: '243 - Ciclo parqueadero',
      latlng: LatLng(-12.1020553191034, -77.01593265069521),
    ),
    MapPlaceData(
      title: '244 - Ciclo parqueadero',
      latlng: LatLng(-12.10254220957326, -77.01566777512778),
    ),
    MapPlaceData(
      title: '245 - Ciclo parqueadero',
      latlng: LatLng(-12.09750954388793, -77.01829977915301),
    ),
    MapPlaceData(
      title: '246 - Ciclo parqueadero',
      latlng: LatLng(-12.09882798664552, -77.01700883746162),
    ),
    MapPlaceData(
      title: '247 - Ciclo parqueadero',
      latlng: LatLng(-12.09363506451267, -77.00999315562595),
    ),
    MapPlaceData(
      title: '248 - Ciclo parqueadero',
      latlng: LatLng(-12.10189397942873, -77.0153323877571),
    ),
    MapPlaceData(
      title: '249 - Ciclo parqueadero',
      latlng: LatLng(-12.09970787222849, -77.01280826674042),
    ),
    MapPlaceData(
      title: '25 - Ciclo parqueadero',
      latlng: LatLng(-12.09464584651825, -77.04389358352798),
    ),
    MapPlaceData(
      title: '250 - Ciclo parqueadero',
      latlng: LatLng(-12.09919762804853, -77.01503317625237),
    ),
    MapPlaceData(
      title: '251 - Ciclo parqueadero',
      latlng: LatLng(-12.10090608228887, -77.01676606451979),
    ),
    MapPlaceData(
      title: '252 - Ciclo parqueadero',
      latlng: LatLng(-12.10363634494444, -77.01178795731842),
    ),
    MapPlaceData(
      title: '253 - Ciclo parqueadero',
      latlng: LatLng(-12.10392223064074, -77.01283494832654),
    ),
    MapPlaceData(
      title: '254 - Ciclo parqueadero',
      latlng: LatLng(-12.10389899248962, -77.01370028577368),
    ),
    MapPlaceData(
      title: '255 - Ciclo parqueadero',
      latlng: LatLng(-12.10266931705656, -77.01572000225019),
    ),
    MapPlaceData(
      title: '256 - Ciclo parqueadero',
      latlng: LatLng(-12.09996514185491, -77.01833166272621),
    ),
    MapPlaceData(
      title: '257 - Ciclo parqueadero',
      latlng: LatLng(-12.09256492054559, -77.01706648424728),
    ),
    MapPlaceData(
      title: '258 - Ciclo parqueadero',
      latlng: LatLng(-12.09251886117463, -77.01580019454595),
    ),
    MapPlaceData(
      title: '259 - Ciclo parqueadero',
      latlng: LatLng(-12.09721886833663, -77.01621013894231),
    ),
    MapPlaceData(
      title: '26 - Ciclo parqueadero',
      latlng: LatLng(-12.09598143303784, -77.04372408125934),
    ),
    MapPlaceData(
      title: '260 - Ciclo parqueadero',
      latlng: LatLng(-12.09189105334802, -77.01006314379468),
    ),
    MapPlaceData(
      title: '261 - Ciclo parqueadero',
      latlng: LatLng(-12.09175378482681, -77.01028145576225),
    ),
    MapPlaceData(
      title: '262 - Ciclo parqueadero',
      latlng: LatLng(-12.09725097409433, -77.01513947767985),
    ),
    MapPlaceData(
      title: '263 - Ciclo parqueadero',
      latlng: LatLng(-12.10185266315555, -77.01624200738733),
    ),
    MapPlaceData(
      title: '265 - Ciclo parqueadero',
      latlng: LatLng(-12.09806245455574, -77.02754745789025),
    ),
    MapPlaceData(
      title: '266 - Ciclo parqueadero',
      latlng: LatLng(-12.10550921920344, -77.05954874412184),
    ),
    MapPlaceData(
      title: '267 - Ciclo parqueadero',
      latlng: LatLng(-12.10252129183385, -77.02615360001752),
    ),
    MapPlaceData(
      title: '268 - Ciclo parqueadero',
      latlng: LatLng(-12.09857653371095, -77.01997895314075),
    ),
    MapPlaceData(
      title: '269 - Ciclo parqueadero',
      latlng: LatLng(-12.09202741753056, -77.04292004397982),
    ),
    MapPlaceData(
      title: '27 - Ciclo parqueadero',
      latlng: LatLng(-12.09534137088612, -77.0402119836638),
    ),
    MapPlaceData(
      title: '270 - Ciclo parqueadero',
      latlng: LatLng(-12.09518533418184, -77.02104554243446),
    ),
    MapPlaceData(
      title: '271 - Ciclo parqueadero',
      latlng: LatLng(-12.09318043797735, -77.02184324850852),
    ),
    MapPlaceData(
      title: '272 - Ciclo parqueadero',
      latlng: LatLng(-12.09556145417585, -77.01433752591279),
    ),
    MapPlaceData(
      title: '273 - Ciclo parqueadero',
      latlng: LatLng(-12.09554504011938, -77.01533127843302),
    ),
    MapPlaceData(
      title: '274 - Ciclo parqueadero',
      latlng: LatLng(-12.09069266394945, -77.01206008066436),
    ),
    MapPlaceData(
      title: '275 - Ciclo parqueadero',
      latlng: LatLng(-12.10174487119124, -77.03333103981204),
    ),
    MapPlaceData(
      title: '276 - Ciclo parqueadero',
      latlng: LatLng(-12.09448939397028, -77.02895743275118),
    ),
    MapPlaceData(
      title: '277 - Ciclo parqueadero',
      latlng: LatLng(-12.091311092711, -77.03790039404819),
    ),
    MapPlaceData(
      title: '278 - Ciclo parqueadero',
      latlng: LatLng(-12.09180062640938, -77.04876356587489),
    ),
    MapPlaceData(
      title: '279 - Ciclo parqueadero',
      latlng: LatLng(-12.09264479210358, -77.04863130659561),
    ),
    MapPlaceData(
      title: '28 - Ciclo parqueadero',
      latlng: LatLng(-12.09599668428347, -77.04912788551138),
    ),
    MapPlaceData(
      title: '28 - Ciclo parqueadero',
      latlng: LatLng(-12.09620672845395, -77.05468587147671),
    ),
    MapPlaceData(
      title: '280 - Ciclo parqueadero',
      latlng: LatLng(-12.09291940449593, -77.04861791126666),
    ),
    MapPlaceData(
      title: '281 - Ciclo parqueadero',
      latlng: LatLng(-12.09098766697688, -77.03536491434031),
    ),
    MapPlaceData(
      title: '282 - Ciclo parqueadero',
      latlng: LatLng(-12.09354316000231, -77.03460574410299),
    ),
    MapPlaceData(
      title: '283 - Ciclo parqueadero',
      latlng: LatLng(-12.09472592573598, -77.03280768999436),
    ),
    MapPlaceData(
      title: '284 - Ciclo parqueadero',
      latlng: LatLng(-12.09500266303845, -77.03173776779778),
    ),
    MapPlaceData(
      title: '285 - Ciclo parqueadero',
      latlng: LatLng(-12.09876729328825, -77.03117815277248),
    ),
    MapPlaceData(
      title: '286 - Ciclo parqueadero',
      latlng: LatLng(-12.10083402972756, -77.03099843256838),
    ),
    MapPlaceData(
      title: '287 - Ciclo parqueadero',
      latlng: LatLng(-12.09673624303029, -77.02958574160158),
    ),
    MapPlaceData(
      title: '289 - Ciclo parqueadero',
      latlng: LatLng(-12.09801056433722, -77.03617648600378),
    ),
    MapPlaceData(
      title: '29 - Ciclo parqueadero',
      latlng: LatLng(-12.09653628791081, -77.05613532853528),
    ),
    MapPlaceData(
      title: '295 - Ciclo parqueadero',
      latlng: LatLng(-12.10987537475452, -77.03667848063802),
    ),
    MapPlaceData(
      title: '296 - Ciclo parqueadero',
      latlng: LatLng(-12.10782016044202, -77.05589039089882),
    ),
    MapPlaceData(
      title: '297 - Ciclo parqueadero',
      latlng: LatLng(-12.10912846353208, -77.05458270495312),
    ),
    MapPlaceData(
      title: '298 - Ciclo parqueadero',
      latlng: LatLng(-12.10872131492901, -77.05386709005651),
    ),
    MapPlaceData(
      title: '299 - Ciclo parqueadero',
      latlng: LatLng(-12.10948581027918, -77.05387880596173),
    ),
    MapPlaceData(
      title: '30 - Ciclo parqueadero',
      latlng: LatLng(-12.09666399914647, -77.05348179263387),
    ),
    MapPlaceData(
      title: '300 - Ciclo parqueadero',
      latlng: LatLng(-12.10787323995691, -77.05645034899456),
    ),
    MapPlaceData(
      title: '301 - Ciclo parqueadero',
      latlng: LatLng(-12.1086738363885, -77.05517606945284),
    ),
    MapPlaceData(
      title: '302 - Ciclo parqueadero',
      latlng: LatLng(-12.10932432337125, -77.05423521638747),
    ),
    MapPlaceData(
      title: '303 - Ciclo parqueadero',
      latlng: LatLng(-12.10948735460184, -77.05346266425386),
    ),
    MapPlaceData(
      title: '31 - Ciclo parqueadero',
      latlng: LatLng(-12.09682075387787, -77.0560155618776),
    ),
    MapPlaceData(
      title: '32 - Ciclo parqueadero',
      latlng: LatLng(-12.09229864126219, -77.04584990254595),
    ),
    MapPlaceData(
      title: '33 - Ciclo parqueadero',
      latlng: LatLng(-12.09020012114271, -77.0479761721634),
    ),
    MapPlaceData(
      title: '34 - Ciclo parqueadero',
      latlng: LatLng(-12.09224094662516, -77.05876523770638),
    ),
    MapPlaceData(
      title: '35 - Ciclo parqueadero',
      latlng: LatLng(-12.09620452081098, -77.0580949802809),
    ),
    MapPlaceData(
      title: '36 - Ciclo parqueadero',
      latlng: LatLng(-12.09798405535214, -77.04821255354958),
    ),
    MapPlaceData(
      title: '37 - Ciclo parqueadero',
      latlng: LatLng(-12.08987566953957, -77.05016674758068),
    ),
    MapPlaceData(
      title: '38 - Ciclo parqueadero',
      latlng: LatLng(-12.09612165997331, -77.05973336072618),
    ),
    MapPlaceData(
      title: '39 - Ciclo parqueadero',
      latlng: LatLng(-12.09689645626331, -77.05839705811509),
    ),
    MapPlaceData(
      title: '40 - Ciclo parqueadero',
      latlng: LatLng(-12.10906853750391, -77.05349511241003),
    ),
    MapPlaceData(
      title: '41 - Ciclo parqueadero',
      latlng: LatLng(-12.10768479247637, -77.05425919409515),
    ),
    MapPlaceData(
      title: '42 - Ciclo parqueadero',
      latlng: LatLng(-12.09803870450601, -77.05600611787892),
    ),
    MapPlaceData(
      title: '43 - Ciclo parqueadero',
      latlng: LatLng(-12.0981165206551, -77.0556207035623),
    ),
    MapPlaceData(
      title: '44 - Ciclo parqueadero',
      latlng: LatLng(-12.0999764112593, -77.05705705268828),
    ),
    MapPlaceData(
      title: '45 - Ciclo parqueadero',
      latlng: LatLng(-12.09903203511678, -77.05650590798182),
    ),
    MapPlaceData(
      title: '46 - Ciclo parqueadero',
      latlng: LatLng(-12.1028919481167, -77.0524109511106),
    ),
    MapPlaceData(
      title: '47 - Ciclo parqueadero',
      latlng: LatLng(-12.10270544484587, -77.05245092042965),
    ),
    MapPlaceData(
      title: '48 - Ciclo parqueadero',
      latlng: LatLng(-12.10238935595621, -77.05899796175642),
    ),
    MapPlaceData(
      title: '49 - Ciclo parqueadero',
      latlng: LatLng(-12.1053082831428, -77.04021614766533),
    ),
    MapPlaceData(
      title: '50 - Ciclo parqueadero',
      latlng: LatLng(-12.10553373812605, -77.04019790154143),
    ),
    MapPlaceData(
      title: '51 - Ciclo parqueadero',
      latlng: LatLng(-12.10582196380969, -77.04035048002531),
    ),
    MapPlaceData(
      title: '52 - Ciclo parqueadero',
      latlng: LatLng(-12.10630946646018, -77.04013534564447),
    ),
    MapPlaceData(
      title: '53 - Ciclo parqueadero',
      latlng: LatLng(-12.10647243936956, -77.04010939139208),
    ),
    MapPlaceData(
      title: '54 - Ciclo parqueadero',
      latlng: LatLng(-12.10684281528442, -77.04004208571303),
    ),
    MapPlaceData(
      title: '55 - Ciclo parqueadero',
      latlng: LatLng(-12.10706505964463, -77.03996134243395),
    ),
    MapPlaceData(
      title: '56 - Ciclo parqueadero',
      latlng: LatLng(-12.1062550715475, -77.04039566630877),
    ),
    MapPlaceData(
      title: '57 - Ciclo parqueadero',
      latlng: LatLng(-12.10757753269554, -77.03986093692225),
    ),
    MapPlaceData(
      title: '58 - Ciclo parqueadero',
      latlng: LatLng(-12.1010140115225, -77.05524013780762),
    ),
    MapPlaceData(
      title: '59 - Ciclo parqueadero',
      latlng: LatLng(-12.10136791993782, -77.0539587726439),
    ),
    MapPlaceData(
      title: '60 - Ciclo parqueadero',
      latlng: LatLng(-12.10101846949166, -77.05382223840063),
    ),
    MapPlaceData(
      title: '61 - Ciclo parqueadero',
      latlng: LatLng(-12.10122697159331, -77.05374396058288),
    ),
    MapPlaceData(
      title: '62 - Ciclo parqueadero',
      latlng: LatLng(-12.10727883511322, -77.05560965304733),
    ),
    MapPlaceData(
      title: '63 - Ciclo parqueadero',
      latlng: LatLng(-12.10833662894259, -77.04926289117378),
    ),
    MapPlaceData(
      title: '64 - Ciclo parqueadero',
      latlng: LatLng(-12.10839722407515, -77.04923321381723),
    ),
    MapPlaceData(
      title: '65 - Ciclo parqueadero',
      latlng: LatLng(-12.10588390763308, -77.04856346722055),
    ),
    MapPlaceData(
      title: '66 - Ciclo parqueadero',
      latlng: LatLng(-12.10772722959755, -77.0574207581718),
    ),
    MapPlaceData(
      title: '67 - Ciclo parqueadero',
      latlng: LatLng(-12.10564395936345, -77.05979006595861),
    ),
    MapPlaceData(
      title: '68 - Ciclo parqueadero',
      latlng: LatLng(-12.10643235793452, -77.05010748407189),
    ),
    MapPlaceData(
      title: '69 - Ciclo parqueadero',
      latlng: LatLng(-12.10526704996449, -77.05955197854213),
    ),
    MapPlaceData(
      title: '70 - Ciclo parqueadero',
      latlng: LatLng(-12.0988968184527, -77.05835075832636),
    ),
    MapPlaceData(
      title: '71 - Ciclo parqueadero',
      latlng: LatLng(-12.10794962783061, -77.05013577116227),
    ),
    MapPlaceData(
      title: '72 - Ciclo parqueadero',
      latlng: LatLng(-12.10710708283907, -77.05474043676728),
    ),
    MapPlaceData(
      title: '73 - Ciclo parqueadero',
      latlng: LatLng(-12.10644887144957, -77.04035176307346),
    ),
    MapPlaceData(
      title: '74 - Ciclo parqueadero',
      latlng: LatLng(-12.10986442590132, -77.03715598513662),
    ),
    MapPlaceData(
      title: '75 - Ciclo parqueadero',
      latlng: LatLng(-12.09163848133476, -77.03392307631044),
    ),
    MapPlaceData(
      title: '76 - Ciclo parqueadero',
      latlng: LatLng(-12.10118759146447, -77.03672372461322),
    ),
    MapPlaceData(
      title: '77 - Ciclo parqueadero',
      latlng: LatLng(-12.10890990470221, -77.03849454710638),
    ),
    MapPlaceData(
      title: '78 - Ciclo parqueadero',
      latlng: LatLng(-12.10388267819856, -77.03784721532412),
    ),
    MapPlaceData(
      title: '79 - Ciclo parqueadero',
      latlng: LatLng(-12.09965380188719, -77.0372980872461),
    ),
    MapPlaceData(
      title: '80 - Ciclo parqueadero',
      latlng: LatLng(-12.09955450294821, -77.03492317478148),
    ),
    MapPlaceData(
      title: '81 - Ciclo parqueadero',
      latlng: LatLng(-12.09482482576678, -77.0376120071038),
    ),
    MapPlaceData(
      title: '82 - Ciclo parqueadero',
      latlng: LatLng(-12.09663249243472, -77.03603614017234),
    ),
    MapPlaceData(
      title: '83 - Ciclo parqueadero',
      latlng: LatLng(-12.09735906165147, -77.03641972838209),
    ),
    MapPlaceData(
      title: '84 - Ciclo parqueadero',
      latlng: LatLng(-12.09772736067841, -77.03660011246649),
    ),
    MapPlaceData(
      title: '85 - Ciclo parqueadero',
      latlng: LatLng(-12.09800638582847, -77.03678967263001),
    ),
    MapPlaceData(
      title: '86 - Ciclo parqueadero',
      latlng: LatLng(-12.10092506830432, -77.03685554992718),
    ),
    MapPlaceData(
      title: '87 - Ciclo parqueadero',
      latlng: LatLng(-12.10196589673762, -77.03667490114267),
    ),
    MapPlaceData(
      title: '88 - Ciclo parqueadero',
      latlng: LatLng(-12.10132456762867, -77.03691165598003),
    ),
    MapPlaceData(
      title: '89 - Ciclo parqueadero',
      latlng: LatLng(-12.10339540147835, -77.03688133165693),
    ),
    MapPlaceData(
      title: '90 - Ciclo parqueadero',
      latlng: LatLng(-12.10545100992769, -77.03729006511571),
    ),
    MapPlaceData(
      title: '91 - Ciclo parqueadero',
      latlng: LatLng(-12.09731554508583, -77.03533152977842),
    ),
    MapPlaceData(
      title: '92 - Ciclo parqueadero',
      latlng: LatLng(-12.09693812391223, -77.03543282561996),
    ),
    MapPlaceData(
      title: '93 - Ciclo parqueadero',
      latlng: LatLng(-12.09138085504765, -77.0383111831741),
    ),
    MapPlaceData(
      title: '94 - Ciclo parqueadero',
      latlng: LatLng(-12.0911116332793, -77.03654702280774),
    ),
    MapPlaceData(
      title: '95 - Ciclo parqueadero',
      latlng: LatLng(-12.10746088623864, -77.0371142979711),
    ),
    MapPlaceData(
      title: '96 - Ciclo parqueadero',
      latlng: LatLng(-12.10814375553958, -77.03712701602814),
    ),
    MapPlaceData(
      title: '97 - Ciclo parqueadero',
      latlng: LatLng(-12.10954984508234, -77.03706367571577),
    ),
    MapPlaceData(
      title: '98 - Ciclo parqueadero',
      latlng: LatLng(-12.09891630953919, -77.03703661888235),
    ),
    MapPlaceData(
      title: '99 - Ciclo parqueadero',
      latlng: LatLng(-12.10363488229955, -77.03173298221357),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return MapWrapper(
      title: 'Ciclo',
      subTitle: 'PARQUEADEROS',
      mapName: 'Ubicaciones',
      places: data,
    );
  }
}
