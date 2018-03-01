$(document).ready(function() {
  $('.tooltipster').tooltipster({
    trigger: 'click',
    functionInit: function(instance, helper){

        var $origin = $(helper.origin),
            dataOptions = $origin.attr('data-tooltipster');

        if(dataOptions){

            dataOptions = JSON.parse(dataOptions);

            $.each(dataOptions, function(name, option){
                instance.option(name, option);
            });
        }
    }
  });

  $('[data-toggle="toggleSwitch"]').hurkanSwitch({
    'width':150
  });
});
