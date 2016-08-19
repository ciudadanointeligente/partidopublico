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
              legendElement.append('<li data-id='+ bcolor +' style="color:' + bcolor + ';"><i class="fa fa-male"></i> ' + labels[j] + " : " + values[j] + '</li>');
              break;
            case 'mujeres':
              legendElement.append('<li data-id='+ bcolor +' style="color:' + bcolor + ';"><i class="fa fa-female"></i> ' + labels[j] + " : " + values[j] + '</li>');
              break;
            default:
              legendElement.append('<li data-id='+ bcolor +' style="color:' + bcolor + ';"><i class="fa fa-male"></i><i class="fa fa-female"></i> ' + labels[j] + " : " + values[j] + '</li>');
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
