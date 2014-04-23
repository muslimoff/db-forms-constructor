/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

//file version 2.82

function getElementsByAttribute(attribute, attributeValue) {
    var elementArray = new Array();
    var matchedArray = new Array();

    if (attribute == "id" && document.all && !IsFF3()) {
        var oObject = document.all.item(attributeValue);
        if (oObject != null) {
            if (oObject.length != null) {
                for (i = 0; i < oObject.length; i++) {
                    matchedArray[matchedArray.length] = oObject(i);
                }
            } else {
                matchedArray[matchedArray.length] = oObject;
            }
        }
        return matchedArray;
    }

    if (document.all && !IsFF3()) {
        elementArray = document.all;
    }
    else {
        elementArray = document.getElementsByTagName("*");
    }

    for (var i = 0; i < elementArray.length; i++) {
        if (attribute == "class") {
            var pattern = new RegExp("(^| )" +
         attributeValue + "( |$)");

            if (pattern.test(elementArray[i].className)) {
                matchedArray[matchedArray.length] = elementArray[i];
            }
        }
        else if (attribute == "for") {
            if (elementArray[i].getAttribute("htmlFor") ||
         elementArray[i].getAttribute("for")) {
                if (elementArray[i].htmlFor == attributeValue) {
                    matchedArray[matchedArray.length] = elementArray[i];
                }
            }
        }
        else if (elementArray[i].getAttribute(attribute) ==
       attributeValue) {
            matchedArray[matchedArray.length] = elementArray[i];
        }
    }

    return matchedArray;
}

function getElementOfObject(attributeValue, objectId) {
    var cNode = '';
    var elements = getElementsByAttribute('id', attributeValue);
    for (var i in elements) {
        cNode = elements[i];
        while (cNode.parentNode != null) {
            if (cNode.parentNode == objectId) { return elements[i]; }
            cNode = cNode.parentNode;
        }
    }
    return false;
}

//////////////////////////////////////////////////////////////////

var objIcon02Img;
var objYesImg0;
var objNoImg0;
var objDoneTypingImg0;
var objYesImg1;
var objNoImg1;
var objDoneTypingImg1;

var mobjBubble = 0;
var mobjContent = 0;
var mobjPointer = 0;
var mblnShowPointer = false;

var mAct;

// outer bubble padding from content
var topPadding = 38;
var leftPadding = 14;
var rightPadding = 14;
var bottomPadding = 3;

var m_Pointed;
var m_PointerXpos = 0;
var m_PointerYpos = 0;
var m_bWidth = 0;
var m_bHeight = 0;
var m_scrOffLeft = 0;
var m_scrOffTop = 0;

//	<xsl:variable name="BUBBLE_DIR_TOP_LEFT" select="3" />
//	<xsl:variable name="BUBBLE_DIR_TOP_RIGHT" select="4" />
//	<xsl:variable name="BUBBLE_DIR_BOTTOM_LEFT" select="1" />
//	<xsl:variable name="BUBBLE_DIR_BOTTOM_RIGHT" select="2" />
//	<xsl:variable name="BUBBLE_DIR_LEFT_TOP" select="7" />
//	<xsl:variable name="BUBBLE_DIR_RIGHT_TOP" select="8" />
//	<xsl:variable name="BUBBLE_DIR_LEFT_BOTTOM" select="5" />
//	<xsl:variable name="BUBBLE_DIR_RIGHT_BOTTOM" select="6" />
//	<xsl:variable name="BUBBLE_DIR_NONE" select="0" />


var BUBB07_NULL = 0;
var BUBB07_NOPOINTER = 0;

var BUBB07_TOPLEFT = 3; 	// 1
var BUBB07_TOPRIGHT = 4; 	// 2
var BUBB07_BOTTOMLEFT = 1; 	// 3
var BUBB07_BOTTOMRIGHT = 2; 	// 4
var BUBB07_LEFTTOP = 7;
var BUBB07_RIGHTTOP = 8; 	// 2
var BUBB07_LEFTBOTTOM = 5;
var BUBB07_RIGHTBOTTOM = 6;

var BUBB07_DEFAULTWIDTH = 200 - leftPadding - rightPadding;

// +++ defines
var BUBB07_LEFTAREA = 37;
var m_BubblePath = "../../img/";
var ash = false;
var abubbv02_bubbcolor = 0;
var tID = 0;
var setpos = true;

//var img1on,img1off,
var img2on, img2off;

var imagesArr = new Array();
var imagesXref = new Array();

function cached_image(color) {
    var bubbc;
    bubbc = convert(String(color), 10, 16);
    while (bubbc.length < 6) bubbc = "0" + bubbc;

    bubbc = bubbc.toLowerCase();
    //alert("cached_image - " + bubbc)

    var m_BubbleImgs;
    m_BubbleImgs =
		[m_BubblePath + 'giftrk1.gif', //0
			m_BubblePath + 'b' + bubbc + '_03.gif',
			m_BubblePath + 'b' + bubbc + '_03over.gif',
			m_BubblePath + 'b' + bubbc + '_01.gif',
			m_BubblePath + 'b' + bubbc + '_02.gif',
			m_BubblePath + 'b' + bubbc + '_04.gif', 	//10
			m_BubblePath + 'b' + bubbc + '_06.gif',
			m_BubblePath + 'b' + bubbc + '_07.gif',
			m_BubblePath + 'b' + bubbc + '_08.gif',
			m_BubblePath + 'b' + bubbc + '_09.gif',
			m_BubblePath + 'b' + bubbc + '_anch_tl.gif', // upper left
			m_BubblePath + 'b' + bubbc + '_anch_tr.gif', // upper right
			m_BubblePath + 'b' + bubbc + '_anch_lthigh.gif', // left high
			m_BubblePath + 'b' + bubbc + '_anch_ltlow.gif', // left low
			m_BubblePath + 'b' + bubbc + '_anch_rthigh.gif', // right high
			m_BubblePath + 'b' + bubbc + '_anch_rtlow.gif', // right low
			m_BubblePath + 'b' + bubbc + '_anch_bl.gif', // bottom left
			m_BubblePath + 'b' + bubbc + '_anch_br.gif',
			m_BubblePath + 'b' + bubbc + '_03disab.gif', // bottom right
			m_BubblePath + 'b' + bubbc + '_03empty.gif'] // no bottom

    this.imageNames = m_BubbleImgs;
    this.color = color;

    var imgon = document.createElement("img");
    imgon.width = 23;
    imgon.height = 21;
    imgon.src = m_BubbleImgs[2];

    var imgoff = document.createElement("img");
    imgoff.width = 23;
    imgoff.height = 21;
    imgoff.src = m_BubbleImgs[1];

    this.imgon = imgon;
    this.imgoff = imgoff;

}


function cached_images(bubcolor) {
    abubbv02_bubbcolor = bubcolor;
    if (!imagesArr["c_" + bubcolor]) {
        imagesArr["c_" + bubcolor] = new cached_image(bubcolor);
        imagesXref[imagesXref.length] = "c_" + bubcolor;
    }
}

function load_buttons() {
    if (document.images) {
        img2on = imagesArr["c_" + abubbv02_bubbcolor].imgon;
        img2off = imagesArr["c_" + abubbv02_bubbcolor].imgoff;
    }
}

function GetScrName(fileName) {
    k = fileName.lastIndexOf('/');
    s = fileName.substr(k + 1);
    return "../../img/" + s;
}

function BubbleimgOn(imgName, img2) {

    if (img2) {
        //mobjBubble.all[imgName].style.display = "none"
        //mobjBubble.all[img2].style.display = "block"
        var cimg = getElementOfObject(imgName, mobjBubble);
        cimg.style.display = "none";
        var cimg2 = getElementOfObject(img2, mobjBubble);
        cimg2.style.display = "block";
    }
    else {
        var blnInBox = false;
        // on highlight if in box otherwise do not highlight
        if (document.images) {
            if ((event.offsetX >= 3 && event.offsetX <= 26) && (event.offsetY >= 7 && event.offsetX <= 27)) {
                mobjBubble.all[imgName].src = GetScrName(eval(imgName + "on.src"));
            }
            else {
                mobjBubble.all[imgName].src = GetScrName(eval(imgName + "off.src"));
            }
        }
    }
}

function BubbleimgOff(imgName, img2) {
    if (img2) {
        //mobjBubble.all[imgName].style.display = "block"
        //mobjBubble.all[img2].style.display = "none"
        var cimg = getElementOfObject(imgName, mobjBubble);
        cimg.style.display = "block";
        var cimg2 = getElementOfObject(img2, mobjBubble);
        cimg2.style.display = "none";
    }
    else {
        if (document.images)
            mobjBubble.all[imgName].src = GetScrName(eval(imgName + "off.src"));
    }
}

function BubbleClose() {
    /*	if ((event.offsetX >= 3 && event.offsetX <= 26) && (event.offsetY >= 7 && event.offsetX <= 27)) {*/
    OnClose();
    /*}*/
}

