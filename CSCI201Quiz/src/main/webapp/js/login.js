(function ($) {
    "use strict";
    
    $('.validate-form').on('submit', function() {
        var valid = true;
        $('.validate-input .input100').each(function() {
            if(!validate(this)) {
                showValidate(this);
                valid = false;
            }
        });
        return valid;
    });

    $('.validate-form .input100').focus(function() {
        hideValidate(this);
    });

    function validate(input) {
        if($(input).is('[type="email"], [name="email"]') && !$(input).val().trim().match(/^([a-zA-Z0-9_\-\.]+)@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.)|(([a-zA-Z0-9\-]+\.)+))([a-zA-Z]{1,5}|[0-9]{1,3})(\]?)$/)) {
            return false;
        } else if($(input).val().trim() === '') {
            return false;
        } else {
            return true;
        }
    }

    function showValidate(input) {
        $(input).parent().addClass('alert-validate');
    }

    function hideValidate(input) {
        $(input).parent().removeClass('alert-validate');
    }
})(jQuery);


$(document).ready(function () {

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
        window.location.href = "index.html";
    }
});