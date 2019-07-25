
// Codon.io

$(document).ready(function(){
    $(".dropdown-trigger").dropdown();
    $('.sidenav').sidenav();
    $('.modal').modal();
    $('select').material_select();
    $('.collapsible').collapsible(); // !!!!!! NEW for settings page

    $('input.autocomplete').autocomplete({
        data: [
          {id:1,text:'Apple',img:'http://placehold.it/250x250'},
          {id:2,text:'Microsoft',img:'http://placehold.it/250x250'},
          {id:3,text:'Google',img:'http://placehold.it/250x250'},
        ]
      });
    
});

$('.search_box').hover(function(){ $('#people').addClass('blur'); }); 
$('#people').hover(function(){ $('#people').removeClass('blur'); });

//Tabs
$(document).ready(function(){$('.tabs').tabs()});
//Tooltips
$(document).ready(function(){$('.tooltipped').tooltip()});