function InAnchor(event) {

    var inAnchor = false;
    var xCoord = event.offsetX;
    var yCoord = event.offsetY;
    switch (abubbv02_Pointer) {
        case BUBB07_TOPLEFT:
            if ((xCoord >= 3) && (yCoord <= 38)) {
                // in triangle range

                //slop = (y2 - y1) / (x2 - x1)
                var Slope = (38 - 1) / (18 - 4);

                // CoordPos = y1 = slope * (x2 - x1) - y2
                var CoordPos = (Slope * (18 - xCoord)) + yCoord;

                // if CoordPos < y1
                if (CoordPos > 38) {
                    inAnchor = true;
                }
            }
            break;
        case BUBB07_TOPRIGHT:
            if ((xCoord <= 15) && (yCoord <= 38)) {
                // in triangle range

                //slop = (y2 - y1) / (x2 - x1)
                var Slope = (1 - 35) / (13 - 1);

                // CoordPos = y1 = slope * (x2 - x1) - y2
                var CoordPos = (Slope * (13 - xCoord)) + yCoord;

                // if CoordPos < y1
                if (CoordPos > 1) {
                    inAnchor = true;
                }
                //alert(inAnchor);
            }
            break;
        case BUBB07_BOTTOMLEFT:
            if (xCoord >= 3) {
                // in triangle range

                //slop = (y2 - y1) / (x2 - x1)
                var Slope = (41 - 5) / (5 - 17);

                // CoordPos = y1 = slope * (x2 - x1) - y2
                var CoordPos = (Slope * (5 - xCoord)) + yCoord;

                // if CoordPos < y1
                if (CoordPos < 41) {
                    inAnchor = true;
                }
                //alert(inAnchor);
            }
            break;
        case BUBB07_BOTTOMRIGHT:
            if (xCoord <= 15) {
                // in triangle range

                //slop = (y2 - y1) / (x2 - x1)
                var Slope = (41 - 4) / (14 - 1);

                // CoordPos = y1 = slope * (x2 - x1) - y2
                var CoordPos = (Slope * (14 - xCoord)) + yCoord;

                // if CoordPos < y1
                if (CoordPos < 41) {
                    inAnchor = true;
                }
                //alert(inAnchor);
            }
            break;
        case BUBB07_LEFTTOP:
            if (yCoord >= 3) {
                // in triangle range

                //slop = (y2 - y1) / (x2 - x1)
                var Slope = (15 - 3) / (38 - 1);

                // CoordPos = y1 = slope * (x2 - x1) - y2
                var CoordPos = (Slope * (38 - xCoord)) + yCoord;

                // if CoordPos < y1
                if (CoordPos < 15) {
                    inAnchor = true;
                }
            }
            break;
        case BUBB07_LEFTBOTTOM:
            if (yCoord <= 15) {
                // in triangle range

                //slop = (y2 - y1) / (x2 - x1)
                var Slope = (3 - 15) / (38 - 1);

                // CoordPos = y1 = slope * (x2 - x1) - y2
                var CoordPos = (Slope * (38 - xCoord)) + yCoord;

                // if CoordPos < y1
                if (CoordPos > 3) {
                    inAnchor = true;
                }
            }
            break;
        case BUBB07_RIGHTTOP:
            if (yCoord >= 3) {
                // in triangle range

                //slop = (y2 - y1) / (x2 - x1)
                var Slope = (15 - 3) / (1 - 38);

                // CoordPos = y1 = slope * (x2 - x1) - y2
                var CoordPos = (Slope * (1 - xCoord)) + yCoord;

                // if CoordPos < y1
                if (CoordPos < 15) {
                    inAnchor = true;
                }
            }
            break;
        case BUBB07_RIGHTBOTTOM:
            if (yCoord >= 3) {
                // in triangle range

                //slop = (y2 - y1) / (x2 - x1)
                var Slope = (3 - 15) / (1 - 38);

                // CoordPos = y1 = slope * (x2 - x1) - y2
                var CoordPos = (Slope * (1 - xCoord)) + yCoord;

                // if CoordPos < y1
                if (CoordPos > 3) {
                    inAnchor = true;
                }
            }
            break;

    }
    return inAnchor;
}

function AnchorMouseDown() {
    // this function is to determine if the mousedown event was in the pointer. If not pass event
    // through

    if (!InAnchor(event)) {
        EventMouseDown(event);
    }
}

function AnchorMouseUp() {
    // this function is to determine if the mousedown event was in the pointer. If not pass event
    // through
    if (!InAnchor(event)) {
        EventMouseUp(event);
    }
}


function convert(input, origin, dest) {
    base = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    c = 0; Result = "";
    for (t = 1; t <= input.length; t++) {
        b = base.indexOf(input.substring(t - 1, t));
        n = b * (Math.pow(origin, input.length - t));
        c += n;
    }
    a = 100;
    while (c < Math.pow(dest, a)) { a--; }

    while (a > -1) {
        e = Math.pow(dest, a);
        a--;
        d = ((c - (c % e)) / e) + 1;
        c = c % e; Ciffer = base.substring(d - 1, d); Result = Result + Ciffer;
    }
    return Result;
}


//<!--hide from old browsers

N = (document.all && !IsFF3()) ? 0 : 1;
var ob = false;
var xi, yi;
var global_moveable = true;


// +++ mouse down event
function bubb07_global_MD(e) {
    if (!global_moveable) return;
    if (N) {
        ob = e.target;

        if (e.target.id == "blink" || e.target.id == "m_Caption" || e.target.id == "m_StaticCaption") {
            if (e.target.id == "blink" || e.target.id == "m_StaticCaption") {
                xi = document.getElementById("bubb_cap").offsetWidth;
            }
            else {
                xi = 0
            }

            ob = true;

            X = e.layerX;
            Y = e.layerY;
        };

        return false;
    }
    else {
        if (event.srcElement.id == "blink" || event.srcElement.id == "m_Caption" || event.srcElement.id == "m_StaticCaption") {
            if (event.srcElement.id == "blink" || event.srcElement.id == "m_StaticCaption") {
                xi = mobjBubble.all.bubb_cap.clientWidth;
            }
            else {
                xi = 0;
            }
            ob = true;

            X = window.event.offsetX;
            Y = window.event.offsetY;
        }
    }
}


// +++ mouse move event
function bubb07_global_MM(e) {
    if (ob) {
        if (N) {
            if (ob == true) {
                leftarea = 0;
                rightarea = 0;

                var xMovement = e.pageX - X	//-14-xi + document.body.scrollLeft-leftarea;
                var yMovement = e.pageY - Y	// + document.body.scrollTop-rightarea;

                mobjBubble.style.left = xMovement + "px";
                mobjBubble.style.top = yMovement + "px";

                mobjContent.style.left = Number(xMovement + leftPadding) + "px";
                mobjContent.style.top = Number(yMovement + topPadding) + "px";

                document.getElementById('blink').focus();
            }
        }
        else {
            if (ob == true) {
                leftarea = 0;
                rightarea = 0;

                var xMovement = event.clientX - X - 14 - xi + document.body.scrollLeft - leftarea;
                var yMovement = event.clientY - Y + document.body.scrollTop - rightarea;

                mobjBubble.style.left = xMovement + "px";
                mobjBubble.style.top = yMovement + "px";

                mobjContent.style.left = Number(xMovement + leftPadding) + "px";
                mobjContent.style.top = Number(yMovement + topPadding) + "px";
            }
            return false;
        }
    }
}



// +++ mouse up event
function bubb07_global_MU() {
    if (ob) OnBubbleMoved();
    ob = false;
}

if (N) {
    document.captureEvents(Event.MOUSEDOWN | Event.MOUSEMOVE | Event.MOUSEUP);
}

if (document.attachEvent) {
    document.attachEvent("onmousedown", bubb07_global_MD);
    document.attachEvent("onmousemove", bubb07_global_MM);
    document.attachEvent("onmouseup", bubb07_global_MU);
}
else {
    document.addEventListener("mousedown", bubb07_global_MD, true);
    document.addEventListener("mousemove", bubb07_global_MM, true);
    document.addEventListener("mouseup", bubb07_global_MU, true);
}

function JSRect(left, top, right, bottom) {
    this.m_Left = left;
    this.m_Top = top;
    this.m_Right = right;
    this.m_Bottom = bottom;
}

///////////////////////////////////
//  +++ class JSBubbleInterface  //
///////////////////////////////////
function JSBubbleInterface(name) {
    abubbv02_bVisible = false;
    abubbv02_show = true;
    abubbv02_Text = "";
    abubbv02_CaptionText = "";
    abubbv02_ActionText = "";
    abubbv02_IconName = '';
    abubbv02_Pointer = BUBB07_NULL;
    abubbv02_infos = "";
    abubbv02_enableclose = 1;
    m_Pointed = true;
    //abubbv02_bubbcolor=0;
    _ax = 0;
    _ay = 0;

    // +++ bubble position
    m_rect = new JSRect(-1, -1, -1, -1);

    //alert(name);
    // +++ knowit bubble position
    this.m_knrect = new JSRect(-1, -1, -1, -1)

    //if(document.all) this.m_Object=document.all[this.m_BubbleID];
    this.m_bFFClearHeight = false;
    this.m_Name = name;
    this.m_Text = "";
    this.m_Caption = "";
    this.lastbubbstyle = "";
    this.m_ShowAction = false;
    this.EnabledAction = false;
    this.m_bMoveDefPos = false;
};

///////////////////////////////////////////////
JSBubbleInterface.prototype.SetMode = function(text) {
    //alert(text);
    abubbv02_CaptionText = text;
}


JSBubbleInterface.prototype.ShowMode = function() {
    if (abubbv02_show == true) {
        if (document.all && !IsFF3()) {
            mobjBubble.all.m_Caption.innerText = abubbv02_CaptionText;
        } else {
            var mCap = getElementsByAttribute('id', 'm_Caption');
            for (var i in mCap) {
                mCap[i].textContent = abubbv02_CaptionText;
            };
        };
    }
}

JSBubbleInterface.prototype.StartBlink = function(color) {
    BlinkTxt();
}

JSBubbleInterface.prototype.EndBlink = function(color) {
    clearTimeout(tID);
    var prdiv = document.getElementById("prdiv"); // instead of mobjContent.all (works only in IE)
    prdiv.style.color = "blue"
}

JSBubbleInterface.prototype.SetColor = function(color) {

    abubbv02_bubbcolor = color;
}

function BlinkTxt() {

    if (mobjContent) {
        var prdiv = getElementOfObject("prdiv", mobjContent); // instead of mobjContent.all (works only in IE)
        if (prdiv) {
            if (prdiv.style.color == "#ccffff" || prdiv.style.color == "rgb(204, 255, 255)")
                prdiv.style.color = "#003366"
            else
                prdiv.style.color = "#ccffff";
        }
    }
    tID = setTimeout('BlinkTxt()', 750);
}

function BubbleimgOn2() {
    BubbleimgOn("img2");
}

function BubbleimgOff2() {
    BubbleimgOff("img2");
}

function NoImg() {
}


