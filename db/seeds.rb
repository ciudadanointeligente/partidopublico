Circunscripcion.create!([
  {nombre: "I Tarapacá"},
  {nombre: "II Antofagasta"},
  {nombre: "III Atacama"},
  {nombre: "IV Coquimbo"},
  {nombre: "V Valparaíso Cordillera"},
  {nombre: "VI Valparaíso Costa"},
  {nombre: "VII Santiago Poniente"},
  {nombre: "VIII Santiago Oriente"},
  {nombre: "IX O'Higgins"},
  {nombre: "X Maule Norte"},
  {nombre: "XI Maule Sur"},
  {nombre: "XII Biobío Costa"},
  {nombre: "XIII Biobío Cordillera"},
  {nombre: "XIV Araucanía Norte"},
  {nombre: "XV Araucanía Sur"},
  {nombre: "XVI Los Ríos"},
  {nombre: "XVII Los Lagos"},
  {nombre: "XVIII Aysén"},
  {nombre: "XIX Magallanes"}
])

Region.create!([
  {nombre: "Arica y Parinacota", ordinal: "XV"},
  {nombre: "Tarapacá", ordinal: "I"},
  {nombre: "Antofagasta", ordinal: "II"},
  {nombre: "Atacama", ordinal: "III"},
  {nombre: "Coquimbo", ordinal: "IV"},
  {nombre: "Valparaiso", ordinal: "V"},
  {nombre: "Metropolitana de Santiago", ordinal: "RM"},
  {nombre: "Libertador General Bernardo O'Higgins", ordinal: "VI"},
  {nombre: "Maule", ordinal: "VII"},
  {nombre: "Biobío", ordinal: "VIII"},
  {nombre: "La Araucanía", ordinal: "IX"},
  {nombre: "Los Ríos", ordinal: "XIV"},
  {nombre: "Los Lagos", ordinal: "X"},
  {nombre: "Aisén del General Carlos Ibáñez del Campo", ordinal: "XI"},
  {nombre: "Magallanes y de la Antártica Chilena", ordinal: "XII"}
])

Provincia.create!([
  {nombre: "Arica", region_id: 1},
  {nombre: "Parinacota", region_id: 1},
  {nombre: "Iquique", region_id: 2},
  {nombre: "El Tamarugal", region_id: 2},
  {nombre: "Antofagasta", region_id: 3},
  {nombre: "El Loa", region_id: 3},
  {nombre: "Tocopilla", region_id: 3},
  {nombre: "Chañaral", region_id: 4},
  {nombre: "Copiapó", region_id: 4},
  {nombre: "Huasco", region_id: 4},
  {nombre: "Choapa", region_id: 5},
  {nombre: "Elqui", region_id: 5},
  {nombre: "Limarí", region_id: 5},
  {nombre: "Isla de Pascua", region_id: 6},
  {nombre: "Los Andes", region_id: 6},
  {nombre: "Petorca", region_id: 6},
  {nombre: "Quillota", region_id: 6},
  {nombre: "San Antonio", region_id: 6},
  {nombre: "San Felipe de Aconcagua", region_id: 6},
  {nombre: "Valparaiso", region_id: 6},
  {nombre: "Chacabuco", region_id: 7},
  {nombre: "Cordillera", region_id: 7},
  {nombre: "Maipo", region_id: 7},
  {nombre: "Melipilla", region_id: 7},
  {nombre: "Santiago", region_id: 7},
  {nombre: "Talagante", region_id: 7},
  {nombre: "Cachapoal", region_id: 8},
  {nombre: "Cardenal Caro", region_id: 8},
  {nombre: "Colchagua", region_id: 8},
  {nombre: "Cauquenes", region_id: 9},
  {nombre: "Curicó", region_id: 9},
  {nombre: "Linares", region_id: 9},
  {nombre: "Talca", region_id: 9},
  {nombre: "Arauco", region_id: 10},
  {nombre: "Bio Bío", region_id: 10},
  {nombre: "Concepción", region_id: 10},
  {nombre: "Ñuble", region_id: 10},
  {nombre: "Cautín", region_id: 11},
  {nombre: "Malleco", region_id: 11},
  {nombre: "Valdivia", region_id: 12},
  {nombre: "Ranco", region_id: 12},
  {nombre: "Chiloé", region_id: 13},
  {nombre: "Llanquihue", region_id: 13},
  {nombre: "Osorno", region_id: 13},
  {nombre: "Palena", region_id: 13},
  {nombre: "Aisén", region_id: 14},
  {nombre: "Capitán Prat", region_id: 14},
  {nombre: "Coihaique", region_id: 14},
  {nombre: "General Carrera", region_id: 14},
  {nombre: "Antártica Chilena", region_id: 15},
  {nombre: "Magallanes", region_id: 15},
  {nombre: "Tierra del Fuego", region_id: 15},
  {nombre: "Última Esperanza", region_id: 15}
])

