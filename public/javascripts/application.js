// Place your application-specific JavaScript functions and classes here
// This file is automatically included by javascript_include_tag :defaults

var team_form = {};
team_form["blue_number"]  = 1;
team_form["red_number"]   = 1;

window.addEvent('domready', function() {
  $$("a.play_game").addEvent('click', function(){
    $('players_form').submit();
  });
  
  // reset the form on page load for refresh
  $$('#players_form input').each(function(elm){
    if(elm.name != 'authenticity_token'){
      elm.value = '';
    }
  });
  
  $$("a.draggable_player").each(function(drag) {
  	new Drag.Move(drag, {
  	  droppables: $$('.droppable'),
  	  onDrop: function(elm, droppable, event){
          if (!droppable){
            // console.log(elm, ' dropped on nothing');
            elm.setPosition({x: 0, y: 0});
          }
          else{
            // console.log(elm, 'dropped on', droppable, 'event', event);
            player_id = elm.id;
            player_id = player_id.substr(7, player_id.length);
            
            if(droppable.id == "top"){
              team = "red";
            }
            else{
              team = "blue";
            }
            
            if(team_form[team+"_number"] > 2){
              elm.setPosition({x: 0, y: 0});
            }
            else{
              $(team + '_' + team_form[team+"_number"]).value = player_id;
              team_form[team+"_number"] = team_form[team+"_number"] + 1;
              // snap player to position
              new_elm = elm.clone().inject(droppable);
              set_player_positions(droppable);
              elm.dispose();
            }
          }
      }
  	});
  });
});


// fonts

// window.addEvent('domready', function() {
//  Cufon.replace('#bulk .headit h2, #aside h3, , .headit h4, .museo',{
//     hover: true
//  });
// });


// navigation

window.addEvent('domready', function() {
  
  var mySlide = new Fx.Slide('nav');
  mySlide.hide();
  $('nav_toggler').addEvent('click', function(e){
    e = new Event(e);
    mySlide.toggle();
    e.stop();
  });
});

function set_player_positions(elm){
  elms = elm.getElements('a');
  y_pos = elm.id == 'top' ? 44 : 104;
  if(elms.length <= 1){
    elms[0].setPosition({x: 111, y: y_pos});
  }
  else{
    elms[0].setPosition({x: 77, y: y_pos});
    elms[1].setPosition({x: 97, y: y_pos});
  }
};