JSBubbleInterface.prototype.SetEnableCloseButton = function(bValue) {

//    if (abubbv02_enableclose != bValue)
        if (abubbv02_show == true) {
            var closebtn = document.getElementById("closebtn_" + abubbv02_bubbcolor); // instead of mobjBubble.all["closebtn"] (works only in IE)
        str = "";
        if (bValue == 1) {
            str = "<div id='closebtn_" + abubbv02_bubbcolor + "' style='position:relative'><div><img id='img2' name='img2' src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[1] + "' style='display:block' width='32' height='27' border='0'><img id='img2o' name='img2o' src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[2] + "' style='display:none' width='32' height='27' border='0'></div><div style='position:absolute; left:3px; top:7px'><a href='#' onclick='BubbleClose();return false' onMouseMove='BubbleimgOn(\"img2\",\"img2o\")' onMouseOut='BubbleimgOff(\"img2\",\"img2o\")'><img alt='" + R_bubble_closeondemand + "' id='imghandler' name='imghandler' src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[0] + "' style='display:block' width='23' height='20' border='0'></a></div></div></td>";
            //closebtn.detachEvent("onmousemove",BubbleimgOn2);
            //closebtn.detachEvent("onmouseout",BubbleimgOff2);
            //closebtn.attachEvent("onmousemove",BubbleimgOn2);
            //closebtn.attachEvent("onmouseout",BubbleimgOff2);
            //closebtn.href="javascript:OnClose()";
            //closebtn.all["img2"].src=imagesArr["c_" + abubbv02_bubbcolor].imageNames[2];
            //closebtn.detachEvent("onclick",BubbleClose);
            //closebtn.attachEvent("onclick",BubbleClose);
        }
        else if (bValue == 0) {
            str = '<a id="closebtn_' + abubbv02_bubbcolor + '" onclick=""><img name="img2" src="' + imagesArr["c_" + abubbv02_bubbcolor].imageNames[18] + '" width="32" height="27" border="0" alt="' + R_bubble_closeondemand + '"></td>';
        }
        else {      // bValue == 2 -> nem kell gomb: bxxxxxx_03empty.gif
            str = '<a id="closebtn_' + abubbv02_bubbcolor + '" onclick=""><img name="img2" src="' + imagesArr["c_" + abubbv02_bubbcolor].imageNames[19] + '" width="32" height="27" border="0" alt=""></td>';
        }

        if (document.all && !IsFF3()) {
            closebtn.outerHTML = str;
        } else {
            var r = closebtn.ownerDocument.createRange();
            r.setStartBefore(closebtn);
            var df = r.createContextualFragment(str);
            closebtn.parentNode.replaceChild(df, closebtn);
        }
    }
    abubbv02_enableclose = bValue;
}

JSBubbleInterface.prototype.GetActionLink = function() {
    return getElementOfObject('m_ActionText', mobjBubble);
}

JSBubbleInterface.prototype.GetActionLinkHeight = function() {
    return 27;
}

JSBubbleInterface.prototype.SetPRText = function(text) {
    if (mobjContent) {
        var cElem = document.getElementById('prdiv');
        if (cElem != null) //if(mobjContent.all["prdiv"])
        {
            if (document.all && !IsFF3()) {
                cElem.innerText = text; //mobjContent.all["prdiv"].innerText=text;
            } else {
                cElem.textContent = text;
            }
        }
    }
}

var noactionstitle = false;
JSBubbleInterface.prototype.SetActionText = function(text, notitle) {
    //alert(text);
    abubbv02_ActionText = text;
    //this.ShowActionText();
    noactionstitle = notitle;
    this.ShowActionText();
}

JSBubbleInterface.prototype.ShowActionText = function() {
    //alert("huha");
    if (mobjBubble)
        if (abubbv02_show == true) {
        if (document.all && !IsFF3()) {
            if (!noactionstitle) mobjBubble.all.m_ActionText.title = R_interface_action_alt;
            mobjBubble.all.m_ActionText.innerText = abubbv02_ActionText;
        } else {
            mAct = getElementOfObject('m_ActionText', mobjBubble);
            if (!noactionstitle) mAct.title = R_interface_action_alt;
            mAct.textContent = abubbv02_ActionText;
        }
    }
}

JSBubbleInterface.prototype.Show = function() {
    this.ShowActionText();
    abubbv02_bVisible = true;
    if (mobjBubble) {
        mobjBubble.style.visibility = "visible";
        mobjBubble.style.zIndex = 2;
        mobjContent.style.visibility = "visible";
        mobjContent.style.zIndex = 3;
        if (mblnShowPointer) {
            mobjPointer.style.visibility = "visible";
            mobjPointer.style.zIndex = 4;
        }
        mAct = getElementOfObject('m_ActionText', mobjBubble);
        mAct.style.visibility = "visible";
    }
}

JSBubbleInterface.prototype.Hide = function() {
    if (mobjBubble) {
        abubbv02_bVisible = false;

        //		_ax=mobjContent.style.pixelLeft;
        //		_ay=mobjContent.style.pixelTop;

        _ax = getObjLeft(mobjContent);
        _ay = getObjTop(mobjContent);

        //here what is this for??
        mobjBubble.style.visibility = "hidden";
        mobjContent.style.visibility = "hidden";
        if (mblnShowPointer)
            mobjPointer.style.visibility = "hidden";
        mAct = getElementOfObject('m_ActionText', mobjBubble);
        mAct.style.visibility = "hidden";
    }
}

JSBubbleInterface.prototype.SetErrorMessage = function(text) {
    //alert(text);
    this.m_bFFClearHeight = true;
    var checkobj;
    checkobj = getElementOfObject("errortext", mobjContent);
    if (abubbv02_show == true) {
        var intObjHeight = 0;
        if (text == '') {
            //no error message - regenerate the bubble text using the appropriate function.
            this.Hide();
            this.ShowText();
            kmbdefpos = false;
            RepositionBubble(this);
            this.Show();
        }
        else {
            this.SetEnableCloseButton(true);
            if (!checkobj) {

                this.Hide();
                this.ShowText();

                var objContent = mobjContent;
                var objSpan = document.createElement("span");
                objSpan.ID = "errortext";
                var objB = document.createElement("b");
                var objFont = document.createElement("font");
                objFont.color = "#FF0000";
                objFont.face = "Arial";
                objFont.size = "2";
                objFont.setAttribute("style", "font-family:Arial; font-size:10pt;");

                if (document.all && !IsFF3()) {
                    objFont.innerText = text;
                } else {
                    objFont.textContent = text;
                }
                objB.appendChild(objFont);
                objSpan.appendChild(objB);

                var objHR = document.createElement("hr");
                objSpan.appendChild(objHR);
                if (document.all && !IsFF3()) objContent.insertBefore(objSpan, objContent.children(0))
                else objContent.insertBefore(objSpan, objContent.firstChild);

                this.RefreshBubble();
                kmbdefpos = false;
                RepositionBubble(this);
                this.Show();
            }
        }
    }
}
JSBubbleInterface.prototype.SetIcon = function(iconfilename) {
    if (iconfilename != "") {
        abubbv02_IconName = iconfilename;
    }
}

JSBubbleInterface.prototype.SetMoveable = function(bValue) {
    global_moveable = bValue;
};

JSBubbleInterface.prototype.RefreshBubble = function() {
    // reset the width. Otherwise the width will just grow
    mobjContent.style.pixelWidth = BUBB07_DEFAULTWIDTH;
    //	mobjContent.style.pixelHeight = 30;
    mobjContent.style.width = BUBB07_DEFAULTWIDTH + 'px';
    //	mobjContent.style.height = '30px';

    //	if((mobjContent.clientHeight + topPadding + bottomPadding) > BUBB07_DEFAULTWIDTH)
    //	{	
    //	    //bubble height exceeds predefined bubble width - adjust width to a (4:3) width-to-height ratio...
    //		var avgSize = Math.round((((mobjContent.clientHeight + topPadding + bottomPadding) + (mobjContent.clientWidth + leftPadding + rightPadding))*4)/7) - leftPadding - rightPadding;
    //		
    //		mobjContent.style.width = avgSize;
    //		
    //	}
    //	
}

JSBubbleInterface.prototype.SetText = function(text) {
    abubbv02_Text = text;
}


JSBubbleInterface.prototype.ResetContent = function() {
    abubbv02_IconName = "";
    m_ShowAction = "false";
    abubbv02_infos = "";
}

JSBubbleInterface.prototype.ShowText = function() {
    text = abubbv02_Text;


    if (abubbv02_show == true) {
        var objContent = mobjContent;

        if (text == '') {
            text = '<DIV style="visibility: hidden">longtextlongtextlongtext</DIV>';
            //alert(text);
        }

        objContent.innerHTML = text;

        if (abubbv02_IconName != '') {
            //iconarea='<IMG alt="" width="32" height="32" align="left" src="'+abubbv02_IconName+'"/>';
            var objImg = document.createElement("img");
            objImg.width = 32;
            objImg.height = 32;
            objImg.border = 0;
            objImg.align = "left";
            objImg.src = m_BubblePath + abubbv02_IconName;
            if (document.all && !IsFF3())
                objContent.insertBefore(objImg, objContent.children(0))
            else
                objContent.firstChild.insertBefore(objImg, objContent.firstChild.firstChild);
        }
        var objTable = document.createElement("table");
        objTable.cellspacing = 0;
        objTable.cellpadding = 0;
        objTable.style.marginBottom = "8px";
        var objTableBody = document.createElement("tbody");

        var objTR = document.createElement("tr");

        var objTD = document.createElement("td");
        objTD.height = 5;
        objTR.appendChild(objTD);
        objTableBody.appendChild(objTR);

        if (this.m_ShowAction || abubbv02_infos) {
            objTR = document.createElement("tr");

            if (this.m_ShowAction) {
                //action=+separator+"</td>"
                objTD = document.createElement("td");
                objTD.align = "right";

                var objAnchor = document.createElement("a");
                objAnchor.href = "javascript:OnAlternative();";

                var objImg = document.createElement("img");
                objImg.width = 22;
                objImg.height = 22;
                objImg.border = 0;
                objImg.alt = R_menu_alternatives;
                objImg.src = m_BubblePath + "alternatives.gif"
                objAnchor.appendChild(objImg);

                objTD.appendChild(objAnchor);


                if (screens[showScreen].infoblocks.length > 0) {
                    //separator="<img src='icondivide.gif' width='16' height='19' border='0' alt=''></img>";
                    var objImgSep = document.createElement("img");
                    objImgSep.width = 16;
                    objImgSep.height = 19;
                    objImgSep.border = 0;
                    objImgSep.src = m_BubblePath + "icondivide.gif"
                    objTD.appendChild(objImgSep);
                }

                objTR.appendChild(objTD)
            }

            if (screens[showScreen].infoblocks.length > 0) {
                // process infoblocks
                for (var i = 0; i < screens[showScreen].infoblocks.length; i++) {
                    var ib = screens[showScreen].infoblocks[i];

                    var objInfoBlock = document.createElement("td");
                    objInfoBlock.width = 25;
                    objInfoBlock.border = 0;

                    var objAnchor = document.createElement("a");
                    objAnchor.href = ib.url;
                    objAnchor.title = ib.tooltip;

                    var objActionImg = document.createElement("img");
                    objActionImg.src = ib.buttonfile;
                    objActionImg.width = 22;
                    objActionImg.height = 22
                    objActionImg.border = 0;
                    objActionImg.alt = ib.tooltip;
                    objAnchor.appendChild(objActionImg);

                    objInfoBlock.appendChild(objAnchor);
                    objTR.appendChild(objInfoBlock);
                };
            }
            objTableBody.appendChild(objTR);
        }
        objTable.appendChild(objTableBody);
        objContent.appendChild(objTable);

        if (playMode == "K") {
            // insert images using DOM. Currently three instances of images will be processed
            // through the DOM. These images are only available for Know It
            //var objIcon02 = mobjContent.all["img_icon02"];
            var objIcon02 = document.getElementById("img_icon02");
            if (objIcon02) {
                // if icon exists
                var objImg = objIcon02Img.cloneNode(null);
                objIcon02.appendChild(objImg);
            }

            UpdateYesNo(false, false);
        }
        UpdateDoneTyping(false);
    }
}