Comuna.create!([
  {provincia_id: 1, nombre: "Arica"},
  {provincia_id: 1, nombre: "Camarones"},
  {provincia_id: 2, nombre: "General Lagos"},
  {provincia_id: 2, nombre: "Putre"},
  {provincia_id: 3, nombre: "Alto Hospicio"},
  {provincia_id: 3, nombre: "Iquique"},
  {provincia_id: 4, nombre: "Camiña"},
  {provincia_id: 4, nombre: "Colchane"},
  {provincia_id: 4, nombre: "Huara"},
  {provincia_id: 4, nombre: "Pica"},
  {provincia_id: 4, nombre: "Pozo Almonte"},
  {provincia_id: 5, nombre: "Antofagasta"},
  {provincia_id: 5, nombre: "Mejillones"},
  {provincia_id: 5, nombre: "Sierra Gorda"},
  {provincia_id: 5, nombre: "Taltal"},
  {provincia_id: 6, nombre: "Calama"},
  {provincia_id: 6, nombre: "Ollague"},
  {provincia_id: 6, nombre: "San Pedro de Atacama"},
  {provincia_id: 7, nombre: "María Elena"},
  {provincia_id: 7, nombre: "Tocopilla"},
  {provincia_id: 8, nombre: "Chañaral"},
  {provincia_id: 8, nombre: "Diego de Almagro"},
  {provincia_id: 9, nombre: "Caldera"},
  {provincia_id: 9, nombre: "Copiapó"},
  {provincia_id: 9, nombre: "Tierra Amarilla"},
  {provincia_id: 10, nombre: "Alto del Carmen"},
  {provincia_id: 10, nombre: "Freirina"},
  {provincia_id: 10, nombre: "Huasco"},
  {provincia_id: 10, nombre: "Vallenar"},
  {provincia_id: 11, nombre: "Canela"},
  {provincia_id: 11, nombre: "Illapel"},
  {provincia_id: 11, nombre: "Los Vilos"},
  {provincia_id: 11, nombre: "Salamanca"},
  {provincia_id: 12, nombre: "Andacollo"},
  {provincia_id: 12, nombre: "Coquimbo"},
  {provincia_id: 12, nombre: "La Higuera"},
  {provincia_id: 12, nombre: "La Serena"},
  {provincia_id: 12, nombre: "Paihuaco"},
  {provincia_id: 12, nombre: "Vicuña"},
  {provincia_id: 13, nombre: "Combarbalá"},
  {provincia_id: 13, nombre: "Monte Patria"},
  {provincia_id: 13, nombre: "Ovalle"},
  {provincia_id: 13, nombre: "Punitaqui"},
  {provincia_id: 13, nombre: "Río Hurtado"},
  {provincia_id: 14, nombre: "Isla de Pascua"},
  {provincia_id: 15, nombre: "Calle Larga"},
  {provincia_id: 15, nombre: "Los Andes"},
  {provincia_id: 15, nombre: "Rinconada"},
  {provincia_id: 15, nombre: "San Esteban"},
  {provincia_id: 16, nombre: "La Ligua"},
  {provincia_id: 16, nombre: "Papudo"},
  {provincia_id: 16, nombre: "Petorca"},
  {provincia_id: 16, nombre: "Zapallar"},
  {provincia_id: 17, nombre: "Hijuelas"},
  {provincia_id: 17, nombre: "La Calera"},
  {provincia_id: 17, nombre: "La Cruz"},
  {provincia_id: 17, nombre: "Limache"},
  {provincia_id: 17, nombre: "Nogales"},
  {provincia_id: 17, nombre: "Olmué"},
  {provincia_id: 17, nombre: "Quillota"},
  {provincia_id: 18, nombre: "Algarrobo"},
  {provincia_id: 18, nombre: "Cartagena"},
  {provincia_id: 18, nombre: "El Quisco"},
  {provincia_id: 18, nombre: "El Tabo"},
  {provincia_id: 18, nombre: "San Antonio"},
  {provincia_id: 18, nombre: "Santo Domingo"},
  {provincia_id: 19, nombre: "Catemu"},
  {provincia_id: 19, nombre: "Llaillay"},
  {provincia_id: 19, nombre: "Panquehue"},
  {provincia_id: 19, nombre: "Putaendo"},
  {provincia_id: 19, nombre: "San Felipe"},
  {provincia_id: 19, nombre: "Santa María"},
  {provincia_id: 20, nombre: "Casablanca"},
  {provincia_id: 20, nombre: "Concón"},
  {provincia_id: 20, nombre: "Juan Fernández"},
  {provincia_id: 20, nombre: "Puchuncaví"},
  {provincia_id: 20, nombre: "Quilpué"},
  {provincia_id: 20, nombre: "Quintero"},
  {provincia_id: 20, nombre: "Valparaíso"},
  {provincia_id: 20, nombre: "Villa Alemana"},
  {provincia_id: 20, nombre: "Viña del Mar"},
  {provincia_id: 21, nombre: "Colina"},
  {provincia_id: 21, nombre: "Lampa"},
  {provincia_id: 21, nombre: "Tiltil"},
  {provincia_id: 22, nombre: "Pirque"},
  {provincia_id: 22, nombre: "Puente Alto"},
  {provincia_id: 22, nombre: "San José de Maipo"},
  {provincia_id: 23, nombre: "Buin"},
  {provincia_id: 23, nombre: "Calera de Tango"},
  {provincia_id: 23, nombre: "Paine"},
  {provincia_id: 23, nombre: "San Bernardo"},
  {provincia_id: 24, nombre: "Alhué"},
  {provincia_id: 24, nombre: "Curacaví"},
  {provincia_id: 24, nombre: "María Pinto"},
  {provincia_id: 24, nombre: "Melipilla"},
  {provincia_id: 24, nombre: "San Pedro"},
  {provincia_id: 25, nombre: "Cerrillos"},
  {provincia_id: 25, nombre: "Cerro Navia"},
  {provincia_id: 25, nombre: "Conchalí"},
  {provincia_id: 25, nombre: "El Bosque"},
  {provincia_id: 25, nombre: "Estación Central"},
  {provincia_id: 25, nombre: "Huechuraba"},
  {provincia_id: 25, nombre: "Independencia"},
  {provincia_id: 25, nombre: "La Cisterna"},
  {provincia_id: 25, nombre: "La Granja"},
  {provincia_id: 25, nombre: "La Florida"},
  {provincia_id: 25, nombre: "La Pintana"},
  {provincia_id: 25, nombre: "La Reina"},
  {provincia_id: 25, nombre: "Las Condes"},
  {provincia_id: 25, nombre: "Lo Barnechea"},
  {provincia_id: 25, nombre: "Lo Espejo"},
  {provincia_id: 25, nombre: "Lo Prado"},
  {provincia_id: 25, nombre: "Macul"},
  {provincia_id: 25, nombre: "Maipú"},
  {provincia_id: 25, nombre: "Ñuñoa"},
  {provincia_id: 25, nombre: "Pedro Aguirre Cerda"},
  {provincia_id: 25, nombre: "Peñalolén"},
  {provincia_id: 25, nombre: "Providencia"},
  {provincia_id: 25, nombre: "Pudahuel"},
  {provincia_id: 25, nombre: "Quilicura"},
  {provincia_id: 25, nombre: "Quinta Normal"},
  {provincia_id: 25, nombre: "Recoleta"},
  {provincia_id: 25, nombre: "Renca"},
  {provincia_id: 25, nombre: "San Miguel"},
  {provincia_id: 25, nombre: "San Joaquín"},
  {provincia_id: 25, nombre: "San Ramón"},
  {provincia_id: 25, nombre: "Santiago"},
  {provincia_id: 25, nombre: "Vitacura"},
  {provincia_id: 26, nombre: "El Monte"},
  {provincia_id: 26, nombre: "Isla de Maipo"},
  {provincia_id: 26, nombre: "Padre Hurtado"},
  {provincia_id: 26, nombre: "Peñaflor"},
  {provincia_id: 26, nombre: "Talagante"},
  {provincia_id: 27, nombre: "Codegua"},
  {provincia_id: 27, nombre: "Coínco"},
  {provincia_id: 27, nombre: "Coltauco"},
  {provincia_id: 27, nombre: "Doñihue"},
  {provincia_id: 27, nombre: "Graneros"},
  {provincia_id: 27, nombre: "Las Cabras"},
  {provincia_id: 27, nombre: "Machalí"},
  {provincia_id: 27, nombre: "Malloa"},
  {provincia_id: 27, nombre: "Mostazal"},
  {provincia_id: 27, nombre: "Olivar"},
  {provincia_id: 27, nombre: "Peumo"},
  {provincia_id: 27, nombre: "Pichidegua"},
  {provincia_id: 27, nombre: "Quinta de Tilcoco"},
  {provincia_id: 27, nombre: "Rancagua"},
  {provincia_id: 27, nombre: "Rengo"},
  {provincia_id: 27, nombre: "Requínoa"},
  {provincia_id: 27, nombre: "San Vicente de Tagua Tagua"},
  {provincia_id: 28, nombre: "La Estrella"},
  {provincia_id: 28, nombre: "Litueche"},
  {provincia_id: 28, nombre: "Marchihue"},
  {provincia_id: 28, nombre: "Navidad"},
  {provincia_id: 28, nombre: "Peredones"},
  {provincia_id: 28, nombre: "Pichilemu"},
  {provincia_id: 29, nombre: "Chépica"},
  {provincia_id: 29, nombre: "Chimbarongo"},
  {provincia_id: 29, nombre: "Lolol"},
  {provincia_id: 29, nombre: "Nancagua"},
  {provincia_id: 29, nombre: "Palmilla"},
  {provincia_id: 29, nombre: "Peralillo"},
  {provincia_id: 29, nombre: "Placilla"},
  {provincia_id: 29, nombre: "Pumanque"},
  {provincia_id: 29, nombre: "San Fernando"},
  {provincia_id: 29, nombre: "Santa Cruz"},
  {provincia_id: 30, nombre: "Cauquenes"},
  {provincia_id: 30, nombre: "Chanco"},
  {provincia_id: 30, nombre: "Pelluhue"},
  {provincia_id: 31, nombre: "Curicó"},
  {provincia_id: 31, nombre: "Hualañé"},
  {provincia_id: 31, nombre: "Licantén"},
  {provincia_id: 31, nombre: "Molina"},
  {provincia_id: 31, nombre: "Rauco"},
  {provincia_id: 31, nombre: "Romeral"},
  {provincia_id: 31, nombre: "Sagrada Familia"},
  {provincia_id: 31, nombre: "Teno"},
  {provincia_id: 31, nombre: "Vichuquén"},
  {provincia_id: 32, nombre: "Colbún"},
  {provincia_id: 32, nombre: "Linares"},
  {provincia_id: 32, nombre: "Longaví"},
  {provincia_id: 32, nombre: "Parral"},
  {provincia_id: 32, nombre: "Retiro"},
  {provincia_id: 32, nombre: "San Javier"},
  {provincia_id: 32, nombre: "Villa Alegre"},
  {provincia_id: 32, nombre: "Yerbas Buenas"},
  {provincia_id: 33, nombre: "Constitución"},
  {provincia_id: 33, nombre: "Curepto"},
  {provincia_id: 33, nombre: "Empedrado"},
  {provincia_id: 33, nombre: "Maule"},
  {provincia_id: 33, nombre: "Pelarco"},
  {provincia_id: 33, nombre: "Pencahue"},
  {provincia_id: 33, nombre: "Río Claro"},
  {provincia_id: 33, nombre: "San Clemente"},
  {provincia_id: 33, nombre: "San Rafael"},
  {provincia_id: 33, nombre: "Talca"},
  {provincia_id: 34, nombre: "Arauco"},
  {provincia_id: 34, nombre: "Cañete"},
  {provincia_id: 34, nombre: "Contulmo"},
  {provincia_id: 34, nombre: "Curanilahue"},
  {provincia_id: 34, nombre: "Lebu"},
  {provincia_id: 34, nombre: "Los Álamos"},
  {provincia_id: 34, nombre: "Tirúa"},
  {provincia_id: 35, nombre: "Alto Biobío"},
  {provincia_id: 35, nombre: "Antuco"},
  {provincia_id: 35, nombre: "Cabrero"},
  {provincia_id: 35, nombre: "Laja"},
  {provincia_id: 35, nombre: "Los Ángeles"},
  {provincia_id: 35, nombre: "Mulchén"},
  {provincia_id: 35, nombre: "Nacimiento"},
  {provincia_id: 35, nombre: "Negrete"},
  {provincia_id: 35, nombre: "Quilaco"},
  {provincia_id: 35, nombre: "Quilleco"},
  {provincia_id: 35, nombre: "San Rosendo"},
  {provincia_id: 35, nombre: "Santa Bárbara"},
  {provincia_id: 35, nombre: "Tucapel"},
  {provincia_id: 35, nombre: "Yumbel"},
  {provincia_id: 36, nombre: "Chiguayante"},
  {provincia_id: 36, nombre: "Concepción"},
  {provincia_id: 36, nombre: "Coronel"},
  {provincia_id: 36, nombre: "Florida"},
  {provincia_id: 36, nombre: "Hualpén"},
  {provincia_id: 36, nombre: "Hualqui"},
  {provincia_id: 36, nombre: "Lota"},
  {provincia_id: 36, nombre: "Penco"},
  {provincia_id: 36, nombre: "San Pedro de La Paz"},
  {provincia_id: 36, nombre: "Santa Juana"},
  {provincia_id: 36, nombre: "Talcahuano"},
  {provincia_id: 36, nombre: "Tomé"},
  {provincia_id: 37, nombre: "Bulnes"},
  {provincia_id: 37, nombre: "Chillán"},
  {provincia_id: 37, nombre: "Chillán Viejo"},
  {provincia_id: 37, nombre: "Cobquecura"},
  {provincia_id: 37, nombre: "Coelemu"},
  {provincia_id: 37, nombre: "Coihueco"},
  {provincia_id: 37, nombre: "El Carmen"},
  {provincia_id: 37, nombre: "Ninhue"},
  {provincia_id: 37, nombre: "Ñiquen"},
  {provincia_id: 37, nombre: "Pemuco"},
  {provincia_id: 37, nombre: "Pinto"},
  {provincia_id: 37, nombre: "Portezuelo"},
  {provincia_id: 37, nombre: "Quillón"},
  {provincia_id: 37, nombre: "Quirihue"},
  {provincia_id: 37, nombre: "Ránquil"},
  {provincia_id: 37, nombre: "San Carlos"},
  {provincia_id: 37, nombre: "San Fabián"},
  {provincia_id: 37, nombre: "San Ignacio"},
  {provincia_id: 37, nombre: "San Nicolás"},
  {provincia_id: 37, nombre: "Treguaco"},
  {provincia_id: 37, nombre: "Yungay"},
  {provincia_id: 38, nombre: "Carahue"},
  {provincia_id: 38, nombre: "Cholchol"},
  {provincia_id: 38, nombre: "Cunco"},
  {provincia_id: 38, nombre: "Curarrehue"},
  {provincia_id: 38, nombre: "Freire"},
  {provincia_id: 38, nombre: "Galvarino"},
  {provincia_id: 38, nombre: "Gorbea"},
  {provincia_id: 38, nombre: "Lautaro"},
  {provincia_id: 38, nombre: "Loncoche"},
  {provincia_id: 38, nombre: "Melipeuco"},
  {provincia_id: 38, nombre: "Nueva Imperial"},
  {provincia_id: 38, nombre: "Padre Las Casas"},
  {provincia_id: 38, nombre: "Perquenco"},
  {provincia_id: 38, nombre: "Pitrufquén"},
  {provincia_id: 38, nombre: "Pucón"},
  {provincia_id: 38, nombre: "Saavedra"},
  {provincia_id: 38, nombre: "Temuco"},
  {provincia_id: 38, nombre: "Teodoro Schmidt"},
  {provincia_id: 38, nombre: "Toltén"},
  {provincia_id: 38, nombre: "Vilcún"},
  {provincia_id: 38, nombre: "Villarrica"},
  {provincia_id: 39, nombre: "Angol"},
  {provincia_id: 39, nombre: "Collipulli"},
  {provincia_id: 39, nombre: "Curacautín"},
  {provincia_id: 39, nombre: "Ercilla"},
  {provincia_id: 39, nombre: "Lonquimay"},
  {provincia_id: 39, nombre: "Los Sauces"},
  {provincia_id: 39, nombre: "Lumaco"},
  {provincia_id: 39, nombre: "Purén"},
  {provincia_id: 39, nombre: "Renaico"},
  {provincia_id: 39, nombre: "Traiguén"},
  {provincia_id: 39, nombre: "Victoria"},
  {provincia_id: 40, nombre: "Corral"},
  {provincia_id: 40, nombre: "Lanco"},
  {provincia_id: 40, nombre: "Los Lagos"},
  {provincia_id: 40, nombre: "Máfil"},
  {provincia_id: 40, nombre: "Mariquina"},
  {provincia_id: 40, nombre: "Paillaco"},
  {provincia_id: 40, nombre: "Panguipulli"},
  {provincia_id: 40, nombre: "Valdivia"},
  {provincia_id: 41, nombre: "Futrono"},
  {provincia_id: 41, nombre: "La Unión"},
  {provincia_id: 41, nombre: "Lago Ranco"},
  {provincia_id: 41, nombre: "Río Bueno"},
  {provincia_id: 42, nombre: "Ancud"},
  {provincia_id: 42, nombre: "Castro"},
  {provincia_id: 42, nombre: "Chonchi"},
  {provincia_id: 42, nombre: "Curaco de Vélez"},
  {provincia_id: 42, nombre: "Dalcahue"},
  {provincia_id: 42, nombre: "Puqueldón"},
  {provincia_id: 42, nombre: "Queilén"},
  {provincia_id: 42, nombre: "Quemchi"},
  {provincia_id: 42, nombre: "Quellón"},
  {provincia_id: 42, nombre: "Quinchao"},
  {provincia_id: 43, nombre: "Calbuco"},
  {provincia_id: 43, nombre: "Cochamó"},
  {provincia_id: 43, nombre: "Fresia"},
  {provincia_id: 43, nombre: "Frutillar"},
  {provincia_id: 43, nombre: "Llanquihue"},
  {provincia_id: 43, nombre: "Los Muermos"},
  {provincia_id: 43, nombre: "Maullín"},
  {provincia_id: 43, nombre: "Puerto Montt"},
  {provincia_id: 43, nombre: "Puerto Varas"},
  {provincia_id: 44, nombre: "Osorno"},
  {provincia_id: 44, nombre: "Puero Octay"},
  {provincia_id: 44, nombre: "Purranque"},
  {provincia_id: 44, nombre: "Puyehue"},
  {provincia_id: 44, nombre: "Río Negro"},
  {provincia_id: 44, nombre: "San Juan de la Costa"},
  {provincia_id: 44, nombre: "San Pablo"},
  {provincia_id: 45, nombre: "Chaitén"},
  {provincia_id: 45, nombre: "Futaleufú"},
  {provincia_id: 45, nombre: "Hualaihué"},
  {provincia_id: 45, nombre: "Palena"},
  {provincia_id: 46, nombre: "Aisén"},
  {provincia_id: 46, nombre: "Cisnes"},
  {provincia_id: 46, nombre: "Guaitecas"},
  {provincia_id: 47, nombre: "Cochrane"},
  {provincia_id: 47, nombre: "O'higgins"},
  {provincia_id: 47, nombre: "Tortel"},
  {provincia_id: 48, nombre: "Coihaique"},
  {provincia_id: 48, nombre: "Lago Verde"},
  {provincia_id: 49, nombre: "Chile Chico"},
  {provincia_id: 49, nombre: "Río Ibáñez"},
  {provincia_id: 50, nombre: "Antártica"},
  {provincia_id: 50, nombre: "Cabo de Hornos"},
  {provincia_id: 51, nombre: "Laguna Blanca"},
  {provincia_id: 51, nombre: "Punta Arenas"},
  {provincia_id: 51, nombre: "Río Verde"},
  {provincia_id: 51, nombre: "San Gregorio"},
  {provincia_id: 52, nombre: "Porvenir"},
  {provincia_id: 52, nombre: "Primavera"},
  {provincia_id: 52, nombre: "Timaukel"},
  {provincia_id: 53, nombre: "Natales"},
  {provincia_id: 53, nombre: "Torres del Paine"}
])

