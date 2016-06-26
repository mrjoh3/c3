HTMLWidgets.widget({

  name: 'c3',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    var chart;

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
          //console.log(x.grid);

          el.innerText = x.message;

          x.bindto = '#' + el.id;

          // set size if missing
          if (x.size === null) {
              x.size = {
                width: el.getBoundingClientRect().width,
                height: el.getBoundingClientRect().height
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


          //console.log(x.data.groups);
          chart = c3.generate(
              x
          );

          // set colours using column headers
          //chart.data.colors({
          //  a: '#FFFFFF',
          //  b: '#000000'
          //});

      },

      resize: function(width, height) {

        var w = el.getBoundingClientRect().width;
        var h = el.getBoundingClientRect().height;

        // TODO: code to re-render the widget with a new size
        chart.resize({
          height: h,
          width: w
        })

        console.log(h)
        console.log(el)
      }

    };
  }
});