function UpdateDoneTyping(HighLighted) {
    //var objDoneTyping = mobjContent.all["img_DoneTyping"];
    //var objDoneTyping = mobjContent.img_DoneTyping;
    var a_objDoneTyping = getElementsByAttribute('id', 'img_DoneTyping');
    for (var i in a_objDoneTyping) {
        objDoneTyping = a_objDoneTyping[i];
        if (objDoneTyping) {
            // if yes No object exists
            if ((document.all && !IsFF3() && objDoneTyping.childNodes.length == 0) || (!document.all && objDoneTyping.nodeType == 1)) {
                // if the object is empty then populate using appenchild		
                //<img id='bbyes' src='yes0.gif' onClick='HLink(11)' onMouseOver='HLink(111)' onMouseOut='HLink(110)'>
                objDoneTyping.appendChild(objDoneTypingA);
                objDoneTypingA.appendChild(objDoneTypingImg0);
                objDoneTypingA.appendChild(objDoneTypingImg1);
            }
            objDoneTypingImg0.style.marginTop = "26px";
            objDoneTypingImg1.style.marginTop = "26px";
//            objDoneTypingImg0.style.marginBottom = "15px";
//            objDoneTypingImg1.style.marginBottom = "15px";
            if (HighLighted) {
                objDoneTypingImg1.style.display = "block";
                objDoneTypingImg0.style.display = "none";
            }
            else {
                objDoneTypingImg1.style.display = "none";
                objDoneTypingImg0.style.display = "block";
            }
        }
    }
}

function UpdateYesNo(YesHighLighted, NoHighlighted) {
    //var objYesNo = mobjContent.all["img_YesNo"];
    var objYesNo = document.getElementById("img_YesNo");
    if (objYesNo) {
        // if yes No object exists

        if (objYesNo.childNodes.length == 0 || !mobjContent.all) {
            // if the object is empty then populate using appenchild

            objYesNo.appendChild(objYesA);
            objYesA.appendChild(objYesImg0);
            objYesA.appendChild(objYesImg1);


            var objTextNode = document.createTextNode("  ");
            objYesNo.appendChild(objTextNode);

            objYesNo.appendChild(objNoA);
            objNoA.appendChild(objNoImg0);
            objNoA.appendChild(objNoImg1);
        }
        if (YesHighLighted) {
            objYesImg1.style.display = "inline"
            objYesImg0.style.display = "none"
        }
        else {
            objYesImg1.style.display = "none"
            objYesImg0.style.display = "inline"
        }
        if (NoHighlighted) {
            objNoImg1.style.display = "inline"
            objNoImg0.style.display = "none"
        }
        else {
            objNoImg1.style.display = "none"
            objNoImg0.style.display = "inline"
        }
    }
}

function YesOnClick() {
    HLink(11);
}

function YesOnMouseOver() {
    HLink(111);
}

function YesOnMouseOut() {
    HLink(110);
}

function NoOnClick() {
    HLink(12);
}

function NoOnMouseOver() {
    HLink(121);
}

function NoOnMouseOut() {
    HLink(120);
}

function DTOnClick() {
    HLink(13);
}

function DTOnMouseOver() {
    HLink(131);
}

function DTOnMouseOut() {
    HLink(130);
}

JSBubbleInterface.prototype.SetAlternative = function(bShow, bEnabled) {
    this.m_ShowAction = bShow;
    this.EnabledAction = bEnabled;
}

JSBubbleInterface.prototype.AddInfoBlock = function(bitmapname, urltext, tooltip) {
    //if(abubbv02_show==true)
    {
        var EncodedTooltip = fixHTMLString(tooltip)
        abubbv02_infos += "<td width='25' border='0'><a target='_blank' href='" + urltext + "'><img src='" + bitmapname + "' width='22' height='22' border='0' alt='" + EncodedTooltip + "'></img></a></td>";
    }
}

var kmbdefpos = false;
var FirstBubble = true;

JSBubbleInterface.prototype.HandleRepos = function() {
    var sScreen = getDIV("screen");
    var sx = sScreen.offsetLeft;
    var sy = sScreen.offsetTop;
    var xdiff = m_scrOffLeft - sx;
    var ydiff = m_scrOffTop - sy;
    if (xdiff != 0) {
        mobjContent.style.left = Number(getObjLeft(mobjContent) - xdiff) + "px";
        mobjContent.style.top = Number(getObjTop(mobjContent) - ydiff) + "px";
        mobjBubble.style.left = Number(getObjLeft(mobjBubble) - xdiff) + "px";
        mobjBubble.style.top = Number(getObjTop(mobjBubble) - ydiff) + "px";
        if (mobjPointer) {
            mobjPointer.style.left = Number(getObjLeft(mobjPointer) - xdiff) + "px";
            mobjPointer.style.top = Number(getObjTop(mobjPointer) - ydiff) + "px";
        }
    }
    m_scrOffLeft = sScreen.offsetLeft;
    m_scrOffTop = sScreen.offsetTop;
}

JSBubbleInterface.prototype.GetBubbleLeft = function(full) {
    if (!full)
        return getObjLeft(mobjBubble);
    switch (m_PointerDirection) {
        case BUBB07_LEFTTOP:
        case BUBB07_LEFTBOTTOM:
            return getObjLeft(mobjPointer)
        default:
            return getObjLeft(mobjBubble);
    }
}

JSBubbleInterface.prototype.GetBubbleTop = function(full) {
    if (!full)
        return getObjTop(mobjBubble);
    switch (m_PointerDirection) {

        case BUBB07_TOPLEFT:
        case BUBB07_TOPRIGHT:
            return getObjTop(mobjPointer)
        default:
            return getObjTop(mobjBubble);
    }
}

JSBubbleInterface.prototype.GetBubbleWidth = function(full) {
    if (!full)
        return getClientWidth(mobjBubble);
    switch (m_PointerDirection) {
        case BUBB07_LEFTTOP:
        case BUBB07_RIGHTTOP:
        case BUBB07_LEFTBOTTOM:
        case BUBB07_RIGHTBOTTOM:
            return getClientWidth(mobjBubble) + getClientWidth(mobjPointer);
        default:
            return getClientWidth(mobjBubble);
    }
}

JSBubbleInterface.prototype.GetBubbleHeight = function(full) {
    if (!full)
        return getClientHeight(mobjBubble);
    switch (m_PointerDirection) {
        case BUBB07_TOPLEFT:
        case BUBB07_TOPRIGHT:
        case BUBB07_BOTTOMLEFT:
        case BUBB07_BOTTOMRIGHT:
            return getClientHeight(mobjBubble) + getClientHeight(mobjPointer);
        default:
            return getClientHeight(mobjBubble);
    }
}

JSBubbleInterface.prototype.GetBubblePointer = function() {
    return m_PointerDirection;
}

JSBubbleInterface.prototype.SetPosition = function(left, top, right, bottom, pointed, pointerDirection, pointerXpos, pointerYPos, bwidth, bheight) {

    // +++ check & set knowit mode move default position flag 
    //mobjContent = document.all["content"];
    mobjContent = document.getElementById('content');
    this.Hide();
    this.ShowText();
    this.RefreshBubble();


    //	kmbdefpos=false;
    if (m_rect.m_Left == -1 && this.m_bMoveDefPos) kmbdefpos = true;
    if (FirstBubble) {
        this.m_bMoveDefPos = true;
        FirstBubble = false;
    }

    m_rect.m_Left = left;
    m_rect.m_Top = top;
    m_rect.m_Right = right;
    m_rect.m_Bottom = bottom;

    m_Pointed = pointed;
    m_PointerDirection = pointerDirection;
    m_PointerXpos = pointerXpos;
    m_PointerYpos = pointerYPos;
    m_bWidth = bwidth;
    m_bHeight = bheight;

    mblnShowPointer = m_Pointed;

    RepositionBubble(this);
    this.ShowMode();
    //	alert(pointerXpos + " X,W " + bwidth);

}

