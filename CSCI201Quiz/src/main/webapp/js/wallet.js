
$(document).ready(function () {

    //loads the navbar from nav.html
    updateNavByLoginStatus();
    const logoutButton = document.getElementById("logoutNav-li");
    console.log(logoutButton);
    logoutButton.addEventListener('click', function () {
        logOut();
    });

    // var walletEventsColumn = "";
    //listening to searchbutton
    // customAlert("hello");

    loadAllWalletData();
    // document.addEventListener("click", function (e) {
    //     if (e.target.classList.contains('submit-button')) {

    //         const submitButtons = e.target.getElementsByClassName("submit-button");
    //         for (const submitButton of submitButtons) {
    //             console.log(submitButton);
    //         }
    //         e.target.addEventListener('click', function () {

    //             console.log(this.parentElement.parentElement.parentElement);

    //             doWalletTrade(this.parentElement.parentElement.parentElement);
    //             event.stopPropagation();
    //         });
    //         // console.log(e.target.innerHTML);

    //     }

    //      // Or any other selector.

    //     // if (submitButtons) {
    //     //     // Do something with `target`.
    //     //     for (const submitButton of submitButtons) {
    //     //         console.log("ready");
    //     //         console.log(submitButton.parentElement.parentElement.parentElement);
    //     //         submitButton.addEventListener('click', function () {
    //     //             // console.log(this.parentElement.parentElement.parentElement);

    //     //             doWalletTrade(this.parentElement.parentElement.parentElement);

    //     //         });
    //     //     }


    //     // }
    // });
    
    // while(document.readyState !== "loading"){


    // }


    const popUpOKButton = document.getElementsByClassName("popup-ok-button")[0];
    popUpOKButton.addEventListener('click', function () {
        document.getElementById("myPopup").classList.toggle("show");
    });
    // const walletPopUpOKButton = document.getElementsByClassName("wallet-popup-ok-button")[0];
    // walletPopUpOKButton.addEventListener('click', function () {
    //     window.location.href = "wallet.html";
    // });





    var saveTableData = [];
    var allWalletEvents = []
    var cashBalance = 0;
    var totalAccountValue = 0;

    updateUserBalance();

    function popUpMessage(message) {

        
        let walletPopupDiv = document.getElementById("myPopup")
        walletPopupDiv.classList.toggle("show");
        
        // document.getElementsByClassName("popup-ok-button")[0].dataset.type = "normal";
        
        document.getElementsByClassName("popup-text")[0].innerHTML = message;
        // popup.innerHTML = message;
        // popupwindow("http://localhost:8081/assignmentWeb4/wallet.html");
    }
    function walletPopUpMessage(message) {
        
        
        document.getElementsByClassName("popup-ok-button")[0].setAttribute( "onClick", "window.location.href='wallet.html';" );
        popUpMessage(message)
        // onclick = ;
        
        
        // popup.innerHTML = message;
        // popupwindow("http://localhost:8081/assignmentWeb4/wallet.html");
    }


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
    function deleteFromArray(value, array) {
        var index = array.indexOf(value);
        if (index > -1) {
            array.splice(index, 1);
        }
        return array;
    }
    function roundFloatingNumber(number, decimalPlaces){
        return Number(number).toFixed(decimalPlaces); 
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
    
    function updateUserBalance(){
        let ajaxUrl = 'http://localhost:8081/assignmentWeb4/userBalance?' + 'username=' + getCookie("username");
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

                if(Number(response) < 0){
                    alert("Unable to get user balance.");
                    return;
                }
                else{
                    cashBalance += Number(response);
                    totalAccountValue += Number(response);
                    document.getElementsByClassName("cash-balance-span")[0].innerHTML = "Cash Balance: $" + Number(cashBalance).toFixed(2) ;
                }

            },
            error: function (err) {

                window.alert("Unable to get user balance.");
            }

        })
    }
    function insertWalletData(eventId, quantity) {

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

                var walletData = response;


                // var allWalletEventsWrapper = "<div class='all-wallet-events-wrapper column'>";
                // var allWalletEventsWrapper = "";

                var nameDiv = '<div class="wallet-event name-div row">' + '<div class="wallet-event-name">' + walletData["event"]["name"] + '</div></div>';



                let priceChange = walletData["price"]["max"] - walletData["price"]["min"];
                let avgCost = walletData["price"]["min"];
                let totalCost = quantity * walletData["price"]["min"];
                let marketValue = quantity * walletData["price"]["max"];
                let pricesAvailable = true;
                if (walletData["price"]["max"] < 0 || walletData["price"]["min"] < 0) {
                    console.log(walletData["price"]["max"]);
                    pricesAvailable = false;
                    priceChange = 'N/A';
                    walletData["price"]["max"] = 'N/A';
                    walletData["price"]["min"] = 'N/A';
                    avgCost = 'N/A';
                    totalCost = 'N/A';
                    marketValue = 'N/A';
                }
                else{
                    totalAccountValue += quantity*Number(walletData["price"]["min"]);
                    console.log(totalAccountValue);
                    walletData["price"]["max"] = Number(walletData["price"]["max"]).toFixed(2);
                    walletData["price"]["min"] = Number(walletData["price"]["min"]).toFixed(2);
                    totalCost = Number(totalCost).toFixed(2);
                    marketValue = Number(marketValue).toFixed(2);
                    avgCost = Number(avgCost).toFixed(2);
                    if(priceChange > 0 ){
                        priceChange = "&#8593;  " + Number(priceChange).toFixed(2);
                    }
                    else{
                        priceChange = "&#8595;  " + Number(priceChange).toFixed(2);
                    }
                }
                let walletEventRowOne = '<tr><td class="quantity header">Quantity</td><td class="quantity value">' + quantity + '</td><td class="price-change header">Change:</td><td class="price-change value">' + priceChange + '</td></tr>';

                let walletEventRowTwo = '<tr><td class="avg-cost header">Avg. Cost</td><td class="avg-cost value">' + avgCost + '</td><td class="current-price header">Current Price:</td><td class="current-price value">' + walletData["price"]["max"] + '</td></tr>';

                let walletEventRowThree = '<tr><td class="total-cost header">Total Cost:</td><td class="total-cost value">' + totalCost + ' </td><td class="market-value header">Market Value:</td><td class="market-value value">' + marketValue + '</td></tr>';


                let tableDiv = '<div class="wallet-event table-div row"><table class="wallet-event-table">' + walletEventRowOne + walletEventRowTwo + walletEventRowThree + '</table></div>';

                let quantityDiv = '<div class="wallet-event quantity-div row"><label for="purchase-quantity" class="purchase-quantity header">Quantity:</label><input class="purchase-quantity input" type="number"></div>'

                let radioDiv = '<div class="wallet-event radio-div row"><div class="buy-radio-div column"><input type="radio" name="trade-type" class="buy event-radio" value="buy"><label for="buy" class="buy-radio header">Buy</label></div><div class="sell-radio-div column"><input type="radio" name="trade-type" class="sell event-radio" value="sell"><label for="sell" class="sell-radio header">Sell</label></div></div>';

                // let buttonDiv = '<div class="wallet-event button-div row"><button class="submit-button">Submit</button></div>';


                var submitButton = document.createElement("button");
                $(submitButton).addClass("submit-button");
                submitButton.innerHTML = "Submit";
                submitButton.dataset.eventid = eventId;
                let buttonDiv = '<div class="wallet-event button-div row">' + submitButton.outerHTML + '</div>';


                // let walletEventsColumn = document.createElement("div");
                // walletEventsColumn.dataset.eventId = eventId;
                // walletEventsColumn.dataset.minPrice = walletData["price"]["min"];

                walletEventsColumn = '<div class="wallet-events wrapper" data-eventid="' + eventId + '" data-minprice="' + walletData["price"]["min"] + '">' + '<div class="wallet-events column">' + nameDiv + tableDiv + quantityDiv;

                if (pricesAvailable) {
                    walletEventsColumn += radioDiv + buttonDiv;
                }
                walletEventsColumn += ('</div>' + '</div>');

                // var array = JSON.parse(response);
                // console.log(array)
                // console.log(response["date"]);
                // return tradeData;


                // console.log(allWalletEventsWrapper);
                let allWalletEventsWrapper = document.getElementsByClassName("all-wallet-events-wrapper column")[0];
                allWalletEventsWrapper.insertAdjacentHTML('beforeend', walletEventsColumn);

                document.getElementsByClassName("account-value-span")[0].innerHTML = "Total Account Value: $" + Number(totalAccountValue).toFixed(2);
                // allWalletEventsWrapper.addEventListener("click", function (e) {
                //     if (e.target.classList.contains('submit-button')) {

                //         // console.log(e.target);

                //         const submitButtons = allWalletEventsWrapper.getElementsByClassName("submit-button");
                //         for (const submitButton of submitButtons) {
                //             console.log(submitButton);
                //         }
                //         e.target.addEventListener('click', function (event) {

                //             console.log(this.parentElement.parentElement.parentElement);

                //             doWalletTrade(this.parentElement.parentElement.parentElement);
                //             event.stopPropagation();
                //         });
                //         // console.log(e.target.innerHTML);

                //     }
                // });
            },
            error: function (err) {

                window.alert("Unable to get details of event saved in wallet.");
            }

        })
    }
    function loadAllWalletData() {
        // document.getElementsByClassName("trade-events-div")[0].style.display = "flex";
        // let eventFavorited = false;
        // let sendData = {
        //     "username": getCookie("username")
        //  };


        let ajaxUrl = 'http://localhost:8081/assignmentWeb4/wallet?' + 'username=' + getCookie("username");
        console.log(ajaxUrl);
        $.ajax({
            url: ajaxUrl,
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

                allWalletEvents = JSON.parse(response);

                console.log(allWalletEvents);
                if (allWalletEvents.length <= 0) {
                    alert("You have no events in your wallet");
                }


                for (const walletEvent of allWalletEvents) {
                    insertWalletData(walletEvent["eventId"], walletEvent["quantity"]);

                }
                
                let allWalletEventsWrapper = document.getElementsByClassName("all-wallet-events-wrapper column")[0];
                allWalletEventsWrapper.addEventListener("click", function (e) {
                    // const submitButtons = allWalletEventsWrapper.getElementsByClassName("submit-button");
                    // for (const submitButton of submitButtons) {
                    //     console.log(submitButton);
                    //     submitButton.addEventListener('click', function (event) {
                    //         // event.stopPropagation();
                    //         console.log(this.parentElement.parentElement.parentElement);

                    //         doWalletTrade(this.parentElement.parentElement.parentElement);
                            
                    //     });
                    // }
                    if (e.target.classList.contains('submit-button')) {

                        // console.log(e.target);
                        // console.log();
                        console.log(e.target.parentElement.parentElement.parentElement);

                        doWalletTrade(e.target.parentElement.parentElement.parentElement);
                            // event.stopPropagation();
                        // e.target.addEventListener('click', function (event) {

                        //     console.log(this.parentElement.parentElement.parentElement);

                        //     doWalletTrade(this.parentElement.parentElement.parentElement);
                        //     event.stopPropagation();
                        // });
                        // console.log(e.target.innerHTML);

                    }
                    if (e.target.classList.contains('event-radio')) {
                        $(e.target).addClass("checked");
                    }

                });
                

                // let insertWalletEventsPromise = new Promise(function (myResolve, myReject) {
                //     for (const walletEvent of allWalletEvents) {
                //         insertWalletData(walletEvent["eventId"], walletEvent["quantity"]);
                //     }



                //     myResolve("OK");
                // });


                // insertWalletEventsPromise.then(function () {


                //     allWalletEventsWrapper += '</div>';
                //     console.log(allWalletEventsWrapper);
                //     document.getElementsByTagName("body")[0].insertAdjacentHTML('beforeend', allWalletEventsWrapper);
                // });


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
                // window.alert(err.responseJSON);
                alert("You have no favorites");
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

        // appendChild(tradeInfoLink);


    }
    function doWalletTrade(tradeEventWrapperElement) {
        console.log(tradeEventWrapperElement);

        let quantity = Number(tradeEventWrapperElement.getElementsByClassName("purchase-quantity input")[0].value);
        let quantityOwned = Number(tradeEventWrapperElement.getElementsByClassName("quantity value")[0].innerHTML);
        
        if (quantity <= 0) {
            console.log(quantity + " -> error");
            popUpMessage("FAILED: transaction not possible");
            return;
        }
        

        console.log(quantity);
        let eventId = tradeEventWrapperElement.dataset.eventid;
        let eventName = tradeEventWrapperElement.getElementsByClassName("wallet-event-name")[0].innerHTML;
        let minPrice = tradeEventWrapperElement.dataset.minprice;
        var tradePrice = minPrice;
        let radioElements = tradeEventWrapperElement.getElementsByClassName("event-radio");
        let radioChecked = false;
        let buyType = true;
        for (const radioElement of radioElements) {
            if ($(radioElement).hasClass("checked")) {
                // alert('One of the radio buttons is checked!');
                radioChecked = true;
                if (radioElement.value == "sell") {
                    buyType = false;
                    quantity *= -1;
                    maxPrice = Number(tradeEventWrapperElement.getElementsByClassName("current-price value")[0].innerHTML);
                    tradePrice = maxPrice;
                }

                console.log(quantity + "*" + tradePrice);
                break;

            }
        }
        if (!radioChecked) {
            popUpMessage("FAILED: transaction not possible");
            return;
        }

        let quantityRemaining = quantityOwned + quantity;
        if(quantityRemaining < 0){
            console.log(quantityRemaining);
            popUpMessage("FAILED: transaction not possible, not enough tickets to sell");
            return;
        }
        
        
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
                if(processResponse[0] === "success"){
                    let returnedBalance = Number(processResponse[1]);
                    let calculatedCashBalance = cashBalance;
                    let calculatedTotalAccountValue = totalAccountValue;

                    
                    
                    if(buyType){
                        calculatedCashBalance -= Math.abs(quantity)*tradePrice;//buy --> at min price, but account value += max price
                        // buy --> account value is constant, change  money into tickets
                    }
                    else{
                        calculatedCashBalance += Math.abs(quantity)*tradePrice;//sell --> cash increase always
                        calculatedTotalAccountValue +=  Math.abs(quantity) * (maxPrice - minPrice);// account value incrasae by diff. between purchase & sell price
                    }

                    if(returnedBalance == calculatedCashBalance){
                        let tradeType = (buyType) ? "Bought" : "Sold";
                        cashBalance = calculatedCashBalance;
                        totalAccountValue = calculatedTotalAccountValue;
                        walletPopUpMessage(tradeType + " " + Math.abs(quantity) + " " + eventName + " ticket(s)");
                        
                    }
                    else{
                        console.log("FAILED: transaction calculating error. Adjusting balances to match back-end.");
                        
                        totalAccountValue +=  returnedBalance - cashBalance ;
                        cashBalance = returnedBalance;
                    }

                    
                    tradeEventWrapperElement.getElementsByClassName("quantity value")[0].innerHTML = quantityRemaining;
                    tradeEventWrapperElement.getElementsByClassName("market-value value")[0].innerHTML = quantityRemaining * minPrice;

                    document.getElementsByClassName("cash-balance-span")[0].innerHTML = "Cash Balance: $" + Number(cashBalance).toFixed(2);
                    document.getElementsByClassName("account-value-span")[0].innerHTML = "Total Account Value: $" + Number(totalAccountValue).toFixed(2) ;
                    
                    
                    console.log("cashBalance: " + cashBalance);
                    console.log("accountValue: " + cashBalance);
                    
                    
                }
                if(quantityRemaining == 0){
                    tradeEventWrapperElement.style.display = "none";
                }
                
                

                // var array = JSON.parse(response);
                // console.log(array)
                // console.log(response["date"]);
                // return tradeData;

            },
            error: function (err) {
                console.log(err);
                if(buyType){
                    popUpMessage("FAILED: transaction not possible, not enough cash to purchase");
                }

                else{
                    popUpMessage("FAILED: transaction not possible, not enough tickets to sell");
                }
                
            }

        })

    }
    function tradeEventData(tradeData, eventId) {
        document.getElementsByClassName("trade-events-div")[0].style.display = "flex";
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
                var favoriteEvent_star = $(document.getElementsByClassName("fa")[0]);

                if (eventFavorited) {
                    $(favoriteEvent_star).removeClass("fa-star-o");
                    $(favoriteEvent_star).addClass("fa-star");
                }
                else {
                    $(favoriteEvent_star).removeClass("fa-star");
                    $(favoriteEvent_star).addClass("fa-star-o");
                }
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




        let tradeInfoLink = document.createElement('a');
        tradeInfoLink.setAttribute('href', tradeData["event"]["url"]);
        tradeInfoLink.innerHTML = tradeData["event"]["url"]
        document.getElementsByClassName("trade-details-more-info")[0].innerHTML = tradeData["event"]["url"];
        document.getElementsByClassName("trade-details-more-info")[0].href = tradeData["event"]["url"];

        // appendChild(tradeInfoLink);


    }
});

// $(window).resize(function () {
//     diff_screen_resolution();
// });