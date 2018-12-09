
$(document).on('turbolinks:load', function() {
    var today = new Date();

    $('#datetimepicker').datetimepicker({
      format: 'DD-MM-YYYY HH:mm',
      allowInputToggle : true,
      startDate: today,
      minDate: new Date(today.getFullYear(), today.getMonth()-1),
      maxDate: new Date(today.getFullYear(), today.getMonth()+3),
      useCurrent: false,
      todayHighlight: true,
      autoclose: true,
      language: 'es',
      buttons: {showClose: true },
      widgetPositioning: {
            horizontal: 'right',
            vertical: 'bottom'
        }
    });

    function change_status(status){
      $("#btn-search").attr('disabled',status);
    }

    change_status(true);

    $('#search_title').change(function(){
        if($(this).val().length !=0){
            change_status(false);
        }else{
            change_status(true);

        }
    });

});
