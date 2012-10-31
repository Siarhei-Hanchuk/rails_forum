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
//= require twitter/bootstrap
//= require_tree .

$(document).ready(function() {
	$("table tr:nth-child(odd)").css("background-color","#dad0ff");
	$("table tr:nth-child(even)").css("background-color","#fefefe");
});

$(document).ready(function() {
	$('#btn_img').click(function(){
		$('#new_topic_text').val($('#new_topic_text').val()+'<img src=""></img>');
	});
	$('#btn_url').click(function(){
		$('#new_topic_text').val($('#new_topic_text').val()+'<a href=""></a>');
	});
	$('#btn_bold').click(function(){
		$('#new_topic_text').val($('#new_topic_text').val()+'<b></b>');
	});
	$('#btn_italic').click(function(){
		$('#new_topic_text').val($('#new_topic_text').val()+'<i></i>');
	});
	$('#b_b').click(function(){
		$('.app_input').text($('.app_input').text()+'[b]');
	});
});

$(document).ready(function() {
	function getPostId(event){
		return event.target.id.match(/.*-([0-9]*).*/)[1];
	}

	$('.like').mouseenter(function(event){
		post_id=getPostId(event);
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

	$('.like').click(function(event){
		post_id=getPostId(event);
		$.get('/ajax/like?post_id='+post_id,function(data){
			data=data.split('\^');
			if(data[0]=='nil')
				return;
			if(data[0]=='-'){
				$('#like_btn-'+post_id).removeClass('active').text(data[1]);
			}
			if(data[0]=='+'){
				$('#like_btn-'+post_id).addClass('active').text(data[1]);
			}
		});
	});

	function send_comment(id){
		text=$('#comment_input-'+id).val();
		if(text.length<1){
			return
		}
		$.post("/ajax/comment",
		{
			post_id: id,
			comment: text
		},
		function(data){
			$('#send_comment-'+id).before('<div>'+data+'</div>');
			$('#comment_input-'+id).val('');
		}
		);
	}

	$('.comment_button').click(function(event){
		send_comment(getPostId(event));
		
	});

	$('.comment_input').keypress(function(event){
		post_id=getPostId(event);
		/*if((event.ctrlKey) && ((event.keyCode == 0xA)||(event.keyCode == 0xD))){
			$('#comment_input-'+id).val($('#comment_input-'+id).val()+'\n');	
		}*/
		if(event.keyCode==13){
			send_comment(post_id);
		}
	});
});