function RepositionBubble(thisItem) {

    // Note that we should probably incorperate
    // the screen object (infoblocks) in the interface as well.

    // set dimensions of hotspot location
    thisItem.SetEnableCloseButton(abubbv02_enableclose);

    var right = m_rect.m_Right;
    var left = m_rect.m_Left;
    var bottom = m_rect.m_Bottom;
    var top = m_rect.m_Top;
    var pointed = m_Pointed;

    var contentLeft = 0;
    var contentTop = 0;

    // width and height of hotspot location
    var _w = right - left;
    var _h = bottom - top;

    var addwidth = 0;

    var sScreen = getDIV("screen");
    if (m_bWidth > sScreen.style.pixelWidth) m_bWidth = sScreen.style.pixelWidth;
    var sx = sScreen.offsetLeft;
    var sy = sScreen.offsetTop;
    m_scrOffLeft = sScreen.offsetLeft;
    m_scrOffTop = sScreen.offsetTop;

    // if hotspot width is less that 40 and greater that 0 then added width is half of 
    // hotspot width, otherwise add width is 20	
    if (_w < 40 & _w > 0) addwidth = (_w) / 2;
    else addwidth = 20;

    if (abubbv02_show == true) {
        var cw = document.body.clientWidth; // client width
        var ch = document.body.clientHeight; // client height
        var w = mobjContent.clientWidth; 	// bubble width
        var h = mobjContent.clientHeight; 	// bubble height
        var x, y;
        var st01, st02;

        x = right + w;
        y = bottom + h;

        var right_over = false;
        var left_over = false;
        var top_over = false;
        var bottom_over = false;

        //alert("bubborék valós1 = "+m_Object.style.pixelLeft+","+m_Object.style.pixelTop+",");

        if (setpos) {
            //			thisItem.m_knrect.left=mobjContent.style.pixelLeft;
            //			thisItem.m_knrect.top=mobjContent.style.pixelTop;

            thisItem.m_knrect.left = getObjLeft(mobjContent);
            thisItem.m_knrect.top = getObjTop(mobjContent);
        }
        if (left == -1 && pointed && m_PointerDirection == 0) {
            //			thisItem.m_knrect.left=_ax;//m_Object.style.pixelLeft;
            //			thisItem.m_knrect.top=_ay;//m_Object.style.pixelTop;
            //alert("bubborék valós0 = "+this.m_knrect.left+","+this.m_knrect.top+",");
            setpos = false;

        }
        if (!pointed) {
            if (m_bWidth) setpos = false;
            else setpos = true;
            if (thisItem.m_knrect.left) {
                //alert("bubborék valós2 = "+this.m_knrect.left+","+this.m_knrect.top+",");
                //mobjContent.style.pixelLeft=thisItem.m_knrect.left;
                //mobjContent.style.pixelTop=thisItem.m_knrect.top;

                mobjContent.style.left = thisItem.m_knrect.left + "px";
                mobjContent.style.top = thisItem.m_knrect.top + "px";
            }
        }
        if (pointed) {
            setpos = false;
            if (mobjContent && m_PointerDirection > 0) {
                abubbv02_Pointer = m_PointerDirection;

                mobjContent.style.pixelWidth = m_bWidth - 28;
                mobjContent.style.pixelHeight = m_bHeight - 41;
                if (m_bWidth) mobjContent.style.width = (m_bWidth - 28) + 'px';
                mobjContent.style.height = '';
                if (!thisItem.m_bFFClearHeight && mobjContent.clientHeight < (m_bHeight - 41)) mobjContent.style.height = (m_bHeight - 41) + 'px';

                var pointerdir = 0;
                var inScreen = false;
                while (!inScreen) {
                    if (abubbv02_Pointer == BUBB07_TOPLEFT) {
                        //alert("TopLeft");

                        GetBubble("bubbTLp", abubbv02_bubbcolor);
                        contentLeft = sx + m_PointerXpos - 4;
                        contentTop = sy + m_PointerYpos;
                        // place the pointer

                        //						mobjPointer.style.pixelTop = contentTop;
                        //						mobjPointer.style.pixelLeft = contentLeft;

                        mobjPointer.style.left = contentLeft + "px";
                        mobjPointer.style.top = contentTop + "px";

                        // place the bubble over top of pointer

                        //						mobjBubble.style.pixelLeft = contentLeft - leftPadding;
                        //						mobjBubble.style.pixelTop=contentTop + 38;

                        mobjBubble.style.left = Number(contentLeft - leftPadding) + "px";
                        mobjBubble.style.top = Number(contentTop + 38) + "px";

                        // place the content in the bubble

                        //						mobjContent.style.pixelLeft = contentLeft;
                        //						mobjContent.style.pixelTop = contentTop + 37 + topPadding;

                        mobjContent.style.left = contentLeft + "px";
                        mobjContent.style.top = Number(contentTop + 37 + topPadding) + "px";

                        mobjBubble.style.zIndex = 2
                        mobjContent.style.zIndex = 3
                        mobjPointer.style.zIndex = 4
                    }

                    if (abubbv02_Pointer == BUBB07_TOPRIGHT) {
                        //alert("TopRight");

                        GetBubble("bubbTRp", abubbv02_bubbcolor);
                        contentLeft = sx + m_PointerXpos - 10;
                        contentTop = sy + m_PointerYpos;
                        // place the pointer

                        //						mobjPointer.style.pixelTop = contentTop;
                        //						mobjPointer.style.pixelLeft = contentLeft - 5;

                        mobjPointer.style.left = Number(contentLeft - 5) + "px";
                        mobjPointer.style.top = contentTop + "px";

                        // place the bubble over top of pointer

                        //						mobjBubble.style.pixelLeft = (contentLeft+ leftPadding + rightPadding) - mobjBubble.clientWidth;
                        //						mobjBubble.style.pixelTop=contentTop + 38;

                        mobjBubble.style.left = Number((contentLeft + leftPadding + rightPadding) - mobjBubble.clientWidth) + "px";
                        mobjBubble.style.top = Number(contentTop + 38) + "px";

                        // place the content in the bubble

                        //						mobjContent.style.pixelLeft = (contentLeft+ leftPadding + rightPadding) - mobjBubble.clientWidth + leftPadding;
                        //						mobjContent.style.pixelTop = contentTop + 37 + topPadding;

                        mobjContent.style.left = Number((contentLeft + leftPadding + rightPadding) - mobjBubble.clientWidth + leftPadding) + "px";
                        mobjContent.style.top = Number(contentTop + 37 + topPadding) + "px";

                        mobjBubble.style.zIndex = 2;
                        mobjContent.style.zIndex = 3;
                        mobjPointer.style.zIndex = 4;
                    }

                    if (abubbv02_Pointer == BUBB07_BOTTOMRIGHT) {
                        //alert("BottomRight");
                        GetBubble("bubbBRp", abubbv02_bubbcolor);
                        contentLeft = sx + m_PointerXpos - 10;
                        contentTop = sy + m_PointerYpos - 41;
                        //contentTop = top-41;
                        // place the pointer

                        //						mobjPointer.style.pixelTop = contentTop;
                        //						mobjPointer.style.pixelLeft = contentLeft - 5;

                        mobjPointer.style.left = Number(contentLeft - 5) + "px";
                        mobjPointer.style.top = contentTop + "px";

                        // place the bubble over top of pointer

                        //						mobjBubble.style.pixelLeft = (contentLeft+ leftPadding + rightPadding) - mobjBubble.clientWidth;
                        //						mobjBubble.style.pixelTop=contentTop - mobjBubble.clientHeight + 3;

                        mobjBubble.style.left = Number((contentLeft + leftPadding + rightPadding) - mobjBubble.clientWidth) + "px";
                        mobjBubble.style.top = Number(contentTop - mobjBubble.clientHeight + 3) + "px";

                        // place the content in the bubble

                        //						mobjContent.style.pixelLeft = (contentLeft+ leftPadding + rightPadding) - mobjBubble.clientWidth + leftPadding;
                        //						mobjContent.style.pixelTop = contentTop - mobjBubble.clientHeight + 2 + topPadding;

                        mobjContent.style.left = Number((contentLeft + leftPadding + rightPadding) - mobjBubble.clientWidth + leftPadding) + "px";
                        mobjContent.style.top = Number(contentTop - mobjBubble.clientHeight + 2 + topPadding) + "px";

                        mobjBubble.style.zIndex = 2;
                        mobjContent.style.zIndex = 3;
                        mobjPointer.style.zIndex = 4;
                    }

                    if (abubbv02_Pointer == BUBB07_BOTTOMLEFT) {
                        //alert("BottomRight");
                        GetBubble("bubbBLp", abubbv02_bubbcolor);
                        contentLeft = sx + m_PointerXpos - 4;
                        contentTop = sy + m_PointerYpos - 41;
                        //alert("h=" + h + "\nObject Height = " + m_Object.clientHeight);
                        //contentTop = top - 41;

                        //						mobjPointer.style.pixelTop = contentTop;
                        //						mobjPointer.style.pixelLeft = contentLeft;

                        mobjPointer.style.left = contentLeft + "px";
                        mobjPointer.style.top = contentTop + "px";

                        // place the bubble over top of pointer

                        //						mobjBubble.style.pixelLeft = contentLeft - leftPadding;
                        //						mobjBubble.style.pixelTop=contentTop - mobjBubble.clientHeight + 3;

                        mobjBubble.style.left = Number(contentLeft - leftPadding) + "px";
                        mobjBubble.style.top = Number(contentTop - mobjBubble.clientHeight + 3) + "px";

                        // place the content in the bubble

                        //						mobjContent.style.pixelLeft = contentLeft;
                        //						mobjContent.style.pixelTop = contentTop - mobjBubble.clientHeight + 2 + topPadding;

                        mobjContent.style.left = contentLeft + "px";
                        mobjContent.style.top = Number(contentTop - mobjBubble.clientHeight + 2 + topPadding) + "px";

                        mobjBubble.style.zIndex = 2;
                        mobjContent.style.zIndex = 3;
                        mobjPointer.style.zIndex = 4;
                    }

                    if (abubbv02_Pointer == BUBB07_LEFTTOP) {
                        //alert("TopLeft");

                        GetBubble("bubbLTp", abubbv02_bubbcolor);
                        contentLeft = sx + m_PointerXpos;
                        contentTop = sy + m_PointerYpos - 3;
                        // place the pointer

                        //						mobjPointer.style.pixelTop = contentTop;
                        //						mobjPointer.style.pixelLeft = contentLeft;

                        mobjPointer.style.left = contentLeft + "px";
                        mobjPointer.style.top = contentTop + "px";

                        // place the bubble over top of pointer

                        //						mobjBubble.style.pixelLeft = contentLeft - leftPadding + 52;
                        //						mobjBubble.style.pixelTop=contentTop - 15;

                        mobjBubble.style.left = Number(contentLeft - leftPadding + 52) + "px";
                        mobjBubble.style.top = Number(contentTop - 15) + "px";

                        // place the content in the bubble

                        //						mobjContent.style.pixelLeft = contentLeft + 52;
                        //						mobjContent.style.pixelTop = contentTop + topPadding - 16;

                        mobjContent.style.left = Number(contentLeft + 52) + "px";
                        mobjContent.style.top = Number(contentTop + topPadding - 16) + "px";

                        mobjBubble.style.zIndex = 2;
                        mobjContent.style.zIndex = 3;
                        mobjPointer.style.zIndex = 4;
                    }

                    if (abubbv02_Pointer == BUBB07_RIGHTTOP) {
                        //alert("TopRight");

                        GetBubble("bubbRTp", abubbv02_bubbcolor);
                        contentLeft = sx + m_PointerXpos - 41;
                        contentTop = sy + m_PointerYpos - 3;
                        // place the pointer

                        //						mobjPointer.style.pixelTop = contentTop;
                        //						mobjPointer.style.pixelLeft = contentLeft;

                        mobjPointer.style.left = contentLeft + "px";
                        mobjPointer.style.top = contentTop + "px";

                        // place the bubble over top of pointer

                        //						mobjBubble.style.pixelLeft = (contentLeft - leftPadding) - mobjBubble.clientWidth + 17;
                        //						mobjBubble.style.pixelTop=contentTop - 15;

                        mobjBubble.style.left = Number((contentLeft - leftPadding) - mobjBubble.clientWidth + 17) + "px";
                        mobjBubble.style.top = Number(contentTop - 15) + "px";

                        // place the content in the bubble

                        //						mobjContent.style.pixelLeft = (contentLeft - leftPadding) - mobjBubble.clientWidth + leftPadding + 17;
                        //						mobjContent.style.pixelTop = contentTop + topPadding - 16;

                        mobjContent.style.left = Number((contentLeft - leftPadding) - mobjBubble.clientWidth + leftPadding + 17) + "px";
                        mobjContent.style.top = Number(contentTop + topPadding - 16) + "px";

                        mobjBubble.style.zIndex = 2;
                        mobjContent.style.zIndex = 3;
                        mobjPointer.style.zIndex = 4;
                    }

                    if (abubbv02_Pointer == BUBB07_RIGHTBOTTOM) {
                        //alert("BottomRight");
                        GetBubble("bubbRBp", abubbv02_bubbcolor);
                        contentLeft = sx + m_PointerXpos - 41;
                        contentTop = sy + m_PointerYpos - 15;
                        // place the pointer

                        //						mobjPointer.style.pixelTop = contentTop;
                        //						mobjPointer.style.pixelLeft = contentLeft;

                        mobjPointer.style.left = contentLeft + "px";
                        mobjPointer.style.top = contentTop + "px";

                        // place the bubble over top of pointer

                        //						mobjBubble.style.pixelLeft = (contentLeft - leftPadding) - mobjBubble.clientWidth + 17;
                        //						mobjBubble.style.pixelTop=contentTop - mobjBubble.clientHeight + 33;

                        mobjBubble.style.left = Number((contentLeft - leftPadding) - mobjBubble.clientWidth + 17) + "px";
                        mobjBubble.style.top = Number(contentTop - mobjBubble.clientHeight + 33) + "px";

                        // place the content in the bubble

                        //						mobjContent.style.pixelLeft = (contentLeft - leftPadding) - mobjBubble.clientWidth + leftPadding + 17;
                        //						mobjContent.style.pixelTop = contentTop - mobjBubble.clientHeight + 32 + topPadding;

                        mobjContent.style.left = Number((contentLeft - leftPadding) - mobjBubble.clientWidth + leftPadding + 17) + "px";
                        mobjContent.style.top = Number(contentTop - mobjBubble.clientHeight + 32 + topPadding) + "px";

                        mobjBubble.style.zIndex = 2;
                        mobjContent.style.zIndex = 3;
                        mobjPointer.style.zIndex = 4;
                    }

                    if (abubbv02_Pointer == BUBB07_LEFTBOTTOM) {
                        //alert("BottomRight");
                        GetBubble("bubbLBp", abubbv02_bubbcolor);
                        contentLeft = sx + m_PointerXpos;
                        contentTop = sy + m_PointerYpos - 15;
                        //alert("h=" + h + "\nObject Height = " + m_Object.clientHeight);
                        //contentTop = top;

                        //						mobjPointer.style.pixelTop = contentTop;
                        //						mobjPointer.style.pixelLeft = contentLeft;

                        mobjPointer.style.left = contentLeft + "px";
                        mobjPointer.style.top = contentTop + "px";

                        // place the bubble over top of pointer

                        //						mobjBubble.style.pixelLeft = contentLeft - leftPadding + 52;
                        //						mobjBubble.style.pixelTop=contentTop - mobjBubble.clientHeight + 33;

                        mobjBubble.style.left = Number(contentLeft - leftPadding + 52) + "px";
                        mobjBubble.style.top = Number(contentTop - mobjBubble.clientHeight + 33) + "px";

                        // place the content in the bubble

                        //						mobjContent.style.pixelLeft = contentLeft + 52;
                        //						mobjContent.style.pixelTop = contentTop - mobjBubble.clientHeight + 32 + topPadding;

                        mobjContent.style.left = Number(contentLeft + 52) + "px";
                        mobjContent.style.top = Number(contentTop - mobjBubble.clientHeight + 32 + topPadding) + "px";

                        mobjBubble.style.zIndex = 2;
                        mobjContent.style.zIndex = 3;
                        mobjPointer.style.zIndex = 4;
                    }
                    if (abubbv02_Pointer == 9) {
                        //alert("BottomRight");
                        GetBubble("bubbLBp", abubbv02_bubbcolor);
                        m_PointerXpos = getUniWidth(sScreen) / 2;
                        m_PointerYpos = getUniHeight(sScreen) / 2;
                        contentLeft = sx + m_PointerXpos;
                        contentTop = sy + m_PointerYpos - 15;

                        mobjPointer.style.left = contentLeft + "px";
                        mobjPointer.style.top = contentTop + "px";


                        mobjBubble.style.left = Number(contentLeft - leftPadding + 52) + "px";
                        mobjBubble.style.top = Number(contentTop - mobjBubble.clientHeight + 33) + "px";


                        mobjContent.style.left = Number(contentLeft + 52) + "px";
                        mobjContent.style.top = Number(contentTop - mobjBubble.clientHeight + 32 + topPadding) + "px";

                        mobjBubble.style.zIndex = 2;
                        mobjContent.style.zIndex = 3;
                        mobjPointer.style.zIndex = 4;
                        pointed = false;

                    }
                    //					if(mobjBubble.style.pixelTop - sy < 0 || mobjBubble.style.pixelTop - sy + mobjBubble.clientHeight > sScreen.style.pixelHeight ||
                    //						mobjBubble.style.pixelLeft - sx < 0 ||  mobjBubble.style.pixelLeft - sx + mobjBubble.clientWidth > sScreen.style.pixelWidth)
                    if
					(
						getObjTop(mobjBubble) - sy < 0 ||
						getObjTop(mobjBubble) - sy + getClientHeight(mobjBubble) > getUniHeight(sScreen) ||
						getObjLeft(mobjBubble) - sx < 0 ||
						getObjLeft(mobjBubble) - sx + getClientWidth(mobjBubble) > getUniWidth(sScreen)
					) {
                        pointerdir++;
                        abubbv02_Pointer = pointerdir;
                        inScreen = false;
                        switch (abubbv02_Pointer) {
                            case 1:
                                m_PointerXpos = right - sx;
                                m_PointerYpos = top - sy;
                                break;
                            case 2:
                                m_PointerXpos = left - sx;
                                m_PointerYpos = top - sy;
                                break;
                            case 3:
                                m_PointerXpos = right - sx;
                                m_PointerYpos = bottom - sy;
                                break;
                            case 4:
                                m_PointerXpos = left - sx;
                                m_PointerYpos = bottom - sy;
                                break;
                            case 5:
                                m_PointerXpos = right - sx;
                                m_PointerYpos = top - sy;
                                break;
                            case 6:
                                m_PointerXpos = left - sx;
                                m_PointerYpos = top - sy;
                                break;
                            case 7:
                                m_PointerXpos = right - sx;
                                m_PointerYpos = bottom - sy;
                                break;
                            case 8:
                                m_PointerXpos = left - sx;
                                m_PointerYpos = bottom - sy;
                                break;
                            case 9:
                                //								abubbv02_Pointer = BUBB07_TOPLEFT;
                                m_PointerXpos = getUniWidth(sScreen) / 2;
                                m_PointerYpos = getUniHeight(sScreen) / 2;
                                pointed = false;
                                inScreen = true;
                                break;
                        }
                    }
                    else {
                        thisItem.m_bFFClearHeight = false;
                        inScreen = true;
                    }
                    m_PointerDirection = abubbv02_Pointer;
                    thisItem.lastbubbstyle = abubbv02_Pointer;
                }
            }
        }
        if (!pointed) {
            thisItem.m_bMoveDefPos = false;

            brect = new JSRect();

            //			brect.left = mobjContent.style.pixelLeft - leftPadding;
            //			brect.top = mobjContent.style.pixelTop - topPadding;
            //			brect.right = mobjContent.style.pixelLeft + w + rightPadding;
            //			brect.bottom = mobjContent.style.pixelTop + h + bottomPadding;

            brect.left = getObjLeft(mobjContent) - leftPadding;
            brect.top = getObjTop(mobjContent) - topPadding;
            brect.right = getObjLeft(mobjContent) + w + rightPadding;
            brect.bottom = getObjTop(mobjContent) + h + bottomPadding;

            if (m_bWidth) mobjContent.style.pixelWidth = m_bWidth - 28;
            mobjContent.style.pixelHeight = m_bHeight - 41;
            if (m_bWidth) mobjContent.style.width = (m_bWidth - 28) + 'px';
            mobjContent.style.height = '';
            if (!thisItem.m_bFFClearHeight && mobjContent.clientHeight < (m_bHeight - 41)) mobjContent.style.height = (m_bHeight - 41) + 'px';

            setBubbleWidthToNowrapElements('getNode:NOBR', 'size:maxWidth');

            if (m_PointerXpos != 0) {
                mobjContent.style.pixelWidth = m_bWidth - 28;
                mobjContent.style.pixelHeight = m_bHeight - 41;
                if (m_bWidth) mobjContent.style.width = (m_bWidth - 28) + 'px';
                mobjContent.style.height = '';
                if (!thisItem.m_bFFClearHeight && mobjContent.clientHeight < (m_bHeight - 41)) {
                    mobjContent.style.height = (m_bHeight - 41) + 'px';
                    thisItem.m_bFFClearHeight = false;
                }
            }

            GetBubble("bubbNp", abubbv02_bubbcolor);
            abubbv02_Pointer = BUBB07_NOPOINTER;

            contentLeft = sx + m_PointerXpos - (mobjBubble.clientWidth / 2);
            contentTop = sy + m_PointerYpos - (mobjBubble.clientHeight / 2);
            //-------------Bubble Out--------------------------------------------------
            if (m_PointerXpos == 0) {
                contentLeft = brect.left;
                contentTop = brect.top;
            }
            //-------------------------------------------------------------------------
            //contentLeft = brect.left;
            //contentTop = brect.top;
            // check bubble position
            if ((brect.right > cw) && (m_PointerXpos == 0)) {
                contentLeft = cw - mobjContent.clientWidth - 10 - leftPadding - rightPadding;
            }
            if ((brect.bottom > ch) && (m_PointerXpos == 0)) {
                contentTop = ch - mobjContent.clientHeight - 10 - topPadding - bottomPadding;
            }

            // +++ check default position flag
            if ((kmbdefpos) && (m_PointerXpos == 0)) {
                // +++ set deafult position
                contentLeft = (cw - mobjContent.clientWidth - 10 - leftPadding - rightPadding);
                contentTop = ((ch / 2) - mobjContent.clientHeight / 2) - topPadding - bottomPadding;
                // +++ actualize bubble position
                brect.left = contentLeft;
                brect.top = contentTop;
            }
            //alert('contentLeft='+contentLeft+'; sx='+sx);
            if (contentLeft - sx < 0) contentLeft = 0 + sx;
            if (contentLeft - sx + mobjBubble.clientWidth > getUniWidth(sScreen)) contentLeft = getUniWidth(sScreen) - mobjBubble.clientWidth + sx;
            if (contentTop - sy < 0) contentTop = 0 + sy;
            if (contentTop - sy + mobjBubble.clientHeight > getUniHeight(sScreen)) contentTop = getUniHeight(sScreen) - mobjBubble.clientHeight + sy;

            // place the bubble over top of pointer

            //			mobjBubble.style.pixelLeft = contentLeft;
            //			mobjBubble.style.pixelTop=contentTop;

            mobjBubble.style.left = contentLeft + "px";
            mobjBubble.style.top = contentTop + "px";

            // place the content in the bubble

            //			mobjContent.style.pixelLeft = contentLeft + leftPadding;
            //			mobjContent.style.pixelTop = contentTop + topPadding;

            mobjContent.style.left = Number(contentLeft + leftPadding) + "px";
            mobjContent.style.top = Number(contentTop + topPadding) + "px";

            mobjBubble.style.zIndex = 2
            mobjContent.style.zIndex = 3
            if
			(
				getObjTop(mobjBubble) < top &&
				getObjTop(mobjBubble) + getClientHeight(mobjBubble) > bottom &&
				getObjLeft(mobjBubble) < left &&
				getObjLeft(mobjBubble) + getClientWidth(mobjBubble) > right
			) {
                if (left > (cw - right)) {
                    contentLeft = left - getClientWidth(mobjBubble) - 10;
                    if (contentLeft - sx < 0) contentLeft = 0;
                }
                else {
                    contentLeft = right + 10;
                    if (contentLeft - sx + mobjBubble.clientWidth > getUniWidth(sScreen)) contentLeft = sx + getUniWidth(sScreen) - mobjBubble.clientWidth;
                }
                mobjBubble.style.left = contentLeft + "px";
                mobjContent.style.left = Number(contentLeft + leftPadding) + "px";
            }
        }

        if (mobjContent && left == -1 && right == -1 && top == -1 && bottom == -1 && pointed && m_PointerDirection == 0) {
            //			if(m_bWidth && m_PointerXpos > 0) mobjContent.style.width = m_bWidth - 28;
            //			if(m_bHeight && m_PointerXpos > 0) mobjContent.style.height = m_bHeight - 52;
            if (m_bWidth) mobjContent.style.pixelWidth = m_bWidth - 28;
            if (m_bHeight) mobjContent.style.pixelHeight = m_bHeight - 41;
            if (m_bWidth) mobjContent.style.width = (m_bWidth - 28) + 'px';
            mobjContent.style.height = '';
            if (!thisItem.m_bFFClearHeight && mobjContent.clientHeight < (m_bHeight - 41)) {
                mobjContent.style.height = (m_bHeight - 41) + 'px';
                thisItem.m_bFFClearHeight = false;
            }

            mobjContent.style.width = queryContentWidth()

            GetBubble("bubbNp", abubbv02_bubbcolor);
            abubbv02_Pointer = BUBB07_NOPOINTER;

            cw = document.body.clientWidth;
            ch = document.body.clientHeight;
            if (m_PointerXpos > 0 && m_PointerYpos > 0) {
                contentLeft = (sx + m_PointerXpos - mobjBubble.clientWidth / 2); //right;//-(right-left);
                contentTop = sy + m_PointerYpos - mobjBubble.clientHeight / 2;
            }
            else {
                contentLeft = ((cw / 2) - mobjBubble.clientWidth / 2); //right;//-(right-left);
                contentTop = (ch / 2) - mobjBubble.clientHeight / 2;
            }
            //if(abubbv02_Pointer!=BUBB07_NOPOINTER) 
            //{
            //this.SetColor(abubbv02_bubbcolor);
            //}

            if (contentLeft - sx < 0) contentLeft = 0 + sx;
            if (contentLeft - sx + mobjBubble.clientWidth > getUniWidth(sScreen)) contentLeft = getUniWidth(sScreen) - mobjBubble.clientWidth + sx;
            if (contentTop - sy < 0) contentTop = 0 + sy;
            if (contentTop - sy + mobjBubble.clientHeight > getUniHeight(sScreen)) contentTop = getUniHeight(sScreen) - mobjBubble.clientHeight + sy;

            //			mobjBubble.style.pixelLeft = contentLeft;
            //			mobjBubble.style.pixelTop = contentTop;

            mobjBubble.style.left = contentLeft + "px";
            mobjBubble.style.top = contentTop + "px";

            // place the content in the bubble

            //			mobjContent.style.pixelLeft = contentLeft + leftPadding;
            //			mobjContent.style.pixelTop = contentTop + topPadding;

            mobjContent.style.left = Number(contentLeft + leftPadding) + "px";
            mobjContent.style.top = Number(contentTop + topPadding) + "px";

            mobjBubble.style.zIndex = 2;
            mobjContent.style.zIndex = 3;
        }
    }
}

