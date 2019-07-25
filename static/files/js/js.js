
// Codon.io

$(document).ready(function(){
    $('.collapsible').collapsible();
    $(".dropdown-trigger").dropdown();
    $('.sidenav').sidenav();
    $('.modal').modal();
    $('select').material_select();    
});

$('.search_box').hover(function(){ $('#people').addClass('blur'); }); 
$('#people').hover(function(){ $('#people').removeClass('blur'); });

//Tabs
$(document).ready(function(){$('.tabs').tabs()});
//Tooltips
$(document).ready(function(){$('.tooltipped').tooltip()});