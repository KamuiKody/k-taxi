$('#box').css("display", "none");

function speedLimiter(limit) {
  $.post("https://k-taxi/setlimiter", JSON.stringify({id: limit-1})); 
}

$(function() {

    
  window.addEventListener("message", function(event) {
      var item = event.data;
      
      if (event.data.action === "hide") {
        $('#box').css("display", "none");        
      } else if (event.data.action === "show") {
        $('#box').css("display", "flex");
        var str1 = event.data.fare;
        var str2 = event.data.distance;
        var str3 = event.data.limiter;
        var str4 = event.data.permile;
        var fare = '$ ' + str1.toString().padStart(3, '0') + ".00"; 
        var distance = str2.toString().padStart(3, '0.00') + 'mi';
        var limiter = str3.toString().padStart(3, '0') + " mph"; 
        var permile = '$ ' + str4.toString().padStart(3, '0') + " /mi"; 
        document.getElementById("fare").innerHTML = fare;
        document.getElementById("distance").innerHTML = distance;
        document.getElementById("speedlimit").innerHTML = limiter;
        document.getElementById("permile").innerHTML = permile;
      };
  });
});