var imgCntr = 0;

function buildBubble(color) {

    var bubble = "";
    var bubID;

    var bubbc;
    bubbc = convert(String(color), 10, 16);
    while (bubbc.length < 6) bubbc = "0" + bubbc;
    bubbc = "#" + bubbc;

    bubID = "bubble_" + color;

    bubble += "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:100; top:100;zIndex:2;visibility:hidden'>";

    bubble += "<table ID='BubbleTable' width='266' border='0' cellspacing='0' cellpadding='0'>";
    bubble += "<tr>"
    bubble += "<td valign='top'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[3] + "' width='14' height='27' border='0' alt=''></td>";
    bubble += "<td valign='top' bgcolor='#003166' width='100%' background=" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[4] + ">";
    //	bubble += "<div style='position:absolute;'>";
    bubble += "<table border='0' cellspacing='0' cellpadding='0' height='27' width='100%'>";
    bubble += "<tr>"
    bubble += "<td id='bubb_cap' valign='bottom' nowrap><a style='cursor:default' id='m_Caption' class='CurvedBoxText'></a></td>";
    bubble += "<td id='m_StaticCaption' valign='bottom' width='100%' align='right' valign='bottom'><div id='blink' style='VISIBILITY: visible'><a id='m_ActionText' style='color:#ccffff; cursor:pointer; text-decoration:underline;' onclick='setAOpener(event)' class='CurvedBoxNav'></a></div></td>";
    bubble += "<td>&nbsp;&nbsp;</td>";
    bubble += "</tr>";
    bubble += "<tr height='3'>";
    bubble += "<td colspan='3'></td>";
    bubble += "</tr>";
    bubble += "</table>";
    //	bubble += "</div>";
    //	bubble += "<img src='"+imagesArr["c_" + abubbv02_bubbcolor].imageNames[4]+"' width='100%' height='27' border='0' alt=''>";
    bubble += "</td>";
    bubble += "<td valign='top'><div id='closebtn_" + color + "' style='position:relative'><div><img id='img2' name='img2' src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[1] + "' style='display:block' width='32' height='27' border='0'><img id='img2o' name='img2o' src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[2] + "' style='display:none' width='32' height='27' border='0'></div><div style='position:absolute; left:3px; top:7px'><a onclick='BubbleClose();return false' onMouseMove='BubbleimgOn(\"img2\",\"img2o\")' onMouseOut='BubbleimgOff(\"img2\",\"img2o\")'><img href='#' alt='" + R_bubble_closeondemand + "' id='imghandler' name='imghandler' src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[0] + "' style='display:block' width='23' height='20' border='0'></a></div></div></td>";
    bubble += "</tr>";
    bubble += "<tr>";
    bubble += "<td><img height='100%' width='14px' src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[5] + "'></td>";
    bubble += "<td ID='BubbleSides' bgcolor='" + bubbc + "' height='116'>&nbsp;</td>";
    bubble += "<td><img height='100%' width='32px' src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[6] + "'></td>";
    bubble += "</tr>";
    bubble += "<tr>"
    bubble += "<td valign='top'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[7] + "' width='14' height='14' border='0' alt=''></td>";
    bubble += "<td valign='top' width='100%'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[8] + "' width='100%' height='14px'></td>";
    bubble += "<td valign='top'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[9] + "' width='32' height='14' border='0' alt=''></td>";
    bubble += "</tr>";
    bubble += "</table>"
    bubble += "</div>"

    document.write(bubble);

    //<!-- anchor upper left -->
    bubID = "ulPointer_" + color;
    ul = "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:114; top:62;zIndex:2;visibility:hidden' onMouseDown='AnchorMouseDown(); return false' onMouseUp='AnchorMouseUp(); return false'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[10] + "' width='18' height='41' border='0' alt=''></div>";
    //<!-- anchor upper right -->
    bubID = "urPointer_" + color;
    ur = "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:334; top:62;zIndex:2;visibility:hidden' onMouseDown='AnchorMouseDown(); return false' onMouseUp='AnchorMouseUp(); return false'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[11] + "' width='18' height='41' border='0' alt=''></div>";
    //<!-- anchor left high -->
    bubID = "lhPointer_" + color;
    lh = "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:62; top:114;zIndex:2;visibility:hidden' onMouseDown='AnchorMouseDown(); return false' onMouseUp='AnchorMouseUp(); return false'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[12] + "' width='41' height='18' border='0' alt=''></div>";
    //<!-- anchor left low -->
    bubID = "llPointer_" + color;
    ll = "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:62; top:225;zIndex:2;visibility:hidden' onMouseDown='AnchorMouseDown(); return false' onMouseUp='AnchorMouseUp(); return false'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[13] + "' width='41' height='18' border='0' alt=''></div>";
    //<!-- anchor right high -->
    bubID = "rhPointer_" + color;
    rh = "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:363; top:114;zIndex:2;visibility:hidden' onMouseDown='AnchorMouseDown(); return false' onMouseUp='AnchorMouseUp(); return false'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[14] + "' width='41' height='18' border='0' alt=''></div>";
    //<!-- anchor right low -->
    bubID = "rlPointer_" + color;
    rl = "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:363; top:225;zIndex:2;visibility:hidden' onMouseDown='AnchorMouseDown(); return false' onMouseUp='AnchorMouseUp(); return false'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[15] + "' width='41' height='18' border='0' alt=''></div>";
    //<!-- anchor lower left -->
    bubID = "btPointer_" + color;
    bt = "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:114; top:254;zIndex:2;visibility:hidden' onMouseDown='AnchorMouseDown(); return false' onMouseUp='AnchorMouseUp(); return false'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[16] + "' width='18' height='41' border='0' alt=''></div>";
    //<!-- anchor lower right -->
    bubID = "brPointer_" + color;
    br = "<div id='" + bubID + "' name='" + bubID + "' style='position:absolute; left:334; top:254;zIndex:2;visibility:hidden' onMouseDown='AnchorMouseDown(); return false' onMouseUp='AnchorMouseUp(); return false'><img src='" + imagesArr["c_" + abubbv02_bubbcolor].imageNames[17] + "' width='18' height='41' border='0' alt=''></div>";

    document.write(ul);
    document.write(ur);
    document.write(lh);
    document.write(ll);
    document.write(rh);
    document.write(rl);
    document.write(bt);
    document.write(br);

}

