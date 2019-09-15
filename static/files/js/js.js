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
    let chip = $(this).parent().parent();

    $.ajax({
        url: "/remove_skills",
        type: "POST", 
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        accepts: {json: "application/json"},
        data: JSON.stringify(skill)
    })
    .done(function(data) {
        chip.remove();
    });
});


// Home Page
$('.search_box').hover(function(){ $('#people').addClass('blur'); }); 
$('#people').hover(function(){ $('#people').removeClass('blur'); });



// Socket.io
$(document).ready(function() {

    // Connect to the socket
    let socket = io.connect('http://127.0.0.1:5000/session');
    
    // Create the conversation id variable
    let conversation_id;

    // Everyone joins the personal room
    socket.emit('join')
    
    // Search coders - Send chat request
    // $('#searchCoders').on("submit", function(e) {
    $("#skill-search").on("keyup", function(e) {
        e.preventDefault();
        skills = [];
        let chips = $("#addingSkill").children(".chip");        
        for (var i = 0; i < chips.length; i++) {
            skills.push(chips[i].firstChild.textContent);
        }
        if (skills.length > 0) {
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
                        $('.people-container').append('<div class="card sticky-action"><div class="card-image waves-effect waves-block waves-light"><img class="activator" src="' + user.avatar_link + '") }}"></div><div class="card-content"><span class="card-title activator grey-text text-darken-4">' + user.username + '<i class="material-icons right">more_vert</i></span><div class="stars"><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons" style="color: orange">star</i><i class="material-icons">star</i></div><p><a href="profile/' + user.username + '">Show profile</a></p></div><div class="card-action"><a class="blue-text ask-question" data-room="' + user.room_id + '" data-username="' + user.username + '" data-avatar_link="' + user.avatar_link + '" data-about="' + user.about + '">ask a question</a></div><div class="card-reveal"><span class="card-title grey-text text-darken-4">' + user.username + "'s Bio" + '<i class="material-icons right">close</i></i><span><p>' + user.about + '</p></div></div>');
                        // Questioner sends the chat request and joins the chat room
                        $('.ask-question').on('click', function(e) {
                            e.preventDefault();
                            // Get the room id
                            let room = this.dataset.room;
                            // Get the question
                            let question = $('#skill-search').val().trim();
                            $('#chat_question').html(question);
                            // Send the room id and question
                            socket.emit('send request', {'room': room, 'question': question, 'skills': skills});
                            // Clear messages (flash)
                            $('#messages').html("<br><br><br><br>");
                            // Get questioner's username
                            $('#questioner').html(this.dataset.username);
                            // Set user's profile link
                            $('.questioner_links').attr("href", "profile/"+this.dataset.username);
                            // Get questioner's avatar
                            $("#chat_avatar").attr("src", this.dataset.avatar_link);
                            // Get questioner's bio
                            $('#chat_about').html(this.dataset.about);
                            // Open the chat window
                            $('.chat_notification').removeClass("hide");
                            $('.chat_notification').html("Waiting for " + this.dataset.username + "'s response...")
                            $('.main-container').hide();
                            $('.chat-window').show();
                            // Alert on leaving
                            window.onbeforeunload = s => "";
                        });
                    });
                }
            }); 
        }
    });

    // Change color theme
    $("#change_color_theme").click(function() {
        $("#chat-header").addClass("night-mode");
    });

    // Questioner receives room id
    socket.on('receive room id', function(data) {
        // Questioner sends message
        $('#send_message').on('click', function() {
            let message = $('#message_input').val().trim();
            if (message != '') {
                socket.emit('send message', {'message': message, 'room': data.room, 'conversation_id' : conversation_id});
                // Get avatar link from navbar
                let avatar = $('.profile_button').attr('src');
                $('.chat-container').append('<div id="chatblock" class="row"><div class="col s10 m10 l11"><div class="chat-box person">' + message + '</div></div><div class="col s2 m2 l1"><img class="circle responsive-img" src="' + avatar + '" alt="Furkan Torun"></div></div>');
                $('#message_input').val('');
                $('#message_input').focus();
                scrollDown();
            }
        });

        // End the conversation
        $('#end_conversation').on('click', function() {
            // Leave the chat room and inform the respondent 
            socket.emit('leave chat', {'room': data.room, 'conversation_id' : conversation_id});
            // Get the rate types with Ajax
            $(document).ready(function() {
                $.getJSON('/get-rate-types', function(data) {
                    data.forEach(function(rate_type) {
                        $('#rate_types').append('<p><label><input name="group1" type="radio" data-rate_type_id="'+ rate_type.id +'" /><span>' + rate_type.name + '</span></label></p>');
                    });
                });
                return false;
            });
            $("#rate_answer_modal").modal('open');
            // Rate the answer
            $('#rate_answer').on('click', function() {
                let rate = {'conversation_id' : conversation_id, 'rate_type_id' : $("input[type='radio'][name='group1']:checked").data('rate_type_id')};
                $.ajax({
                    url: "/rate-answer",
                    type: "POST", 
                    dataType: "json",
                    contentType: "application/json; charset=UTF-8",
                    accepts: {json: "application/json"},
                    data: JSON.stringify(rate)
                })
                .done(function(data) {
                    $("#rating_thanks_modal").modal('open');
                    // Alert on leaving
                    window.onbeforeunload = null;
                    setTimeout(function(){ window.location.replace("http://127.0.0.1:5000/home"); }, 2000);
                });
            });

        });
    });
    
    // Show incoming request
    socket.on('incoming request', function(data) {
        $('#messages').html('<div class="message-bar blue lighten-1"><div class="container request-box"><p class="flow-text">' + data.questioner + ': ' + data.question + '</p><div><button id="accept_request" class="btn white blue-text darken-1 btn-request">Answer</button><button id="decline_request" class="btn deep-orange accent-3 btn-request">Dismiss</button></div></div></div>');
        // Respondent accepts the request
        $('#accept_request').on('click', function() {
            // Respondent joins the chat room
            socket.emit('join chat room', {'room': data.room, 'topic': data.question, 'skills': data.skills});
            // Clear messages (flash)
            $('#messages').html("<br><br><br><br>");
            // Get questioner's username
            $('#questioner').html(data.questioner);
            // Get questioner's avatar
            $("#chat_avatar").attr("src", data.avatar_link);
            // Get questioner's bio
            $('#chat_about').html(data.about);
            // Get the question
            $('#chat_question').html(data.question);
            // Open the chat window
            $('.chat_notification').removeClass("hide");        
            $('.chat_notification').html("You joined the chat")
            $('.main-container').hide();
            $('.chat-window').show();
            // Alert on leaving
            window.onbeforeunload = s => "";
            // Respondent sends message
            $('#send_message').on('click', function() {
                let message = $('#message_input').val().trim();
                if (message != '') {
                    socket.emit('send message', {'message': message, 'room': data.room});
                    // Get avatar link from navbar
                    let avatar = $('.profile_button').attr('src');
                    $('.chat-container').append('<div id="chatblock" class="row"><div class="col s10 m10 l11"><div class="chat-box person">' + message + '</div></div><div class="col s2 m2 l1"><img class="circle responsive-img" src="' + avatar + '" alt="Furkan Torun"></div></div>');
                    $('#message_input').val('');
                    $('#message_input').focus();
                    scrollDown();
                }
            });
        });
        // Decline the request
        $('#decline_request').on('click', function() {
            socket.emit('decline chat request', {'room': data.room});
            // Clear messages (flash)
            $('#messages').html("<br><br><br><br>");
        });
    });

    // Respondent joined the chat
    socket.on('respondent joined', function(data) {
        $('.chat_notification').removeClass("hide");
        $('#end_conversation_btn').removeClass("hide");
        $('.chat_notification').html(data.respondent + " joined the chat");
        conversation_id = data.conversation_id;
    });
    
    // Get messages
    socket.on('message', function(data) {
        $('.chat-container').append('<div id="chatblock" class="row"><div class="col s2 m2 l1"><img class="circle responsive-img" src="' + data.avatar_link + '" alt="' + data.username + '"></div><div class="col s10 m10 l11"><div class="chat-box you" data-muid="' + data.message_id + '">' + data.message + '</div></div></div>');
        scrollDown();
        
        // Abuse alert event
        $(".chat-box.you").dblclick(function () {
            let muid = this.dataset.muid;
            $("#abuse_modal").attr('data-muid', muid);
            $("#abuse_modal").modal('open');
            console.log(muid);
        });
        
    });
    
    $("#report_abuse_btn").click(function () {
        temp_muid = $("#abuse_modal").attr("data-muid");
        $.ajax({
            url: "/report_abuse",
            type: "POST",
            dataType: "json",
            contentType: "application/json; charset=UTF-8",
            accepts: { json: "application/json" },
            data: JSON.stringify(temp_muid)
        })
            .done(function (data) {
                M.toast({html: 'Abusement has been reported.'});
            });
    });
    
    // The request is declined
    socket.on('request declined', function() {
        $('.chat-container').append("<div class='chat_notification'>Your request has been declined<br>Redirecting to the home page...</div>");
        window.onbeforeunload = null;
        setTimeout(function(){ window.location.replace("http://127.0.0.1:5000/home"); }, 3000);

    });

    // The questioner ends the chat
    socket.on('questioner ends chat', function(data) {
        $('.chat-container').append("<div class='chat_notification'>" + data.questioner + " has ended the conversation<br>Redirecting to the home page...</div>");
        window.onbeforeunload = null;
        setTimeout(function(){ window.location.replace("http://127.0.0.1:5000/home"); }, 3000);
    });
    
    // Logout
    $('#logout').on('click', function() {
        socket.emit('logout', {});
    });

    // Set enter key to send message
    $('#message_input').on('keyup', function(event) {
        if (event.keyCode === 13) {
            $("#send_message").click();
        }
    });
    
    // Scroll down
    function scrollDown() {
        $('.chat-container').stop().animate({
            scrollTop: $('.chat-container')[0].scrollHeight
        }, 800);
    }
});


// Send Feedback
$('#send_feedback').on('click', function() {
    let feedback = $('#feedback').val();
    $.ajax({
        url: "/give-feedback",
        type: "POST",
        dataType: "json",
        contentType: "application/json; charset=UTF-8",
        accepts: { json: "application/json" },
        data: JSON.stringify(feedback)
    })
        .done(function (data) {
            $("#feedback_thanks_modal").modal('open');
        });
});