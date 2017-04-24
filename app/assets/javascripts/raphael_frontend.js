$(document).ready(function(){
  var green = "#1AC0A4";
  var green_light = "#23DBB8";
  var green_dark = "#19A58A";
  var sky_light = "#78EEE8";
  var sky_dark = "#06B9BF";

    Raphael.fn.donutChart = function (cx, cy, r, rin, values, labels, stroke, legend, legendElement, colors) {
    var paper = this,
      rad = Math.PI / 180,
      chart = this.set();

    function sector(cx, cy, r, startAngle, endAngle, params) {
      var x1 = cx + r * Math.cos(-startAngle * rad),
        x2 = cx + r * Math.cos(-endAngle * rad),
        y1 = cy + r * Math.sin(-startAngle * rad),
        y2 = cy + r * Math.sin(-endAngle * rad),
        xx1 = cx + rin * Math.cos(-startAngle * rad),
        xx2 = cx + rin * Math.cos(-endAngle * rad),
        yy1 = cy + rin * Math.sin(-startAngle * rad),
        yy2 = cy + rin * Math.sin(-endAngle * rad);

       var cc = paper.path([
        "M", xx1, yy1,
          "L", x1, y1,
          "A", r, r, 0, +(endAngle - startAngle > 180), 0, x2, y2,
          "L", xx2, yy2,
          "A", rin, rin, 0, +(endAngle - startAngle > 180), 1, xx1, yy1, "z"
      ]).attr(params);
      // cc.node.id = params.fill;
      return cc ;

    }
    var angle = 0,
      total = 0,
      start = 0,
      PaddingTop = 0,
      process = function (j) {
        var value = values[j],
          angleplus = 360 * value / total,
          popangle = angle + (angleplus / 2),
          color = Raphael.hsb(start, .75, 1),
          ms = 200,
          delta = 25,
          bcolor = Raphael.hsb(start,1,1) ;
          bcolor = colors[j%colors.length];
          draw_params = {fill: "90-" + bcolor + "-" + bcolor, stroke: stroke, "stroke-width": 3}
          var p = sector(cx, cy, r, angle, angle + angleplus, draw_params);

          if (legend == true && legendElement) {
            switch(labels[j]) {
              case 'hombres':
                legendElement.append('<li><i class="fa fa-circle" aria-hidden="true" data-id='+ bcolor +' style="color:' + bcolor + ';"></i> ' + labels[j] + " : " + Math.floor(values[j]) + '</li>');
                break;
              case 'mujeres':
                legendElement.append('<li><i class="fa fa-circle" aria-hidden="true" data-id='+ bcolor +' style="color:' + bcolor + ';"></i> ' + labels[j] + " : " + Math.floor(values[j]) + '</li>');
                break;
              default:
                legendElement.append('<li><i class="fa fa-circle" aria-hidden="true" data-id='+ bcolor +' style="color:' + bcolor + ';"></i> ' + labels[j] + " : " + Math.floor(values[j]) + '</li>');
                break;
            }
          }

        // ****** Added BY SM ******* //
        var startangle=angle;
        var endangle= angle + angleplus;
        var middleangle = (startangle + endangle) / 2;

        var left = 0, top = 0;
        var percentcloseMaxValue=0;
        if (middleangle >= 0  && middleangle < 90){
        // top will be negative -10 to 0
        // left will be positive 0 to 10
          percentcloseMaxValue = middleangle/90;
          top = -10 * percentcloseMaxValue;
          left = 10 * (1 - percentcloseMaxValue);
        }
        if (middleangle >= 90  && middleangle < 180){
          // top will be negative -10 to 0
          // left will be negative -10 to 0
          percentcloseMaxValue = (180-middleangle)/90;
          top = -10 * percentcloseMaxValue;
          left = -10 * (1-percentcloseMaxValue);
        }

        if (middleangle >= 180  && middleangle < 270){
          // top will be positive 0 to 10
          // left will be negative -10 to 0
          percentcloseMaxValue = (270-middleangle)/90;
          top = 10 * (1 - percentcloseMaxValue);
          left = -10 * percentcloseMaxValue;
        }
        if (middleangle >= 270  && middleangle < 360){
        // top will be positive 0 to 10
        // left will be positive 0 to 10
          percentcloseMaxValue = (360-middleangle)/90;
          top = 10 * percentcloseMaxValue;
          left = 10 * (1 - percentcloseMaxValue);
        }

        // ************* //

        p.mouseover(function () {
          p.stop().animate({transform: "t" + left + "," + top + ", s1.05 1.05"}, ms, "easin");
        }).mouseout(function () {
          p.stop().animate({transform: ""}, ms, "easeout");
        });

        angle += angleplus;
        chart.push(p);
        start += .1;

      };

    for (var i = 0, ii = values.length; i < ii; i++) {
      total += values[i];
    }

    for (i = 0; i < ii; i++) {
      process(i);
    }

    return chart;
  };

  Raphael.fn.no_data_chart = function(){
    this.text(20 , 20, "No hay datos")
         .attr({
           "font-family" : "Karla-Regular, Karla",
           "font-size" : 30,
           'text-anchor': 'start',
           'font-weight' : "bold"
         });
  }

  Raphael.fn.ingreso_ord_front_header = function(){

    var paper = this;

    paper.circle(12, 15, 9 )
    .attr({
      "fill" : green_light,
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
      "fill" : green_dark,
      "stroke" : "none"
    });

    paper.text(207, 17, "Aportes privados")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

  };

  Raphael.fn.ingreso_ord_front_bar = function(dato){
    var paper = this;
    var bar_width = 300;
    var bar_height = 30;
    var ingreso_width = dato.percentage * bar_width;
    if (ingreso_width < 1) {
      ingreso_width = 1;
      if (dato.value == 0) {
        ingreso_width = 0;
      }
    }
    console.log(dato)
    console.log(ingreso_width)
    console.log(dato.text)
    // var color = '#23DBB8';

    if(dato.text == "Aportes Del Estado (Art. 33 Bis Ley N°18603)" ||
                    "Otras Transferencias Públicas" ||
                    "Aportes Del Estado (Art. 33 Bis Ley N 18603)" ||
                    "Aportes Del Estado (Art. 33 Bis Ley Nª18603)"){
      color = '#23DBB8';
      console.log("DENTRO IF" + dato.text)
    } else if (dato.text == "Cotizaciones" ||
                           "Donaciones" ||
                           "Asignaciones Testamentarias" ||
                           "Frutos Y Productos De Los Bienes Patrimoniales" ||
                           "Otras Transferencias Privadas" ||
                           "Ingresos Militantes") {
      color = '#19a58a';
      console.log("DENTRO ELSE IF" + dato.text)
    }

    var bar = paper.rect(0, 0, ingreso_width, bar_height).attr({
      "fill" : color,
      "stroke" : "none"
    });

  }

  Raphael.fn.ingreso_ord_front_footer = function(dato){
    var paper = this;
    var bar_width = 300;
    var bar_height = 30;
    var publico_width = (dato.publicos / (dato.publicos + dato.privados)) * bar_width;
    var privado_width = bar_width - publico_width;

    var publico_bar = paper.rect(0, 0, publico_width, bar_height).attr({
      "fill" : green_light,
      "stroke" : "none"
    });

    var privado_bar = paper.rect(publico_width, 0, privado_width, bar_height).attr({
      "fill" : green_dark,
      "stroke" : "none"
    });

  }

  Raphael.fn.egreso_ord_front_header = function(){

    var paper = this;

    paper.circle(12, 15, 9 )
    .attr({
      "fill" : sky_light,
      "stroke" : "none"
    });

    paper.text(28, 17, "Egresos públicos")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

    paper.circle(190, 15, 9 )
    .attr({
      "fill" : sky_dark,
      "stroke" : "none"
    });

    paper.text(208, 17, "Egresos privados")
    .attr({
      "font-family" : "Karla-Regular, Karla",
      "font-size" : 14,
      'text-anchor': 'start'
    });

  };

  Raphael.fn.egreso_ord_front_bar = function(dato){
    var paper = this;
    var bar_width = 300;
    var bar_height = 30;
    var publico_percentage = dato.value_publico / dato.value;
    var privado_percentage = dato.value_privado / dato.value;
    var publico_width = bar_width * (dato.percentage / 100) * publico_percentage
    if (publico_width < 1){
      publico_width = 1;
      if (dato.value_publico == 0) {
        publico_width = 0;
      }
    }
    var privado_width = (bar_width *  (dato.percentage / 100)) - publico_width;
    if (privado_width < 1){
      privado_width = 1;
      if (dato.value_privado == 0) {
        privado_width = 0;
      }
    }

    var publico_bar = paper.rect(0, 0, publico_width, bar_height).attr({
      "fill" : sky_light,
      "stroke" : "none"
    });

    var privado_bar = paper.rect(publico_width, 0, privado_width, bar_height).attr({
      "fill" : sky_dark,
      "stroke" : "none"
    });

  }

  Raphael.fn.egreso_ord_front_footer = function(dato){
    var paper = this;
    var bar_width = 300;
    var bar_height = 30;
    var publico_width = (dato.publicos / (dato.publicos + dato.privados)) * bar_width;
    var privado_width = bar_width - publico_width;

    var publico_bar = paper.rect(0, 0, publico_width, bar_height).attr({
      "fill" : sky_light,
      "stroke" : "none"
    });

    var privado_bar = paper.rect(publico_width, 0, privado_width, bar_height).attr({
      "fill" : sky_dark,
      "stroke" : "none"
    });

  }

  Raphael.fn.transferencia_front_bar = function(dato){
    var paper = this;
    var bar_width = 300;
    var bar_height = 30;
    var width = bar_width * (dato.percentage / 100);


    var bar = paper.rect(0, 0, width, bar_height).attr({
      "fill" : sky_light,
      "stroke" : "none"
    });

  }

})