function LoadAllBubbles() {
    for (var c = 0; c < imagesXref.length; c++) {
        var color = imagesArr[imagesXref[c]].color;
        abubbv02_bubbcolor = color;
        buildBubble(color);
    }

    document.write("<div id='content' name='content' style='position:absolute; left:114; top:138;zIndex:10;visibility:hidden'></div>");

    objDoneTypingA = document.createElement("A");
    objDoneTypingA.id = "bbdta";
    objDoneTypingA.onclick = DTOnClick;
    objDoneTypingA.onmouseover = DTOnMouseOver;
    objDoneTypingA.onmouseout = DTOnMouseOut;

    objDoneTypingImg0 = document.createElement("img");
    objDoneTypingImg0.id = "bbdt0";
    objDoneTypingImg0.style.display = "block"
    objDoneTypingImg0.src = m_BubblePath + template_knowit_dt_img0;

    objDoneTypingImg1 = document.createElement("img");
    objDoneTypingImg1.id = "bbdt1";
    objDoneTypingImg0.style.display = "none"
    objDoneTypingImg1.src = m_BubblePath + template_knowit_dt_img1;

    if (playMode == "K") {
        // know it needs to have additional images

        // icon imape
        objIcon02Img = document.createElement("img");
        objIcon02Img.src = m_BubblePath + template_knowit_icon02;

        // yes button images	
        objYesA = document.createElement("A");
        objYesA.id = "bbyesa";
        objYesA.onclick = YesOnClick;
        objYesA.onmouseover = YesOnMouseOver;
        objYesA.onmouseout = YesOnMouseOut;

        objYesImg0 = document.createElement("img");
        objYesImg0.id = "bbyes0";
        objYesImg0.style.display = "inline"
        objYesImg0.src = m_BubblePath + template_knowit_yes_img0;
        objYesImg0.style.marginTop = "10px";

        objYesImg1 = document.createElement("img");
        objYesImg1.id = "bbyes1";
        objYesImg1.style.display = "none"
        objYesImg1.src = m_BubblePath + template_knowit_yes_img1;
        objYesImg1.style.marginTop = "10px";

        // no button images	
        objNoA = document.createElement("A");
        objNoA.id = "bbnoa";
        objNoA.onclick = NoOnClick;
        objNoA.onmouseover = NoOnMouseOver;
        objNoA.onmouseout = NoOnMouseOut;

        objNoImg0 = document.createElement("img");
        objNoImg0.id = "bbno0";
        objNoImg0.style.display = "inline"
        objNoImg0.src = m_BubblePath + template_knowit_no_img0;
        objNoImg0.style.marginTop = "10px"

        objNoImg1 = document.createElement("img");
        objNoImg1.id = "bbno1";
        objNoImg1.style.display = "none"
        objNoImg1.src = m_BubblePath + template_knowit_no_img1;
        objNoImg1.style.marginTop = "10px"
    }

}

