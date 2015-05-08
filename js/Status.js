
$('#MyHeader').hide();

var globalArray = [];

var CommentArray = new Array();
var LikeArray = [];
var FriendsCount;
var TotalComments;
var TotalLikes;
var TheUser;
var SelectedUser = 'me';
var AlreadyPopulatedAccounts = '';

var pager;
var DoICancel;

var FBWindow;


document.addEventListener("backbutton", BackButtonPressed, false);
document.getElementById('myFooter').style.display = 'none';
document.getElementById("SearchStuff").style.display = 'none';
$('#info').hide();
$('#SettingsDisplay').hide();
$('#PagesBlock').hide();
$('#cmtLike').hide();



function ProccessSearch() {

    var searchterm = $("#search-basic").val();
    //alert(searchterm);

    arr = jQuery.grep(globalArray, function (a) {

        if (a.message != undefined) {
            return a.message.toLowerCase().indexOf(searchterm.toLowerCase()) > -1;
        }
    });

    // alert('search: ' + arr.length);

    if (arr != undefined) {
        //CreateList(arr);

        pager = new Pager(10, arr);
        pager.init(arr);
        pager.showPageNav('pager', 'pageNavPosition', arr);
        pager.showPage(1, arr);


        SetUpStatus();
        MakeStatusTabActive();
    }

}

function ResetSearch() {
    pager = new Pager(10, globalArray);
    pager.init(globalArray);
    pager.showPageNav('pager', 'pageNavPosition', globalArray);
    pager.showPage(1, globalArray);


    SetUpStatus();
    MakeStatusTabActive();
}

$("#SearchBlock").keyup(function (event) {

    //console.log('keycode: ' + event.keyCode);
    if (event.keyCode == 13) {

        ProccessSearch();

        //$("#id_of_button").click();
    }
});

function Pager(itemsPerPage, theArray) {

    this.itemsPerPage = itemsPerPage;
    this.currentPage = 1;
    this.pages = 0;
    this.inited = false;

    this.showRecords = function (from, to) {

        //console.log('From: ' + from + ' To: ' + to);

        var pagedArray = [];

        // i starts from 1 to skip table header row
        for (var i = 0; i < theArray.length; i++) {
            if (i < from || i > to) {
                //Do nothing
            }
            else {
                var pageOBJ = new Object();
                pageOBJ = theArray[i];
                pagedArray.push(pageOBJ);
            }
        }


        //Bind Grid
        CreateList(pagedArray);

    }

    this.showPage = function (pageNumber, theArray) {
        if (!this.inited) {
            //alert("not inited");
            return;
        }

        //var oldPageAnchor = document.getElementById('pg' + this.currentPage);
        //oldPageAnchor.className = 'pg-normal';

        this.currentPage = pageNumber;
        //var newPageAnchor = document.getElementById('pg' + this.currentPage);
        //newPageAnchor.className = 'pg-selected';

        //console.log('show page array length: ' + theArray.length);
        //console.log('pagenumber: ' + pageNumber);
        //console.log('itemsPerPage: ' + itemsPerPage);

        var from = (pageNumber - 1) * itemsPerPage + 1;
        var to = from + itemsPerPage - 1;

        //console.log('from: ' + from);
        //console.log('to: ' + to);

        var oldPageAnchor = document.getElementById('pgPager');

        if (theArray.length < to) {
            to = theArray.length;
        }

        oldPageAnchor.innerHTML = from + ' to ' + to + ' of ' + theArray.length + ' ';

        //This is a hack to handle the fact that we are storing it on a 0 based array
        if (from == 1) {
            from = 0;
        }

        this.showRecords(from, to);
    }

    this.prev = function () {
        if (this.currentPage > 1)
            this.showPage(this.currentPage - 1, theArray);
    }

    this.next = function () {

        if (this.currentPage < this.pages) {
            this.showPage(this.currentPage + 1, theArray);
        }
    }

    this.init = function (theArray) {
        //console.log("in init");
        var records = (theArray.length - 1);
        this.pages = Math.ceil(records / itemsPerPage);
        this.inited = true;
    }

    this.showPageNav = function (pagerName, positionId, theArray) {
        if (!this.inited) {
            // alert("not inited");
            return;
        }

        var element = document.getElementById(positionId);
        var pagerHtml = '<button class="ui-btn ui-mini ui-btn-inline " onclick="' + pagerName + '.prev();"><<</button>';
        //ui-icon-carat-l ui-btn-icon-left
        //for (var page = 1; page <= this.pages; page++)

        pagerHtml += '<span id="pgPager"></span>';
        pagerHtml += '<button class="ui-btn ui-mini ui-btn-inline " onclick="' + pagerName + '.next();">>></button>';
        //ui-icon-carat-r ui-btn-icon-right

        //pagerHtml += '<span id="pg' + page + '" onclick="' + pagerName + '.showPage(' + page + ');">' + page + '</span> | ';


        element.innerHTML = pagerHtml;
    }
}

