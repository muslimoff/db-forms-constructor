/*--
Copyright © 1998, 2009, Oracle and/or its affiliates.  All rights reserved.
--*/

////////////////// ODS functions ////////////////////////////////////////

var ODSTopicSession;
var ODSUrl = "../../img/track.odt";
//var ODSUrl="http://kpdev/ods/content/DHTML%20for%20Winword%20XP/images/track.odt";
var ODSVersion="ver=2";

var showOdsParameters=false;

function MyAlert(s)
{
	if (showOdsParameters)
		alert(s);
}

function ODSOpenEvGroup()
// call from every modes when topic playing starts
{
	if (ODTrack_Enabled==false)
		return;
	if (tutorialMode)
		return;
	var ODSNow=new Date();
	var s="";
	ODSTopicSession = ODSNow.valueOf();
	s=ODSUrl+"?"+ODSVersion+"&type=o&evgtype=t&evgroup="+ODSTopicSession;
	if (playMode=="P")
	{
    	s+="&topicid="+odsTopicID;
    	if (s.substr(0,6)=="../../")
    	{
    	    s=s.substr(4);
    	}
	}
	else
	{
    	s+="&topicid="+document.getElementById("ODSEvGroup").getAttribute("TOPICID");
	}
	s+="&mode="+playMode;
	MyAlert(s);
//	document.images.item("ODSEvGroup").src=s;
	var imgId = document.getElementById("ODSEvGroup");
	imgId.src = s;
}

function ODSCloseEvGroup()
// call from every modes when topic playing finishes
{
	if (ODTrack_Enabled==false)
		return;
	if (tutorialMode)
		return;
	var s=ODSUrl+"?"+ODSVersion+"&type=c&evgtype=t&evgroup="+ODSTopicSession;
	if (playMode=="P")
	{
    	s+="&topicid="+odsTopicID;
    	if (s.substr(0,6)=="../../")
    	{
    	    s=s.substr(4);
    	}
	}
	else
	{
    	s+="&topicid="+document.getElementById("ODSEvGroup").getAttribute("TOPICID");
	}
	s+="&mode="+playMode;
	MyAlert(s);
//	document.images.item("ODSEvGroup").src=s;
	var imgId = document.getElementById("ODSEvGroup");
	imgId.src = s;
}

function ODSFrameView(mode,frame)
// call from every modes when enter a frame
{
	if (ODTrack_Enabled==false)
		return;
	if (tutorialMode)
		return;
    if (playMode=="P")
        return;
	var s=ODSUrl+"?"+ODSVersion+"&type=t&evgroup="+ODSTopicSession;
	s+="&topicid="+document.getElementById("ODSFrameView").getAttribute("TOPICID");
	s+="&mode="+mode+"&frame="+frame;
	MyAlert(s);
	//document.images.item("ODSFrameView").src=s;
	var imgId = document.getElementById("ODSFrameView");
	imgId.src = s;
}

function ODSKnowitScore(score,passed)
// call from KnowIt mode when topic playing finishes
{
	if (ODTrack_Enabled==false)
		return;
	if (tutorialMode)
		return;
	if (playMode=="P")
	    return;
	var s=ODSUrl+"?"+ODSVersion+"&type=k&evgroup="+ODSTopicSession;
	s+="&topicid="+document.getElementById("ODSKnowitScore").getAttribute("TOPICID");
	s+="&score="+score+"&passed="+passed;
	MyAlert(s);
	//document.images.item("ODSKnowitScore").src=s;
	var imgId = document.getElementById("ODSKnowitScore");
	imgId.src = s;
}

////////////////// end of ODS functions /////////////////////////////////

/* export these lines to topic.htm & topicg.htm into end of body section

<IMG ID="ODSFrameView" WIDTH="1" HEIGHT="1" SRC="" TOPICID="_topic_id_">
<IMG ID="ODSKnowitScore" WIDTH="1" HEIGHT="1" SRC="" TOPICID="_topic_id_">
<IMG ID="ODSEvGroup" WIDTH="1" HEIGHT="1" SRC="" TOPICID="_topic_id_">

*/
