HTMLWidgets.widget({

  name: 'c3',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
          //console.log(x.grid);

          el.innerText = x.message;

          x.bindto = '#' + el.id;

          // this works because x.data always exists
          if (x.data.groups) {
            x.data.groups = [x.data.groups.value]
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


          //console.log(x.data.groups);
          var chart = c3.generate(
              x
          );

          // set colours using column headers
          //chart.data.colors({
          //  a: '#FFFFFF',
          //  b: '#000000'
          //});


      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
