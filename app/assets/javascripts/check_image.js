$(document).on('turbolinks:load', function() {
  var readURL;

  readURL = function(input) {
    var reader, types;
    types = ['image/jpeg', 'image/jpg', 'image/png', 'image/gif'];
    if (input.files && input.files[0]) {
      reader = new FileReader;
      if (!types.includes(input.files[0]['type'])) {
        $.gritter.add({ 
          title: 'Error avatar', 
          text: input.files[0]['name'] + ' is not valid image'
        }); 
        $('#avatar-upload').val('');
      } else {
        reader.onload = function(e) {
          $('#img_prev').attr('src', e.target.result);
        };
        reader.readAsDataURL(input.files[0]);
      }
    }
  };

  $('#avatar-upload').change(function() {
    $('#img_prev').removeClass('hidden');
    readURL(this);
  });
});