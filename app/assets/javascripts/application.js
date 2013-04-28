// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require jquery_ujs
//= require foundation
//= require_tree .

$(document).foundation();

$(document).ready( function() {

  // auto-expanding textarea for writing
  $('textarea#writing_body').autoheight();

});

$.fn.autoheight = function() {
  
  return this.filter( 'textarea').each( function() {

    var textarea_text_linecount = 0;
    var line_counter = 0;
    var newline_regexp = /\n/g;
    var base_height = $(this).css( 'height').match(/^\d+/)[0];
    var height_diff = parseFloat( 
      $(this).css( 'line-height').match(/^\d+/)[0])*3;
    
    // set initial height
    if( $(this).val().match( newline_regexp)) {
      $(this).css({ 'height' : 
        Math.max( 
          Math.floor( height_diff *
            ( $(this).val().match( newline_regexp).length / 2)),
          base_height)+"px" }); 
    }

    // auto expand/ contract
    $(this).on( 'keyup change', function() {
      
      var textarea_height = $(this).height();
      var current_textarea_text_linecount = 
        $(this).val().match( newline_regexp);

      // removing a line
      if( $(this).val().length === 0) {
        $(this).animate({ 'height': base_height+"px" });
      } else if( current_textarea_text_linecount < textarea_text_linecount) { 
        line_counter--;
        if( line_counter < -1) {
          $(this).stop().
            animate({ 'height': 
              Math.max( base_height, textarea_height-height_diff)+"px" });
          line_counter = 0;
        }
      // adding a line 
      } else if( current_textarea_text_linecount > textarea_text_linecount) { 
        line_counter++;
        if( line_counter > 1) {
          $(this).stop().
            animate({ 'height': (textarea_height+height_diff)+"px" });
          line_counter = 0;
        }
      }

      textarea_text_linecount = current_textarea_text_linecount;
    });
  });
};
