// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.datetimepicker.js
//= require_tree .

$(function(){

  $('.datetimepicker').datetimepicker({
    lang:'nl',
    format:'d-m-Y H:i'
  });

  $('.datepicker').datetimepicker({
    lang:'nl',
    format:'d-m-Y',
    timepicker: false,
    startDate:'01-01-1990',

    onChangeDateTime:function(dp,$input){
      $('.xdsoft_datetimepicker').hide();
    }
  });

  $('.category_listener').on('change', function(){
    gender = '';
    if ($('#participant_gender_f')[0].checked){
      gender = 'F'
    };
    if ($('#participant_gender_m')[0].checked){
      gender = 'M'
    };

    $.ajax({
      url: '/categories/find_matching.json',
      data:  {
        distance      : $('#participant_distance')[0].value,
        gender        : gender,
        activity_id   : $('#participant_activity_id')[0].value,
        date_of_birth : $('#participant_date_of_birth')[0].value
      }
    }).success(function(data) {
      if(data.result != 'not found'){
        $('#result_category').text(data.result);
        alert('Weet u het zeker dat u zich voor categorie ' + data.result + ' wilt aanmelden?');
      } else {
        $('#result_category').text('Nog geen bijbehorende categorie gevonden!');
      }
    });
  });

  $('table.participations').editableTableWidget({column: 'td.editable'});


  $('table.participations').on('validate', function(evt, newValue) {
    // do something with the new cell value
    id = $($(evt.target).parent()[0]).attr('id');
    console.log(id);
    console.log(newValue)
    console.log("validate")
    return true;
  });

  $('table.participations').on('change', function(evt, newValue) {

    id = $($(evt.target).parent()[0]).attr('id');
    id = id.replace('participation_', '');

    $.ajax({
      url: '/participations/' + id,
      type: 'PUT',
      dataType: 'json',
      data:  {
        participation: {startnumber: newValue}
      }
    }).success(function(data) {
      console.log(data);
    }).error( function( jqXHR, textStatus, errorThrown ){
      console.log(jqXHR.responseText);
      console.log(textStatus);
      console.log(errorThrown);
    });

  });

});
