HTMLWidgets.widget({

  name: 'c3',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var chart;

    // needto id when tab / plot becomes visible
    //$('#' + el.id).on('onblur', function(){
    //        jQuery(window).trigger('resize');
    // })

    return {

      renderValue: function(x) {

          el.innerText = x.message;

          x.bindto = '#' + el.id;

          // when tab hidden el.get... returns 0
          var w = el.getBoundingClientRect().width;
          var h = el.getBoundingClientRect().height;

          console.log(h + ' - h - initial size')
          console.log(w + ' - w - initial size')
          //x.transition = {
          //  duration: 1500
          //}
          //x.onresize = function() {
          //  this.selectChart.style('max-height', h + "px");
          //}
          // set size if missing
          if (x.size === null) {
              x.size = {
                height: h,
                width: w
              }
          console.log('no size set')
          }

          // this works because x.data always exists
          if (x.data.groups) {
            if (x.data.types) {
              x.data.groups = [x.data.groups]
            } else {
            x.data.groups = [x.data.groups.value]
            //console.log(x.data.groups);
            }
          }


          // Grid Lines
          var gridLinesX = (((x || {}).grid || {}).x || {}).lines,
              gridLinesY = (((x || {}).grid || {}).y || {}).lines;
          if (gridLinesX) {
            //x.grid.x.lines = [x.grid.x.lines]
            x.grid.x.lines = HTMLWidgets.dataframeToD3(x.grid.x.lines)
          }
          if (gridLinesY) {
            x.grid.y.lines = HTMLWidgets.dataframeToD3(x.grid.y.lines)
          }

          // Regions
          if (x.regions) {
            x.regions = HTMLWidgets.dataframeToD3(x.regions)
          }

          // Define the chart
          chart = c3.generate(
              x
          );

          //setTimeout(chart.flush, 300)


          // set colours using column headers
          //chart.data.colors({
          //  a: '#FFFFFF',
          //  b: '#000000'
          //});

      },

      resize: function(width, height) {

        //setTimeout(chart.flush, 600)

        var w = el.getBoundingClientRect().width;
        var h = el.getBoundingClientRect().height;

        // code to re-render the widget with a new size
        chart.resize({
          height: h,
          width: w
        })

        // http://stackoverflow.com/questions/26003591/c3-chart-sizing-is-too-big-when-initially-loaded
        //jQuery('#' + el.id).trigger('resize');

        console.log(h)
        //console.log(el)
      }

    };

  }
});