function DisplayLoader() {

    var $this = $(this),
        theme = $this.jqmData("theme") || $.mobile.loader.prototype.options.theme,
        msgText = $this.jqmData("msgtext") || $.mobile.loader.prototype.options.text,
        textVisible = $this.jqmData("textvisible") || $.mobile.loader.prototype.options.textVisible,
        textonly = !!$this.jqmData("textonly");
    html = $this.jqmData("html") || "";
    $.mobile.loading("show", {
        text: 'hey',
        textVisible: true,
        theme: 'b',
        textonly: textonly,
        html: '<div align="center"><img src="http://www.statushistory.com/img/smallloader.gif"><br/><h1 style="text-shadow:none;color:white"><span id="myCount">0</span> statuses retrieved</h1><br\><button class="btn btn-block" onclick="CancelMe();"><span style="text-shadow:none;color:white">Cancel</span></button></div>'
    });
}

function HideLoader() {
    $.mobile.loading("hide");
}

function DisplayPages() {

    PopulateAccounts();
    $('#PagesLoginBlock').hide();
    $('#PagesBlock').show();
    $('#MyHeader').show();


}



function BackButtonPressed() {


    //console.log('In back button');
    //Never initiated -- close it
    if (FBWindow == null) {
        //console.log('Never initiated -- close it');
        application.back();
    }

    //If closed -- kill the app
    if (FBWindow.closed) {
        //console.log('If closed -- kill the app');
        application.back();
    }

    //If it is open -- close the window
    if (!FBWindow.closed) {
        //console.log('If it is open -- close the window');
        FBWindow.close();
        FBWindow = null;  //Just to be sure .. whack it
    }
}

