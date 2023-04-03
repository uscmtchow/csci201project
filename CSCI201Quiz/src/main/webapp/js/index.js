// function diff_screen_resolution() {
//     // for top carousel different screen resolution;
//     if ($(window).width() < 700) {
//         $("#top_carousel_1 .fill").css("background-image", "url(./images/Carousel/IMG1_small.jpg)");
//         $("#top_carousel_3 .fill").css("background-image", "url(./images/Carousel/IMG3_small.jpg)");
//         $("#top_carousel_5 .fill").css("background-image", "url(./images/Carousel/IMG5_small.jpg)");

//         $("#top_carousel_5 .fill").css("background-position", "left");
//     } else {
//         $("#top_carousel_1 .fill").css("background-image", "url(./images/Carousel/IMG1.jpg)");
//         $("#top_carousel_3 .fill").css("background-image", "url(./images/Carousel/IMG3.jpg)");
//         $("#top_carousel_5 .fill").css("background-image", "url(./images/Carousel/IMG5.jpg)");

//         $("#top_carousel_5 .fill").css("background-position", "center");
//     }
// }

// function smooth_move(where) {
//     if (this.hash !== "") {
//         var hash = where;
//         $('html, body').animate({
//             scrollTop: $(hash).offset().top
//         }, 'slow', function(){
//             window.location.hash = hash;
//         });
//     } // End if
// }
//jQuery OnDocument Load



