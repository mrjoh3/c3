HTMLWidgets.widget({

  name: 'c3',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance

    return {

      renderValue: function(x) {

        // TODO: code to render the widget, e.g.
          console.log(x.data);

          el.innerText = x.keys;//x.message;

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
                }
              }
          });

          if (x.groups !== 'delete_groups') {
            chart.groups([x.groups])
          }


      },

      resize: function(width, height) {

        // TODO: code to re-render the widget with a new size

      }

    };
  }
});
