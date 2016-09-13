$(document).ready(function(){
  var bar_width = 300;
  var bar_height = 30;
  var colors_x_edad = ["#FF0000", "#F00000", "#00F000", "#00FF00", "#0000F0", "#0000FF",
                       "#0F0F00", "#FF00F0", "#FF000F", "#FF0F00", "#0FF000", "#FF00FF"]

  Raphael.fn.afiliados_compare_header = function(){
    var paper = this;
    paper.circle(12, 15, 9 )
    .attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

    paper.text(28, 17, "Hombres")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

    paper.circle(191, 15, 9 )
    .attr({
      "fill" : "#19A58A",
      "stroke" : "none"
    });

    paper.text(207, 17, "Mujeres")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });
  }

  Raphael.fn.afiliados_compare_bar = function(dato){
    var paper = this;
    if(dato.total != null){
      var hombres_width = (dato.hombres / (dato.hombres + dato.mujeres)) * bar_width;
      var mujeres_width = bar_width - hombres_width;

      var publico_bar = paper.rect(0, 0, hombres_width, bar_height).attr({
        "fill" : "#23DBB8",
        "stroke" : "none"
      });

      var privado_bar = paper.rect(hombres_width, 0, mujeres_width, bar_height).attr({
        "fill" : "#19a58a",
        "stroke" : "none"
      });
    } else {
      paper.text(50, 15, "Faltan datos.")
    }


  }

  Raphael.fn.regiones_compare_chart = function(datos){
    var paper = this;
    var header_height = 40;
    var line_height = 50;
    var chart_width = 800;
    var header_ordinals = ["I","II","III","IV","V","VI","VII","VIII","IX","X","XI","XII","RM","XIV","XV"]

    function regiones_compare_header(){

      paper.circle(12, 15, 9 )
      .attr({
        "fill" : "#19A58A",
        "stroke" : "none"
      });

      paper.text(28, 17, "Constituido")
      .attr({
        "font-family" : "Karla-Regular, Karla",
        "font-size" : 14,
        'text-anchor': 'start'
      });

      paper.circle(247, 15, 9 )
      .attr({
        "fill" : "#c0c0c0",
        "stroke" : "none"
      });

      paper.text(263, 17, "No Constituido")
      .attr({
        "font-family" : "Karla-Regular, Karla",
        "font-size" : 14,
        'text-anchor': 'start'
      });

      paper.text(10, header_height + 20, "Partido")
      .attr({
        "font-family" : "Karla-Regular, Karla",
        "font-size" : 16,
        'text-anchor': 'start',
        'font-weight' : "bold"
      });

      for(var o=0; o < header_ordinals.length; o++){
        paper.text(235 + o * 37 , header_height + 20, header_ordinals[o])
        .attr({
          "font-family" : "Karla-Regular, Karla",
          "font-size" : 16,
          'text-anchor': 'start',
          'font-weight' : "bold"
        });
      }


    };

    function regions_compare_detail(line_num, nombre, sigla, array_regiones){
      var x = 0;
      var y = header_height + (line_height * line_num);
      var array = array_regiones;

      paper.path(["M", x +10 , y, chart_width - 10, y])

      var detail_label = paper.text(x + 10, y + line_height / 2 , nombre)
           .attr({
             "font-family" : "Karla-Regular, Karla",
             "font-size" : 14,
             'text-anchor': 'start'
           });

      for(var r = 0; r < array.length; r++){
        var color;
        if(!array[r]){
          color = "#c0c0c0";
        }else{
          color = "#19A58A"
        }

        paper.circle(240 + r * 37, y + line_height / 2, 9 )
        .attr({
          "fill" : color,
          "stroke" : "none"
        });

      }
    }

    var header = regiones_compare_header();

    for( var x = 0, y = datos.length; x<y; x++ ){

      var p = regions_compare_detail(x + 1, datos[x].nombre, datos[x].sigla, datos[x].mapa);

    }

  }

  Raphael.fn.ingreso_ord_compare_bar = function(dato){
    var paper = this;
    if(!dato.missing_data){
      var publico_width = (dato.total_publico / (dato.total_publico + dato.total_privado)) * bar_width;
      var privado_width = bar_width - publico_width;

      var publico_bar = paper.rect(0, 0, publico_width, bar_height).attr({
        "fill" : "#23DBB8",
        "stroke" : "none"
      });

      var privado_bar = paper.rect(publico_width, 0, privado_width, bar_height).attr({
        "fill" : "#19a58a",
        "stroke" : "none"
      });
    } else {
      paper.text(50, 15, "Faltan datos.")
    }


  }

  Raphael.fn.ingreso_ord_header = function(){
    var paper = this;
    paper.circle(12, 15, 9 )
    .attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

    paper.text(28, 17, "Aportes públicos")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

    paper.circle(191, 15, 9 )
    .attr({
      "fill" : "#19A58A",
      "stroke" : "none"
    });

    paper.text(207, 17, "Aportes privados")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });
  }

  Raphael.fn.representantes_compare_header = function(){
    var paper = this;
    paper.circle(12, 15, 9 )
    .attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

    paper.text(28, 17, "Alcaldes")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

    paper.circle(110, 15, 9 )
    .attr({
      "fill" : "#19A58A",
      "stroke" : "none"
    });

    paper.text(126, 17, "Concejales")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

    paper.circle(220, 15, 9 )
    .attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

    paper.text(236, 17, "Diputados")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

    paper.circle(320, 15, 9 )
    .attr({
      "fill" : "#19A58A",
      "stroke" : "none"
    });

    paper.text(336, 17, "Senadores")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

    paper.circle(430, 15, 9 )
    .attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

    paper.text(446, 17, "Presidentes")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

    paper.circle(540, 15, 9 )
    .attr({
      "fill" : "#19A58A",
      "stroke" : "none"
    });

    paper.text(556, 17, "Consejeros Regionales")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });
  }

  Raphael.fn.representantes_compare_bar = function(max, val, text){
    var paper = this;
    var width = (val / max) * bar_width;

    var bar = paper.rect(0, 0, width, bar_height).attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

  }

  Raphael.fn.edades_compare_header = function(data){
    var paper = this;
    for(var i = 0; i < data.tramos.length; i++ ){
      paper.circle(12 + (i * 90), 15, 9 )
      .attr({
        "fill" : colors_x_edad[i],
        "stroke" : "none"
      });

      paper.text(28 + (i * 90), 17, data.tramos[i].tramo[0] + "-" +  data.tramos[i].tramo[1] + " años")
      .attr({
        "font-family" : "Karla-Regular, Karla",
        "font-size" : 14,
        'text-anchor': 'start'
      });
    }
  }

  Raphael.fn.edades_compare_bar = function(max, data){
    var paper = this;
    var prev_width = 0;

    for(var i = 0; i < data.tramos.length; i++){
      var width = (data.tramos[i].count / max) * bar_width;
      var bar = paper.rect(prev_width, 0, width, bar_height).attr({
        "fill" : colors_x_edad[i],
        "stroke" : "none"
      });

      prev_width = prev_width + width;
    }
  }


  Raphael.fn.no_data_chart = function(){
    this.text(20 , 20, "No hay datos")
         .attr({
           "font-family" : "Karla-Regular, Karla",
           "font-size" : 30,
           'text-anchor': 'start',
           'font-weight' : "bold"
         });
  }

})
