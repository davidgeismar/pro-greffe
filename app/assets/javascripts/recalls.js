// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
$(document).ready(function(){
  $(function() {
    window.dataLayer = window.dataLayer || [];
    dataLayer.push({
      'event' : 'WebsiteEvent',
      'eventCategory' : 'RecallEvent',
      'eventAction' : 'AskRecall',
      'eventLabel' : 'AskRecall',
      'eventValue' : '1'
    })
    $(".form_datetime").datetimepicker({
      format: "dd MM yyyy - hh:ii",
      autoclose: true,
      todayBtn: true,
      pickerPosition: "bottom-right",
      orientation: "left",
      language: 'fr'
    });
  })
})
