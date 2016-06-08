HTMLWidgets.widget({

  name: 'c3',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
          //console.log(x.data);

          el.innerText = x.message;

          var chart = c3.generate({
              bindto: '#' + el.id,
              data: {
                json: x.data,
                keys: {
                  value: x.keys
                },
                x: x.x,
                type: x.plot_type
              },
              axis: {
                x: {
                  type: 'category' // this needed to load string x value
                },
                rotated: (x.rotated ? true : false)
              },
              bar: {
                  width: {
                      ratio: (x.bar_width ? x.bar_width : 0.6) // this makes bar width 50% of length between ticks
                  }
                  // or
                  //width: 100 // this makes bar width 100px
              }
          });

          // need better way to interact with options as everything done out here happens after initial render
          if (x.groups) {
            chart.groups([x.groups])
          }

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
