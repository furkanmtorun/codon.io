// Codon.io
$(document).ready(function(){
    $('.collapsible').collapsible();
    $(".dropdown-trigger").dropdown();
    $('.sidenav').sidenav();
    $('.modal').modal();
});


// Tabs
$(document).ready(function () { $('.tabs').tabs() });
// Tooltips
$(document).ready(function () { $('.tooltipped').tooltip() });


// Ajax for getting skills
$(document).ready(function() {
    $.getJSON('/get-skills', function(data) {
        // Create skills object to hold skill names
        var skills = new Object();
        data.forEach(function(skill_list) {
            skills[skill_list.skill_name] = null;
        });
        // Skills autocomplete
        $('.chips').chips();
        $('.chips-autocomplete').chips({
            placeholder: 'Type a language/library',
            secondaryPlaceholder: '+Add',
            autocompleteOptions: {
                data: skills,
                limit: 5,
                minLength: 1
            }
        });
    });
    return false;
});


// Adding Skill Button
$('#changeSkills').click(function() {
    $("#addingSkill").removeClass("hide");
    $("#updateSkillsBtn").removeClass("hide");
    $(".removeSkillBtn").removeClass("hide");
    $("#changeSkills").addClass("hide");
});


// Update Skill Button
$("#updateSkillsBtn").click(function() {
    skills_list = [];
    var list_of_chips = $("#addingSkill").children(".chip");
    for (var i = 0; i < list_of_chips.length; i++) {
        skills_list.push(list_of_chips[i].firstChild.textContent);
    }
    $.ajax({
        url: "/update_skills",
        type: "POST", 
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        accepts: {json: "application/json"},
        data: JSON.stringify(skills_list)
    })
    .done(function(data) {
        location.reload();
    });
});


// Remove Skills
$(".removeSkillBtn").click(function() {
    skill = this.dataset.skill_name;
    $.ajax({
        url: "/remove_skills",
        type: "POST", 
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        accepts: {json: "application/json"},
        data: JSON.stringify(skill)
    })
    .done(function(data) {
        location.reload();
    });
});


// Home Page
$('.search_box').hover(function(){ $('#people').addClass('blur'); }); 
$('#people').hover(function(){ $('#people').removeClass('blur'); });


// Socket.io
$(document).ready(function() {

    //Connect to the socket
    let socket = io.connect('http://127.0.0.1:5000/session');
    
    //Everyone joins the personal room
    socket.emit('join')
    
    //Questioner sends the chat request and joins the chat room
    $('.ask-question').on('click', function(e) {
        e.preventDefault();
        let room = this.dataset.room;
        socket.emit('send request', {'room': room});
        //Open the chat window
        $('.request-box').remove();
        $('.main-container').hide();
        // Get questioner's username
        let questionerUsername = this.dataset.username;
        $('#questioner').html(questionerUsername);
        // Get questioner's avatar
        let questionerAvatarLink = this.dataset.avatar_link;
        $('#questioner').html(questionerAvatarLink);
        $('.chat-window').show();
    });
    
    //Receive room id
    socket.on('receive room id', function(data) {
        //Send message
        $('#send_message').on('click', function() {
            let message = $('#message_input').val();
            socket.emit('send message', {'message': message, 'room': data.room});
            //Get avatar link from navbar
            let avatar = $('.profile_button').attr('src');
            $('.chat-container').append('<div id="chatblock" class="row"><div class="col s10 m10 l11"><div class="chat-box person">' + message + '</div></div><div class="col s2 m2 l1"><img class="circle responsive-img" src="' + avatar + '" alt="Furkan Torun"></div></div>');
            $('#message_input').val('');
            $('#message_input').focus();
            scrollDown();
        });
    });
    
    //Show incoming request
    socket.on('incoming request', function(data) {
        $('#messages').html('<div class="message-bar green lighten-1"><div class="container request-box"><p class="flow-text">Hey ' + data.respondent + '! ' + data.questioner + ' want to ask you a question.</p><div><button id="accept_request" class="btn lime darken-1 btn-request">Accept</button><button id="decline_request" class="btn deep-orange accent-3 btn-request">Decline</button></div></div></div>');
        //Respondent accepts the request
        $('#accept_request').on('click', function() {
            //Respondent joins the chat room
            socket.emit('join chat room', {'room': data.room});
            //Open the chat window
            $('.request-box').remove();
            $('.main-container').hide();
            $('.chat-window').show();
            //Send message
            $('#send_message').on('click', function() {
                let message = $('#message_input').val();
                socket.emit('send message', {'message': message, 'room': data.room});
                //Get avatar link from navbar
                let avatar = $('.profile_button').attr('src');
                $('.chat-container').append('<div id="chatblock" class="row"><div class="col s10 m10 l11"><div class="chat-box person">' + message + '</div></div><div class="col s2 m2 l1"><img class="circle responsive-img" src="' + avatar + '" alt="Furkan Torun"></div></div>');
                $('#message_input').val('');
                $('#message_input').focus();
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
        $('.chat-container').append('<div id="chatblock" class="row"><div class="col s2 m2 l1"><img class="circle responsive-img" src="' + data.avatar_link + '" alt="' + data.username + '"></div><div class="col s10 m10 l11"><div class="chat-box you">' + data.message + '</div></div></div>');
        scrollDown();
    });
    
    //Search coders
    $('#searchCoders').on("submit", function(e) {
        e.preventDefault();
        skills = [];
        let chips = $("#addingSkill").children(".chip");        
        for (var i = 0; i < chips.length; i++) {
            skills.push(chips[i].firstChild.textContent);
        }
        socket.emit('get available coders');
        socket.on('update available users', function(data) {
            let users = JSON.parse(data);
            users = users.filter(users => users.username != $('#profile_name').text() && skills.every(element => users.skills.indexOf(element) > -1));
            if (users.length === 0) {
                $('.people-container').html('');
                $('.people-container').append('<h5><i class="material-icons">code</i> No available user found who code in ' + skills.join(', ') + '</h5>');
            } else {
                $('.people-container').html('');
                $('.people-container').append('<h5><i class="material-icons">code</i> who code in ' + skills.join(', ') + '</h5>');
                users.forEach(function(user) {
                $('.people-container').append('<div class="card sticky-action"><div class="card-image waves-effect waves-block waves-light"><img class="activator" src="' + user.avatar_link + '") }}"></div><div class="card-content"><span class="card-title activator grey-text text-darken-4">' + user.username + '<i class="material-icons right">more_vert</i></span><div class="stars"><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons">star</i></div><p><a href="profile/' + user.username + '">Show profile</a></p></div><div class="card-action"><a class="blue-text ask-question" data-room="' + user.room_id + '" data-username="' + user.username + '">ask a question</a></div><div class="card-reveal"><span class="card-title grey-text text-darken-4">' + user.username + "'s Bio" + '<i class="material-icons right">close</i></i><span><p>' + user.about + '</p></div></div>');
                $('.ask-question').on('click', function(e) {
                        e.preventDefault();
                        let room = this.dataset.room;
                        socket.emit('send request', {'room': room});
                        //Open the chat window
                        $('.request-box').remove();
                        $('.main-container').hide();
                        // Get questioner's username
                        let questioner = this.dataset.username;
                        $('#questioner').html(questioner);
                        $('.chat-window').show();
                    });
                });
            }
        });
    });
    
    //The request is declined
    socket.on('request declined', function() {
        alert('Your request has been declined.')
        window.location.replace("http://127.0.0.1:5000/home");
    });
    
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
        $('.chat-container').stop().animate({
            scrollTop: $('.chat-container')[0].scrollHeight
        }, 800);
    }
});