function CreateStatusArray(status) {

    var StatusArray = [];

    for (i = 0; i < status.data.length; i++) {

        // if (status.data[i].status_type != undefined)
        //{


        var StatusOBJ = new Object();

        if (status.data[i].id != undefined) {
            StatusOBJ.id = status.data[i].id;
        }

        if (status.data[i].story != undefined) {
            StatusOBJ.story = status.data[i].story;
        }

        if (status.data[i].message != undefined) {
            StatusOBJ.message = status.data[i].message;
        }
        else {
            if (status.data[i].story != undefined) {
                StatusOBJ.message = status.data[i].story;
            }
        }

        if (status.data[i].picture != undefined) {
            StatusOBJ.picture = status.data[i].picture;
        }
        else {
            StatusOBJ.picture = '';
        }

        if (status.data[i].link != undefined) {

            if (status.data[i].link.indexOf("facebook") > -1) {
                StatusOBJ.link = status.data[i].link.replace("www", "m");
            }
            else {
                StatusOBJ.link = status.data[i].link;
            }


        }

        if (status.data[i].source != undefined) {
            StatusOBJ.source = status.data[i].source;
        }

        if (status.data[i].from.name != undefined) {
            StatusOBJ.name = status.data[i].from.name;
        }

        if (status.data[i].with_tags != undefined) {
            StatusOBJ.with_tags = status.data[i].with_tags;
        }

        if (status.data[i].status_type != undefined) {
            StatusOBJ.status_type = status.data[i].status_type;
        }

        if (status.data[i].description != undefined) {
            StatusOBJ.description = status.data[i].description;
        }
        else {

            StatusOBJ.description = '';

        }

        if (status.data[i].application != undefined) {
            StatusOBJ.application = status.data[i].application;
        }

        if (status.data[i].updated_time != undefined) {
            var shortDate = status.data[i].updated_time.substring(0, 10);
            var createDate = new Date(shortDate);
            StatusOBJ.updated_time = createDate.toDateString();

            //StatusOBJ.updated_time = status.data[i].updated_time;
        }

        if (status.data[i].created_time != undefined) {
            StatusOBJ.created_time = status.data[i].created_time;
        }

        if (status.data[i].likes != undefined) {
            StatusOBJ.likes = status.data[i].likes.data.length;

            //This gets the Comments and provides counts for multiple comments
            for (c = 0; c < status.data[i].likes.data.length; c++) {

                var InnerLikeOBJ = new Object();

                //console.log('prop: ' + Object.keys(status.data[i].likes.data[c]));

                InnerLikeOBJ.id = status.data[i].likes.data[c].id;
                InnerLikeOBJ.name = status.data[i].likes.data[c].name;
                InnerLikeOBJ.count = 1;

                //console.log('first name: ' + InnerLikeOBJ.name);

                if (LikeArray[InnerLikeOBJ.name]) {
                    //Exists -- lets increment the count
                    var myLike = LikeArray[InnerLikeOBJ.name];
                    myLike.count = myLike.count + 1;
                    LikeArray[InnerLikeOBJ.name] = myLike;
                }
                else {
                    LikeArray[InnerLikeOBJ.name] = InnerLikeOBJ;
                }

                //CommentArray.push({ key: InnerCommentOBJ.id, value: InnerCommentOBJ });

            }

            //console.log('LikeArray Length: ' + Object.keys(LikeArray).length);

        }
        else {
            StatusOBJ.likes = 0;
        }

        if (status.data[i].comments != undefined) {

            StatusOBJ.comments = status.data[i].comments.data.length;

            //console.log('Comment Length: ' + status.data[i].comments.data.length);


            //This gets the Comments and provides counts for multiple comments
            for (c = 0; c < status.data[i].comments.data.length; c++) {

                var InnerCommentOBJ = new Object();

                //alert(status.data[i].comments.data[c].from);
                if (status.data[i].comments.data[c].from != undefined) {


                    InnerCommentOBJ.id = status.data[i].comments.data[c].from.id;
                    InnerCommentOBJ.name = status.data[i].comments.data[c].from.name;
                    InnerCommentOBJ.count = 1;

                    //console.log('first name: ' + InnerCommentOBJ.name);

                    if (CommentArray[InnerCommentOBJ.name]) {
                        //Exists -- lets increment the count
                        var myComment = CommentArray[InnerCommentOBJ.name];
                        myComment.count = myComment.count + 1;
                        CommentArray[InnerCommentOBJ.name] = myComment;
                    }
                    else {
                        CommentArray[InnerCommentOBJ.name] = InnerCommentOBJ;
                    }

                }

                //CommentArray.push({ key: InnerCommentOBJ.id, value: InnerCommentOBJ });

            }

            //console.log('InnerCommentArray Length: ' + Object.keys(CommentArray).length);
        }
        else {
            StatusOBJ.comments = 0;
        }

        StatusArray.push(StatusOBJ);

        //}
    }

    return StatusArray;

}

//posts -- try Posts
//links
//statuses

function OpenFBWindow(url) {

    //var loginWindow = window.open('http://www.google.com');

    FBWindow = window.open(url, '_blank', 'location=no');

    FBWindow.addEventListener('loadstart', function (event) {
        //console.log('in loadstart')
        var url = event.url;
        console.log('URL ' + event.url);
    });

    FBWindow.addEventListener('exit', function () {
        console.log('in exit')
        MakeStatusTabActive();
        // Handle the situation where the user closes the login window manually before completing the login process
    });

}

function shorten(text, maxLength) {
    var ret = text;
    if (ret.length > maxLength) {
        ret = ret.substr(0, maxLength - 3) + " ...";
    }
    return ret;
}