function GetBubble(type, color) {
    //mobjBubble = document.all["bubble_" + color];
    mobjBubble = document.getElementById('bubble_' + color);
    //mobjBubble = document.getElementById('bubble_16777152');
    if (mblnShowPointer) {
        mblnShowPointer = true;
        switch (type) {
            case "bubbTLp":
                mobjPointer = document.getElementById("ulPointer_" + color);
                break;
            case "bubbTRp":
                mobjPointer = document.getElementById("urPointer_" + color);
                break;
            case "bubbBLp":
                mobjPointer = document.getElementById("btPointer_" + color);
                break;
            case "bubbBRp":
                mobjPointer = document.getElementById("brPointer_" + color);
                break;
            case "bubbLTp":
                mobjPointer = document.getElementById("lhPointer_" + color);
                break;
            case "bubbRTp":
                mobjPointer = document.getElementById("rhPointer_" + color);
                break;
            case "bubbLBp":
                mobjPointer = document.getElementById("llPointer_" + color);
                break;
            case "bubbRBp":
                mobjPointer = document.getElementById("rlPointer_" + color);
                break;
            case "bubbNp":
                mblnShowPointer = false;
        }
    }
    //mobjContent.style.backgroundColor = color;
    //mobjBubble.style.backgroundColor = color;

    //alert(mobjBubble.all["BubbleSides"]);
    //mobjBubble.all["BubbleSides"].height = mobjContent.clientHeight + topPadding + bottomPadding;
    //mobjBubble.all["BubbleSides"].height = mobjContent.clientHeight //+ bottomPadding;
    //document.getElementById('BubbleSides').height = mobjContent.clientHeight //+ bottomPadding;
    var cBS = getElementsByAttribute('id', 'BubbleSides');
    for (var i in cBS) {
        cBS[i].height = mobjContent.clientHeight;
    };

    //mobjBubble.all["BubbleTable"].width = mobjContent.clientWidth + leftPadding + rightPadding;
    //document.getElementById('BubbleTable').width = mobjContent.clientWidth + leftPadding + rightPadding;
    var cBT = getElementsByAttribute('id', 'BubbleTable');
    for (var i in cBT) {
        cBT[i].width = mobjContent.clientWidth + leftPadding + rightPadding;
    };

    load_buttons();
}

function setBubbleWidthToNowrapElements(getNode, getBy) {
    try {
        var getNode = getNode.split(':')[1];
        var cParts = mobjContent.getElementsByTagName('*');
        var KCmaxWidth = 0;

        //get left
        for (var i = 0; i < cParts.length; i++) {
            if (cParts[i].nodeName == getNode) {
                var nodeLeft = cParts[i].offsetLeft;
                break;
            }
        }

        //get by size
        if (getBy.indexOf('size') != -1) {
            for (var i = 0; i < cParts.length; i++) {
                if (cParts[i].nodeName == getNode) {
                    if (cParts[i].offsetWidth > KCmaxWidth) {
                        KCmaxWidth = cParts[i].offsetWidth;
                    }
                }
            }
            if (KCmaxWidth + nodeLeft > mobjContent.clientWidth) mobjContent.style.width = KCmaxWidth + nodeLeft + 'px';
        }

        //get by id
        if (getBy.indexOf('id') != -1) {
            var nodeId = getBy.split(':')[1];
            for (var i = 0; i < cParts.length; i++) {
                if (cParts[i].id == nodeId) {
                    mobjContent.style.width = cParts[i].offsetWidth + nodeLeft + 'px';
                    break;
                }
            }
        }
    } catch (e) { }
}

function queryContentWidth() {
    try {
        var cParts = mobjContent.getElementsByTagName('*');
        var KCmaxWidth = 0;

        //get left
        for (var i = 0; i < cParts.length; i++) {
            if (cParts[i].nodeName.toUpperCase() == 'P' || cParts[i].nodeName.toUpperCase() == 'NOBR' || cParts[i].nodeName.toUpperCase() == 'SPAN' || cParts[i].nodeName.toUpperCase() == 'DIV' || cParts[i].nodeName.toUpperCase() == 'TABLE') {
                var w = cParts[i].offsetWidth + cParts[i].offsetLeft;
                if (w > KCmaxWidth) KCmaxWidth = w;
            }
        }
        return KCmaxWidth;
    } catch (e) { }
}
