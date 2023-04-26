/**
 * 
 */

$(document).ready(function() {

	const params = new Proxy(new URLSearchParams(window.location.search), {
		get: (searchParams, prop) => searchParams.get(prop),
	});
	const quizId = params.id;

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