function CreateList(theArray) {

    var list = document.getElementById('MyListView');

    //alert('loop size: ' + theArray.length);

    var html = '';
    for (i = 0; i < theArray.length; i++) {
        //console.log('loop: ' + i);
        html += '<li data-role="list-divider" role="heading" class="ui-li-divider ui-bar-inherit ui-li-has-count ui-first-child">' + theArray[i].updated_time + '<span class="ui-li-count ui-body-inherit">' + theArray[i].comments + '</span></li>';
        html += '<li><a style="padding:2px;vertical-align: middle;"  onclick="OpenFBWindow(&#39' + theArray[i].link + '&#39)" class="ui-btn "> '; //ui-btn-icon-right ui-icon-carat-r 

        if (theArray[i].picture.length > 0) {
            html += '<table><tr><td><img height="65" width="65" align="top" src=' + theArray[i].picture + '><td></td><td> <span style="align:middle;font-weight:normal;white-space: normal !important">' + shorten(theArray[i].message, 80) + '</span></td></tr></table><br/>';  //white-space: normal !important
        }
        else {
            html += ' <span style="align:middle;font-weight:normal;white-space: normal !important">' + shorten(theArray[i].message, 80) + '</span><br/>';
        }
        html += '<p class="ui-li-aside"><strong></strong></p></a></li>';
    };
    list.innerHTML = html;
}



function dynamicSort(property) {
    var sortOrder = 1;
    if (property[0] === "-") {
        sortOrder = -1;
        property = property.substr(1);
    }
    return function (a, b) {
        var result = (a[property] > b[property]) ? -1 : (a[property] < b[property]) ? 1 : 0;
        return result * sortOrder;
    }
}



function SortLikes() {

    //Sort Comments

    TotalLikes = 0;

    var sortedLikes = [];
    for (var key in LikeArray) {
        var MyLike = LikeArray[key];
        TotalLikes = TotalLikes + MyLike.count;
        sortedLikes.push(MyLike);
    }

    sortedLikes.sort(dynamicSort("count"));
    //We are done at this point

    //This just prints them out
    var list = document.getElementById('TopLikers');
    var html = '';

    for (c = 0; c < sortedLikes.length; c++) {

        //console.log('loop: ' + i);
        html += '<li><table><tr><td><img height="65" width="65" style="vertical-align:middle;" src="http://graph.facebook.com/' + sortedLikes[c].id + '/picture?type=normal" alt="France"></td><td>' + sortedLikes[c].name + ' liked <span style="font-weight: bold;">' + sortedLikes[c].count + '</span> times</td></tr></table></li>';
        if (c > 10) {
            break;  //bail after 10
        }
        //console.log('name: ' + sortedLikes[c].name + ' count: ' + sortedLikes[c].count);
    }

    list.innerHTML = html;


}

function SortComments() {

    //Sort Comments
    var sortedComments = [];

    TotalComments = 0;

    for (var key in CommentArray) {
        var MyComment = CommentArray[key];

        TotalComments = TotalComments + MyComment.count;
        sortedComments.push(MyComment);
    }

    sortedComments.sort(dynamicSort("count"));
    //We are done at this point

    //This just prints them out
    var list = document.getElementById('TopCommentors');
    var html = '';

    for (c = 0; c < sortedComments.length; c++) {

        //console.log('loop: ' + i);
        html += '<li><table><tr><td><img height="65" width="65" style="vertical-align:middle;" src="http://graph.facebook.com/' + sortedComments[c].id + '/picture?type=normal" alt="France"></td><td>' + sortedComments[c].name + ' commented <span style="font-weight: bold;">' + sortedComments[c].count + '</span> times</td></tr></table></li>';
        if (c > 10) {
            break;  //bail after 10
        }
        //console.log('name: ' + sortedComments[c].name + ' count: ' + sortedComments[c].count);
    }

    list.innerHTML = html;

}

function DoneWithLoading() {

    //Hide
    HideLoader();
    document.getElementById("LoginBlock").style.display = 'none';

    $("#SearchStuff").hide();

    //Show Menu
    document.getElementById('myFooter').style.display = '';


    //MakeStatusTabActive();
    SelectInfoButton();

}




function MakeInfoTabActive() {

    //Reset tabs
    $('#BtnSearch').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnSearch').removeClass('ui-btn-active');

    $('#BtnSettings').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnSettings').removeClass('ui-btn-active');

    $('#BtnStatus').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnStatus').removeClass('ui-btn-active');

    $('#BtnInfo').addClass('ui-btn-active');

}

