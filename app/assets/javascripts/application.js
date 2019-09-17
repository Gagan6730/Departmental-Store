// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .
//= require 'jspdf'

$( document ).ready(function() {
    $('#logout-user').click(function () {
        window.location.href="/logout"
    });
});

function dynamic_time()
{
    var pref = "0";
    var date = new Date;
    var year = date.getFullYear();
    var month = date.getMonth();
    var d = date.getDate();
    var day = date.getDay();
    var hours = date.getHours();
    var min = date.getMinutes();
    var sec = date.getSeconds();
    month = parseInt(month) + 1;
    //console.log('' + day+'/'+month+'/'+d);
    if(hours<10)
    {
        hours = pref+hours;
    }
    if(min<10)
    {
        min = pref+min;
    }
    if(sec<10)
    {
        sec = pref+sec;
    }
    var date_result = '' + d + '/' + month + '/' + year;
    var time_result = '' + hours + ':' + min + ':' + sec;

    $('#header_date').html("Date: " + date_result + "      |");
    $('#header_time').html("Time: " + time_result + "  ");
    setTimeout('dynamic_time();','1000');
}

window.onload = dynamic_time();