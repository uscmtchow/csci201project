/**
 * 
 */

$(document).ready(function() {
	const params = new Proxy(new URLSearchParams(window.location.search), {
		get: (searchParams, prop) => searchParams.get(prop),
	});
	const quizId = params.quiz_id;
	updateNavByLoginStatus();
	
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
	async function load() {

		// Load quiz questions
		$.get(`/CSCI201Quiz/question`, {
			quizId
		}, function(data) {
			questions = JSON.parse(data);

			for (let q of questions) {

				// Add quiz
				$("table").append(`
					<tr>
						<td>${q.description}</td>
						<td>
						${q.answerList.map((answer) => {
					return (`
								<div>
									<input type='radio' name=${q.question_no} value=${answer.description} data-point-value=${answer.answer_value} required/>
									<label for=${answer.description}>${answer.description}</label>
								</div>
							`);
				}).join('')}
						</td>
					</tr>
					`)
			}

			// Add submit button
			$(".quiz-container form").append(`
				<div class='button-wrapper'>
					<button type='submit'>Submit</button>
				</div>
			`)
		});

	}
	


	
	$(document).on("submit", "#quiz", function(e) {

		e.preventDefault();

		// Get sum of answers
		let sum = $("#quiz input[data-point-value=1]:checked").length;

		// Load quiz questions
		$.get(`/CSCI201Quiz/result`, {
			quiz_id: quizId,
			score: sum,
			username: getCookie("username")
		}, function(data) {
			$("body").prepend(`
				<modal></modal>
				<div class='modal-window'>
					<h1>Score: ${sum}</h1>
					<div>
					<img class='img' src=${data.loc}/>
					<span class='desc'>${data.description}</span>
					</div>
				</div>
			
			`)
		});



		$(document).on("click", "modal", function(e) {
			$("modal, .modal-window").remove();
		});

	});

	load();

});