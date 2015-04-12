// PageMethods.js

var displayElement;

//Sets the session state value.
function ProcessRedeemed(UID, couponid) {
    PageMethods.ProcessRedeemed(UID,couponid,
        OnSucceeded, OnFailed);
}


function SetName(name) {
    PageMethods.SetName(name,
        OnSucceeded, OnFailed);
}

function Authenticated(YN) {
    PageMethods.Authenticated(YN,
        OnSucceeded, OnFailed);
}




// Callback function invoked on successful 
// completion of the page method.
function OnSucceeded(result, userContext, methodName) {
    if (methodName == "GetSessionValue") {
        displayElement.innerHTML = "Current session state value: " +
            result;
    }
}

// Callback function invoked on failure 
// of the page method.
function OnFailed(error, userContext, methodName) {
   // alert('error: ' + error.get_message());
}

if (typeof (Sys) !== "undefined") Sys.Application.notifyScriptLoaded();