function MakeStatusTabActive() {

    //Reset tabs
    $('#BtnSearch').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnSearch').removeClass('ui-btn-active');

    $('#BtnSettings').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnSettings').removeClass('ui-btn-active');

    $('#BtnInfo').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnInfo').removeClass('ui-btn-active');

    $('#BtnStatus').addClass('ui-btn-active');

}

function MakeSettingsTabActive() {

    //Reset tabs
    $('#BtnSearch').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnSearch').removeClass('ui-btn-active');

    $('#BtnStatus').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnStatus').removeClass('ui-btn-active');

    $('#BtnInfo').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnInfo').removeClass('ui-btn-active');

    $('#BtnSettings').addClass('ui-btn-active');

}

function MakeSearchTabActive() {

    //Reset tabs
    $('#BtnSettings').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnSettings').removeClass('ui-btn-active');

    $('#BtnStatus').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnStatus').removeClass('ui-btn-active');

    $('#BtnInfo').removeClass('ui-btn-hover-b').addClass('ui-btn-up-b');
    $('#BtnInfo').removeClass('ui-btn-active');

    $('#BtnSearch').addClass('ui-btn-active');

}


function SelectSettingButton() {

    $('#SearchStuff').hide();
    $('#pageNavPosition').hide();
    $('#MyListView').hide();
    $('#cmtLike').hide();
    $('#LoginBlock').hide();
    $('#info').hide();


    $('#SettingsDisplay').show();
    $('#myFooter').show();


    document.getElementById("userName").innerHTML = TheUser;

    MakeSettingsTabActive();



}


function SelectInfoButton() {

    SetUpInfo();
    MakeInfoTabActive();

}

function SelectRandomPost() {

    if (globalArray.length != undefined) {

        var randomnumber = Math.floor(Math.random() * globalArray.length)

        //        MakeSettingsTabActive();
        OpenFBWindow(globalArray[randomnumber].link);

    }

}

function SetUpSearch() {

    $('#MyListView').hide();
    $('#cmtLike').hide();
    $('#pageNavPosition').hide();
    $('#info').hide();
    $('#SettingsDisplay').hide();

    $('#SearchStuff').show();



}

function SetUpStatus() {

    $('#MyListView').show();
    $('#cmtLike').show();
    $('#pageNavPosition').show();
    $('#SearchStuff').hide();
    $('#SettingsDisplay').hide();

    $('#info').hide();


}

function SetUpInfo() {

    $('#SearchStuff').hide();
    $('#MyListView').hide();
    $('#cmtLike').hide();
    $('#pageNavPosition').hide();
    $('#SearchStuff').hide();
    $('#SettingsDisplay').hide();

    $('#info').show();

}

function CancelMe() {

    DoICancel = true;

}

function PopulateAccounts() {
    openFB.api({
        path: '/me/accounts',
        success: function (theresponse) {
            console.log('MyResponse: ' + theresponse.data.length);
            console.log('Accounts: ' + JSON.stringify(theresponse))


            var list = document.getElementById('PagesSelectItem');

            //alert('loop size: ' + theArray.length);


            if (AlreadyPopulatedAccounts == '') {

                var html = '';
                for (i = 0; i < theresponse.data.length; i++) {
                    console.log('Page name: ' + theresponse.data[i].name);
                    console.log('i ' + i);
                    if (i == 0) {
                        $('#PagesSelectItem').append('<option value="' + theresponse.data[i].id + '" selected="selected">' + theresponse.data[i].name + '</option>');
                    }
                    else {
                        $('#PagesSelectItem').append('<option value="' + theresponse.data[i].id + '">' + theresponse.data[i].name + '</option>');
                    }
                };

                AlreadyPopulatedAccounts = 'WeDidThis';

                $("#PagesSelectItem").selectmenu("refresh");
                // $("#PagesSelectItem").trigger("change");

            }


        },
        error: function (ErrorResponse) { console.log('pages: ' + JSON.stringify(ErrorResponse)); DoneWithLoading(); }
    });
}


