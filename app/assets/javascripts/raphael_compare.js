
$(document).ready(function(){
  var bar_width = 300;
  var bar_height = 30;
  var colors_x_edad = ["#FF0000", "#F00000", "#00F000", "#00FF00", "#0000F0", "#0000FF",
                       "#0F0F00", "#FF00F0", "#FF000F", "#FF0F00", "#0FF000", "#FF00FF"]
  var colors_representantes =["#FF0000", "#F0F000", "#0FF000", "#0FFF0F", "#0000F0", "#0000FF"]

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

  Raphael.fn.afiliados_compare_bar = function(max, dato){
    var paper = this;
    if(dato.total != null){
      var scale = dato.total / max
      var hombres_width = (dato.hombres / (dato.hombres + dato.mujeres)) * bar_width * scale;
      var mujeres_width = (bar_width * scale - hombres_width) ;

      var publico_bar = paper.rect(0, 0, hombres_width, bar_height).attr({
        "fill" : "#23DBB8",
        "stroke" : "none"
      });

      // publico_bar.txt = paper.text(5, 10, dato.hombres).attr({
      //   "font-family" : "Karla-Regular, Karla",
      //   "font-size" : 14,
      //   'text-anchor': 'start'
      // });
      //
      // publico_bar.mouseover(function () {
      //             //this.animate({"fill-opacity": 1, 'transform':"s2 2"}, 500);
      //         this.txt.show();
      //     })
      //     .mouseout(function () {
      //         //this.animate({"fill-opacity": 0.8, 'transform':"s0.5 0.5"}, 500);
      //         this.txt.hide();
      //     });

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

  Raphael.fn.ingreso_ord_compare_bar = function(dato, max_v){
    colors = ["#23dbb8", "#5a052a", "#19a58a", "#245d72", "#1ed6d6", "#17a5a5"];
    var paper = this;
    tmp = [];
    total = 0;
    adj = 1;
    if(dato.length > 0){
      for(var i=0; i<dato.length; i++){
        // tmp[i]/ ={"concepto": dato[i].concepto, "importe": dato[i].importe)};
        total += dato[i].importe;
      };
      if(max_v == total){
        adj = 1

      }else{
        adj = total / max_v
      }
      prev = 0;
      for(var i=0; i<dato.length; i++){
        this_w = (dato[i].importe/total) * bar_width * adj
        paper.rect(prev, 0, this_w, bar_height).attr({
          "title": dato[i].concepto + " : " + dato[i].importe,
          "fill" : colors[i],
          "stroke" : "none"
        });
        prev += this_w
      };

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

  Raphael.fn.ingreso_cam_compare_bar = function(dato, max_v){
      colors = ["#23dbb8", "#5a052a", "#19a58a", "#245d72", "#1ed6d6", "#17a5a5"];
      var paper = this;
      tmp = [];
      total = 0;
      adj = 1;
      if(dato.length > 0){
        for(var i=0; i<dato.length; i++){
          // tmp[i]/ ={"concepto": dato[i].concepto, "importe": dato[i].importe)};
          total += dato[i].monto;
        };
        if(max_v == total){
          adj = 1

        }else{
          adj = total / max_v
        }
        prev = 0;
        for(var i=0; i<dato.length; i++){
          this_w = (dato[i].monto/total) * bar_width * adj
          paper.rect(prev, 0, this_w, bar_height).attr({
            "title": dato[i].tipo_aporte + " : " + dato[i].monto,
            "fill" : colors[i],
            "stroke" : "none"
          });
          prev += this_w
        };

      } else {
        paper.text(50, 15, "Faltan datos.")
      }
    }

  Raphael.fn.ingreso_cam_header = function(){
    var paper = this;
    paper.circle(12, 15, 9 )
    .attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

    paper.text(28, 17, "Aportes 1")
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

    paper.text(207, 17, "Aportes 2")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });
  }

  Raphael.fn.egreso_cam_compare_bar = function(dato, max_v){
      colors = ["#23dbb8", "#5a052a", "#19a58a", "#245d72", "#1ed6d6", "#17a5a5"];
      var paper = this;
      tmp = [];
      total = 0;
      adj = 1;
      if(dato.length > 0){
        for(var i=0; i<dato.length; i++){
          // tmp[i]/ ={"concepto": dato[i].concepto, "importe": dato[i].importe)};
          total += dato[i].monto;
        };
        if(max_v == total){
          adj = 1

        }else{
          adj = total / max_v
        }
        prev = 0;
        for(var i=0; i<dato.length; i++){
          this_w = (dato[i].monto/total) * bar_width * adj
          paper.rect(prev, 0, this_w, bar_height).attr({
            "title": dato[i].tipo_campana + " : " + dato[i].monto,
            "fill" : colors[i],
            "stroke" : "none"
          });
          prev += this_w
        };

      } else {
        paper.text(50, 15, "Faltan datos.")
      }
    }

  Raphael.fn.transferencias_compare_bar = function(dato, max_v){
      colors = ["#23dbb8", "#5a052a", "#19a58a", "#245d72", "#1ed6d6", "#17a5a5"];
      var paper = this;
      tmp = [];
      total = 0;
      adj = 1;
      if(dato.length > 0){
        for(var i=0; i<dato.length; i++){
          // tmp[i]/ ={"concepto": dato[i].concepto, "importe": dato[i].importe)};
          total += Math.abs(dato[i].monto);
        };

        if(max_v == total){
          adj = 1

        }else{
          adj = total / max_v
        }
        prev = 0;
        // for(var i=0; i<dato.length; i++){
          // this_w = (dato[i].monto/total) * bar_width * adj
          this_w = 1 * bar_width * adj
          paper.rect(prev, 0, this_w, bar_height).attr({
            // "title": dato[i].descripcion + " : " + dato[i].monto,
            // "title": "total",
            "fill" : colors[0],
            "stroke" : "none"
          });
        //   prev += this_w
        // };

      } else {
        paper.text(50, 15, "Faltan datos.")
      }
    }

  Raphael.fn.contratacions_compare_bar = function(dato, max_v){
      colors = ["#23dbb8", "#5a052a", "#19a58a", "#245d72", "#1ed6d6", "#17a5a5"];
      var paper = this;
      tmp = [];
      total = 0;
      adj = 1;
      if(dato.length > 0){
        for(var i=0; i<dato.length; i++){
          // tmp[i]/ ={"concepto": dato[i].concepto, "importe": dato[i].importe)};
          total += Math.abs(dato[i].monto);
        };

        if(max_v == total){
          adj = 1

        }else{
          adj = total / max_v
        }
        prev = 0;
        // for(var i=0; i<dato.length; i++){
          // this_w = (dato[i].monto/total) * bar_width * adj
          this_w = 1 * bar_width * adj
          paper.rect(prev, 0, this_w, bar_height).attr({
            // "title": dato[i].descripcion + " : " + dato[i].monto,
            // "title": "total",
            "fill" : colors[0],
            "stroke" : "none"
          });
        //   prev += this_w
        // };

      } else {
        paper.text(50, 15, "Faltan datos.")
      }
    }

  Raphael.fn.egreso_cam_header = function(){
    var paper = this;
    paper.circle(12, 15, 9 )
    .attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

    paper.text(28, 17, "Aportes 1")
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

    paper.text(207, 17, "Aportes 2")
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
      "fill" : colors_representantes[0],
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
      "fill" : colors_representantes[1],
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
      "fill" : colors_representantes[2],
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
      "fill" : colors_representantes[3],
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
      "fill" : colors_representantes[4],
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
      "fill" : colors_representantes[5],
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
    var color = 0;
    switch (text) {
    case "Alcalde":
        color = 0;
        break;
    case "Concejal":
        color = 1;
        break;
    case "Diputado":
        color = 2;
        break;
    case "Senador":
        color = 3;
        break;
    case "Presidente":
        color = 4;
        break;
    case "Consejero Regional":
        color = 5;
        break;
    default:
        color = 0;
        break;
      }


    var bar = paper.rect(0, 0, width, bar_height).attr({
      "fill" : colors_representantes[color],
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
