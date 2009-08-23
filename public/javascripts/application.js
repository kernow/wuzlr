// LOADS of shonky JavaScript, I didn't write any of this, honest!

var team_form = {};
team_form["blue_number"]  = 1;
team_form["red_number"]   = 1;

window.addEvent('domready', function() {
  
  if($("play_game")){
    $("play_game").addEvent('click', function(){
      SqueezeBox.initialize({
          size: { x: 350,
                  y: 150, }});
                  
      SqueezeBox.open(  $('players_form').getProperty('action'), {
                        ajaxOptions: {  method: 'post',
                                        data: { authenticity_token: $('players_form').authenticity_token.value,
                                          blue: {1: $('players_form').blue_1.value, 2: $('players_form').blue_2.value},
                                          red: {1: $('players_form').red_1.value, 2: $('players_form').red_2.value}}}});
    });
  }
  
  if($("submit_score")){
    $("submit_score").addEvent('click', function(){
      $('edit_match').submit();
    });
  }
  
  // reset the form on page load for refresh
  if($$('#players_form input')){
    $$('#players_form input').each(function(elm){
      if(elm.name != 'authenticity_token'){
        elm.value = '';
      }
    });
  }
  
  if($$("li a.draggable_player")){
    add_tool_tips($$("li a.draggable_player"));
  
    $$("li a.draggable_player").each(function(drag) {

    	new Drag.Move(drag, {
    	  droppables: $$('.droppable'),
    	  onStart: function(elm){
    	    elm.setStyle('z-index', '9999');
    	  },
    	  onDrop: function(elm, droppable, event){
          if (!droppable){
            elm.setPosition({x: 0, y: 0});
          }
          else{
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
          // re-enable tool tips
          add_tool_tips($$("li a.draggable_player"));
        }
    	});
    });
  }
});


// sortable tables
window.addEvent('domready', function() {
  if($('fuckingsweet')){
    new SortingTable('fuckingsweet', {
      dont_sort_class: 'nosort'
    });
  }
});


// compare tables
window.addEvent('domready', function() {
  if($('compare-you') && $('compare-them')){
    $('compare-you').getElements('li').each(function(you_elm){
      var them_elm = $('compare-them').getElement('li.'+you_elm.className);
      if(you_elm.innerHTML.toInt() > them_elm.innerHTML.toInt()){
        var win_elm = you_elm;
        var lose_elm = them_elm;
      }
      else{
        var win_elm = them_elm;
        var lose_elm = you_elm;
      }
      if(win_elm.getProperty('rel') == 'percentize'){
        var p = get_percentages(win_elm.innerHTML.toInt(), lose_elm.innerHTML.toInt());
        var win_val = p[0];
        var lose_val = p[1];
      }
      else{
        var win_val = win_elm.innerHTML;
        var lose_val = lose_elm.innerHTML;
      }
      
      win_elm.setStyle('background', 'url(/images/rouge.png)');
      lose_elm.setStyle('background', 'url(/images/blu.png)');
      var winFx = new Fx.Tween(win_elm, {unit: '%'});
      winFx.start('width', '0', win_val+'%');
      
      var loseFx = new Fx.Tween(lose_elm, {unit: '%'});  
      loseFx.start('width', '0', lose_val+'%');
    });
  }
});


// home graphs

window.addEvent('domready', function() {
  if($('dedicated-graphs')){
    var games = [];
    var max = 0;
    $$('#dedicated-graphs li .games').each(function(elm){
      var num = elm.innerHTML.toInt();
      games.push([elm, num]);
      if(num > max){
        max = num;
      }
    });
    games.each(function(item){
      item[0].setStyle('background', 'url(/images/blu.png)');
      var meFx = new Fx.Tween(item[0], {unit: '%'});
      meFx.start('width', '0', toPercent(item[1], max));
    });
  }
});

function toPercent(val, max){
  return (val/max)*100;
};

function get_percentages(val1, val2){
  if(val1 > val2){
    var p = (val2/val1)*100;
    return [100,p];
  }
  else if(val1 < val2){
    var p = (val2/val1)*100;
    return [p,100];
  }
  else{
    return [50,50];
  }
};




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

function add_tool_tips(elms){
  elms.each(function(elm) {
    elm.tip = new Tips(elm.getElement('img'), {className: 'tool-tip'});
  
    elm.addEvent('mousedown', function(e){
      e.target.parentNode.tip.hide();
      remove_tool_tips($$("li a.draggable_player"));
      e.stop();
    });
  });
};

function remove_tool_tips(elms){
  elms.each(function(elm) {
    elm.tip.detach(elm.getElement('img'));
  });
};
