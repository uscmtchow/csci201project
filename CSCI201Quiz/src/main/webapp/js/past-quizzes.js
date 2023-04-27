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
        window.location.href = "login.html";
    }


	async function getResults() {

		// Load quiz results
		let username = getCookie("username");
		let url = '/CSCI201Quiz/quizrecord?username=' + username;
		console.log(url);
		let results = await fetch(`/CSCI201Quiz/quizrecord?username=` + username, {
			method: "GET"
		}).then((response) => {
			try {
				return response.json();
			} catch (error) {
				console.log(error);
				return [];
			}
		}).catch((error) => {
			alert(error);
			return [];
		});

		console.log(results);
		if(results.length <= 0){
			alert("You have no past quizzes.");
			return;
		}
		for (let result of results) {
			$(".results-container table tbody").append(`
		<tr>
			<td><img class='result-image' src='${result.image_location}'/></td>
			<td>
				<span style="padding-bottom: 10px; font-weight: bolder; font-size: xx-large;">${result.quiz_name}</span>
				<span>${result.quiz_result}</span>
			</td>
			
		</tr>
		`)
		}

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

	updateNavByLoginStatus();
	getResults();
	const logoutButton = document.getElementById("logoutNav-li");
    // console.log(logoutButton);
    logoutButton.addEventListener('click', function (){
        logOut();
    });



});