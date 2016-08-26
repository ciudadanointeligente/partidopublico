$(document).ready(function(){
  Raphael.fn.afiliados_compare_chart = function(){
    console.log("afiliados_compare_chart");
    var paper = this;
    var header_height = 40;
    var line_height = 40;
    var chart_width = 700;
    var bar_width = 210;

    paper.circle(12, 15, 9 )
    .attr({
      "fill" : "#23DBB8",
      "stroke" : "none"
    });

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

      paper.text(360, header_height + 20, "Número de afiliados")
      .attr({
        "font-family" : "Karla-Regular, Karla",
        "font-size" : 16,
        'text-anchor': 'start',
        'font-weight' : "bold"
      });

    };

    var p = afiliados_compare_header();
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

})
