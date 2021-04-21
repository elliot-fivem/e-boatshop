$(document).ready(function(){
    $("#container").hide();

    window.addEventListener("message", function(event) {
        const eventData = event.data;

        if (eventData.Action == "OPEN_NUI"){
            $("#container").show()
        }

        else if (eventData.Action == "CLOSE_NUI"){
            $("#container").hide()
        }
    });
    $("#yesButton").click(function(){
        $.post('http://boatshop/callbackName', JSON.stringify({
            response: true
        }));
    });

    $("#noButton").click(function(){
        $.post('http://boatshop/callbackName', JSON.stringify({
            response: false
        }));
    });

});