$(document).ready(function () {

    //loads the navbar from nav.html
    getAllCategories();

    let getAllQuizzesURL = "http://localhost:8081/CSCI201Quiz/quiz";
    ajaxAPIParseJSON("GET",getAllQuizzesURL, document.getElementsByClassName("quiz-data")[0]);
    
    let getQuizzesByCategoryURL = "http://localhost:8081/CSCI201Quiz/quiz?" + "category=" + "Sports";
    ajaxAPIParseJSON("GET",getQuizzesByCategoryURL, document.getElementsByClassName("quiz-by-category")[0]);
    
    let quizQuestionsURL = "http://localhost:8081/CSCI201Quiz/question?" + "quizId=" + "1";
    ajaxAPIParseJSON("GET",quizQuestionsURL, document.getElementsByClassName("quiz-questions")[0]);
    



    function printTime() {
        const today = new Date();
        var currentdate = today.toLocaleString('en-US', { dateStyle: "medium", timeStyle: "medium" });
        // var datetime = "Last Updated: " + currentdate.getDate() + "/"
        //     + (currentdate.getMonth()+1)  + "/" 
        //     + currentdate.getFullYear() + " @ "  
        //     + currentdate.getHours() + ":"  
        //     + currentdate.getMinutes() + ":" 
        //     + currentdate.getSeconds();
        console.log('Print Time:' + currentdate);
        // document.getElementById("last-updated").textContent = "Last updated:  " + currentdate; //it will print on html page
    }
    function popUpMessage(message) {

        
        let walletPopupDiv = document.getElementById("myPopup")
        walletPopupDiv.classList.toggle("show");
        
        // document.getElementsByClassName("popup-ok-button")[0].dataset.type = "normal";
        
        document.getElementsByClassName("popup-text")[0].innerHTML = message;
        // popup.innerHTML = message;
        // popupwindow("http://localhost:8081/assignmentWeb4/wallet.html");
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
    function checkUsernameCookie() {
        let username = getCookie("username");
        if (username != "") {
            return true;
        } else {
            return false;
        }
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
    function ajaxAPIParseJSON(APItype, ajaxUrl, tableClassName){
        // let ajaxUrl = "http://localhost:8081/CSCI201Quiz/category";
        console.log(ajaxUrl);
        $.ajax({
            type: APItype,
            // headers: {
            //     'Access-Control-Allow-Origin': '*'
            //     // 'Content-Type':'application/json'
            // },
            dataType: 'json',
    
            url: ajaxUrl,
            // contentType: 'application/json',
            // data: JSON.stringify( sendData ),
            success: function (response) {
                console.log(response);
                
                let data = JSON.parse(response);
                console.log(data);
                // for (const datum of data) {
                //     console.log(categoryData);
                // }
                printToTable(data, tableClassName);
                // return data;
                
                // searchEventTable.style.display = "block";
                // saveTableData = array;
    
                // //reinitializing array to store File IDs that match filters
                // filteredFileIDs = [];
                // insertFiledataToTable(0, filterKeysArray[0], filterLoadNoFiles, fileSizeFilterOperator, fileSizeFilter);
    
    
            },
            error: function (err) {
    
                window.alert("Error: " + tableClassName + " returned empty data");
                // window.alert(tableClassName + " error.");
            }
    
        })
    }
    function updateNavByLoginStatus() {

        let loggedInUsername = getCookie("username");
        // return(username != "") ;
        console.log(loggedInUsername);
        if (loggedInUsername != "") {
            document.getElementById("favouritesNav-li").style.display = "block";
            document.getElementById("walletNav-li").style.display = "block";
            document.getElementById("logoutNav-li").style.display = "block";
            document.getElementById("loginNav-li").style.display = "none";



        }
        else {
            console.log(document.getElementById("favouritesNav-li"));
            document.getElementById("favouritesNav-li").style.display = "none";
            document.getElementById("walletNav-li").style.display = "none";
            document.getElementById("logoutNav-li").style.display = "none";
            document.getElementById("loginNav-li").style.display = "block";
        }


    }
    function printToTable(data, table){
        if(data.length <=0){
            return;
        }
        var row = table.insertRow();
        for (var key in data[0]) {
            var tableHeader = document.createElement("th");
            tableHeader.innerHTML = key;

            row.appendChild(tableHeader);
        }

        for(const datum of data){
            var row = table.insertRow();
            for (var key in datum) {
                if (datum.hasOwnProperty(key)) {
                    console.log(datum[key]);
                    if(key === "image_location"){
                        var image_link = document.createElement("a");
                        image_link.innerHTML = "Link to image";
                        image_link.target = "_blank";
                        image_link.setAttribute("href", datum[key]);

                        var td = row.insertCell();
                        td.appendChild(image_link);
                        // td.appendChild(image_link);
                    }
                    else if(key === "answerList"){
                        printAnswerList(datum["description"], datum[key]);
                        row.insertCell().innerHTML = datum[key];
                    }
                    else{
                        row.insertCell().innerHTML = datum[key];
                    }
                    
                }
            }
        }
        
    }
    function printAnswerList(question, answerList){
        let table = document.getElementsByClassName("question-answers")[0];
        let headerRow = table.insertRow();
        headerRow.insertCell().innerHTML = "Question";
        headerRow.insertCell().innerHTML = "question_id";
        headerRow.insertCell().innerHTML = "answer_description";
        headerRow.insertCell().innerHTML = "answer_value";
        for(const answer of answerList){
            let dataRow = table.insertRow();
            dataRow.insertCell().innerHTML = question;
            for (var key in answer) {
                if (answer.hasOwnProperty(key)) {
                    dataRow.insertCell().innerHTML = answer[key];
                }
            }
        }
    }
    function getAllCategories(){
        let ajaxUrl = "http://localhost:8081/CSCI201Quiz/category";
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
            success: function (response) {
                console.log(response);
                
                let allCategoryData = JSON.parse(response);
                // searchEventTable.style.display = "block";
                console.log(allCategoryData);
                for (const categoryData of allCategoryData) {
                    console.log(categoryData);
                    console.log(categoryData["name"]);
                    console.log(categoryData["description"]);
                }
                printToTable(allCategoryData, document.getElementsByClassName("category-data")[0]);
                // saveTableData = array;
    
                // //reinitializing array to store File IDs that match filters
                // filteredFileIDs = [];
                // insertFiledataToTable(0, filterKeysArray[0], filterLoadNoFiles, fileSizeFilterOperator, fileSizeFilter);
    
    
            },
            error: function (err) {
    
                window.alert("getAllCategories error.");
            }
    
        })
    }
    
    
   
    
});
// $(window).resize(function () {
//     diff_screen_resolution();
// });