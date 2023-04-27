// (function ($) {
//     "use strict";

//     $('.validate-form').on('submit', function () {
//         var valid = true;
//         $('.validate-input .input100').each(function () {
//             if (!validate(this)) {
//                 showValidate(this);
//                 valid = false;
//             }
//         });
//         return valid;
//     });

//     $('.validate-form .input100').focus(function () {
//         hideValidate(this);
//     });

//     function validate(input) {
//         if ($(input).is('[type="email"], [name="email"]') && !$(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/)) {
//             return false;
//         } else if ($(input).val().trim() === '') {
//             return false;
//         } else {
//             return true;
//         }
//     }

//     function showValidate(input) {
//         $(input).parent().addClass('alert-validate');
//     }

//     function hideValidate(input) {
//         $(input).parent().removeClass('alert-validate');
//     }
// })(jQuery);


$(document).ready(function () {

    updateNavByLoginStatus();

    let loginButton = document.getElementsByClassName("login-form-btn")[0];
    loginButton.addEventListener('click', function (){
        logIn();
    });

    const logoutButton = document.getElementById("logoutNav-li");
    // console.log(logoutButton);
    logoutButton.addEventListener('click', function (){
        logOut();
    });



    function getCookie(cname) {
        let name = cname + "=";
        let decodedCookie = decodeURIComponent(document.cookie);
        let ca = decodedCookie.split(';');
        for (let i = 0; i < ca.length; i++) {
            let c = ca[i];
            while (c.charAt(0) == ' ') {
                c = c.substring(1);
            }
            if (c.indexOf(name) == 0) {
                return c.substring(name.length, c.length);
            }
        }
        return "";
    }
    function deleteCookie(cname) {
        document.cookie = cname + '=; Max-Age=-99999999;' + 'domain=localhost';
        updateNavByLoginStatus();
    }
    function logOut() {
        deleteCookie("username");
        console.log(getCookie("username"));
        window.location.href = "login.html";
    }

    function updateNavByLoginStatus() {

        let loggedInUsername = getCookie("username");
        // return(username != "") ;
        console.log(loggedInUsername);
        if (loggedInUsername != "") {//Logged in user
            document.getElementById("pastQuiz-li").style.display = "block";
            document.getElementById("logoutNav-li").style.display = "block";
            document.getElementById("loginNav-li").style.display = "none";
            // document.getElementById("loginNav-li").style.display = "none";



        }
        else {//Guest user, not logged in
            // console.log(document.getElementById("favouritesNav-li"));
            
            document.getElementById("pastQuiz-li").style.display = "none";
            document.getElementById("logoutNav-li").style.display = "none";
            document.getElementById("loginNav-li").style.display = "block";
        }


    }


    function logIn() {
        let username = document.getElementById("username-input").value;
        // let email = document.getElementById("email-input").value;
        let password = document.getElementById("password-input").value;
        // let confirmPassword = document.getElementById("confirm-password-input").value;

        // alert(username + "/" + email + "/" + password + "/" );
        // return;
        if(username == "" || password == "" ){
            alert("Please fill in all required fields.");
            return;
        }
        // if(password != confirmPassword){
        //     alert("Passwords entered do not match");
        //     return;
        // }
        // if(!email.includes('@')){
        //     alert("Please enter a valid email");
        //     return;
        // }

        let ajaxUrl = 'http://localhost:8082/CSCI201Quiz/login';
        console.log(ajaxUrl);
        let sendData = {
            "username": username,
            "password": password
         };
        $.ajax({
            type: "POST",
            // headers: {
            //     'Access-Control-Allow-Origin': '*'
            //     // 'Content-Type':'application/json'
            // },
            dataType: 'json',

            url: ajaxUrl,
            contentType: 'application/json',
            data: JSON.stringify( sendData ),
            // crossDomain: true,
            // processData: false,
            // beforeSend: function(xhr){xhr.setRequestHeader('Authorization', '[your-api-key]');},
            // headers: {'Authorization': '[your API key]'},
            success: function (response) {
                console.log(response);
                

                // printTime();
                // updateNavByLoginStatus();
                window.location.href = "index.html";
                


            },
            error: function (err) {
                console.log(err);
                console.log(err.responseJSON);
                window.alert("Error Logging In: " + err.responseJSON);
                // window.alert("Unable to get details of selected event.");
            }

        });
    }

});