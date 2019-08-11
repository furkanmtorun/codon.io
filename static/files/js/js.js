
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

// Tabs
$(document).ready(function(){$('.tabs').tabs()});
// Tooltips
$(document).ready(function(){$('.tooltipped').tooltip()});

// Socket.io

$(document).ready(function() {

    //Connect to the socket
    let socket = io.connect('http://127.0.0.1:5000/session');
    //Everyone joins the personal room
    socket.emit('join', {})
    //Questioner sends the chat request and joins the chat room
    $('.ask-question').on('click', function(e) {
        e.preventDefault();
        let room = this.dataset.room;
        socket.emit('send request', {'room': room});
        //Open the chat window
        $('.request-box').remove();
        $('.main-container').hide();
        $('.chat-container').show();
    });
    socket.on('receive room id', function(data) {
        //Send message
        $('#send_message').on('click', function() {
            let message = $('#message_input').val();
            socket.emit('send message', {'message': message, 'room': data.room});
            $('.msg_history').append('<div class="outgoing_msg"><div class="sent_message"><p>' + message + '</p></div></div>');
            $('#message_input').val('');
            scrollDown();
        });
    });
    //Show incoming request
    socket.on('incoming request', function(data) {
        $('#messages').append('<div class="alert alert-success request-box"><p>Hey ' + data.respondent + '! ' + data.questioner + ' want to ask a question.</p><div><button id="accept_request" class="btn btn-success btn-request">Accept</button><button id="decline_request" class="btn btn-danger btn-request">Decline</button></div></div>');
        //Respondent accepts the request
        $('#accept_request').on('click', function() {
            //Respondent joins the chat room
            socket.emit('join chat room', {'room': data.room});
            //Open the chat window
            $('.request-box').remove();
            $('.main-container').hide();
            $('.chat-container').show();
            //Send message
            $('#send_message').on('click', function() {
                let message = $('#message_input').val();
                socket.emit('send message', {'message': message, 'room': data.room})
                $('.msg_history').append('<div class="outgoing_msg"><div class="sent_message"><p>' + message + '</p></div></div>');
                $('#message_input').val('');
                scrollDown();
            });
        });
        //Decline the request
        $('#decline_request').on('click', function() {
            socket.emit('decline chat request', {'room': data.room});
            $('.request-box').remove();
        });
    });
    //Get messages
    socket.on('message', function(data) {
        $('.msg_history').append('<div class="incoming_msg"><div class="received_msg"><div class="received_withd_msg"><p>' + data.message + '</p><span class="time_date">' + data.username + '</span></div></div></div>');
    });
    //The request is declined
    socket.on('request declined', function() {
        alert('Your request has been declined.')
        window.location.replace("http://127.0.0.1:5000/ask");
    });
    //Update available users
    socket.on('update available users', function(data) {
        let users = JSON.parse(data);
        $('.people-container').html('');
        users.forEach(function(user) {
            
            $('.people-container').append('<div class="card sticky-action"><div class="card-image waves-effect waves-block waves-light"><img class="activator" src="' + user.avatar_link + '") }}"></div><div class="card-content"><span class="card-title activator grey-text text-darken-4">' + user.username + '<i class="material-icons right">more_vert</i></span><div class="stars"><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons">star</i></div><p><a href="profile/' + user.username + '">Show profile</a></p></div><div class="card-action"><a class="blue-text ask-question data-room="' + user.room_id + '">ask a question</a></div><div class="card-reveal"><span class="card-title grey-text text-darken-4">' + user.username + "'s Bio" + '<i class="material-icons right">close</i></i><span><p>' + user.about + '</p></div></div>');

            //Questioner sends the chat request and joins the chat room
            $('.ask-question').on('click', function(e) {
                e.preventDefault();
                let room = this.dataset.room;
                socket.emit('send request', {'room': room});
                //Open the chat window
                $('.request-box').remove();
                $('.main-container').hide();
                $('.chat-container').show();
            });
        });
    });
    //Leave the chat
    // $(window).bind('beforeunload', function() {
    //     socket.emit('leave chat', {});
    // });
    //Logout
    $('#logout').on('click', function() {
        socket.emit('logout', {});
    });


    //Set enter key to send message
    $('#message_input').on('keyup', function(event) {
        if (event.keyCode === 13) {
            $("#send_message").click();
        }
    });
    //Scroll down
    function scrollDown() {
        $('.msg_history').stop().animate({
            scrollTop: $('.msg_history')[0].scrollHeight
        }, 800);
    }
});