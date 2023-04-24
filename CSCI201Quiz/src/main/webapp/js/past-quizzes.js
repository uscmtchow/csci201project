$(document).ready(function() {

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

	async function getResults() {

		// Load quiz results
		let results = await fetch(`/CSCI201Quiz/userhistory?username=ttrojan`, {
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

		for (let result of results) {
			$(".results-container table tbody").append(`
		<tr>
			<td><img class='result-image' src='${result.image_location}'/></td>
			<td><span>${result.quiz_result}</span></td>
			<td><span>${result.quiz_id}</span></td>
		</tr>
		`)
		}

	}

	getResults();



});