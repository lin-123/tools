(function(){
  var files = []
  $(document).ready(function(){
    $("uploadFile_4 input").change(function(){
      files = this.files;
    });
  });
  console.log('in client.js')
  uploadFile = function (){
    // var files = [];
    // $('#uploadFile_4 input')[0].addEventListener('change', function(){
    // var file = this.files[0]
    // if(!file) return console.log('没有文件')
    console.log('upload file: ', files)
    var fd = new FormData();
    for (var i = 0; i < files.length; i++) {
      fd.append("file", files[i]);
    }
    $.ajax({
      url: "/upload/",
      method: "POST",
      data: fd,
      contentType: false,
      processData: false,
      cache: false,
      success: function(data){
        console.log(data);
      }
    });
  }
}).call(this)