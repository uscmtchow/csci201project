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
    // updateNavByLoginStatus();
    var category = 'Sports';
    const logoutButton = document.getElementById("logoutNav-li");
    console.log(logoutButton);
    logoutButton.addEventListener('click', function () {
        logOut();
    });
    //listening to searchbutton
    const searchButton = document.getElementsByClassName("search-button")[0];
    searchButton.addEventListener('click', function () {
        // console.log("ikasknas");
        searchData();
    });

    // const purchaseButton = document.getElementsByClassName("purchase-button")[0];
    // purchaseButton.addEventListener('click', function () {
    //     doTradeEvent();
    // });

    // const popUpOKButton = document.getElementsByClassName("popup-ok-button")[0];
    // popUpOKButton.addEventListener('click', function () {
    //     document.getElementById("myPopup").classList.toggle("show");
    // });

    // var favoriteEvent_starVar = document.getElementsByClassName("fa")[0];
    // var favoriteEvent_star = $(document.getElementsByClassName("fa")[0]);
    // favoriteEvent_starVar.addEventListener('click', function (event) {

    //     // console.log(this.parentElement.parentElement.parentElement);
    //     event.stopPropagation();
    //     var eventId = document.getElementsByClassName("trade-details-id")[0].innerHTML;
    //     var eventName = document.getElementsByClassName("trade-details-name")[0].innerHTML;

    //     console.log("click " + eventId);
    //     if (favoriteEvent_star.hasClass("fa-star-o")) {//originally unstarred
    //         //add star
    //         favoriteEvent_star.removeClass("fa-star-o");
    //         favoriteEvent_star.addClass("fa-star");
    //         updateFavoritedEvent(eventId, "add");
    //         popUpMessage("Added " + eventName + " to favorites");

    //     } else if (favoriteEvent_star.hasClass("fa-star")) {////originally starred
    //         //remove star
    //         favoriteEvent_star.removeClass("fa-star");
    //         favoriteEvent_star.addClass("fa-star-o");
    //         updateFavoritedEvent(eventId, "remove");
    //         popUpMessage("Removed " + eventName + " from favorites");
    //     } 
    //     // console.log(favoriteIdCount);
    //     // console.log(favoriteEventId);

    // });



    var saveTableData = [];


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
    // // Add smooth scrolling to all links in navbar + footer link
    // $(".navbar a, footer a[href='#WiDeS'], .carousel .text a, .dropbtn").on('click', function(event) {
    //     // Make sure this.hash has a value before overriding default behavior
    //     if (this.hash !== "") {
    //         // Prevent default anchor click behavior
    //         event.preventDefault(); 
    //         // Store hash
    //         var hash = this.hash;

    //         // Using jQuery's animate() method to add smooth page scroll
    //         // The optional number (1000) specifies the number of milliseconds it takes to scroll to the specified area
    //         $('html, body').animate({
    //             scrollTop: $(hash).offset().top
    //         }, 'slow', function(){
    //             // Add hash (#) to URL when done scrolling (default click behavior)
    //             window.location.hash = hash;
    //         });
    //     } // End if
    // });

    // $('.flip').hover(function(){
    // 	$(this).find('.card').toggleClass('flipped');
    // });

    // $('.single-item').slick({
    //     slidesToShow: 1,
    //     slidesToScroll: 1,
    //     autoplay: false,
    //     autoplaySpeed: 1000,
    //     arrows: true,
    //     dots: false,
    //     fade: false,
    //     cssEase: 'linear',
    //     pauseOnHover: true
    // });

    // $('.customer-logos').slick({
    //     slidesToShow: 5,
    //     slidesToScroll: 1,
    //     autoplay: true,
    //     autoplaySpeed: 1000,
    //     arrows: false,
    //     dots: false,
    //     pauseOnHover: false,
    //     responsive: [{
    //         breakpoint: 1200,
    //         settings: {
    //             slidesToShow: 4
    //         }
    //     },{
    //         breakpoint: 900,
    //         settings: {
    //         slidesToShow: 3
    //     }
    //     }, {
    //         breakpoint: 768,
    //         settings: {
    //         slidesToShow: 2
    //         }
    //     }]
    // });

    // $('#myCarousel').carousel({
    //     interval: 1000 * 20
    // });

    // $('#newsCarousel').carousel({
    //     interval: 1000 * 20
    // });

    // $(".item div.news-fill").hover(function(){
    //     $(".carousel.textNews").removeClass("hidden");
    //     $(".news-fill span").removeClass("hidden");
    // }, function(){
    //     $(".carousel.textNews").addClass("hidden");
    // });

    // $(".item div.news-fill h3").click(function(){
    //     $(".news-fill span").removeClass("hidden");
    // });

    // $(".carousel-caption").hover(function(){
    //     $(".carousel-caption p").removeClass("hidden");
    // }, function(){
    //     $(".carousel-caption p").addClass("hidden");
    // });


    // $(".navbar-nav li a").click(function(event) {
    //     $(".navbar-collapse").collapse('hide');
    // });

    // for different screen resoltion
    // diff_screen_resolution();
    function searchData() {


        $("#events-table").find("tr:not(:first)").remove();
        var tradeEventsDiv = document.getElementsByClassName("trade-events-div")[0];
        if (tradeEventsDiv != null) {
            tradeEventsDiv.style.display = "none";
        }


        // var keywordFilterWords = document.getElementById("keyword-filter").value;
        // var locationFilterWords = document.getElementById("location-filter").value;

        // var keywordFilter = keywordFilterWords.replace(/\s+/g, '%20');
        // var locationFilter = locationFilterWords.replace(/\s+/g, '%20');


        // var filterKeysArray = [];
        // var filterNotSelected = false;
        // var filterLoadNoFiles = parseInt(filterKeys[3].innerHTML);
        // var filenameDatatable = document.getElementById("filenameTable");
        // var filenameFilter = document.getElementById("searchFilenameFilter").value;
        // var fileSizeFilterOperator = filterKeys[4].innerHTML;
        // var fileSizeFilter = document.getElementById("fileSizeFilter").value;
        // var fileSizeFilter = fileSizeFilter == ""? -1: parseInt(fileSizeFilter);
        // var dateCreatedFilter = document.getElementById("dateCreatedFilter").value;
        // var dateCreatedFilter = dateCreatedFilter == ""? -1: parseInt(dateCreatedFilter);
        // if (!isNumber(dateCreatedFilter) || !(isNumber(fileSizeFilter))) {
        //     alert("Error! You must enter a number into the File size and Date created filters!");
        // }
        let category = 'Sports'
        let ajaxUrl = 'http://localhost:8082/CSCI201Quiz/quiz?category=' + category;
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
                saveTableData = JSON.parse(response);
                // searchEventTable.style.display = "block";

                for (const result of saveTableData) {
                    console.log(result);
                    console.log(result["name"]);
                }
                displayQuizdata();
                insertQuizdataToTable();
                
                // saveTableData = array;

                // //reinitializing array to store File IDs that match filters
                // filteredFileIDs = [];
                // insertFiledataToTable(0, filterKeysArray[0], filterLoadNoFiles, fileSizeFilterOperator, fileSizeFilter);


            },
            error: function (err) {

                window.alert("Please fill in all required fields.");
            }

        })
    }

    function displayQuizdata() {
        let displayQuizDiv = document.getElementsByClassName("quiz-list column")[0];
        for (let i = 0; i < saveTableData.length; i++) {
            let displayQuizRow = document.createElement("div");
            $(displayQuizRow).addClass("quiz-list row");

            let quizImageCol = document.createElement("div");
            $(quizImageCol).addClass("column quiz-image");
            let imageElem = document.createElement("img");
            imageElem.setAttribute("src", saveTableData[i]["image_location"]);
            imageElem.setAttribute("height", "100px");
            imageElem.setAttribute("width", "150px");
            // imageElem.setAttribute("alt", "Flower");
            quizImageCol.appendChild(imageElem);


            let quizInfoCol = document.createElement("div");
            $(quizInfoCol).addClass("column quiz-info");
            
            let quizNameDiv = document.createElement("div");
            $(quizNameDiv).addClass("row quiz-name");
            quizNameDiv.innerHTML = saveTableData[i]["name"];

            let quizCategoryDiv = document.createElement("div");
            $(quizCategoryDiv).addClass("row quiz-category");
            quizCategoryDiv.innerHTML = category;

            let quizDescriptionDiv = document.createElement("div");
            $(quizDescriptionDiv).addClass("row quiz-description");
            quizDescriptionDiv.innerHTML = saveTableData[i]["description"];

            quizInfoCol.appendChild(quizNameDiv);
            quizInfoCol.appendChild(quizCategoryDiv);
            quizInfoCol.appendChild(quizDescriptionDiv);

            displayQuizRow.appendChild(quizImageCol);
            displayQuizRow.appendChild(quizInfoCol);
            
            displayQuizDiv.appendChild(displayQuizRow);
        }
    }
    function insertQuizdataToTable() {

        let searchDataTable = document.getElementById("quiz-table");


        if (saveTableData == null || saveTableData.length < 1) {
            window.alert("No quizzess found for selected category.");
        }
        else {
            document.getElementsByClassName("quiz-table-div")[0].style.display = "block";
            for (let i = 0; i < saveTableData.length; i++) {
                // var filteredFileID = filteredFileIDs[i];
                var row = searchDataTable.insertRow();
                // console.log(row.rowIndex);
                // row.addEventListener('click', function (e) {
                //     // console.log(this.row);
                //     // if(checkUsernameCookie()){

                //     // }

                //     // console.log(this.rowIndex);
                //     if (getCookie("username") != "") {
                //         getTradeEventData(saveTableData[this.rowIndex - 1]["eventId"]);
                //     }


                //     // console.log(this.index());
                //     // this.getRowInfo()
                // });


                row.insertCell().innerHTML = saveTableData[i]["name"];
                var imageElem = document.createElement("img");
                imageElem.setAttribute("src", saveTableData[i]["image_location"]);
                imageElem.setAttribute("height", "100px");
                imageElem.setAttribute("width", "150px");
                // imageElem.setAttribute("alt", "Flower");
                row.insertCell().appendChild(imageElem);
                // row.insertCell().innerHTML = saveTableData[i]["images"]
                row.insertCell().innerHTML = saveTableData[i]["description"];
                row.insertCell().innerHTML = category;
                // if(fileType == "CFT"){
                //     row.insertCell().innerHTML = saveTableData[i]["parentFolder"];
                // }

                // var filenameCell = row.insertCell();
                // if(filenameTooLong){
                //     // console.log(filename);
                //     filenameCell.classList.add("filenameTooLongCell");
                //     filenameCell.innerHTML = filename.substring(0, 20) + ".....";
                //     filenameCell.style.color = "#0000FF";

                //     filenameCell.addEventListener('click', function () {
                //         var modal = document.getElementById("filenameTooLongModal");
                //         // Get the <span> element that closes the modal
                //         var span = document.getElementsByClassName("close")[0];
                //         var fileTableID = parseInt(this.previousElementSibling.innerHTML);
                //         if(fileType == "CFT"){//extra parent folder column, need to go back 2 sibling elements
                //             fileTableID = parseInt(this.previousElementSibling.previousElementSibling.innerHTML);
                //         }
                //         var modalContent = document.getElementById("modalContent");

                //         modalContent.innerHTML = saveTableData[fileTableID]["filename"];
                //         modal.style.display = "block";
                //         span.onclick = function() {
                //             modal.style.display = "none";
                //         }
                //         window.onclick = function(event) {
                //             if (event.target == modal) {
                //                 modal.style.display = "none";
                //             }
                //         }
                //     });

                // }
                // else filenameCell.innerHTML = filename;

                // row.insertCell().innerHTML = saveTableData[i]["lastModifiedTime"];
                // row.insertCell().innerHTML = saveTableData[i]["creationTime"];
                // row.insertCell().innerHTML = saveTableData[i]["fileSize"];
            }
        }
    }
    function getTradeEventData(eventId) {
        $.ajax({
            type: "GET",
            // headers: {
            //     'Access-Control-Allow-Origin': '*'
            //     // 'Content-Type':'application/json'
            // },
            dataType: 'json',

            url: 'https://us-west2-csci201-376723.cloudfunctions.net/explore-events/eventDetail/' + eventId,
            // contentType: 'application/json',
            // data: JSON.stringify( sendData ),
            // crossDomain: true,
            // processData: false,
            // beforeSend: function(xhr){xhr.setRequestHeader('Authorization', '[your-api-key]');},
            // headers: {'Authorization': '[your API key]'},
            success: function (response) {
                console.log(response);

                // printTime();
                let tradeData = response;

                // var array = JSON.parse(response);
                // console.log(array)
                // console.log(response["date"]);
                // return tradeData;
                insertTradeEventData(tradeData, eventId);


            },
            error: function (err) {

                window.alert("Unable to get details of selected event.");
            }

        })
    }
    function insertTradeEventData(tradeData, eventId) {
        let tradeEventsDiv = document.getElementsByClassName("trade-events-div")[0];;
        tradeEventsDiv.style.display = "flex";
        tradeEventsDiv.dataset.eventid = eventId;
        tradeEventsDiv.dataset.minprice = tradeData["price"]["min"];
        let eventFavorited = false;
        // let sendData = {
        //     "username": getCookie("username")
        //  };
        console.log('http://localhost:8081/assignmentWeb4/favorites');

        $.ajax({
            url: 'http://localhost:8081/assignmentWeb4/favorites?' + 'username=' + getCookie("username") + '&eventId=' + eventId,
            type: "GET",
            dataType: 'json',
            // data: JSON.stringify(sendData),
            // contentType: 'application/json',
            mimeType: 'application/json',
            // headers: {
            //     'Access-Control-Allow-Origin': '*',
            //     'Content-Type':'application/json'
            // },


            // contentType: 'application/json',

            // crossDomain: true,
            // processData: false,
            // beforeSend: function(xhr){xhr.setRequestHeader('Authorization', '[your-api-key]');},
            // headers: {'Authorization': '[your API key]'},
            success: function (response) {
                console.log(response);
                // saveTableData = JSON.parse(response);
                // console.log(response.responseText);

                // const tableId = "#filenameTable";
                // var table = document.getElementById(tableId);
                // $(tableId).find("tr:not(:first)").remove();
                // printTime();
                // console.log(getCookie("username"));
                // console.log(checkUsernameCookie().toString());
                // updateNavByLoginStatus();
                eventFavorited = (response === 'true');
                // console.log(eventFavorited);

                var favoriteEvent_star = $(document.getElementsByClassName("fa")[0]);

                if (eventFavorited) {
                    favoriteEvent_star.removeClass("fa-star-o");
                    favoriteEvent_star.addClass("fa-star");
                }
                else {
                    favoriteEvent_star.removeClass("fa-star");
                    favoriteEvent_star.addClass("fa-star-o");
                }



            },
            error: function (err) {
                console.log(err);
                window.alert(err.responseJSON);
            }

        })
        //"GET" AJAX api call to get trade Event data





        //"GET" API call to server check whether event was favorited 
        //Fill into trade-details div
        // console.log(tradeData["date"]);
        // console.log(tradeData["price"]["max"]);
        // console.log(document.getElementsByClassName("trade-details-name")[0]);
        // let h1Name = document.createElement('a');
        // h1Name.innerHTML = tradeData["event"]["name"];
        document.getElementsByClassName("trade-details-id")[0].innerHTML = eventId;
        document.getElementsByClassName("trade-details-name")[0].innerHTML = tradeData["event"]["name"];

        document.getElementsByClassName("trade-details-date")[0].innerHTML = tradeData["date"]["localDate"];
        document.getElementsByClassName("trade-details-venue")[0].innerHTML = tradeData["event"]["venue"];

        let tradeDetailsPrice_span = document.getElementsByClassName("trade-details-price-range")[0]
        if (parseInt(tradeData["price"]["min"]) == -1) {
            tradeDetailsPrice_span.innerHTML = "N/A - N/A";
            document.getElementsByClassName("purchase-button")[0].style.display = "none";
            // alert("Event is not currently available for trade.");
        }
        else {
            tradeDetailsPrice_span.innerHTML = tradeData["price"]["min"] + " - " + tradeData["price"]["max"];
            document.getElementsByClassName("purchase-button")[0].style.display = "flex";
        }




        let tradeInfoLink = document.getElementsByClassName("trade-details-more-info")[0];
        console.log(tradeInfoLink);
        tradeInfoLink.setAttribute('href', tradeData["event"]["url"]);
        tradeInfoLink.innerHTML = tradeData["event"]["url"];
        tradeInfoLink.target = "_blank";
        // document.getElementsByClassName("trade-details-more-info")[0].innerHTML = tradeData["event"]["url"];
        // document.getElementsByClassName("trade-details-more-info")[0].href = tradeData["event"]["url"];

        // appendChild(tradeInfoLink);


    }

    function updateFavoritedEvent(eventId, updateType) {
        $.ajax({
            url: 'http://localhost:8081/assignmentWeb4/favorites?' + 'username=' + getCookie("username") + '&eventId=' + eventId + '&updateType=' + updateType,
            type: "POST",
            dataType: 'json',
            // data: JSON.stringify(sendData),
            // contentType: 'application/json',
            mimeType: 'application/json',
            // headers: {
            //     'Access-Control-Allow-Origin': '*',
            //     'Content-Type':'application/json'
            // },


            // contentType: 'application/json',

            // crossDomain: true,
            // processData: false,
            // beforeSend: function(xhr){xhr.setRequestHeader('Authorization', '[your-api-key]');},
            // headers: {'Authorization': '[your API key]'},
            success: function (response) {
                console.log(response);

                let favoriteEventName = document.getElementsByClassName("trade-details-name")[0].innerHTML;
                // if(updateType === "add"){
                //     popUpMessage("Added " + favoriteEventName + " to favorites");
                // }

                // if(updateType === "remove"){

                //     popUpMessage("Removed " + favoriteEventName + " from favorites");
                // }
                // else{
                //     console.log("favorite updateType error");
                // }
                // saveTableData = JSON.parse(response);
                // console.log(response.responseText);


                // window.location.href = "index.html";
                // for (const result of saveTableData) {
                //     // console.log(result);
                //     console.log(result["id"]);
                // }
                // insertFiledataToTable();
                // saveTableData = array;

                // //reinitializing array to store File IDs that match filters
                // filteredFileIDs = [];
                // insertFiledataToTable(0, filterKeysArray[0], filterLoadNoFiles, fileSizeFilterOperator, fileSizeFilter);


            },
            error: function (err) {
                console.log(err);
                window.alert("Failed");
            }

        })
    }
    function doTradeEvent() {
        let tradeEventDiv = document.getElementsByClassName("trade-events-div")[0];
        console.log(tradeEventDiv);

        let quantity = Number(document.getElementById("trade-details-quantity").value);


        if (quantity <= 0) {
            // console.log(quantity);
            popUpMessage("FAILED: transaction not possible");
            return;
        }


        console.log(quantity);

        let eventId = tradeEventDiv.dataset.eventid;
        let eventName = tradeEventDiv.getElementsByClassName("trade-details-name")[0].innerHTML;
        let tradePrice = tradeEventDiv.dataset.minprice;




        let ajaxUrl = 'http://localhost:8081/assignmentWeb4/wallet?' + 'username=' + getCookie("username") + '&eventId=' + eventId + '&numTickets=' + quantity + '&price=' + tradePrice;
        console.log(ajaxUrl);
        $.ajax({
            type: "POST",
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

                processResponse = response.split(",");
                if (processResponse[0] === "success") {
                    let returnedBalance = Number(processResponse[1]);
                    if (returnedBalance >= 0) {
                        popUpMessage("Bought" + " " + Math.abs(quantity) + " " + eventName + " ticket(s)");
                    }
                    else {
                        console.log("doTradeEvent error");
                    }

                }




                // var array = JSON.parse(response);
                // console.log(array)
                // console.log(response["date"]);
                // return tradeData;

            },
            error: function (err) {
                console.log(err);

                popUpMessage("FAILED: transaction not possible, not enough cash to purchase");


            }

        })

    }
});

// $(window).resize(function () {
//     diff_screen_resolution();
// });