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
//= require_tree .

$(document).ready(function() {
	$("table tr:nth-child(odd)").css("background-color","#dad0ff");
	$("table tr:nth-child(even)").css("background-color","#fefefe");
});

$(document).ready(function() {
	$('#b_b').click(function(){
		$('.app_input').text($('.app_input').text()+'[b]');
	});

	$('.like').mouseenter(function(event){
		post_id=event.target.id;
		$.get('/ajax/like_logins?post_id='+post_id,function(data){
			$('<div class="likes_list"></div>').css({
				position: 'absolute',
				left: event.pageX,
				top: event.pageY,
				cursor: 'pointer',
			}).html(data).appendTo('body');
		});		
	});

	$('.like').mouseleave(function(event){
		$(".likes_list").remove();
	});


	$('.like').click(function(invoker){
		post_id=invoker.target.id;
		$.get('/ajax/?post_id='+post_id,function(data){
			if(data=='+'){
				$('#'+post_id+'.like').removeClass('like_m').addClass('like_p');
			}
			if(data=='-'){
				$('#'+post_id+'.like').removeClass('like_p').addClass('like_m');
			}
		});
	});
});

