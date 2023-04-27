/**
 * 
 */

$(document).ready(function() {
	const params = new Proxy(new URLSearchParams(window.location.search), {
		get: (searchParams, prop) => searchParams.get(prop),
	});
	const quizId = params.quiz_id;
	updateNavByLoginStatus();
	const logoutButton = document.getElementById("logoutNav-li");
    // console.log(logoutButton);
    logoutButton.addEventListener('click', function () {
        logOut();
    });
	
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
				$("#quiz-questions-table").append(`
					<tr>
						<td>${q.question_no}</td>
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
			$(".questions-container form").append(`
				<div class='button-wrapper'>
					<button type='submit'>Submit</button>
				</div>
			`)
		});

	}
	
	function getQuizInfoFromId(quizId){
		// localhost:8082/CSCI201Quiz/quiz?quiz_id=1
		let quizInfoTable = document.getElementsByClassName("quiz-info-table")[0];
        $(quizInfoTable).find("tr:not(:first)").remove();

		let ajaxUrl = 'http://localhost:8082/CSCI201Quiz/quiz?quiz_id=' + quizId;
        console.log(ajaxUrl);
        $.ajax({
            type: "GET",
            // headers: {
            //     'Access-Control-Allow-Origin': '*'
            //     // 'Content-Type':'application/json'
            // },
            dataType: 'json',

            url: ajaxUrl,
            // contentType: 'application/json',
            // data: JSON.stringify( sendData ),
            // crossDomain: true,
            // processData: false,
            // beforeSend: function(xhr){xhr.setRequestHeader('Authorization', '[your-api-key]');},
            // headers: {'Authorization': '[your API key]'},
            success: function (response) {
                console.log(response);
                // console.log(response.responseText);

                // const tableId = "#filenameTable";
                // var table = document.getElementById(tableId);
                // $(tableId).find("tr:not(:first)").remove();

                // //For CFT, add extra column for file's Parent Folder Name
                // if(filterKeysArray[0] == "CFT"){
                //     $('#parent-file-col').show();
                // }
                // else{
                //     $('#parent-file-col').hide();
                // }
                // printTime();
                let quizInfo = JSON.parse(response);
				
				let row = quizInfoTable.insertRow();
				
				var imageElem = document.createElement("img");
                imageElem.setAttribute("src", quizInfo["image_location"]);


                imageElem.setAttribute("height", "200px");
                imageElem.setAttribute("width", "300px");
                // imageElem.setAttribute("alt", "Flower");
                row.insertCell().appendChild(imageElem);
                // row.insertCell().innerHTML = saveTableData[i]["images"]

                
                
                var quizNameSpan = document.createElement("span");
                quizNameSpan.classList.add("quiz-name");
                quizNameSpan.innerHTML = quizInfo["name"];

                // var lineBreak = document.createElement("br");

                var quizDescriptionSpan = document.createElement("span");
                quizDescriptionSpan.classList.add("quiz-description");
                quizDescriptionSpan.innerHTML = quizInfo["description"];

                // var takeQuizButton = document.createElement("button");
                // takeQuizButton.classList.add("take-quiz");
                // takeQuizButton.dataset.quizid = saveTableData[i].id;
                // takeQuizButton.innerHTML = "Take Quiz!";
                // takeQuizButton.addEventListener('click', function () {
                //     let quiz_id = this.dataset.quizid;
                //     console.log(quiz_id);
                //     goToQuiz(quiz_id);
                // });
                
                var quizInfoCell = row.insertCell();
                quizInfoCell.appendChild(quizNameSpan);
                quizInfoCell.appendChild(document.createElement("br"));
                quizInfoCell.appendChild(document.createElement("br"));
                quizInfoCell.appendChild(quizDescriptionSpan);
                // quizInfoCell.appendChild(lineBreak);
                // quizInfoCell.appendChild(takeQuizButton);


                // searchEventTable.style.display = "block";



                // saveTableData = array;

                // //reinitializing array to store File IDs that match filters
                // filteredFileIDs = [];
                // insertFiledataToTable(0, filterKeysArray[0], filterLoadNoFiles, fileSizeFilterOperator, fileSizeFilter);


            },
            error: function (err) {
                window.alert("Please fill in all required fields.");
            }

        });

	}

	
	$(document).on("submit", "#quiz", function(e) {

		e.preventDefault();

		// Get sum of answers
		let sum = $("#quiz input[data-point-value=1]:checked").length;

		// Load quiz questions
		console.log("Score:" + sum);
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
					<img class='img' src=${data.loc}>
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
	getQuizInfoFromId(quizId);

});