Distrito.create!([
  {circunscripcion_id: 1, nombre: "1"},
  {circunscripcion_id: 1, nombre: "2"},
  {circunscripcion_id: 2, nombre: "3"},
  {circunscripcion_id: 2, nombre: "4"},
  {circunscripcion_id: 3, nombre: "5"},
  {circunscripcion_id: 3, nombre: "6"},
  {circunscripcion_id: 4, nombre: "7"},
  {circunscripcion_id: 4, nombre: "8"},
  {circunscripcion_id: 4, nombre: "9"},
  {circunscripcion_id: 5, nombre: "10"},
  {circunscripcion_id: 5, nombre: "11"},
  {circunscripcion_id: 5, nombre: "12"},
  {circunscripcion_id: 6, nombre: "13"},
  {circunscripcion_id: 6, nombre: "14"},
  {circunscripcion_id: 6, nombre: "15"},
  {circunscripcion_id: 7, nombre: "16"},
  {circunscripcion_id: 7, nombre: "17"},
  {circunscripcion_id: 7, nombre: "18"},
  {circunscripcion_id: 7, nombre: "19"},
  {circunscripcion_id: 7, nombre: "20"},
  {circunscripcion_id: 7, nombre: "22"},
  {circunscripcion_id: 7, nombre: "30"},
  {circunscripcion_id: 7, nombre: "31"},
  {circunscripcion_id: 8, nombre: "21"},
  {circunscripcion_id: 8, nombre: "23"},
  {circunscripcion_id: 8, nombre: "24"},
  {circunscripcion_id: 8, nombre: "25"},
  {circunscripcion_id: 8, nombre: "26"},
  {circunscripcion_id: 8, nombre: "27"},
  {circunscripcion_id: 8, nombre: "28"},
  {circunscripcion_id: 8, nombre: "29"},
  {circunscripcion_id: 9, nombre: "32"},
  {circunscripcion_id: 9, nombre: "33"},
  {circunscripcion_id: 9, nombre: "34"},
  {circunscripcion_id: 9, nombre: "35"},
  {circunscripcion_id: 10, nombre: "36"},
  {circunscripcion_id: 10, nombre: "37"},
  {circunscripcion_id: 10, nombre: "38"},
  {circunscripcion_id: 11, nombre: "39"},
  {circunscripcion_id: 11, nombre: "40"},
  {circunscripcion_id: 12, nombre: "42"},
  {circunscripcion_id: 12, nombre: "43"},
  {circunscripcion_id: 12, nombre: "44"},
  {circunscripcion_id: 12, nombre: "45"},
  {circunscripcion_id: 13, nombre: "41"},
  {circunscripcion_id: 13, nombre: "46"},
  {circunscripcion_id: 13, nombre: "47"},
  {circunscripcion_id: 14, nombre: "48"},
  {circunscripcion_id: 14, nombre: "49"},
  {circunscripcion_id: 15, nombre: "50"},
  {circunscripcion_id: 15, nombre: "51"},
  {circunscripcion_id: 15, nombre: "52"},
  {circunscripcion_id: 16, nombre: "53"},
  {circunscripcion_id: 16, nombre: "54"},
  {circunscripcion_id: 17, nombre: "55"},
  {circunscripcion_id: 17, nombre: "56"},
  {circunscripcion_id: 17, nombre: "57"},
  {circunscripcion_id: 17, nombre: "58"},
  {circunscripcion_id: 18, nombre: "59"},
  {circunscripcion_id: 19, nombre: "60"}
])

Admin.create!([
  {email: "papu@ciudadanointeligente.org", password: "xxxxxxxx", password_confirmation: "xxxxxxxx", is_superadmin: true}
])

Partido.create!([
  {nombre: "Partido Demócrata Cristiano", sigla: "PDC", lema: "Partido Demócrata Cristiano"},
  {nombre: "Partido Revolución Democrática", sigla: "PRD", lema: "Partido Revolución Democrática"},
  {nombre: "Partido Liberal", sigla: "PL", lema: "Partido Liberal"},
  {nombre: "Partido Por la Democracia", sigla: "PPD", lema: "Partido Por la Democracia"},
  {nombre: "Partido Comunista de Chile", sigla: "PCC", lema: "Partido Comunista de Chile"},
  {nombre: "Partido Amplitud", sigla: "PA", lema: "Partido Amplitud"},
  {nombre: "Partido Ciudadanos", sigla: "PC", lema: "Partido Ciudadanos"},
])