function SelectPageMe() {

    SelectedUser = 'me';
    GoGetData();

}


function SelectPage() {

    var val = $('#PagesSelectItem :selected').val();
    SelectedUser = val;
    GoGetData();

}

function GoGetData() {

    console.log('SelectedUser: ' + SelectedUser);
    if (SelectedUser != undefined) {
        //Clear out
        globalArray = [];
        CommentArray = [];
        LikeArray = [];
        FriendsCount = 0;
        TotalComments = 0;
        TotalLikes = 0;
        //Go
        TryThis();
    }

}


function TryInner(url) {

    openFB.apiWithoutPermission({
        path: url,
        success: function (response) {

            //console.log('The Inner length is: ' + response.data.length);
            //console.log('The global length is: ' + globalArray.length);
            //console.log('dump: ' + JSON.stringify(response));

            var theCount = document.getElementById('myCount');
            theCount.innerHTML = globalArray.length;

            var StatusArray = CreateStatusArray(response);
            globalArray = globalArray.concat(StatusArray);

            if (response.paging != null && !DoICancel) { // && globalArray.length < 40

                theredirect = response.paging.next;
                theredirect = theredirect.replace('https://graph.facebook.com', '');

                TryInner(theredirect);
            }
            else {

                theCount.innerHTML = globalArray.length;

                //Set up pager
                //console.log("in setup pager");
                pager = new Pager(10, globalArray);
                pager.init(globalArray);
                pager.showPageNav('pager', 'pageNavPosition', globalArray);
                pager.showPage(1, globalArray);


                DoneWithLoading();

                var TheUserID = "";

                openFB.api({
                    path: '/' + SelectedUser + '/friends',
                    success: function (data) {

                        console.log('Friend Count: ' + data.data.length);

                        FriendsCount = data.data.length;
                        SortComments();
                        SortLikes();

                        console.log(Object.keys(CommentArray).length + ' out of ' + FriendsCount + ' friends commented on one of your status updates');
                        console.log(Object.keys(LikeArray).length + ' out of ' + FriendsCount + ' friends liked on one of your status updates');

                        console.log('Friends have Commented on your statuses ' + TotalComments + ' times.');
                        console.log('Friends have Liked on your statuses ' + TotalLikes + ' times.');

                        openFB.api({
                            path: '/' + SelectedUser,
                            success: function (data) {
                                TheUser = data.name;
                                TheUserID = data.id;
                                //Lets logs
                                $.get("mystats.aspx?id=" + TheUserID + "&c=" + TotalComments + "&l=" + TotalLikes + "&p=" + globalArray.length + "&g=good");

                            },
                            error: function (ErrorResponse) { console.log('error2: ' + JSON.stringify(ErrorResponse)); DoICancel = true; TryInner(url.split('&until')[0]); }
                        });

                    },
                    error: function (ErrorResponse) { console.log('error3: ' + JSON.stringify(ErrorResponse)); DoICancel = true; TryInner(url.split('&until')[0]); }
                });





                //PopulateAccounts();

            }

        },
        error: function (ErrorResponse) { console.log('error1: ' + JSON.stringify(ErrorResponse)); DoICancel = true; TryInner(url.split('&until')[0]); }
    });

}


function TryThis() {


    $('#LoginBlock').hide();
    $('#MyHeader').hide();
    DisplayLoader();

    DoICancel = false;

    openFB.api({
        path: '/' + SelectedUser + '/posts',
        params: {
            limit: '50'
        },
        success: function (data) {
            //console.log(JSON.stringify(data));

            //console.log('Before parse');
            //console.log('The length is: ' + data.data.length);
            $('#MyHeader').show();

            var StatusArray = CreateStatusArray(data);
            globalArray = globalArray.concat(StatusArray);
            console.log('tom: ' + JSON.stringify(data));
            var theredirect = data.paging.next;
            theredirect = theredirect.replace('https://graph.facebook.com', '');
            theredirect = theredirect.replace('v1.0', 'v2.3');

            TryInner(theredirect);

        },
        error: function (ErrorResponse) { console.log('error4: ' + JSON.stringify(ErrorResponse)); DoneWithLoading(); }
    });


}






