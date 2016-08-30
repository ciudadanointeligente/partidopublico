$(document).ready(function(){
  Raphael.fn.afiliados_compare_chart = function(datos, datos_totales){
    var paper = this;
    var header_height = 40;
    var line_height = 50;
    var chart_width = 800;
    var bar_width = 300;
    var box_x_start = 300;
    var max_value = datos_totales[0].max_value;


    function afiliados_compare_header(){
      console.log("afiliados_compare_header");
      paper.circle(12, 15, 9 )
      .attr({
        "fill" : "#23DBB8",
        "stroke" : "none"
      });

      paper.text(28, 17, "Mujeres")
      .attr({
        "font-family" : "Karla-Regular, Karla",
        "font-size" : 14,
        'text-anchor': 'start'
      });

      paper.circle(247, 15, 9 )
      .attr({
        "fill" : "#19A58A",
        "stroke" : "none"
      });

      paper.text(263, 17, "Hombres")
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

      paper.text(chart_width - 20, header_height + 20, "Número de afiliados")
      .attr({
        "font-family" : "Karla-Regular, Karla",
        "font-size" : 16,
        'text-anchor': 'end',
        'font-weight' : "bold"
      });

    };

      function afiliados_detail(line_num, nombre, sigla, hombres, mujeres){
      var x = 0;
      var y = header_height + (line_height * line_num);
      var hombres_width = (hombres / max_value) * bar_width;
      var mujeres_width = bar_width - hombres_width;

      paper.path(["M", x +10 , y, chart_width - 10, y])

      var detail_label = paper.text(x + 10, y + line_height / 2 , nombre)
           .attr({
             "font-family" : "Karla-Regular, Karla",
             "font-size" : 14,
             'text-anchor': 'start'
           });
      var detail_number_label = paper.text(chart_width - 50, y + line_height / 2 , hombres + mujeres)
            .attr({
              "font-family" : "Karla-Regular, Karla",
              "font-size" : 14,
              'text-anchor': 'end'
            });

      var detail_hombres_box = paper.rect(box_x_start, y + line_height / 4, hombres_width, 30)
      .attr({
        "fill" : "#19a58a",
        "stroke" : "none"
      });

      var detail_mujeres_box = paper.rect(box_x_start + hombres_width, y + line_height / 4, mujeres_width, 30)
        .attr({
          "fill" : "#23DBB8",
          "stroke" : "none"
        });


    }
    // start drawing
    var p = afiliados_compare_header();

    for( var x = 0, y = datos.length; x<y; x++ ){

      var p = afiliados_detail(x + 1, datos[x].nombre, datos[x].sigla, datos[x].hombres, datos[x].mujeres);

    }
    // end drawing
  };

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

      var bar_width = 300;
      var bar_height = 30;
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
