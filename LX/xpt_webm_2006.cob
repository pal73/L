CoB1P  applydef.htm�f  applyset.htm
:F  index.htmlH�  secure/banner.htm��  secure/banner.jsw@�-  secure/connset.htm�Pn  secure/connset.jsn��  secure/dissetup.htm� �  secure/footer.htm���  secure/gpio.htm�'��  secure/gpio.jsVd�  secure/hlist.htm�� secure/hlist.jsX�) secure/ltx_conf.htm
�, secure/menu.htm~,�> secure/menu.jsdk secure/netset.htm�f� secure/netset.js�!E� secure/serial.htm�3(� secure/serial.js��� secure/servset.htm!a secure/servset.js� x) secure/setuprec.dtdv ;* secure/setuprec.xmlL�* secure/smtpset.htm_�9 secure/smtpset.js�\E secure/smtptrig.htm_L] secure/smtptrig.js�w secure/subdef.htm��~ secure/unitinfo.dtdv �� secure/unitinfo.xml�� secure/welcome.htm!� secure/welcome.js~� secure/images/about.gif��� secure/images/home.gifb&� secure/images/ltrx_logo.gif�$�� secure/images/ltrx_style.cssT L� secure/images/spacer.gif"i �� secure/images/top_graphic_tile.gifL	� secure/images/XPortLogo.png�!U� secure/js/util.js�  secure/js/validate.js�1 secure/js/validatenetwork.js HTTP/1.0 200
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
<head>


<style type="text/css" screen="media">

</style>
</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table width=600 border=0>
  <tr>
    <td>
      <p class=datalabelcenter><br><br>

         <b>The unit will reboot in order for the factory defaults to be applied.<br>
         
	Please point the browser to the correct IP address and HTTP Port number<br>
	of the unit in order to continue using the web based configuration manager.</b><br>

      </p>
    </td>
  </tr>
</table>       

</body>
</html>
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
<head>


<style type="text/css" screen="media">

</style>
<script language="javascript">
<!--
var sTarget = "welcome.htm";
var mTarget;
var rebootTime = 13000;			// in milliseconds
var ip_changed = false;

// progress bar related variables.
var progressEnd = 12;		// number of span elements
var progressAt = progressEnd;
var progressInterval = 1000;	// in milliseconds
var progressColor = 'blue';
var progressTimer;

// function for handling the div based visibility of sections of html
function getStyleObject(objectId) {
  // checkW3C DOM, then MSIE 4, then NN 4.
  if(document.getElementById && document.getElementById(objectId)) {
	return document.getElementById(objectId).style;
  }
  else if (document.all && document.all(objectId)) {  
	return document.all(objectId).style;
  } 
  else if (document.layers && document.layers[objectId]) { 
	return document.layers[objectId];
  } else {
    return false;
  }
}

function progress_clear() {
   for (var i = 1; i <= progressEnd; i++) 
   {
	 styleObject = getStyleObject('p'+ i);
	 styleObject.backgroundColor = 'transparent';
   }
   progressAt = 0;
}

function progress_update() {
   progressAt++;
   if (progressAt > progressEnd) progress_clear(); 
   else 
   {
	  styleObject = getStyleObject('p' + progressAt); 
	  styleObject.backgroundColor = progressColor;
   }   
   progressTimer = setTimeout("progress_update()",progressInterval);
}

function progress_stop() {
	clearTimeout(progressTimer); 
	progress_clear();
}

function pageRefresh()
{
  progress_stop();
  parent.frames.leftmenu.location.href=mTarget;
  window.location.href = sTarget;
}

function dispMesg()
{
  var para = document.getElementById("dyn");
  var htmlText;
  //progress_stop();
  clearTimeout(progressTimer);

  htmlText = "<br><br><b>Network Connectivity settings have been modified. <br>";
  htmlText += "Please point the browser to the new IP address with the correct HTTP Server Port<br>";
  htmlText += "in order to continue using the web based configuration manager.</b><br>";

  para.innerHTML = htmlText;
}

function initPage()
{
  mTarget = parent.frames.leftmenu.location.href;
  nw_changed = parent.frames.leftmenu.nwinfo_changed();
  
  progress_update();

  //set timeout to refresh pages.
  if (!nw_changed)
    setTimeout("pageRefresh()", rebootTime);
  else
    setTimeout("dispMesg()", rebootTime);  
}
-->
</script>
       
</head>
 
<body text=#000000 bgcolor=#ffffff leftmargin=0 topmargin=0 marginwidth="0" marginheight="0" onload="initPage()">
<!-- this top enclosing table is used to fix nn4 background image tiling issues -->
<table width=600 border=0>
  <tr>
    <td colspan=3>
      <p class=datalabelcenter><br><br>

         <b>Please wait while the configuration is saved...<br>
         The unit will reboot in order for the settings to be applied.</b><br>

      </p>
    </td>
  </tr>
  <tr>
    <td colspan=3>&nbsp;</td>
  </tr>
  <tr>
    <td width=233></td>
    <td width=114>
      <div style="font-size:10pt;padding:2px;border:solid black 1px">
        <span id="p1">&nbsp;&nbsp;</span>
        <span id="p2">&nbsp;&nbsp;</span>
        <span id="p3">&nbsp;&nbsp;</span>
        <span id="p4">&nbsp;&nbsp;</span>
        <span id="p5">&nbsp;&nbsp;</span>
        <span id="p6">&nbsp;&nbsp;</span>
        <span id="p7">&nbsp;&nbsp;</span>
        <span id="p8">&nbsp;&nbsp;</span>
        <span id="p9">&nbsp;&nbsp;</span>
        <span id="p10">&nbsp;&nbsp;</span>
        <span id="p11">&nbsp;&nbsp;</span>
        <span id="p12">&nbsp;&nbsp;</span>
      </div>
    </td>
    <td width=233></td>
  </tr>
  <tr>
    <td colspan=3>&nbsp;</td>
  </tr>
  <tr>
    <td colspan=3>
      <p class=datalabelcenter id="dyn">  
      <!-- dynamic string gets inserted here.. -->
      </p>
    </td>   
  </tr>
</table>

</body>
</html>
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<noscript>
<meta http-equiv="refresh" content="1; URL=secure/ltx_conf.htm">
</noscript>
<script language="JavaScript">
<!--
var sTargetURL = "secure/ltx_conf.htm";
function doRedirect() {
  setTimeout("window.location.href = sTargetURL", 100);
}
-->
</script>
<script language="JavaScript1.1">
<!--
function doRedirect() {
  window.location.replace( sTargetURL );
}
doRedirect();
-->
</script>
</head>
<body onload="doRedirect()">
</body>
</html>
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
<head>

<link href="images/ltrx_style.css" type=text/css rel=stylesheet>
</head>
<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table cellSpacing=0 cellPadding=0 width=100% background=images/top_graphic_tile.gif border=0>
  <tbody>
	<tr>
	  <td>
		<table cellSpacing=0 cellPadding=0 width=600 height=67 background=images/spacer.gif border=0>
			<tbody>
				<tr>
				  <td>&nbsp;</td>

        <td><img width=193 height=48 src= "images/XPortLogo.png"   border=0></td> 

				  <td><img height=15 width=319 src="images/spacer.gif" border=0><br></td>

				   <td class=product valign=left width=231>
				     <!-- <img height=15 width=200 src="images/spacer.gif" border=0><br> -->

					 <a href="http://www.lantronix.com" target=lanweb><img width=231 height=67 src="images/ltrx_logo.gif" border=0></a><br>

                     <!--  <img height=15 width=200 src="images/spacer.gif" border=0><br> -->
                    </td>
	            </tr>
            </tbody>
        </table>
       </td>
    </tr>
  </tbody>
</table><!-- end top enclosing table -->
</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
var nnXmlDoc; // global var for navigating 
var xmlDoc;
// #define equivalents
var NUM_INFO = 2;

// fills in the setup records array from the XML document
function fillIn(xmldoc)
{
  var unitinfo, nodeList;
  var recdata = new Array(NUM_INFO);
  var i = 0;
  var j = 0;
  var adtab, rows;
  var cells;
    
  // fill in the values in the fields
  unitinfo = xmldoc.getElementsByTagName('UNITINFO').item(0);
 
  nodeList = unitinfo.getElementsByTagName('FW');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;   
  nodeList = unitinfo.getElementsByTagName('MAC');
  recdata[i] = nodeList.item(0).firstChild.nodeValue;
  recdata[i] = recdata[i].replace(/:/g, "-");
  
  adtab = document.getElementById("infotab");
  rows = adtab.rows;
  for (i = 0; i < 2; i++)
  {
    cells = rows[i].cells;
    for (j = 0; j < 1; j++)
      cells[j*2+1].innerHTML = recdata[i*1+j];
  }
     
} // fillIn

// event handler for Netscape - called when XML document is loaded
function documentLoaded(e) 
{
  fillIn(nnXmlDoc);
} // documentLoaded


//Function to convert xml file from String to Document, utility for chrome browser.
function StringToDoc(text) 
{
	var parser = new DOMParser();
	return parser.parseFromString(text, 'text/xml');
}

// called when web page is loaded in the browser
// determines browser type and loads XML in the appropriate manner						
function initPage()
{
    var agt=navigator.userAgent.toLowerCase();

    if (agt.indexOf("chrome") != -1)  //chrome
	{
          xmlDoc = new XMLHttpRequest();
		  if (xmlDoc.overrideMimeType)
		  {
		       xmlDoc.overrideMimeType ('text/xml');
		  }
		  xmlDoc.onreadystatechange = function ()
		  {
		       if ((xmlDoc.readyState == 3)  && (xmlDoc.status == 200))
			   {
			        fillIn (StringToDoc (xmlDoc.responseText));
			   }
		  }
		  xmlDoc.open ("GET", "/secure/unitinfo.xml", true, "", "");
		  xmlDoc.send (null);
		  return;
	}
	if (agt.indexOf("firefox") != -1) 	//Firefox & Netscape browsers returns firefox index.
	{  
         xmlDoc = new XMLHttpRequest();
         xmlDoc.onreadystatechange = function ()
         {
              if (xmlDoc.readyState == 4 && xmlDoc.status == 200 )
              {
                   fillIn(xmlDoc.responseXML);
              }
         }
		 xmlDoc.open("GET", "/secure/unitinfo.xml" ,true ,"","");                       
		 xmlDoc.send(null);
		 return;
    }

	if (agt.indexOf("safari") != -1)    //'Safari';
	{
		xmlDoc = new XMLHttpRequest();
		if (xmlDoc.overrideMimeType)
		{
		    xmlDoc.overrideMimeType ('text/xml');
		}
		xmlDoc.onreadystatechange = function ()
		{
		    if ((xmlDoc.readyState == 3)  && (xmlDoc.status == 200))
			{
			    fillIn (StringToDoc (xmlDoc.responseText));
			}
		}
		xmlDoc.open ("GET", "/secure/unitinfo.xml", true, "", "");
		xmlDoc.send (null);
		return;
	}
	if ((agt.indexOf("msie") != -1) || (agt.indexOf("gecko") != -1))	// 'Internet Explorer';
	{
		var ie_version= parseFloat(agt.substring(agt.indexOf("msie")+5));
		if ((ie_version >= 10) || (agt.indexOf("gecko") != -1))     // IE10 & IE11
		{
			xmlDoc = new XMLHttpRequest();
			if (xmlDoc.overrideMimeType)
			{
		       xmlDoc.overrideMimeType ('text/xml');
			}
			xmlDoc.onreadystatechange = function ()
			{
		       if ((xmlDoc.readyState == 3)  && (xmlDoc.status == 200))
				{
			        fillIn (StringToDoc (xmlDoc.responseText));
				}
			}
			xmlDoc.open ("GET", "/secure/unitinfo.xml", true, "", "");
			xmlDoc.send (null);
		}
		else
		{
			xmlDoc = document.getElementsByTagName('xml').item(0);
			fillIn(xmlDoc);
		}
		return;
	}

} // initPage

-->
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>

<LINK href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/validate.js"></script>
<script language="JavaScript" src="js/validatenetwork.js"></script>
<script language="JavaScript" src="js/util.js"></script>
<script language="Javascript" src="connset.js"></script>

</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table cellSpacing=0 cellPadding=0 width="600" border=0>
  <tr>
    <td width=60>&nbsp;</td>

    <td class=datatitle width=480>Connection Settings</td>


    <td width=60>&nbsp;</td>
  </tr>
  <tr>
    <td class=color1back colspan=3><img height=2 src="images/spacer.gif" width=600 border=0></td>
  </tr>
</table>

<form name=protoform>
<table cellSpacing=5 cellPadding=0 width="300" border=0 id="connproto">
  <tr>
    <td class=datalabelleftlarge colspan=2>
      <!-- dynamic label gets inserted here via Javascript-->
    </td>
  </tr>
  <tr>

    <td class=tabletitleleft colspan=2>Connect Protocol</td>

  </tr>
  <tr>

    <td class=datalabel width=80>Protocol:</td>

    <td class=datavalueleft>
      <select name=xprtproto onChange="switchProto(this,'tcpconn','udpconn');">
        <option>TCP</option>
        <option>UDP</option>
      </select>
    </td>
  </tr>
</table>
</form>

<table border=0><tr><td>

<div id="tcpconn"
  style="position:absolute;top:120;left:0;visibility:hidden">

<form name=tcpform>
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="tcpconntbl">
  <tr>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
    <td width=120><img height=1 src="images/spacer.gif" border=0></td>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
    <td width=55><img height=1 src="images/spacer.gif" border=0></td>
    <td width=25><img height=1 src="images/spacer.gif" border=0></td>
    <td width=35><img height=1 src="images/spacer.gif" border=0></td>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
    <td width=75><img height=1 src="images/spacer.gif" border=0></td>
    <td width=40><img height=1 src="images/spacer.gif" border=0></td>
    <td width=45><img height=1 src="images/spacer.gif" border=0></td>
    <td width=50><img height=1 src="images/spacer.gif" border=0></td>
    <td width=35><img height=1 src="images/spacer.gif" border=0></td>
    <td width=20><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>

    <td class=tabletitleleft colspan=13>Connect Mode</td>

  </tr>
  <tr>
    <td></td>

    <td class=tabletitleleft colspan=5><b>Passive Connection:</b></td>
    <td></td>
    <td class=tabletitleleft colspan=6><b>Active Connection:</b></td>

  </tr>
  <tr>

    <td class=datalabel colspan=2>Accept Incoming:</td>

    <td class=datavalue colspan=4>
      <select name=accptin>

        <option value='0xC0'>Yes</option>
        <option value='0x00'>No</option>
        <option value='0x40'>With Active Mdm Ctrl In</option>

      </select>
    </td>

    <td class=datalabel colspan=3>Active Connect:</td>

    <td class=datavalue colspan=4>
      <select name=actvconn onChange="OnChgActvConn(this);">

        <option value='0x00'>None</option>
        <option value='0x01'>With Any Character</option>
        <option value='0x02'>With Active Mdm Ctrl In</option>
        <option value='0x03'>With Start Character</option>
        <option value='0x04'>Manual Connection</option>
        <option value='0x05'>Auto Start</option>

      </select>
    </td>
  </tr>
  <tr>

    <td class=datalabel colspan=2>Password Required:</td>
    <td class=datavalue colspan=4>
      <input type=radio name=passyn onClick="SetPasswdMode(true)">Yes
      <input type=radio name=passyn onClick="SetPasswdMode(false)">No
    </td>
    <td class=datalabel colspan=3>Start Character:</td>
    <td class=datavalue colspan=4>
      0x<input type=text name=stchar size=2 maxlength=2> (in Hex)

    </td>
  </tr>
  <tr>

    <td class=datalabel colspan=2>Password:</td>

    <td class=datavalue colspan=4>
      <input type=password name=popass size=15 maxlength=15>
    </td>

    <td class=datalabel colspan=3>Modem Mode:</td>

    <td class=datavalue colspan=4>
      <select name=mdmmode onChange="OnChgMdmMode(this);" >

        <option>None</option>
		<option value='0x06'>Without Echo</option>
        <option value='0x16'>Verbose Mdm Resp & Echo</option>
        <option value='0x17'>Numeric Mdm Resp & Echo</option>
		<option value='0x0E'>Verbose Mdm Resp Only</option>
		<option value='0x0F'>Numeric Mdm Resp Only</option>

      </select></td>
  </tr>
  <tr>

    <td class=datalabel colspan=4>Modem Escape Sequence Pass Through:</td>
    <td class=datavalue colspan=3>
      <input type=radio name=escpassyn value="0x00">Yes
      <input type=radio name=escpassyn value="0x04">No
	</td>


    <td class=datalabel colspan=3>Show IP Address After RING:</td>
    <td class=datavalue colspan=2>
      <input type=radio name=suppipyn value="0x01">Yes
      <input type=radio name=suppipyn value="0x00">No
	</td>


  </tr>
  <tr>
    <td></td>
    <td colspan=5><hr width="100%" /></td>
    <td></td>
    <td colspan=6><hr width="100%" /></td>
  </tr>
<!-- Endpoint Configuration -->
  <tr>
    <td></td>

    <td class=tabletitleleft colspan=12>Endpoint Configuration:</td>

  </tr>
  <tr>

    <td class=datalabel colspan=2>Local Port:</td>

    <td class=datavalue colspan=2>
      <input type=text name=lport size=5 maxlength=5></td>
	  <td colspan=3></td>

    <td class=datalabel colspan=2>Remote Port:</td>

    <td class=datavalue colspan=3>
      <input type=text name=rport size=5 maxlength=5></td>

  </tr>
  <tr>
<td colspan=1></td>
    <td class=tablefield colspan=6>
      <input type=checkbox name=ainclport value='0'>

      Auto increment Local Port for active connect

    </td>
	

    <td class=datalabel colspan=2>Remote Host:</td>

    <td class=datavalue colspan=3>
        <input type=text name=rhost size=15 maxlength=15></td>
  </tr>
  <tr>
    <td></td>
    <td colspan=12><hr width=100%></td>
  </tr>
<!-- Common Configuration -->
  <tr>
    <td></td>

    <td class=tabletitleleft colspan=12><b>Common Options:</b></td>

  </tr>
  <tr>

    <td class=datalabel colspan=3>Telnet Com Port Cntrl:</td>

    <td class=datavalue colspan=2>
      <select name=telnetm>

        <option>Enable</option>
        <option>Disable</option>

      </select>
    </td>

    <td class=datalabel colspan=4>Connect Response:</td>

    <td class=datavalue colspan=5>
      <select name=connresp>

        <option value='0x00'>None</option>
        <option value='0x10'>Char Response</option>

      </select>
    </td>
  </tr>
  <tr>

    <td class=datalabel colspan=2>Terminal Name:</td>

    <td class=datavalue colspan=3>
      <input type=text name=termname size=15 maxlength=15></td>

    <td class=datalabel colspan=2>Use Hostlist:</td>
    <td class=datavalue colspan=3>
      <input type=radio name=hlistyn value="0x20">Yes
      <input type=radio name=hlistyn value="0x00">No
	</td>

    <td class=datalabel>LED:</td>
    <td class=datavalue colspan=2>
      <select name=ledyn>

        <option value='0x00'>Blink</option>
        <option value='0x01'>Off</option>

      </select></td>
  </tr>
  <tr>
    <td colspan=13><img height=2 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td colspan=12><hr width=100%></td>
  </tr>
<!-- DISCONNECT MODE -->
  <tr>

    <td class=tabletitleleft colspan=12>Disconnect Mode</td>

  </tr>
  <tr>

    <td class=datalabel colspan=3>On Mdm_Ctrl_In Drop:</td>
    <td class=datavalue colspan=2>
      <input type=radio name=dtrdisc value='0x80'>Yes
      <input type=radio name=dtrdisc value='0x00'>No
    </td>
    <td class=datalabel colspan=3>Hard Disconnect:</td>
    <td class=datavalue colspan=5>
      <input type=radio name=hdisc value='0x00'>Yes
      <input type=radio name=hdisc value='0x08'>No

    </td>
  </tr>
  <tr>

    <td class=datalabel colspan=3>Check EOT(Ctrl-D):</td>
    <td class=datavalue colspan=2>
      <input type=radio name=eotdisc value='0x20'>Yes
      <input type=radio name=eotdisc value='0x00'>No
    </td>
    <td class=datalabel colspan=3>Inactivity Timeout:</td>

    <td class=datavalue colspan=5>
      <input type=text name=inactmin size=3 maxlength=3><b>&nbsp : &nbsp</b>

      <input type=text name=inactsec size=3 maxlength=3> (mins : secs)

    </td>
  </tr>
</table>

<table cellSpacing=5 cellPadding=0 border=0 width="600">
 <table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>

       <input type=button value="    OK    " onClick="return applyForm()">

    </td>
	<td id="statmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>
</form>



</div>

<div id="udpconn"
  style="position:absolute;top:120px;left:0px;visibility:hidden;">
<form name="udpform">
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="udpconntbl" style="">
  <tr>
    <td width=70><img height=1 src="images/spacer.gif" border=0></td>
    <td width=55><img height=1 src="images/spacer.gif" border=0></td>
    <td width=60><img height=1 src="images/spacer.gif" border=0></td>
    <td width=35><img height=1 src="images/spacer.gif" border=0></td>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
    <td width=60><img height=1 src="images/spacer.gif" border=0></td>
    <td width=35><img height=1 src="images/spacer.gif" border=0></td>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
    <td width=60><img height=1 src="images/spacer.gif" border=0></td>
    <td width=55><img height=1 src="images/spacer.gif" border=0></td>
    <td width=70><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>

    <td class=tabletitleleft colspan=11>Datagram Mode:</td>

  </tr>
  <tr>

    <td class=datalabel colspan=2>Datagram Type:</td>

    <td class=datavalue colspan=2>
      <select name=dgramt onChange="OnChgDgramType(this)">
        <option value='0x00'>00</option>
        <option value='0x01'>01</option>
        <option value='0x02'>02</option>
        <option value='0x04'>04</option>
        <option value='0x05'>05</option>
        <option value='0x08'>08</option>
        <option value='0x12'>12</option>
        <option value='0xFD'>FD</option>
      </select>
    </td>

    <td class=datalabel colspan=3>Accept Incoming:</td>

    <td class=datavalue colspan=4>
      <select name=daccptin>

        <option value='0xC0'>Yes</option>
        <option value='0x00'>No</option>
        <option value='0x40'>With Active Mdm Ctrl In</option>

      </select>
    </td>
  </tr>
<!-- Endpoint Configuration -->
  <tr>

    <td class=tabletitleleft colspan=11>Endpoint Configuration:</td>

  </tr>
  <tr>

    <td class=datalabel colspan=2>Local Port:</td>

    <td class=datavalue colspan=2>
      <input type=text name=dlport size=5 maxlength=5></td>

    <td class=datalabel colspan=3>Remote Port:</td>

    <td class=datavalue colspan=4>
      <input type=text name=drport size=5 maxlength=5></td>
  </tr>
  <tr>

    <td class=datalabel colspan=2>Remote Host:</td>

    <td class=datavalue colspan=3>
        <input type=text name=drhost size=15 maxlength=15></td>

	<td class=datavalue colspan=3>
      <input type=checkbox name=bcastaddr onClick="CheckBcast()">

      Use Broadcast

    </td>
	</tr>

  <tr>
    <td></td>

    <td class=tabletitleleft colspan=10>Device Address Table:</td>

  </tr>
  <tr>
    <td></td>
    <td colspan=10>
      <table class=tablelight cellspacing=3 border=0 id="addrtab">
        <tr>

          <td class=tableheader width=25>No.</td>
          <td class=tableheader width=60>Dev Addr</td>
          <td class=tableheader width=25>No.</td>
          <td class=tableheader width=60>Dev Addr</td>
          <td class=tableheader width=25>No.</td>
          <td class=tableheader width=60>Dev Addr</td>
          <td class=tableheader width=25>No.</td>
          <td class=tableheader width=60>Dev Addr</td>

        </tr>
        <tr>
          <td class=tablefield>0</td>
          <td class=tablefield>
            <input type=text name=sladdr1 size=3 maxlength=3>
          </td>
          <td class=tablefield>1</td>
          <td class=tablefield>
            <input type=text name=sladdr2 size=3 maxlength=3>
          </td>
          <td class=tablefield>2</td>
          <td class=tablefield>
            <input type=text name=sladdr3 size=3 maxlength=3>
          </td>
          <td class=tablefield>3</td>
          <td class=tablefield>
            <input type=text name=sladdr4 size=3 maxlength=3>
          </td>
        </tr>
        <tr>
          <td class=tablefield>4</td>
          <td class=tablefield>
            <input type=text name=sladdr5 size=3 maxlength=3>
          </td>
          <td class=tablefield>5</td>
          <td class=tablefield>
            <input type=text name=sladdr6 size=3 maxlength=3>
          </td>
          <td class=tablefield>6</td>
          <td class=tablefield>
            <input type=text name=sladdr7 size=3 maxlength=3>
          </td>
          <td class=tablefield>7</td>
          <td class=tablefield>
            <input type=text name=sladdr8 size=3 maxlength=3>
          </td>
        </tr>
        <tr>
          <td class=tablefield>8</td>
          <td class=tablefield>
            <input type=text name=sladdr9 size=3 maxlength=3>
          </td>
          <td class=tablefield>9</td>
          <td class=tablefield>
            <input type=text name=sladdr10 size=3 maxlength=3>
          </td>
          <td class=tablefield>10</td>
          <td class=tablefield>
            <input type=text name=sladdr11 size=3 maxlength=3>
          </td>
          <td class=tablefield>11</td>
          <td class=tablefield>
            <input type=text name=sladdr12 size=3 maxlength=3>
          </td>
        </tr>
        <tr>
          <td class=tablefield>12</td>
          <td class=tablefield>
            <input type=text name=sladdr13 size=3 maxlength=3>
          </td>
          <td class=tablefield>13</td>
          <td class=tablefield>
            <input type=text name=sladdr14 size=3 maxlength=3>
          </td>
          <td class=tablefield>14</td>
          <td class=tablefield>
            <input type=text name=sladdr15 size=3 maxlength=3>
          </td>
          <td class=tablefield>15</td>
          <td class=tablefield>
            <input type=text name=sladdr16 size=3 maxlength=3>
          </td>
        </tr>
      </table>
    </td>
  </tr>
</table>

<table cellSpacing=5 cellPadding=0 border=0 width="600">
 <table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>

       <input type=button value="    OK    " onClick="return applyForm()">

    </td>
    <td id="ustatmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>

</form>

</div>



</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Setup Records Arrays



var CHAN_ID;

// #define equivalents
var CHAN0_OFF = 16;	// offsets into record 0 directly
var CHAN1_OFF = 64;	// offsets into record 0 directly
var CH_PARAM_SIZE = 48;	// size of channel specific parameters.

var SENDIP_OFF	= 117;

var UDP_MODE = 0x0C;

var STCHAR_OFF = 75;	// start char offset in record 3
var MISC_OFF = 116;		// miscellaneous flags in record 3

var AINC_BIT = 0x01;		// bit 0 within MISC_OFF
var ESCPASS_BIT = 0x04;		// bit 2 within MISC_OFF

//relative offset within the channel parameters
var CMODE_OFF = 12;
var DMODE_OFF = 13;
var UDP_TYPE_OFF = 13;
var LPORT_OFF = 4;
var RPORT_OFF = 6;
var RHOST_OFF = 8;
var IN_TO_MIN_OFF = 14;
var FLMODE_OFF = 18;
var PASS_TERM_OFF = 32;
var DEVADDR_OFF = 22;

var NUM_DEVADDRS = 16;

var TCP_DIV = "tcpconn";
var UDP_DIV = "udpconn"; 
    
// handler to take care of the switching of the tcp and udp parameters section
function switchProto(sel, tcp_div, udp_div)
{
  // based on the value of the selected object
  // we perform the hide and show the div
  var index = sel.selectedIndex;
  if (getStyleObject(tcp_div) && getStyleObject(udp_div)) 
  {
    // index 0 = tcp and index 1 = udp
    if (index == 0)
    { 
      changeObjectVisibility(tcp_div, "visible");
      changeObjectVisibility(udp_div, "hidden");
    }
    else
    {
      changeObjectVisibility(tcp_div, "hidden");
      changeObjectVisibility(udp_div, "visible");
    }
  }
}

function OnChgMdmMode(sel)
{
   var f = document.tcpform;
   
   if (sel.selectedIndex == 0) 
   {
     f.actvconn.disabled = false;
     f.connresp.disabled = false;
   }
   else
   {
     f.actvconn.disabled = true;
     f.connresp.disabled = true;  
   }
}

function OnChgActvConn(sel)
{
   var f = document.tcpform;
   
   if (sel.selectedIndex == 3)
      f.stchar.disabled = false;
   else
      f.stchar.disabled = true;
}

function OnChgDgramType(dgramt)
{
   var uf = document.udpform;
   var adtab = document.getElementById("addrtab");
   var distab = true;
   var i;

   // C-071108-101540 all options of Accepting Income not applicable to UDP
   uf.daccptin.disabled = true;            
   switch (dgramt.selectedIndex)
   {
     case 0: // dgram type 0x00
     case 2: // dgram type 0x02
     case 3: // dgram type 0x04
     case 5: // dgram type 0x08
     case 6: // dgram type 0x12
            uf.dlport.disabled = true;
            uf.drport.disabled = true;
            uf.drhost.disabled = true;
            uf.bcastaddr.disabled = true;
            break;
     case 7: // dgram type 0xfd
	        distab = false;	        
     case 1: // dgram type 0x01
     case 4: // dgram type 0x05
            uf.dlport.disabled = false;
            uf.drport.disabled = false;
            uf.bcastaddr.disabled = false;            
            // We also need to see if broadcast is selected:
            uf.drhost.disabled = uf.bcastaddr.checked;
            break;
   }  

   adtab.disabled = distab;
   
   // for firefox browser
   for (i = 0; i < NUM_DEVADDRS; i++)
   {
      obj = eval("uf.sladdr" + (i+1));   
      obj.disabled = distab;
   }
   
}


// toggles password enable/disable based on the radio button     
function SetPasswdMode(passyn)   
{
  var f = document.tcpform;
  f.termname.disabled = passyn;
  f.popass.disabled = !passyn;
  // transfer string
  if (passyn)
  {
    f.popass.value = f.termname.value;
    f.termname.value = "";
  }
  else
  {
    f.termname.value = f.popass.value;
    f.popass.value = "";
  }
}

// populate the device address table for dgram type 0xFD
function popDevAddrTab(arr)
{
   var uf = document.udpform;
   var i, darr, obj;
   
   darr = arr.slice(DEVADDR_OFF, DEVADDR_OFF + NUM_DEVADDRS);
   for (i = 0; i < NUM_DEVADDRS; i++)
   {
      obj = eval("uf.sladdr" + (i+1));
      obj.value = darr[i];
   }   
}

function AddrTabToArr()
{
   var uf = document.udpform;
   var i, darr = new Array(NUM_DEVADDRS);
   var obj;
      
   for (i = 0; i < NUM_DEVADDRS; i++)
   {
      obj = eval("uf.sladdr" + (i+1));   
      darr[i] = parseInt(obj.value, 10);
   }
   return darr;   
}

function verifyAddrTab()
{
   var uf = document.udpform;
   var i, val;
   var ok = true;
   
   for (i = 0; i < NUM_DEVADDRS; i++)
   {
      obj = eval("uf.sladdr" + (i+1));   
      val = obj.value;

      ok = verifyNumRange(val, 0, 255, "Dev Address" + (i+1), false);

      if (!ok) break;
   }
   return ok;
}

function popFields()
{
  var pf = document.protoform;
  var tf = document.tcpform;
  var uf = document.udpform;
  var i, dgram;
  var chanParams;
  var curropt;
  var tmode, popass;
  var tempstr = "";
  var chanOff;
  
  if (CHAN_ID == 0){
     chanParams = rec0.slice(CHAN0_OFF, CHAN0_OFF + CH_PARAM_SIZE);
	 chanOff = CHAN0_OFF;
  }
  else if (CHAN_ID == 1){ 
     chanParams = rec0.slice(CHAN1_OFF, CHAN1_OFF + CH_PARAM_SIZE);  
	 chanOff = CHAN1_OFF;
  }
  curropt = chanParams[CMODE_OFF];
  
  // read the protocol option to determine how to populate each connection
  // section
 ((curropt & 0x0f) == UDP_MODE) ? dgram = true : dgram = false;

  pf.xprtproto.options[0].selected = !dgram;
  pf.xprtproto.options[1].selected = dgram;

  // setup the tcp form options
  // passive connect options
  switch (curropt & 0xc0)
  {
     case 0xc0: tf.accptin.options[0].selected = true; break;
     case 0x00: tf.accptin.options[1].selected = true; break;
     case 0x40: tf.accptin.options[2].selected = true; break;
     default: break;
  }
  
  // active connect options
  // start character
  tf.stchar.value = hexcode(rec3[CHAN_ID + STCHAR_OFF]);
  
  switch (curropt & 0x0f)
  {
    case 0: tf.actvconn.options[0].selected = true; break;
    case 1: tf.actvconn.options[1].selected = true; break;
    case 2: tf.actvconn.options[2].selected = true; break;
    case 3: tf.actvconn.options[3].selected = true; break;
    case 4: tf.actvconn.options[4].selected = true; break;
    case 5: tf.actvconn.options[5].selected = true; break;
    // it is modem mode. We would not be configuring this if we are in 
    // datagram mode.
    default: break;
  }
  OnChgActvConn(tf.actvconn);
  
  // modem mode options
  switch (curropt & 0x1f)
  {
    case 0x00: tf.mdmmode.options[0].selected = true; break;
	case 0x06: tf.mdmmode.options[1].selected = true; break;
    case 0x16: tf.mdmmode.options[2].selected = true; break;    
    case 0x17: tf.mdmmode.options[3].selected = true; break;
	case 0x0e: tf.mdmmode.options[4].selected = true; break;
	case 0x0f: tf.mdmmode.options[5].selected = true; break;
    default: break;
  }
  OnChgMdmMode(tf.mdmmode);
  
  if( CHAN_ID == 0 ){
	  if( (rec3[ SENDIP_OFF ] & 0x01) == 0x01 ){
		  tf.suppipyn[0].checked = false;
		  tf.suppipyn[1].checked = true;
	  }
	  else{
		  tf.suppipyn[0].checked = true;
		  tf.suppipyn[1].checked = false;
	  }
  }
  if( CHAN_ID == 1 ){
	  if( (rec3[ SENDIP_OFF ] & 0x02) == 0x02 ){
		  tf.suppipyn[0].checked = false;
		  tf.suppipyn[1].checked = true;
	  }
	  else{
		  tf.suppipyn[0].checked = true;
		  tf.suppipyn[1].checked = false;
	  }
  }


  // hostlist option
  if (curropt & 0x20)
     tf.hlistyn[0].checked = true;
  else
     tf.hlistyn[1].checked = true;
  
  // connection response
  switch (curropt & 0x10)
  {
     case 0: tf.connresp.options[0].selected = true; break;
     default: tf.connresp.options[1].selected = true; break;
  }
  
  tf.lport.value = parseInt(chanParams[LPORT_OFF]) + parseInt((chanParams[LPORT_OFF+1] << 8));
  tf.rport.value = parseInt(chanParams[RPORT_OFF]) + parseInt((chanParams[RPORT_OFF+1] << 8));

  
  if( dgram ){
	  if( ( rec0[ chanOff+RHOST_OFF ]  == 0xFF) &&
		  ( rec0[ chanOff+RHOST_OFF+1 ]  == 0xFF) &&
		  ( rec0[ chanOff+RHOST_OFF+2 ]  == 0xFF) &&
		  ( rec0[ chanOff+RHOST_OFF+3 ]  == 0xFF)){
		  uf.drhost.value = "0.0.0.0";
		  tf.rhost.value = "0.0.0.0";
		  uf.bcastaddr.checked = true;
		  uf.drhost.disabled  = true;
	  }
	  else{
		  uf.drhost.value = IPAddrToStr(chanParams, RHOST_OFF);
	  }
  }
  else{
	if( ( rec0[ chanOff+RHOST_OFF ]  == 0xFF) &&
		  ( rec0[ chanOff+RHOST_OFF+1 ]  == 0xFF) &&
		  ( rec0[ chanOff+RHOST_OFF+2 ]  == 0xFF) &&
		  ( rec0[ chanOff+RHOST_OFF+3 ]  == 0xFF)){
		  tf.rhost.value = "0.0.0.0";
		  uf.bcastaddr.checked = false;
	}
	else{
		tf.rhost.value = IPAddrToStr(chanParams, RHOST_OFF);
		uf.drhost.value = IPAddrToStr(chanParams, RHOST_OFF);
	}
  }

  if (rec3[MISC_OFF] & (AINC_BIT << CHAN_ID))
     tf.ainclport.checked = true;
  else
     tf.ainclport.checked = false;
  
  if (rec3[MISC_OFF] & (ESCPASS_BIT << CHAN_ID))
     tf.escpassyn[1].checked = true;
  else
     tf.escpassyn[0].checked = true;



  // evaluating the disconnect mode byte
  // since the disconnect mode in tcpsetup is shared with the datagram type
  // in the udp setup we will init the disc mode to 0 if dgram mode is 
  // true at init
  
  if (!dgram)
     curropt = chanParams[DMODE_OFF];
  else
     curropt = 0;
  
  // port password or telnet mode selection
  switch (curropt & 0x50)
  {
    case 0x10: // port password required
              popass = true;
              tmode = false;
              tf.passyn[0].checked = true;
              tf.telnetm.options[1].selected = true;
              break;
    case 0x40: // telnet mode enabled..
              popass = false;
              tmode = true;
              tf.passyn[1].checked = true;
              tf.telnetm.options[0].selected = true;
              break;
    case 0x50: // both telnet mode and port password enabled.
               popass = tmode = true;
               tf.passyn[0].checked = true;
               tf.telnetm.options[0].selected = true;
               break;
    default:
              popass = tmode = false;
              tf.passyn[1].checked = true;
              tf.telnetm.options[1].selected = true;
              break;          
  }          

  // setup the terminal name or port password field depending on the selection
  tf.popass.value = "";
  tf.termname.value = "";
  
  if (!dgram)
  {
     tempstr = ArrToStr(chanParams, PASS_TERM_OFF, 16);   
     tf.popass.value = tempstr;
     tf.termname.value = tempstr; 

     // set the corresponding section
     SetPasswdMode(popass);
  }
    
    // disconnect mode
  //with dtr drop
  if (curropt & 0x80)
     tf.dtrdisc[0].checked = true;
  else
     tf.dtrdisc[1].checked = true;
  
  // hard disconnect   
  if (curropt & 0x08)
     tf.hdisc[1].checked = true;
  else
     tf.hdisc[0].checked = true;

  // ctrl-d disconnect
  if (curropt & 0x20)
     tf.eotdisc[0].checked = true;
  else
     tf.eotdisc[1].checked = true;
 
  // led blinking
  if (curropt & 0x01)
     tf.ledyn.options[1].selected = true;
  else
     tf.ledyn.options[0].selected = true;
     
  // inactivity timeout
  tf.inactmin.value = "" + chanParams[IN_TO_MIN_OFF];
  tf.inactsec.value = "" + chanParams[IN_TO_MIN_OFF + 1];  
 
  // setup the UDP form options.
  curropt = chanParams[CMODE_OFF];

  // incoming dgram options
  switch (curropt & 0xc0)
  {
     case 0xc0: uf.daccptin.options[0].selected = true; break;
     case 0x00: uf.daccptin.options[1].selected = true; break;
     case 0x40: uf.daccptin.options[2].selected = true; break;
     default: break;
  }
  
  // since the disconnect mode in tcpsetup is shared with the datagram type
  // in the udp setup we will init the disc mode to 0 if dgram mode is 
  // true at init
  if (dgram)
     curropt = chanParams[DMODE_OFF];
  else
     curropt = 0;


  uf.dlport.value = parseInt(chanParams[LPORT_OFF]) + parseInt((chanParams[LPORT_OFF+1] << 8)); 
  uf.drport.value = parseInt(chanParams[RPORT_OFF]) + parseInt((chanParams[RPORT_OFF+1] << 8));
  

  // default settings for the address table.. will be changed if the
  // dgram type is 0xfd
  popDevAddrTab(chanParams);    
  
  // datagram type
  // based on the dgram type the other options are initialized.    
  switch (curropt & 0xff)
  {
    case 0x00: uf.dgramt.options[0].selected = true; break;
    case 0x01: uf.dgramt.options[1].selected = true; break;
    case 0x02: uf.dgramt.options[2].selected = true; break;
    case 0x04: uf.dgramt.options[3].selected = true; break;
    case 0x05: uf.dgramt.options[4].selected = true; break;
    case 0x08: uf.dgramt.options[5].selected = true; break;
    case 0x12: uf.dgramt.options[6].selected = true; break;
    case 0xfd: uf.dgramt.options[7].selected = true; break;
    default: break;
  }
  // set the mode for the address table based on this...
  OnChgDgramType(uf.dgramt);
    
  switchProto(pf.xprtproto, TCP_DIV, UDP_DIV);
}


function CheckBcast()
{
	var tf = document.udpform;
	var idx = tf.dgramt.selectedIndex;
	tf.drhost.disabled = tf.bcastaddr.checked;

	// We don't want to enable the field for the wrong datagram type:
	if((idx == 0) || (idx == 2))
		tf.drhost.disabled = true;
}


// Called when Apply is selected; validates the fields, and if all is well,
// opens the status window, submits the form, and changes the frame contents.
function applyForm()
{
  var ok = true;
  var pf = document.protoform;
  var tf = document.tcpform;
  var uf = document.udpform;
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
  var prot = 0;  

  var idx, recval, chanOff;
  var tempArr = new Array();

  // get the chanParams offset.
  chanOff = CHAN_ID ? CHAN1_OFF : CHAN0_OFF;

  // datagram mode or not...
  (pf.xprtproto.selectedIndex == 1) ? dgram = true : dgram = false;  
  if (!dgram)
  {
	prot = 0;
	// if not in UDP mode broadcast cant be checked
	uf.bcastaddr.checked = false;

    if (isNaN(parseInt(tf.stchar.value, 16)))
    {

       alert("Start Character contains invalid characters.\nValid characters are 0-9 and A-F or a-f");

       return false; 
    }
    

    ok = (verifyNumRange(tf.lport.value, 0, 65535, "Local Port", true) &&
          verifyNumRange(tf.rport.value, 0, 65535, "Remote Port", true) &&
          verifyNumRange(tf.inactmin.value, 0, 99, "Inactivity Timeout(mins)", true) &&
          verifyNumRange(tf.inactsec.value, 0, 59, "Inactivity Timeout(secs)", true) &&
		  verifyIP(tf.rhost.value, "Remote Host", true, true) );


    if (ok)
    {
      recval = 0;
       
      idx = tf.accptin.selectedIndex;		      // passive connect
      recval |= parseInt(tf.accptin.options[idx].value);
 
      idx = tf.mdmmode.selectedIndex;	      // modem mode option
      if (idx)
        recval |= parseInt(tf.mdmmode.options[idx].value);
      else
      {
        idx = tf.actvconn.selectedIndex;	// active conn option
        recval |= parseInt(tf.actvconn.options[idx].value);   
        idx = tf.connresp.selectedIndex;	// conn resp option
        recval |= parseInt(tf.connresp.options[idx].value);
      }
      if (tf.hlistyn[0].checked)		    // hostlist option
        recval |= parseInt(tf.hlistyn[0].value);
                           
      rec0[chanOff + CMODE_OFF] = recval;
      
      rec3[CHAN_ID + STCHAR_OFF] = parseInt(tf.stchar.value, 16);
      
      recval = parseInt(tf.lport.value, 10);
      rec0[chanOff + LPORT_OFF] = recval & 0xff;
      rec0[chanOff + LPORT_OFF + 1] = (recval >> 8) & 0xff;
    
      recval = parseInt(tf.rport.value, 10);
      rec0[chanOff + RPORT_OFF] = recval & 0xff;
      rec0[chanOff + RPORT_OFF + 1] = (recval >> 8) & 0xff;
       
	  tempArr = StrToIPAddr(tf.rhost.value);
      UpdateArr(rec0, chanOff+RHOST_OFF, 4, tempArr);


      // disconnect mode byte
      recval = 0;
      idx = tf.telnetm.selectedIndex;
      if (tf.passyn[0].checked)
      {
        recval |= 0x10;
        tempArr = StrToArr(tf.popass.value, 16);
      }
      else
        tempArr = StrToArr(tf.termname.value, 16);
      if ((tf.telnetm.selectedIndex) == 0)
        recval |= 0x40;
      UpdateArr(rec0, chanOff+PASS_TERM_OFF, 16, tempArr);
  
      if (tf.dtrdisc[0].checked)
        recval |= parseInt(tf.dtrdisc[0].value);
      if (tf.hdisc[1].checked)
        recval |= parseInt(tf.hdisc[1].value);
      if (tf.eotdisc[0].checked)
        recval |= parseInt(tf.eotdisc[0].value);
      if (tf.ledyn.selectedIndex == 1)
        recval |= parseInt(tf.ledyn.options[1].value);  
        
      rec0[chanOff + DMODE_OFF] = recval;
      rec0[chanOff + IN_TO_MIN_OFF] = parseInt(tf.inactmin.value, 10);
      rec0[chanOff + IN_TO_MIN_OFF + 1] = parseInt(tf.inactsec.value, 10); 
      
      // misc flags
      recval = rec3[MISC_OFF];
      if (tf.ainclport.checked)
        recval |= (AINC_BIT << CHAN_ID);
      else
        recval &= ~(AINC_BIT << CHAN_ID);
      
	  if (tf.escpassyn[0].checked)
	    recval &= ~(ESCPASS_BIT << CHAN_ID);
	  else
	    recval |= (ESCPASS_BIT << CHAN_ID);
  
      rec3[MISC_OFF] = recval;
    }
  }
  else			// udp datagram mode.
  {
	prot = 1;
    // datagram type
    idx = uf.dgramt.selectedIndex;
    if ((idx == 0) || (idx == 2))	// datagram type 0 or 4
    {

      ok = (verifyNumRange(uf.dlport.value, 0, 65535, "Local Port", false) &&
            verifyNumRange(uf.drport.value, 0, 65535, "Remote Port", false) &&
            verifyAddrTab());

	  if(uf.bcastaddr.checked == false )
	  {
		  ok = verifyIP(uf.drhost.value, "Remote Host", false, true);
	  }


    }
    else
    {
	

      ok = (verifyNumRange(uf.dlport.value, 1, 65535, "Local Port", true) &&
            verifyNumRange(uf.drport.value, 0, 65535, "Remote Port", true) &&
            verifyAddrTab());   

	  if(uf.bcastaddr.checked == false )
	  {
		  ok = verifyIP(uf.drhost.value, "Remote Host", true, true);
	  }


    }             
    
    if (ok)      
    {
      // udp form options
      recval = 0;  
      recval |= UDP_MODE;		    // datagram mode
      idx = uf.daccptin.selectedIndex;		// passive connect
      recval |= parseInt(uf.daccptin.options[idx].value);
  
      rec0[chanOff + CMODE_OFF] = recval;
    
      // datagram type
      idx = uf.dgramt.selectedIndex;
      rec0[chanOff + DMODE_OFF] = parseInt(uf.dgramt.options[idx].value);  
      
      if (idx == 1)
      {
          // For UDP Datagram Type 0x01, disable buffer flushing   
          // This needs to be done for the appropriate channel instead of the previous fix
          // that applied it only for channel 1
          rec0[chanOff + FLMODE_OFF] &= 80;
      }
      recval = parseInt(uf.dlport.value, 10);
      rec0[chanOff + LPORT_OFF] = recval & 0xff;
      rec0[chanOff + LPORT_OFF + 1] = (recval >> 8) & 0xff;
    
      recval = parseInt(uf.drport.value, 10);
      rec0[chanOff + RPORT_OFF] = recval & 0xff;
      rec0[chanOff + RPORT_OFF + 1] = (recval >> 8) & 0xff;
   
      tempArr = AddrTabToArr();
      UpdateArr(rec0, chanOff+DEVADDR_OFF, NUM_DEVADDRS, tempArr);   

	  if(uf.bcastaddr.checked == true ){
		tempArr = StrToIPAddr("255.255.255.255");
		UpdateArr(rec0, chanOff+RHOST_OFF, 4, tempArr);
	  }
	  else{
		tempArr = StrToIPAddr(uf.drhost.value);
		UpdateArr(rec0, chanOff+RHOST_OFF, 4, tempArr);
	  }

    }        
  }

  switch( CHAN_ID ){
	case 0x00:
		if( tf.suppipyn[0].checked )
		{
		rec3[SENDIP_OFF] &= ~0x01;
		}
		else{
		rec3[SENDIP_OFF] |= 0x01;
		}
	break;
	case 0x01:
		if( tf.suppipyn[0].checked )
		{
		rec3[SENDIP_OFF] &= ~0x02;
		}
		else{
		rec3[SENDIP_OFF] |= 0x02;
		}
	break;
  }


  if (ok)
  {
    recstr = rec0.join();
    RecDoc.SetRecord(0, recstr);
  
    recstr = rec3.join();
    RecDoc.SetRecord(3, recstr);
    
	if( prot != 0 ){
		ureportDone();
	}
	else{
		reportDone();
	}
  }  
  
  return ok;
}

function initPage()
{
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
  var table = document.getElementById("connproto");
  var rows = table.rows;
  var cells = rows[0].cells;
 
  recstr = RecDoc.GetRecord(0);
  rec0 = recstr.split(",");
  recstr = RecDoc.GetRecord(3);
  rec3 = recstr.split(",");
  
  // setup the correct channel number:
  CHAN_ID = parseInt(RecDoc.GetCurrChanNo());

  cells[0].innerHTML = "Channel " + (CHAN_ID + 1);


  // populate the fields based on the setup records array
  popFields();
}
-->
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
<head>

<style type="text/css" screen="media">

</style>
</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table width=600 border=0>
  <tr>
    <td>
      <p class=datalabelcenter><br><br>

         <b>Error retrieving configuration records from the unit.<br>
          Web Based configuration seems to be disabled on the unit.<br><br>
          Please enable WebSetup in the Security options via the<br>
          serial or telnet based setup and reload the Configuration<br>
          Manager to continue with web based setup.</b><br>

      </p>
    </td>
  </tr>
</table>       

</body>
</html>
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
<head>

<link href="images/ltrx_style.css" type=text/css rel=stylesheet>
<base TARGET="data">
</head>
<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">
<table cellSpacing=0 cellPadding=0 width=100% background=images/top_graphic_tile.gif border=0>
<tbody>
	<tr>
		<td>
			<table cellSpacing=0 cellPadding=0 width=900 height=45 background=images/spacer.gif border=0>
			<tbody>
				<tr>
					<td class=footerContainer>&nbsp; WebManager Version: 2.0.0.6</td>
					<td class=footerContainer width=210>&nbsp;</td>

					<td class=footerContainer >Copyright &copy;
						<a href="http://www.lantronix.com">Lantronix, Inc.</a> 2007-2014. All rights reserved.
					</td>

				</tr>
			</tbody>
			</table>
		</td>
	</tr>
</tbody>
</table><!-- end top enclosing table -->
</body>
</html>
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">
<LINK href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/util.js"></script>
<script language="JavaScript" src="gpio.js"></script>
</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table cellSpacing=0 cellPadding=0 width="600" border=0>
  <tr>
    <td width=60>&nbsp;</td>
    <td class=datatitle width=480>Configurable Pin Settings</td>
    <!--
    <td class=datatitlehelp width=60><a class=datatitlehelp target="help" href="help.htm"><img height=21 width=50 src="images/help.gif" border=0></a></td>
    -->
    <td width=60>&nbsp;</td>
  </tr>
  <tr>
    <td class=color1back colspan=2><img height=2 src="images/spacer.gif" width=600 border=0></td>
  </tr>
</table>

<form name=theform>
<table cellSpacing=10 cellPadding width=600 border=0>
<tr><td>
  <table class=tablelight cellSpacing=3 cellPadding=0 width="580" border=0 id="gpiotbl">
    <tr>
      <td class=tableheader width=30>CP</td>
      <td class=tableheader width=200>Function</td>
	  <td class=tableheader width=120>Direction</td>
      <td class=tableheader width=100>Active Level</td>
    </tr>
    <tr>
      <td class=tablefieldcenter><b>1</b></td>
      <td class=tablefield>
        <select name=p0func onChange="OnChgFunc(this, 0)" style="width:200px;">
          <option> </option> <option> </option> <option> </option> <option> </option>
		  <option> </option> 
        </select>
	  </td>
	  <td class=tablefield>
        <input name=p0dir type=radio value='0x00'>Input 
	    <input name=p0dir type=radio value='0x01'>Output
	  </td>	  
      <td class=tablefield>
        <input name=p0level type=radio onClick="OnChgLev(0,0)" value='0x00'>Low
  	    <input name=p0level type=radio onClick="OnChgLev(0,1)" value='0x01'>High
      </td>	  
    </tr>
    <tr>
      <td class=tablefieldcenter><b>2</b></td>
      <td class=tablefield>
        <select name=p1func onChange="OnChgFunc(this, 1)" style="width:200px;">
          <option> </option> <option> </option> <option> </option> <option> </option> 
	  </td>
	  <td class=tablefield>
        <input name=p1dir type=radio value='0x00'>Input 
	    <input name=p1dir type=radio value='0x01'>Output
	  </td>
	  <td class=tablefield>
        <input name=p1level type=radio onClick="OnChgLev(1,0)">Low
  	    <input name=p1level type=radio onClick="OnChgLev(1,1)" value='0x1'>High
      </td>	  
    </tr>
	<tr>
      <td class=tablefieldcenter><b>3</b></td>
      <td class=tablefield>
        <select name=p2func onChange="OnChgFunc(this, 2)" style="width:200px;">
          <option> </option> <option> </option> <option> </option> <option> </option>
		  <option> </option> <option> </option> 
        </select>
	  </td>
	  <td class=tablefield>
        <input name=p2dir type=radio value='0x00'>Input 
	    <input name=p2dir type=radio value='0x01'>Output
	  </td>
      <td class=tablefield>									  
        <input name=p2level type=radio onClick="OnChgLev(2,0)">Low
  	    <input name=p2level type=radio onClick="OnChgLev(2,1)" value='0x1'>High
      </td>	  
    </tr>
    
  </table>    
</td></tr>
</table>
</form>

<div id="appdiv" style="visibility:visible;">
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>

       <input type=button value="    OK    " onClick="return applyForm()">

    </td>
    <td id="statmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>  
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>
</div>

</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Setup Records Arrays



var NUM_PINS = 3 ;
var NUM_VALS = 14;		// number of pins that have a definition
var NUM_FUNCS = 9;

var func_name_arr =  new Array("HW Flow Control Out", "HW Flow Control In", "Modem Control Out", 
							   "Modem Control In", "General Purpose I/O", "Status LED 1", "Status LED 3",
							   "Link Status", "RS485 Tx Enable" );
var func_val_arr = new Array("0x00", "0x01", "0x02", "0x03", "0x04", "0x0A", "0x0B", "0x0D", "0x0C");
var func_pin_restrict = new Array(0, 2, 1, 2, 255, 0, 2, 255, 255);

var val_to_func_idx = new Array(0, 1, 2, 3, 4, 4, 4, 4, 4, 4, 5, 6, 8, 7);		// size static NUM_VALS



var INUSE = 1;
var NOT_INUSE = 0;

var GPIO = 4;	// index for the GPIO string.
var RS485_TX_EN = 8;
var LINK_STAT = 7;

var func_arr;
var pin_func_opt;

// SCR
var scr;
var SCR_RS485 = 0x0008;

function OnChgLev(pinNo, level)
{
  var f = document.theform;
  var obj = "";
  var i;
  var idx, val, chosen;
  var skipNo = -1;
  var skipNo2 = -1;
  // detect pin number on which rs485 txen is selected at this time.
  
  for (i = 0; i < NUM_PINS; i++) {
		funcSel = eval("f.p" + i + "func");
		idx = funcSel.selectedIndex;
		val = funcSel.options[idx].value;
		chosen =  val_to_func_idx[parseInt(val)];
		if (isBitSet(scr, SCR_RS485)) {
			if ( chosen == RS485_TX_EN) {
			   skipNo = i;
			   if (i == pinNo) return;
			}
		}
		if ( chosen == LINK_STAT ) {
		   skipNo2 = i;
		   if (i == pinNo) return;
		}
  }
  for (i = 0; i < NUM_PINS; i++) {
     if ((i == pinNo) || (i == skipNo) || ( i == skipNo2 ))continue;
		obj = eval("f.p" + i + "level[" + level + "]");
		obj.checked = true;
  }
}

function disableDir(pinNo, dis)
{
   var f = document.theform;
   var idx, val, chosen;

   var objin = eval("f.p" + pinNo + "dir[0]");
   var objout = eval("f.p" + pinNo + "dir[1]");

   objin.disabled = dis;
   objout.disabled = dis;

   //mfmfmf???
   funcSel = eval("f.p" + pinNo + "func");
   idx = funcSel.selectedIndex;
   val = funcSel.options[idx].value;
   chosen =  val_to_func_idx[parseInt(val)];
   
   //objin = eval("f.p" + pinNo + "level[0]");
   //objout = eval("f.p" + pinNo + "level[1]");	
   //objin.disabled = false;
   //objout.disabled = false;
   //OnChgDir(pinNo, objout.checked);
}

// fill up the pin and function matrix based on the selected
// functions to determine the options that are available for every pin
function popPinFuncMatrix()
{
  var i, j;
  var pin;
  
  for (i = 0; i <= NUM_FUNCS; i++)
  {
    pin = func_arr[i];
    for (j = 0; j < NUM_PINS; j++)
    {
      if (pin == j)			// function in use for this pin.
        pin_func_opt[j][i] = INUSE;
      else if (pin == -1)   // function not assigned to any pin
	  {
		// check the pin restrictions for this function and accordingly
		// mark it INUSE or NOT_INUSE
		if ((func_pin_restrict[i] == 255) ||
		    (func_pin_restrict[i] == j))
           pin_func_opt[j][i] = INUSE;
	    else
		   pin_func_opt[j][i] = NOT_INUSE;
	  }
      else  				// function assigned to atleast some other pin.
        pin_func_opt[j][i] = NOT_INUSE;
    }       
  }
}  

function OnChgFunc(sel, pinNo)
{
  var f = document.theform;
  var objin = eval("f.p" + pinNo + "dir[0]");
  var objout = eval("f.p" + pinNo + "dir[1]"); 
  var rechex = "";
  var i;

  var pintab, rows, func_sel;
    
  // clear out this pin is it is in the func arr
  for (i = 0; i <= NUM_FUNCS; i++)
  {
    if (func_arr[i] == pinNo)
      func_arr[i] = -1; 
  }
  
  idx = sel.selectedIndex;
  val = sel.options[idx].value;
  funcidx = val_to_func_idx[parseInt(val)];
  if (funcidx != GPIO)
  {
    func_arr[funcidx] = pinNo;	// set this pinNo in the func arr if !GPIO
	disableDir(pinNo, true);
  }
  else{
    disableDir(pinNo, false);	// enable the direction (in turn trigger) if GPIO 
  }
  popPinFuncMatrix();
   
  // populate the options for each pins function select
  for (i = 0; i < NUM_PINS; i++)
  {
      func_sel = eval("f.p" + i + "func");
      popPinFuncOptions(func_sel, i, 0, true);
	  func_sel = eval("f.p" + i + "level[0].checked");
	  if( func_sel == true ){
		  OnChgLev(i, 0);
	  }
	  else{
		  OnChgLev(i, 1);
	  }
  } 

  
}

function popPinFuncOptions(funcSel, pinNo, selOpt, reuse)
{
  var darr = pin_func_opt[pinNo];
  var j, k = 0;
  var chosen;
  var idx, val;
  
  if (reuse)
  {
    idx = funcSel.selectedIndex;
    val = funcSel.options[idx].value;
    chosen =  val_to_func_idx[parseInt(val)];
  }
  else
    chosen = selOpt;    
  
  // clear out the current options in the selected function
  for (j = funcSel.options.length; j >= 0; j--) 
    funcSel.options[j] = null;
   
  for (j = 0; j <= NUM_FUNCS; j++)
  {
    if (darr[j] == INUSE)
      tempstr = func_name_arr[j];
    else
      continue;
    funcSel.options[k] = new Option(tempstr);
    funcSel.options[k].value = func_val_arr[j];       
    if (j == chosen)
      funcSel.options[k].selected = true;
    k++;  
  }
}

function popFields()
{
  var f = document.theform;
  var i, j;
  var func, funcidx;
  var obj, dirDis;
  var pintab, rows;
  var cells;
  var func_sel;
  var rechex = "";

  func_arr = new Array(NUM_FUNCS);
  
  // initialize the pin func array
  for (i = 0; i <= NUM_FUNCS; i++)
    func_arr[i] = -1;
  
  // initialize the pin and function matrix
  // also assign the pins to the functions that are already selected.  
  pin_func_opt = new Array(NUM_PINS);
  for (i = 0; i < NUM_PINS; i++)
  {
    func = (rec7[i] & 0x7f);
	if (func > NUM_VALS)	// make it gp input
	  func = GPIO + i * 2;
    funcidx = val_to_func_idx[func];
    if (funcidx != GPIO)			// if it is GPIO, then it is not a unique function.
      func_arr[funcidx] = i;
      
    pin_func_opt[i] = new Array(NUM_FUNCS);
  }
  popPinFuncMatrix();

  // populate the options for each pins function select
  pintab = document.getElementById("gpiotbl");
  rows = pintab.rows;
  for (i = 0; i < NUM_PINS; i++)
  {
    func_sel = eval("f.p" + i + "func");
    func = (rec7[i] & 0x7f);
	if (func > NUM_VALS)	// make it gp input
	  func = GPIO + i * 2;
    funcidx = val_to_func_idx[func];
    popPinFuncOptions(func_sel, i, funcidx, false);

    switch (func)	// direction
    {
      case 0x04:
      case 0x06:
      case 0x08: // GP I/P
                 // set the direction to input...
                 obj = eval("f.p" + i + "dir[0]");
                 obj.checked = true;
                 dirDis = false;
                 break;
      case 0x05:
      case 0x07:
      case 0x09: // GP O/P          
                 // set the direction to output... 
                 objout = eval("f.p" + i + "dir[1]");
                 objout.checked = true;
                 dirDis = false;
                 break;
      default:   obj = eval("f.p" + i + "dir[0]");
                 obj.checked = true;
                 dirDis = true;
                 break;                      
    }
    disableDir(i, dirDis);



    // active level
    func = rec7[124];
	if ((isBitSet(scr, SCR_RS485)) && (funcidx == RS485_TX_EN)){
	//if(funcidx == RS485_TX_EN){
	   func = rec7[124];		
		//mfmfmf???
		switch (func & 0x01)
		{
		  case 0x00: obj = eval("f.p" + i + "level[0]"); break; // active low
		  case 0x01: obj = eval("f.p" + i + "level[1]"); break; // active high
		}
		obj.checked = true;
	}
	else if( funcidx == LINK_STAT ){
		func = rec7[123];
		if( func & 0x01 ){
			obj = eval("f.p" + i + "level[1]");
			obj.checked = true;
			obj = eval("f.p" + i + "level[0]");
			obj.checked = false;
		}
		else{
			obj = eval("f.p" + i + "level[1]");
			obj.checked = false;
			obj = eval("f.p" + i + "level[0]");
			obj.checked = true;
		}
	}
	else{
		func = rec7[125];
		switch (func & 0x01)
		{
		  case 0x00: obj = eval("f.p" + i + "level[0]"); break; // active low
		  case 0x01: obj = eval("f.p" + i + "level[1]"); break; // active high
		}
		obj.checked = true;
	}
  }
}

function applyForm()
{
  var ok = true;
  var f = document.theform;
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
  var recval, i, obj;

  for (i = 0; i < NUM_VALS; i++)
    rec7[NUM_PINS+i] = 0;

  rec7[124] = 0;
  rec7[125] = 0;

  for (i = 0; i < NUM_PINS; i++)
  {
     recval = 0;
     
     obj = eval("f.p" + i + "func");
     idx = obj.selectedIndex;
     recval = parseInt(obj.options[idx].value);

     obj = eval("f.p" + i + "dir[1]");
     if (!obj.disabled) {
	    recval += (i * 2);
        if (obj.checked) recval += parseInt(obj.value);
     }

     rec7[i] = recval;
	 //rec7[NUM_PINS+recval] = 0x80;

     obj = eval("f.p" + i + "level[1]");
	 if (obj.checked) {
        if (isBitSet(scr, SCR_RS485))
		{
		  if (val_to_func_idx[recval] == RS485_TX_EN)
		     rec7[124] = parseInt(obj.value);
		  else{
             if( val_to_func_idx[recval] != LINK_STAT ){
				rec7[125] = parseInt(obj.value);
			 }
		  }
		}
		else{
			if( val_to_func_idx[recval] != LINK_STAT ){
				rec7[125] = parseInt(obj.value);
			}
		}
	 }

	 if( val_to_func_idx[recval] == LINK_STAT ){
		obj = eval("f.p" + i + "level[1]");
		if( obj.checked ){
		   rec7[123] = 1;
		}
		else{
		   rec7[123] = 0;
		}
	 }

  }
  // clear out the unused portion of record 7
  for (i=3;i<122;i++ )
  {
	  rec7[i] = 0;
  }
  recstr = rec7.join();
  RecDoc.SetRecord(7, recstr);
  reportDone();

  return ok;
}

// called when web page is loaded in the browser
// determines browser type and loads XML in the appropriate manner
function initPage()
{
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
   
  recstr = RecDoc.GetRecord(7);
  rec7 = recstr.split(",");

  recstr = RecDoc.GetSCR();
  scr = recstr.split(",");

  if (!(isBitSet(scr, SCR_RS485)))
  {
     NUM_FUNCS -= 1;
	 NUM_VALS -= 1;
  }

  // populate the fields from the setup records array
  popFields();
}
-->
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>

<LINK href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/validate.js"></script>
<script language="JavaScript" src="js/validatenetwork.js"></script>
<script language="JavaScript" src="js/util.js"></script>
<script language="JavaScript" src="hlist.js"></script>

</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->

<table cellSpacing=0 cellPadding=0 width="600" border=0>
  <tr>
    <td width=60>&nbsp;</td>

    <td class=datatitle width=480>Hostlist Settings</td>

    <!--
    <td class=datatitlehelp width=60><a class=datatitlehelp target="help" href="help.htm"><img height=21 width=50 src="images/help.gif" border=0></a></td>
    -->
    <td width=60>&nbsp;</td>
  </tr>
  <tr>
    <td class=color1back colspan=3><img height=2 src="images/spacer.gif" width=600 border=0></td>
  </tr>
</table>

<form name=theform>
<table cellSpacing=5 cellPadding=0 width="600" border=0 id="hostlisttbl">
  <tr>
    <td width=85><img height=1 src="images/spacer.gif" border=0></td>
	<td width=25><img height=1 src="images/spacer.gif" border=0></td>
    <td width=70><img height=1 src="images/spacer.gif" border=0></td>
    <td width=90><img height=1 src="images/spacer.gif" border=0></td>
	<td width=70><img height=1 src="images/spacer.gif" border=0></td>
	<td width=225><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>

    <td class=tabletitleleft colspan=6>Retry Settings</td>

  </tr>
  <tr>

    <td class=datalabel colspan=2>Retry Counter:</td>

    <td class=datavalue>
      <input type=text name=hlretrycnt size=4 maxlength=3>
    </td>

    <td class=datalabel>Retry Timeout:</td>

    <td class=datavalue colspan=2>
      <input type=text name=hlretryto size=6 maxlength=5>
    </td>
  </tr>
  <tr>
  	<td colspan=6><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>

    <td class=tabletitleleft colspan=6>Host Information</td>

  </tr>
  <tr>
    <td colspan=6>
      <table class=tablelight cellspacing=3 border=0 align=center id="hostdata">
        <tr>

          <td class=tableheader width=25>No.</td>
          <td class=tableheader>Host Address</td>
          <td class=tableheader>Port</td>
          <td class=tableheader width=25>No.</td>
          <td class=tableheader>Host Address</td>
          <td class=tableheader>Port</td>

        </tr>
        <tr>
          <td class=tableheader>1</td>
          <td class=tablefield>
		  	<input type=text name=h1ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h1port size=5 maxlength=5>
		  </td>
		  <td class=tableheader>2</td>
          <td class=tablefield>
		  	<input type=text name=h2ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h2port size=5 maxlength=5>
		  </td>      
        </tr>
		<tr>
          <td class=tableheader>3</td>
          <td class=tablefield>
		  	<input type=text name=h3ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h3port size=5 maxlength=5>
		  </td>      
		   <td class=tableheader>4</td>
          <td class=tablefield>
		  	<input type=text name=h4ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h4port size=5 maxlength=5>
		  </td>      
        </tr>
		<tr>
          <td class=tableheader>5</td>
          <td class=tablefield>
		  	<input type=text name=h5ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h5port size=5 maxlength=5>
		  </td>      
          <td class=tableheader>6</td>
          <td class=tablefield>
		  	<input type=text name=h6ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h6port size=5 maxlength=5>
		  </td>      
        </tr>
		<tr>
          <td class=tableheader>7</td>
          <td class=tablefield>
		  	<input type=text name=h7ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h7port size=5 maxlength=5>
		  </td>      
          <td class=tableheader>8</td>
          <td class=tablefield>
		  	<input type=text name=h8ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h8port size=5 maxlength=5>
		  </td>      
        </tr>
		<tr>
          <td class=tableheader>9</td>
          <td class=tablefield>
		  	<input type=text name=h9ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h9port size=5 maxlength=5>
		  </td>      
          <td class=tableheader>10</td>
          <td class=tablefield>
		  	<input type=text name=h10ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h10port size=5 maxlength=5>
		  </td>      
        </tr>
		<tr>
          <td class=tableheader>11</td>
          <td class=tablefield>
		  	<input type=text name=h11ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h11port size=5 maxlength=5>
		  </td>      
          <td class=tableheader>12</td>
          <td class=tablefield>
		  	<input type=text name=h12ip size=16 maxlength=15>
	      </td>	  
          <td class=tablefield>
       	    <input type=text name=h12port size=5 maxlength=5>
		  </td>      		  
        </tr>
	  </table>
	</td>  
  </tr>
</table>
</form>

<div id="appdiv" style="visibility:visible;">
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>

       <input type=button value="    OK    " onClick="return applyForm()">

    </td>
    <td id="statmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>  
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>
</div>

</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Setup Records Arrays


// #define equivalents
var HLRCNT_OFF = 0;
var HLRTO_OFF = 1;
var HLDATA_OFF = 3;

var HLIST_SIZE = 72;
var NUM_HLIST = 12 ;

// populate the hostlist table
function popHostListTab(arr)
{
   var f = document.theform;
   var i, j;
   var darr;
   var addr_off, port_off;
   var objip, objport;
   
   darr = arr.slice(HLDATA_OFF, HLDATA_OFF + HLIST_SIZE);
   j=0;
   for (i = 1; i <= NUM_HLIST; i++)
   {  
      addr_off = (j++) * 6;
      port_off = addr_off + 4;
     
      objip = eval("f.h" + i + "ip");
      objport = eval("f.h" + i + "port");
        
      objip.value = IPAddrToStr(darr, addr_off);
      objport.value = parseInt(darr[port_off]) + parseInt((darr[port_off+1] << 8));
   }            
}

function HostListTabToArr()
{
  var f = document.theform;
  var i, j; 
  var darr = new Array(HLIST_SIZE);
  var addr_off, port_off;      
  var tempArr = new Array();
  var recval;
  var objip, objport;
  
  j = 0;
  for (i = 1; i <= NUM_HLIST; i++)
  {
     objip = eval("f.h" + i + "ip");
     objport = eval("f.h" + i + "port");

     addr_off = (j++) * 6;
     port_off = addr_off + 4;

     tempArr = StrToIPAddr(objip.value);
     UpdateArr(darr, addr_off, 4, tempArr);
      
     recval = parseInt(objport.value, 10);
     darr[port_off] = recval & 0xff;
     darr[port_off + 1] = (recval >> 8) & 0xff;
  } 
  return darr;   
}

function verifyHostListTab()
{
  var f = document.theform;
  var i; 
  var addr, port;
  var ok = true;
  var objip, objport;
  var endOfList = false;
  var endMarker = 0;
   
  for (i = 1; i <= NUM_HLIST; i++)
  {
     objip = eval("f.h" + i + "ip");
     objport = eval("f.h" + i + "port");
 
     addr = objip.value;
     port = objport.value;
     

     ok = (verifyNumRange(port, 0, 65535, "Host List Port " + i, true) &&
           verifyIP(addr, "Host List Address " + i, true, true));

     if (!ok) break;      
     if (ok)
     {
       if ((addr == "0.0.0.0") && (parseInt(port, 10) == 0))
	   {
		   // Make a note of where we saw the first zero entry:
		   if(!endOfList)
			   endMarker = i;
		   endOfList = true;
		   ok = true;
	   }
         
       else if ((addr != "0.0.0.0") && (parseInt(port, 10) != 0))
	   {
		   if(endOfList)
		   {
			   alert("IP address \"0.0.0.0\" at entry " + endMarker + " marks end of list. \nAll subsequent entries must also be \"0.0.0.0\".");
			   return false;
		   }
		   else
               ok = true;
	   }
         
       else       
       {

         alert("Entry " + i + ": Both Host Address and Port must be valid.\n");

         return false;
       }  
     }     
  }   
  return ok;
}

function popFields()
{
  var f = document.theform;

  f.hlretrycnt.value = parseInt(rec3[HLRCNT_OFF]);
  f.hlretryto.value = parseInt(rec3[HLRTO_OFF]) + parseInt((rec3[HLRTO_OFF+1] << 8));
  
  popHostListTab(rec3);
}

// Called when Apply is selected; validates the fields, and if all is well,
// opens the status window, submits the form, and changes the frame contents.
function applyForm()
{
  var ok = true;
  var f = document.theform;
  var RecDoc = parent.frames.leftmenu;
  var recval;
  var tempArr = new Array();
    

  ok = (verifyNumRange(f.hlretrycnt.value, 0, 15, "Retry Count", true) &&
        verifyNumRange(f.hlretryto.value, 10, 65535, "Retry Timeout", true) &&
        verifyHostListTab()); 

         
  if (ok)
  {         
    rec3[HLRCNT_OFF] = parseInt(f.hlretrycnt.value, 10);
    
    recval = parseInt(f.hlretryto.value, 10);
    rec3[HLRTO_OFF] = recval & 0xff;
    rec3[HLRTO_OFF + 1] = (recval >> 8) & 0xff;

    tempArr = HostListTabToArr();
    UpdateArr(rec3, HLDATA_OFF, HLIST_SIZE, tempArr);

    recstr = rec3.join();
    RecDoc.SetRecord(3, recstr);    
    reportDone();
  }
  return ok;  
} // applyForm

// called when web page is loaded in the browser
function initPage()
{
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";

  recstr = RecDoc.GetRecord(3);
  rec3 = recstr.split(",");
  // populate the fields from the setup records array
  popFields();  
} // initPage

-->
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<html>
<head>

<META HTTP-EQUIV="Content-Type" CONTENT="text/html; CHARSET=iso-8859-1">


<title>Lantronix  XPort   Device Server</title> 

<BASE TARGET="data">

</head>

<FRAMESET rows="67,*,40" frameborder=0>
	<FRAME name="topbar" src=banner.htm frameborder=0 scrolling=no marginheight=0 marginwidth=0 noresize target="data">
	<FRAMESET cols="140,*" frameborder=0>
		<FRAME name="leftmenu" src=menu.htm frameborder=0 scrolling=no marginheight=0 marginwidth=0 noresize target="data">
		<FRAME name="data" src=welcome.htm frameborder=0 marginheight=0 marginwidth=0 noresize>
	</FRAMESET>
	<FRAME name="topbar" src=footer.htm frameborder=0 scrolling=no marginheight=0 marginwidth=0 noresize target="data">
</FRAMESET>
</html>
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
<head>

<link href="images/ltrx_style.css" type=text/css rel=stylesheet>

<base target="data">
</head>

<script language="JavaScript" src="js/util.js"></script>
<script language="JavaScript" src="menu.js"></script>

<body text=#000000 bgColor=#999999 leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">

<xml id="setuprec" src="setuprec.xml"></xml>

<form name=theform target="data" action="setup.cgi" method=post>

<table cellSpacing=0 cellPadding=0 width=140 border=0 id="linktbl">
  <tr>
    <td bgColor=#999999>
      <table cellSpacing=0 cellPadding=0 width=140 border=0>
        <tr>
          <td width=5></td>

          <td align=left width=30><a class=about href="welcome.htm" title="Device Server Home Page" onClick="highlight(null)"><img src="images/home.gif" width=20 height=20 border=0></a></td>

          <td align=right width=30>&nbsp;</td>
          <td width=10></td>
        </tr>
      </table>
    </td>
  </tr>
  <tr>
    <td class=topnav>

  
    <a name=netsettings class=topnav href="netset.htm" title="Configure IP address and hostname" onClick="highlight(this)">Network</a>
  

    </td>
  </tr>
  <tr>
    <td class=color2back><img height=2 src="images/spacer.gif" width=140 border=0></td>
  </tr>

  <tr>
    <td class=topnav>

  
    <a name=servsettings class=topnav href="servset.htm" title="Configure global server settings" onClick="highlight(this)">Server</a>
  

    </td>
  </tr>
  <tr>
    <td class=color2back><img height=2 src="images/spacer.gif" width=140 border=0></td>
  </tr>

  <tr>
    <td class=topnav>

  
    Serial Tunnel
  

    </td>
  </tr>
  <tr>
    <td class=botnav>

  
    <a name=hostlist class=botnav href="hlist.htm" title="Hostlist Settings" onClick="highlight(this)">Hostlist</a>
  

    </td>
  </tr>

  <tr>
    <td class=topnav>
  
    Channel 1
  
    </td>
  </tr>
  <tr>
    <td class=botnav>
 
  
    <a name=sersettings1 class=botnav href="serial.htm" title="Serial Settings" onClick="curr_chan=0; highlight(this)">Serial Settings</a>
  
 
    </td>
  </tr>
  <tr>
    <td class=botnav>
 
  
    <a name=connsettings1 class=botnav href="connset.htm" title="Connection Settings" onClick="curr_chan=0; highlight(this)">Connection</a>
  
 
    </td>
  </tr>




  <tr>
    <td class=topnav><a name=smtpset class=topnav href="smtpset.htm" title="SMTP and Email Trigger Settings" onClick="highlight(this)">Email</a></td>
  </tr>
  <tr>
    <td class=botnav><a name=trigset1 class=botnav href="smtptrig.htm" title="Email Trigger Settings" onClick="curr_trig=0; highlight(this)">Trigger 1</a></td>
  </tr>
  <tr>
    <td class=botnav><a name=trigset2 class=botnav href="smtptrig.htm" title="Email Trigger Settings" onClick="curr_trig=1; highlight(this)">Trigger 2</a></td>
  </tr>
  <tr>
    <td class=botnav><a name=trigset3 class=botnav href="smtptrig.htm" title="Email Trigger Settings" onClick="curr_trig=2; highlight(this)">Trigger 3</a></td>
  </tr>
  <tr> 
    <td class=color2back><img height=2 src="images/spacer.gif" width=140 border=0></td>
  </tr>





  <tr>
    <td class=topnav><a name=gpio class=topnav href="gpio.htm" title="Configurable Pins" onClick="highlight(this)">Configurable Pins</a></td>
  </tr>
  <tr>
    <td class=color2back><img height=6 src="images/spacer.gif" width=140 border=0></td>
  </tr>

  <tr>

    <td class=topnav><a name=applyset class=topnav href="" title="Apply Settings" onClick="return highlight(this)">Apply Settings</a></td>

  <tr><td style="height:40px"></td></tr>
  </tr>
  <tr>
    <td class=color2back><img height=6 src="images/spacer.gif" width=140 border=0></td>
  </tr>
  <tr>

    <td class=topnav><a name=applydef class=topnav href="subdef.htm" title="Apply Defaults" onClick="highlight(this)">Apply Defaults</a></td>

  </tr>
  <tr>
    <td class=color2back><img height=2 src="images/spacer.gif" width=140 border=0></td>
  </tr>
  <tr>
    <td class=color2back><img height=4 src="images/spacer.gif" width=140 border=0></td>
  </tr>
</table>

<input type=hidden name=def>
<input type=hidden name=rec0>
<input type=hidden name=rec1>
<input type=hidden name=rec3>
<input type=hidden name=rec5>
<input type=hidden name=rec6>
<input type=hidden name=rec7>
<input type=hidden name=rec8>
<input type=hidden name=rec9>
<input type=hidden name=loc value="applyset.htm">
</form>

</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--

var nnXmlDoc; // global var for navigating 
var xmlDoc;
// Setup Records Arrays
var rec0 = new Array();
var rec1 = new Array();
var rec3 = new Array();
var rec4 = new Array();
var rec5 = new Array();
var rec6 = new Array();
var rec7 = new Array();
var rec8 = new Array();
var rec9 = new Array();

var MAX_RECS = 15;
var rec_index = new Array();
var rec_attr = new Array();
var scr = new Array();
var apply_settings_flag=0;

// global variables indicating the current channel being configured
var curr_chan;

// global variable indicating the current trigger being configured
var curr_trig;

var NWInfoChanged = false; // indication if ip address or http port num has changed.

function GetCurrChanNo()
{
  return curr_chan;
}

function GetCurrTrigNo()
{
  return curr_trig;
}

function UnitNWInfoChange(changed)
{
  if (changed)
    NWInfoChanged = changed;
}

function nwinfo_changed()
{
  return NWInfoChanged;
}

function GetRecord(recno)
{
   var rec = "";

   switch (recno)
   {
     case 0: rec = rec0.join(); break;
     case 1: rec = rec1.join(); break;
     case 3: rec = rec3.join(); break;
     case 4: rec = rec4.join(); break;
     case 5: rec = rec5.join(); break;
     case 6: rec = rec6.join(); break;
     case 7: rec = rec7.join(); break;
     case 8: rec = rec8.join(); break;
     case 9: rec = rec9.join(); break;
     default: rec = null; break;
   }
   return rec;
}

function SetRecord(recno, recstr)
{
   switch (recno)
   {
     case 0: rec0 = recstr.split(","); break;
     case 1: rec1 = recstr.split(","); break;
     case 3: rec3 = recstr.split(","); break;
     case 5: rec5 = recstr.split(","); break;
     case 6: rec6 = recstr.split(","); break;
     case 7: rec7 = recstr.split(","); break;
     case 8: rec8 = recstr.split(","); break;
     case 9: rec9 = recstr.split(","); rec_attr[recno] = true; break;
     default: rec = null; break;
   }
}

function GetSCR()
{
   return (scr.join());
}

// fills in the setup records array from the XML document
function fillIn(xmldoc)
{
  var allRecs, recArr, nodeList;
  var recdata;
  var rechex = "";
  var i, j = 0;
  var rec, recno = "";
  
  // fill in the values in the fields
  allRecs = xmldoc.getElementsByTagName('SETUPREC').item(0);
  if (!allRecs)		// could not retrieve setuprec.xml (one possibility websetup is disabled)
  {
	  parent.frames.data.location.href = "dissetup.htm";
	  disableLinks();
  }
  else
  {
      for (j = 0; j < MAX_RECS; j++)
	     rec_attr[j] = false;
	  j = 0;
      recArr = allRecs.getElementsByTagName('RECORD');
  
	  while(j < recArr.length)
	  {  
	     nodeList = recArr[j].getElementsByTagName('NUM');
	     recno = nodeList.item(0).firstChild.nodeValue;
	     
	     nodeList = recArr[j].getElementsByTagName('DATA');
	     recdata = nodeList.item(0).firstChild.nodeValue; 
	     rechex = decode64(recdata);
	   
	     rec = null;
	     // based on the record number select the records array
	     switch (recno)
	     {
          case "00":
	  case " 0" : rec = rec0; break;
	  case "01":
	  case " 1" : rec = rec1; break;
          case "03":
	        case " 3" : rec = rec3; break;
          case "04":
	        case " 4" : rec = rec4; break;
          case "05":
	        case " 5" : rec = rec5; break;
          case "06":
	        case " 6" : rec = rec6; break;
          case "07":
	        case " 7" : rec = rec7; break;
          case "08":
	        case " 8" : rec = rec8; break;
          case "09":
	        case " 9" : rec = rec9; break;
	        default: break;
	     }

	     // store the records array
	     if (rec){
	        for (i = 0; i < rechex.length; i++)
	           rec[i] = rechex.charCodeAt(i);
	     }

	     // stored the received record numbers so we know which ones
	     // to send back.
	     rec_index[j] = recno;
		 
	     j++;
	  }

      // Read SCR from the XML file
	  nodeList = allRecs.getElementsByTagName('SCR').item(0);
	  recdata = nodeList.firstChild.nodeValue;
	  rechex = decode64(recdata);
	  for (i = 0; i < rechex.length; i++)
	     scr[i] = rechex.charCodeAt(i);

  }

} // fillIn

// event handler for Netscape - called when XML document is loaded
function documentLoaded(e) 
{
  fillIn(nnXmlDoc);
} // documentLoaded

//Function to convert xml file from String to Document, utility for chrome browser.
function StringToDoc(text)    
{
	var parser=new DOMParser();
	return parser.parseFromString(text, 'text/xml');
}

// called when web page is loaded in the browser
// determines browser type and loads XML in the appropriate manner


function initPage()
{
    var agt=navigator.userAgent.toLowerCase();
	
    if (agt.indexOf("chrome") != -1) 		//chrome
	{
	    xmlDoc = new XMLHttpRequest ();
		if(xmlDoc.overrideMimeType)
		{
			xmlDoc.overrideMimeType ('text/xml');
		}
		xmlDoc.onreadystatechange = function ()
		{
			if ((xmlDoc.readyState ==3 ) && (xmlDoc.status == 200) )
			{
				fillIn (StringToDoc (xmlDoc.responseText));              
			}	
		}
		xmlDoc.open ("GET", "/secure/setuprec.xml" ,true ,"","");                       
		xmlDoc.send (null);
		return;		
	}
	if (agt.indexOf("firefox") != -1)   	//Firefox & Netscape browsers returns firefox index.
	{  
	   xmlDoc = new XMLHttpRequest();
       xmlDoc.onreadystatechange = function ()
       {
		  if (xmlDoc.readyState == 4 && xmlDoc.status == 200 )
          {
				fillIn (xmlDoc.responseXML);
	      }
       }
       xmlDoc.open ("GET", "/secure/setuprec.xml" ,true ,"","");                       
       xmlDoc.send (null);
	   return;
	}
	if (agt.indexOf("safari") != -1) 	//'Safari';
	{
	    xmlDoc = new XMLHttpRequest ();
		if(xmlDoc.overrideMimeType)
		{
			xmlDoc.overrideMimeType ('text/xml');
		}
		xmlDoc.onreadystatechange = function ()
		{
			if ((xmlDoc.readyState ==3 ) && (xmlDoc.status == 200) )
			{
				fillIn (StringToDoc (xmlDoc.responseText));              
			}	
		}
		xmlDoc.open ("GET", "/secure/setuprec.xml" ,true ,"","");                       
		xmlDoc.send (null);
		return;		
	}
	if ((agt.indexOf("msie") != -1) || (agt.indexOf("gecko") != -1))	   // 'Internet Explorer';
	{
		var ie_version= parseFloat(agt.substring(agt.indexOf("msie")+5));  //IE10 & IE11
		if ((ie_version >= 10) || (agt.indexOf("gecko") != -1))
		{
			xmlDoc = new XMLHttpRequest ();
			if(xmlDoc.overrideMimeType)
			{
				xmlDoc.overrideMimeType ('text/xml');
			}
			xmlDoc.onreadystatechange = function ()
			{
				if ((xmlDoc.readyState ==3 ) && (xmlDoc.status == 200) )
				{
					fillIn (StringToDoc (xmlDoc.responseText));              
				}	
			}
			xmlDoc.open ("GET", "/secure/setuprec.xml" ,true ,"","");                       
			xmlDoc.send (null);
		}
		else
		{
			xmlDoc = document.getElementsByTagName('xml').item(0);
			fillIn(xmlDoc);
		}
		return;
	}
	  
} // initPage

// obtains the records and populated the form records fields
// making them ready for submit.
function popFormRecs()
{
   var i, j;
   var rec, formval;
   var f = document.theform;
   
   f.def.disabled = true;	// disable the default settings option

   for (i = 0; i < rec_index.length; i++)
   {
      switch (rec_index[i])
      {
         case "00":
         case " 0": rec = rec0; formval = f.rec0; break;
	 case "01":
         case " 1": rec = rec1; formval = f.rec1; break;
         case "03":
         case " 3": rec = rec3; formval = f.rec3; break;
         case "05":
         case " 5": rec = rec5; formval = f.rec5; break;
         case "06":
         case " 6": rec = rec6; formval = f.rec6; break;
         case "07":
         case " 7": rec = rec7; formval = f.rec7; break;
         case "08":
         case " 8": rec = rec8; formval = f.rec8; break;
         case "09":
         case " 9": rec = rec9; formval = f.rec9;
					if (!rec_attr[9])
                      formval.disabled = true;
					break;
      }

      // encode the record in base64 encoding and assign it to
      // form field
      formval.value = encode64(rec);
   }

   return true;
}

function popDefForm(menuDoc)
{
   var f = document.theform;

   f.rec0.disabled = true;
   f.rec1.disabled = true;
   f.rec3.disabled = true;
   f.rec5.disabled = true;
   f.rec6.disabled = true;
   f.rec7.disabled = true;
   f.rec8.disabled = true;
   f.rec9.disabled = true;

   f.def.disabled = false;
   f.def.value = 1;
   f.loc.value = "applydef.htm";
}

function applyDefaults()
{
    popDefForm();
    document.theform.submit();
    return false;
}

function highlight(item)
{
  var is_nav = ((document.layers) ||           // NN4
                (document.addEventListener));  // NN6
  var is_ie = ((document.all && !document.getElementById) || // IE4
               (document.all && document.getElementById)  ||   // IE5 & IE6
	       (document.documentMode));    //IE10 & IE11

  if (is_ie)
  {
    docroot = document.all;
  }
  else
  {
    docroot = document.links;
  }

  // turn off all links
  docroot.netsettings.className = 'topnav';
  docroot.servsettings.className = 'topnav';


  docroot.hostlist.className = 'botnav';



  docroot.sersettings1.className = 'botnav';
  docroot.connsettings1.className = 'botnav';


 

  docroot.smtpset.className = 'topnav';
  docroot.trigset1.className = 'botnav';
  docroot.trigset2.className = 'botnav';
  docroot.trigset3.className = 'botnav';




  docroot.gpio.className = 'topnav';

  docroot.applyset.className = 'topnav';
  docroot.applydef.className = 'topnav';
  
  // turn on the link that was selected
  if (item)
    item.className = 'topnavcurr';
  
  if (item == docroot.applyset)
    {
	  if(apply_settings_flag == 0)
	    {
	      popFormRecs();
          document.theform.submit();
	    }
	  else
	    {
	      alert("Please wait, the previous Apply Settings request is in progress.");
	    }
	  apply_settings_flag ++;
      return false;
   }

  if (item == docroot.applydef)
  {
  //  popDefForm();
  //  document.theform.submit();
  //  return false;
  }
  
  return true;
} // highlight

function disableLinks()
{
  var is_nav = ((document.layers) ||           // NN4
                (document.addEventListener));  // NN6
  var is_ie = ((document.all && !document.getElementById) || // IE4
               (document.all && document.getElementById)  ||   // IE5 & IE6
	       (document.documentMode));    //IE10 & IE11

  if (is_ie)
  {
    docroot = document.all;
  }
  else
  {
    docroot = document.links;
  }

  // turn off all links
  docroot.netsettings.href = "dissetup.htm";
  docroot.servsettings.href = "dissetup.htm";

  docroot.hostlist.href = "dissetup.htm";


  docroot.sersettings1.href = "dissetup.htm";
  docroot.connsettings1.href = "dissetup.htm";



  docroot.smtpset.href = "dissetup.htm";
  docroot.trigset1.href = "dissetup.htm";
  docroot.trigset2.href = "dissetup.htm";
  docroot.trigset3.href = "dissetup.htm";



  docroot.gpio.href = "dissetup.htm";

  docroot.applyset.href = "dissetup.htm";
  docroot.applydef.href = "dissetup.htm";

}

-->
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>

<LINK href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/validatenetwork.js"></script>
<script language="JavaScript" src="js/util.js"></script>
<script language="JavaScript" src="netset.js"></script>

</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table cellSpacing=0 cellPadding=0 width="600" border=0>
  <tr>
    <td width=60>&nbsp;</td>

    <td class=datatitle width=480>Network Settings</td>


    <td width=60>&nbsp;</td>
  </tr>
  <tr>
    <td class=color1back colspan=3><img height=2 src="images/spacer.gif" width=600 border=0></td>
  </tr>
</table>

<form name=theform method=post>
<table cellSpacing=5 cellPadding=0 width="600" border=0>
  <tr>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
	<td width=50><img height=1 src="images/spacer.gif" border=0></td>
    <td width=430><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  
  <tr>
    <td class=datalabel>Network Mode:</td>
    <td class=datavalue>
      <select name=nwif onChange="ChkNWMode();">
        <option value='0x00'>Wired Only</option>

      </select>
    </td>
  </tr>
  
  <tr>

    <td class=tabletitleleft colspan=3>IP Configuration</td>

  </tr>
  
  <tr>
    <td class=datavalueright>
      <input type=radio name=dynip onClick="ChangeDynIp(true);">
    </td>

    <td class=datalabelleft colspan=2>Obtain IP address automatically</td>

  </tr>
  <tr>
    <td></td>
    <td class=datalabelleft colspan=2>Auto Configuration Methods</td>
  </tr>
  <tr> 

    <td class=datalabelright colspan=2>BOOTP:</td>

    <td class=datavalue>
      <input name=nobootp type=radio>Enable
      <input name=nobootp type=radio>Disable
    </td>
  </tr>
  <tr>

    <td class=datalabelright colspan=2>DHCP:</td>

    <td class=datavalue>
      <input name=nodhcp type=radio>Enable
      <input name=nodhcp type=radio>Disable
    </td>
  </tr>
  
  <tr>
  

    <td class=datalabelright colspan=2>AutoIP:</td>

    <td class=datavalue>
      <input name=noautoip type=radio>Enable
      <input name=noautoip type=radio>Disable
    </td>
  
  </tr>
  <tr>
    <td colspan=3><img height=2 src="images/spacer.gif" border=0></td>
  </tr>
  
  <tr>  

    <td class=datalabelright colspan=2>DHCP Host Name:</td>

    <td class=datavalue>
      <input type=text name=dhcphname size=16 maxlength=16>
    </td>
  </tr>
  <tr>
    <td colspan=3><img height=4 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td class=datavalueright>
       <input type=radio name=dynip onClick="ChangeDynIp(false);">
    </td>

    <td class=datalabelleft colspan=2>Use the following IP configuration:</td>

  </tr>
  
  <tr>     

    <td class=datalabel colspan=2>IP Address:</td>

    <td class=datavalue>
      <input type=text name=ipaddr size=16 maxlength=15>
    </td>
  </tr>
  <tr>

    <td class=datalabel colspan=2>Subnet Mask:</td>

    <td class=datavalue>
      <input type=text name=ipmask size=16 maxlength=15>
    </td>
  </tr>
  <tr>

    <td class=datalabel colspan=2>Default Gateway:</td>

    <td class=datavalue>
      <input type=text name=ipgw size=16 maxlength=15>
    </td>
  </tr>

  <tr>
    <td class=datalabel colspan=2>DNS Server:</td>
    <td class=datavalue>
      <input type=text name=dnsip size=16 maxlength=15>
    </td>
  </tr>



  <tr><td colspan=3><hr width=100%></td></tr>
  <tr>

    <td class=tabletitleleft colspan=3>Ethernet Configuration</td>

  </tr>
  <tr>
    <td class=datavalueright>
       <input type=checkbox name=autoneg onClick="ChangeEthMode(this.checked);">
    </td>

    <td class=datalabelleft colspan=2>Auto Negotiate</td>

  </tr>  
  <tr> 

    <td class=datalabelright colspan=2>Speed:</td>

    <td class=datavalue>
      <input name=speed type=radio value='0x04'>100 Mbps
      <input name=speed type=radio value='0x02'>10 Mbps
    </td>
  </tr>
  <tr> 

    <td class=datalabelright colspan=2>Duplex:</td>

    <td class=datavalue>
      <input name=duplex type=radio value='0x01'>Full    
      <input name=duplex type=radio value='0x00'>Half
    </td>
  </tr>

</table>

<!--
<table cellSpacing=5 cellPadding=0 width="600" border=0>
  <tr>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
	<td width=50><img height=1 src="images/spacer.gif" border=0></td>
    <td width=430><img height=1 src="images/spacer.gif" border=0></td>
  </tr>

</table>
-->

</form>

<div id="appdiv" style="visibility:visible;">
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>

       <input type=button value="    OK    " onClick="return applyForm()">

    </td>
    <td id="statmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>  
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>
</div>

</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Setup Records Arrays




// #define equivalents
var IPADDR_OFF  = 0;
var NETMASK_OFF = 6;
var GWADDR_OFF  = 12;
var BRDG_OFF	= 5;
var GENW_OFF	= 0;
var DNS_OFF     = 88;

var BRIDGE_MASK = 0x04;
var WIRELESS_EN = 0x01;

var NO_AUTOIP   = 0x01;
var NO_DHCP     = 0x02;
var NO_BOOTP    = 0x04;

var DHCP_NAME_0_OFF = 112;
var DHCP_NAME_3_OFF = 102;

var ETHMODE_OFF = 77;

var old_ip;		// to store ip address when config started.
var new_ip;		// to compare and see if it has changed.











// handler to take care of changes in ethernet mode selection
function ChangeEthMode(dis)
{
  var f = document.theform;

  f.speed[0].disabled = dis;
  f.speed[1].disabled = dis;
  f.duplex[0].disabled = dis;
  f.duplex[1].disabled = dis;
}


function ChkNWMode()
{
  var f = document.theform;

  switch(f.nwif.selectedIndex)
  {
    case 1:
	  f.autoneg.disabled = true;
	  ChangeEthMode(f.autoneg.disabled);
	  break;
	case 0:
	case 2:
	  f.autoneg.disabled = false;
	  ChangeEthMode(f.autoneg.checked)
      break;
  }

}

// handler to display or disable the dynamic ip configuration section
// associated with the onClick function of the radio buttons.  
function ChangeDynIp(dyn)
{
  var f = document.theform;
  var dis = !dyn;
  
  f.noautoip[0].disabled = dis;
  f.noautoip[1].disabled = dis;
  f.nodhcp[0].disabled = dis;
  f.nodhcp[1].disabled = dis;
  f.nobootp[0].disabled = dis;
  f.nobootp[1].disabled = dis;
  f.dhcphname.disabled = dis;
  
  f.ipaddr.disabled = dyn;
  f.ipmask.disabled = dyn;
  f.ipgw.disabled = dyn;
  f.dnsip.disabled = dyn;
}


// fills in the fields with the values from setup records array
// once the fields are filled in, enables/disabled fields as appropriate
function popFields()
{
  var f = document.theform;
  var ipaddr = "";
  var nmask = "";
  var gwaddr = "";
  var hname1 = ""; hname2 = "";
  var i = 0, dyn = false;
  var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;

  // Unit IP Configuration  
  var ipArray = rec0.slice(IPADDR_OFF, IPADDR_OFF + 4);
  var nmaskArray = getNetMask(rec0[NETMASK_OFF]);

  old_ip = ipaddr = IPAddrToStr(rec0, IPADDR_OFF);
  nmask = IPAddrToStr(nmaskArray, 0);
  gwaddr = IPAddrToStr(rec0, GWADDR_OFF);
  dnss = IPAddrToStr(rec3, DNS_OFF);


  if ((ipArray[0] == 0) && (ipArray[1] == 0)) 
    dyn = true;
  else
    dyn = false;

  // setting the dhcp host name
  if (rec0[DHCP_NAME_0_OFF])
  {
    hname1 = ArrToStr(rec0, DHCP_NAME_0_OFF, 8);
    if (rec3[DHCP_NAME_3_OFF])
      hname2 = ArrToStr(rec3, DHCP_NAME_3_OFF, 8);
    else
      hname2 = "";
        
    f.dhcphname.value = hname1 + hname2;
  }
  else
    f.dhcphname.value = "";   

  // setting all the properties from the obtained values
  if (dyn) {
    f.dynip[0].checked = true;
    (ipArray[2] & NO_AUTOIP) ? f.noautoip[1].checked = true : f.noautoip[0].checked = true;
    (ipArray[2] & NO_DHCP) ? f.nodhcp[1].checked = true : f.nodhcp[0].checked = true;
    (ipArray[2] & NO_BOOTP) ? f.nobootp[1].checked = true : f.nobootp[0].checked = true;
     
    f.dynip[1].checked = false;
    f.ipaddr.value = "";
    f.ipmask.value = "";
    f.ipgw.value = "";
	// C-071219-102965 ipdns java script error 
	f.dnsip.value = "";
  }
  else {
    f.dynip[0].checked = false;   
    f.dynip[1].checked = true;
    f.noautoip[0].checked = true;
    f.nodhcp[0].checked = true;
    f.nobootp[0].checked = true;
    f.ipaddr.value = ipaddr;
    f.ipmask.value = nmask;
    f.ipgw.value = gwaddr;
	f.dnsip.value = dnss;
  }  
  ChangeDynIp(dyn);	  // select the correct set to disable


  i = (rec3[ETHMODE_OFF] & 0x07); 
  if (!i) {
    f.autoneg.checked = true;
	f.speed[0].checked = true;
	f.duplex[0].checked = true;
  }
  else {
	(i & 0x01) ? f.duplex[0].checked = true : f.duplex[1].checked = true;
	switch (i & 0x06) {
	  default:
	  case 0x04: f.speed[0].checked = true; break;
	  case 0x02: f.speed[1].checked = true; break;
	}
  }



  f.nwif.options[0].selected = true;
  f.nwif.options.length = 1;

  ChkNWMode();
}

// Called when Apply is selected; validates the fields, and if all is well,
// opens the status window, submits the form, and changes the frame contents.
function applyForm()
{
  var ok = true;
  var f = document.theform;
  var RecDoc = parent.frames.leftmenu;
  var i = 0, dyn = false;
  var ipaddr = "";
  var nmask = "";
  var gwaddr = "";
  var hname1 = ""; hname2 = "";
  var tempArr = new Array();
  var recstr = "";
  
  (f.dynip[0].checked) ? dyn = true : dyn = false; 
  if (dyn) {
    ipaddr = "0.0.";
    aconfig = 0;
    if (f.noautoip[1].checked) aconfig |= NO_AUTOIP;
    if (f.nodhcp[1].checked) aconfig |= NO_DHCP;
    if (f.nobootp[1].checked) aconfig |= NO_BOOTP;
    ipaddr = ipaddr + aconfig + ".0";
    nmask = "0.0.0.0";
    gwaddr = "0.0.0.0";  
	dnss = "0.0.0.0";
  } 
  else {
    ipaddr =  f.ipaddr.value;
    nmask = f.ipmask.value;
    gwaddr = f.ipgw.value;
	dnss = f.dnsip.value;

    

    ok = (verifyIP(ipaddr, "IP Address", true, false) &&
          verifyMask(nmask, "Subnet Mask") &&    
          verifyIP(gwaddr, "Default Gateway", false, true) &&
		  verifyIP(dnss, "DNS Server", false, true));

  }
  if (ok) {
    hname1 = f.dhcphname.value;
    // verify hostname to contain ... whatever restrictions we have to apply
    if (hname1.length > 8)
      hname2 = hname1.substr(8);
    else
      hname2 = "";
  }      
  if (ok) {         
    // update the setup records global array..
    new_ip = ipaddr;
    if ((new_ip != old_ip) || (ipaddr == "0.0.0.0"))
      RecDoc.UnitNWInfoChange(true);

	if(gwaddr == "")
		gwaddr = "0.0.0.0";
    if(dnss == "")
        dnss = "0.0.0.0";

    tempArr = StrToIPAddr(ipaddr);
    UpdateArr(rec0, IPADDR_OFF, 4, tempArr); 
    tempArr = StrToIPAddr(gwaddr);
    UpdateArr(rec0, GWADDR_OFF, 4, tempArr);     
	
	tempArr = StrToIPAddr(dnss);
    UpdateArr(rec3, DNS_OFF, 4, tempArr);

    i = StrToNetMask(nmask);
    rec0[NETMASK_OFF] = i;                    

    tempArr = StrToArr(hname1, 8);
    UpdateArr(rec0, DHCP_NAME_0_OFF, 8, tempArr);
    tempArr = StrToArr(hname2, 8);
    UpdateArr(rec3, DHCP_NAME_3_OFF, 8, tempArr);

    i = rec3[ETHMODE_OFF];
    i &= 0xf8;
	if (!f.autoneg.checked) {
	  if (f.speed[0].checked)
	    i |= f.speed[0].value
	  else
	    i |= f.speed[1].value;
	  if (f.duplex[0].checked) 
	    i |= f.duplex[0].value;
	}
	rec3[ETHMODE_OFF] = i;

    // Network Mode settings   
	rec8[GENW_OFF] &= 0xfe; 
	rec0[BRDG_OFF] &= ~BRIDGE_MASK;
    i = f.nwif.selectedIndex;
	rec8[GENW_OFF] |= (parseInt(f.nwif.options[i].value) & 0x01);
	rec0[BRDG_OFF] |= (parseInt(f.nwif.options[i].value) & 0x04);
  
    recstr = rec0.join();
    RecDoc.SetRecord(0, recstr); 
    recstr = rec3.join();
    RecDoc.SetRecord(3, recstr);
    recstr = rec8.join();
    RecDoc.SetRecord(8, recstr);
    reportDone();
  }
  return ok;   
} // applyForm

// called when web page is loaded in the browser
function initPage()
{
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
  
  recstr = RecDoc.GetRecord(0);
  rec0 = recstr.split(",");
  recstr = RecDoc.GetRecord(3);
  rec3 = recstr.split(",");

  //  to check for wired vs wireless config...
  recstr = RecDoc.GetRecord(8);
  rec8 = recstr.split(",");	
  // populate the fields from the setup records array
  popFields(); 
} // initPage



-->

HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>

<LINK href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/util.js"></script>
<script language="JavaScript" src="serial.js"></script>
</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table cellSpacing=0 cellPadding=0 width="600" border=0>
  <tr>
    <td width=60>&nbsp;</td>

    <td class=datatitle width=480>Serial Settings</td>


    <td width=60>&nbsp;</td>
  </tr>
  <tr>
    <td class=color1back colspan=3><img height=2 src="images/spacer.gif" width=600 border=0></td>
  </tr>
</table>

<form name=theform>
<table cellSpacing=0 cellPadding=0 width="600" border=0 id="chaninfo">
  <tr>
    <td class=datalabelleftlarge colspan=2>
    <!-- dynamic label gets inserted here via Javascript-->
    </td>
  </tr>
  <tr>
    <td colspan=2><img height=5 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td class=datavalueright width=80>
      <input type=checkbox name=serdisyn value='0xFF' onClick="OnChgDisSerPort(this)">
    </td>

    <td class=datalabelleft width=520>Disable Serial Port</td>

  </tr>
</table>
<table cellSpacing=5 cellPadding=0 width=600 border=0 id="sersettbl">
  <tr>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
    <td width=60><img height=1 src="images/spacer.gif" border=0></td>
    <td width=55><img height=1 src="images/spacer.gif" border=0></td>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
    <td width=75><img height=1 src="images/spacer.gif" border=0></td>
    <td width=40><img height=1 src="images/spacer.gif" border=0></td>
    <td width=90><img height=1 src="images/spacer.gif" border=0></td>
    <td width=40><img height=1 src="images/spacer.gif" border=0></td>
    <td width=25><img height=1 src="images/spacer.gif" border=0></td>
    <td width=70><img height=1 src="images/spacer.gif" border=0></td>
    <td width=55><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>

    <td class=tabletitleleft colspan=11>Port Settings</td>     

  </tr>
  <tr>

    <td class=datalabel colspan=2>Protocol:</td>

    <td class=datavalue colspan=4>
      <select name=serproto>
        <option value='0x00'>RS232</option>

        <option value='0x01'>RS422/RS485 - 4 wire</option>
        <option value='0x03'>RS485 - 2 wire</option>

      </select>
    </td>

    <td class=datalabel>Flow Control:</td>

    <td class=datavalue colspan=4>
      <select name=flow>

        <option value='0x00'>None</option>
        <option value='0x01'>Xon/Xoff</option>
        <option value='0x05'>Xon/Xoff Pass Chars to Host</option>
        <option value='0x02'>CTS/RTS (Hardware)</option>

      </select>
    </td>  
  </tr>
  <tr>

    <td class=datalabel colspan=2>Baud Rate:</td>

    <td class=datavalue colspan=2>
      <select name=baud>
		    <option value='0x07'>300</option>
		    <option value='0x06'>600</option>
		    <option value='0x05'>1200</option>
        <option value='0x04'>2400</option>
        <option value='0x03'>4800</option>
        <option value='0x02'>9600</option>
		    <option value='0x01'>19200</option>
        <option value='0x00'>38400</option>
        <option value='0x09'>57600</option>
        <option value='0x08'>115200</option>
        <option value='0x0A'>230400</option>
        <option value='0x0B'>460800</option>
        <option value='0x0C'>921600</option>
      </select>
    </td>

    <td class=datalabel>Data Bits:</td>

    <td class=datavalue>
      <select name=data>
        <option value='0x08'>7</option>
        <option value='0x0C'>8</option>
      </select>
    </td>

    <td class=datalabel>Parity:</td>

    <td class=datavalue colspan=2>
      <select name=parity>

        <option value='0x00'>None</option>
        <option value='0x30'>Even</option>
        <option value='0x10'>Odd</option>

      </select>
    </td>

    <td class=datalabel>Stop Bits:</td>

    <td class=datavalue>
      <select name=stop>
        <option value='0x40'>1</option>
        <option value='0xC0'>2</option>
      </select>
    </td>
  </tr>
  <tr>
    <td colspan=11><hr width="100%" /></td>
  </tr>
<!-- PACK CONTROL -->
  <tr>

    <td class=tabletitleleft colspan=11>Pack Control</td>

  </tr>
  <tr>
    <td class=datavalueright colspan=2>
      <input type=checkbox name=packyn value='0x80' onClick="OnChgPackCtrl(this)">
    </td>

    <td class=datalabelleft colspan=9>Enable Packing</td>

  </tr>
  <tr>

    <td class=datalabel colspan=3>Idle Gap Time:</td>

	<td class=datavalue colspan=3>
	  <select name=pctrlidle>

        <option value='0x00'>12 msec</option>
        <option value='0x01'>52 msec</option>
        <option value='0x02'>250 msec</option>
        <option value='0x03'>5000 msec</option>

      </select>
	</td>  
  </tr>
  <tr>

    <td class=datalabel colspan=3>Match 2 Byte Sequence:</td>
	<td class=tablefield colspan=3>
	  <input name=pctrlmseq type=radio value='0x10'>Yes
	  <input name=pctrlmseq type=radio value='0x00'>No
	</td>
    <td class=datalabel colspan=2>Send Frame Immediate:</td>
	<td class=tablefield colspan=3>
	  <input name=pctrlsendf type=radio value='0x20'>Yes
	  <input name=pctrlsendf type=radio value='0x00'>No

	</td>
  </tr>
  <tr>

    <td class=datalabel colspan=3>Match Bytes:</td>

	<td class=datavalue colspan=3>
	  0x<input type=text name=pctrlmdata1 size=2 maxlength=2> &nbsp

	  0x<input type=text name=pctrlmdata2 size=2 maxlength=2> (Hex)
	</td>
    <td class=datalabel colspan=2>Send Trailing Bytes:</td>
	<td class=tablefield colspan=3>
	  <input name=pctrltrail type=radio value='0x00'>None
	  <input name=pctrltrail type=radio value='0x04'>One
	  <input name=pctrltrail type=radio value='0x08'>Two

	</td>
  </tr>
  <tr>
    <td colspan=11><hr width="100%" /></td>
  </tr>
<!-- FLUSH MODE -->
  <tr>

    <td class=tabletitleleft colspan=11>Flush Mode</td>

  </tr>
  <tr>
    <td></td>

    <td class=tabletitleleft colspan=4>Flush Input Buffer</td>
    <td></td>
    <td class=tabletitleleft colspan=5>Flush Output Buffer</td>

  </tr>
  <tr>

    <td class=datalabel colspan=3>With Active Connect:</td>
	<td class=datavalue colspan=2>
	  <input name=fliactconn type=radio value='0x10'>Yes
	  <input name=fliactconn type=radio value='0x00'>No

	</td>
	<td></td>

	<td class=datalabel colspan=2>With Active Connect:</td>
	<td class=datavalue colspan=3>
	  <input name=floactconn type=radio value='0x01'>Yes
	  <input name=floactconn type=radio value='0x00'>No

	</td>    
  </tr>
  <tr>

    <td class=datalabel colspan=3>With Passive Connect:</td>
	<td class=datavalue colspan=2>
	  <input name=flipassconn type=radio value='0x20'>Yes
	  <input name=flipassconn type=radio value='0x00'>No

	</td>
	<td></td>

	<td class=datalabel colspan=2>With Passive Connect:</td>
	<td class=datavalue colspan=3>
	  <input name=flopassconn type=radio value='0x02'>Yes
	  <input name=flopassconn type=radio value='0x00'>No

	</td>  
  </tr>    
  <tr>

    <td class=datalabel colspan=3>At Time of Disconnect:</td>
	<td class=datavalue colspan=2>
	  <input name=flidisc type=radio value='0x40'>Yes
	  <input name=flidisc type=radio value='0x00'>No

	</td>  
	<td></td>

    <td class=datalabel colspan=2>At Time of Disconnect:</td>
	<td class=datavalue colspan=3>
	  <input name=flodisc type=radio value='0x04'>Yes
	  <input name=flodisc type=radio value='0x00'>No

	</td>  
  </tr>
</table>
</form>

<div id="appdiv" style="visibility:visible;">
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>

       <input type=button value="    OK    " onClick="return applyForm()">

    </td>
    <td id="statmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>  
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>
</div>

</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Setup Records Arrays
var rec0;
var rec3;

// SCR
var scr;
var SCR_RS485 = 0x0008;
var SCR_BAUD_920K = 0x0010;
var SCR_BAUD_230K = 0x0120;
var UDP_MODE = 0x0C;
var CMODE_OFF = 12;
var DMODE_OFF = 13;


// constant strings for dynamic options	(string, value pair)
var serproto_opts = new Array(
    "RS232", "0x00"

    ,"RS422/RS485 - 4 wire", "0x01"


    ,"RS485 - 2 wire", "0x03"

    );

var baud_opts = new Array(
    "300", "0x07"
    , "600", "0x06"
    , "1200", "0x05"
    , "2400", "0x04"
    , "4800", "0x03"
    , "9600", "0x02"
    , "19200", "0x01"
    , "38400", "0x00"
    , "57600", "0x09"
    , "115200", "0x08"
 	, "230400", "0x0A"
    , "460800", "0x0B"
    , "921600", "0x0C"
);

var flow_opts = new Array(
      "None",                          "0x00"
     , "Xon/Xoff",                     "0x01"
     , "Xon/Xoff Pass Chars to Host",  "0x05"
     , "CTS/RTS (Hardware)",           "0x02"
);

// #define equivalents
var CHAN_ID;

// #define equivalents
var CHAN0_OFF = 16;	// offsets into record 0 directly
var CHAN1_OFF = 64;	// offsets into record 0 directly
var CH_PARAM_SIZE = 48;	// size of channel specific parameters.

//relative offset within the channel parameters
var LINEIF_OFF = 0;
var SPEED_OFF = 1;
var FC_OFF = 2;

var PCKCTRL_OFF = 19;
var SNDCHAR_OFF = 16;
var FLMODE_OFF = 18;


function OnChgDisSerPort(serdis)
{
  var sertab = document.getElementById("sersettbl");
  var f = document.theform;
  
  sertab.disabled = serdis.checked;
  
  // fields with select input type within a table are not disabled
  // have to explicitly set them.
  f.serproto.disabled = serdis.checked;
  f.flow.disabled = serdis.checked;
  f.baud.disabled = serdis.checked;
  f.data.disabled = serdis.checked;
  f.parity.disabled = serdis.checked;
  f.stop.disabled = serdis.checked;
  
  f.fliactconn[0].disabled = serdis.checked;
  f.fliactconn[1].disabled = serdis.checked;
  f.flipassconn[0].disabled = serdis.checked;
  f.flipassconn[1].disabled = serdis.checked;
  f.flidisc[0].disabled = serdis.checked;
  f.flidisc[1].disabled = serdis.checked;

  f.floactconn[0].disabled = serdis.checked;
  f.floactconn[1].disabled = serdis.checked;
  f.flopassconn[0].disabled = serdis.checked;
  f.flopassconn[1].disabled = serdis.checked;
  f.flodisc[0].disabled = serdis.checked;
  f.flodisc[1].disabled = serdis.checked;
   
  //f.pctrlidle.disabled = serdis.checked;
  f.packyn.disabled = serdis.checked;
  OnChgPackCtrl(f.packyn);   
}

function OnChgPackCtrl(packyn)
{
   var f = document.theform;
   var dis;
   var tmp = false;
 
   if(f.packyn.disabled)dis = true;
   else dis = !(packyn.checked);

   f.pctrlidle.disabled = dis;
   f.pctrlmseq[0].disabled = dis;
   f.pctrlmseq[1].disabled = dis;
   f.pctrlmdata1.disabled = dis;
   f.pctrlmdata2.disabled = dis;
   f.pctrlsendf[0].disabled = dis;
   f.pctrlsendf[1].disabled = dis;
   f.pctrltrail[0].disabled = dis;
   f.pctrltrail[1].disabled = dis;
   f.pctrltrail[2].disabled = dis;
}

function popSerProtoSelect(curropt)
{
  var f = document.theform;
  var sp = f.serproto;
  var selidx, size;
  var rs485 = 0;

/* change specific for products that support RS485 on one or both channels */

  rs485 |= 0x01;


  if (isBitSet(scr, SCR_RS485)) {
     if (rs485 & (1 << CHAN_ID))
	 {
		size = 3;
		switch (curropt & 0x03) { 
			case 0: selidx = 0; break;
			case 1: selidx = 1; break;
			case 3: selidx = 2; break;
		}
	 }
	 else{
	   size = 1; selidx = 0;
	 }
  } 
  else {
	size = 1; selidx = 0;
  }
  popOptions(sp, size, serproto_opts, selidx);
}

function popBaudSelect(selidx)
{
  var f = document.theform;
  var bsel = f.baud;
  var size;

  size = 10;	// common set across all products.

  if (isBitSet(scr, SCR_BAUD_230K))
	size += 1;

  if( rec3[116] & 0x80 ){
	  if (isBitSet(scr, SCR_BAUD_920K))
		size += 2;
  }
  popOptions(bsel, size, baud_opts, selidx);
}

function popFlowSelect(curropt)
{
  var f = document.theform;
  var bflow= f.flow;
  var size, selidx;

    size = 4;
    switch(curropt & 0xff)
    {
      case 0x00: selidx = 0 ; break;
      case 0x01: selidx = 1; break;
      case 0x02: selidx = 3; break;
      case 0x05: selidx = 2; break;
      default: break;
    }

  popOptions(bflow, size, flow_opts, selidx);
}

function popFields()
{
  var f = document.theform;
  var df = document.dform;
  var chanParams;
  var curropt;
  var selidx;
    
  if (CHAN_ID == 0)
     chanParams = rec0.slice(CHAN0_OFF, CHAN0_OFF + CH_PARAM_SIZE);
  else if (CHAN_ID == 1) 
     chanParams = rec0.slice(CHAN1_OFF, CHAN1_OFF + CH_PARAM_SIZE); 

  curropt = chanParams[LINEIF_OFF];
  popSerProtoSelect(curropt);

  switch (curropt & 0x0c)
  {
    case 0x08: f.data.options[0].selected = true; break;
    case 0x0c: f.data.options[1].selected = true; break;
    default: break;
  }
  
  switch (curropt & 0x30)
  {
    case 0x00: f.parity.options[0].selected = true; break;
    case 0x30: f.parity.options[1].selected = true; break;
    case 0x10: f.parity.options[2].selected = true; break;
    default: break;
  }
  
  switch (curropt & 0xc0)
  {
    case 0x40: f.stop.options[0].selected = true; break;
    case 0xc0: f.stop.options[1].selected = true; break;
    default: break;
  }
  curropt = chanParams[SPEED_OFF];
  switch (curropt & 0xff)
  {
    case 0x00: selidx = 7; break;
    case 0x01: selidx = 6; break;
    case 0x02: selidx = 5; break;
    case 0x03: selidx = 4; break;
    case 0x04: selidx = 3; break;
    case 0x05: selidx = 2; break;
    case 0x06: selidx = 1; break;
    case 0x07: selidx = 0; break;
    case 0x08: selidx = 9; break;
    case 0x09: selidx = 8; break;
    case 0xff: if (CHAN_ID != 0)
               {
                 f.serdisyn.checked = true;
                 selidx = 5;
               }
               break;
    case 0x0a:
               if (isBitSet(scr, SCR_BAUD_230K)) {
                 selidx = 10; break;
			   }
    case 0x0b:
               if (isBitSet(scr, SCR_BAUD_920K)) {
                 selidx = 11; break;
			   }
    case 0x0c:
               if (isBitSet(scr, SCR_BAUD_920K)) {
                 selidx = 12; break;
			   }
    default: selidx = 5; break;
  }
  popBaudSelect(selidx);

  curropt = chanParams[FC_OFF];  //flow control
  popFlowSelect(curropt);

  // flush mode settings
  curropt = chanParams[FLMODE_OFF];
  (curropt & 0x10) ? f.fliactconn[0].checked = true
				   : f.fliactconn[1].checked = true;

  (curropt & 0x20) ? f.flipassconn[0].checked = true
				   : f.flipassconn[1].checked = true;

  (curropt & 0x40) ? f.flidisc[0].checked = true
				   : f.flidisc[1].checked = true;

  (curropt & 0x01) ? f.floactconn[0].checked = true
				   : f.floactconn[1].checked = true;
  (curropt & 0x02) ? f.flopassconn[0].checked = true
				   : f.flopassconn[1].checked = true;
  (curropt & 0x04) ? f.flodisc[0].checked = true
				   : f.flodisc[1].checked = true;
  
  // pack control settings
  curropt = chanParams[PCKCTRL_OFF];
  switch (curropt & 0x03)
  {
    case 0: f.pctrlidle.options[0].selected = true; break;
    case 1: f.pctrlidle.options[1].selected = true; break;
    case 2: f.pctrlidle.options[2].selected = true; break;
    case 3: f.pctrlidle.options[3].selected = true; break;
    default: break;
  }

  // match 2 byte sequence
  (curropt & 0x10) ? f.pctrlmseq[0].checked = true
                   : f.pctrlmseq[1].checked = true;
  // send immediately following sendchar
  (curropt & 0x20) ? f.pctrlsendf[0].checked = true
                   : f.pctrlsendf[1].checked = true;
  // send trailing bytes
  switch (curropt & 0x0c)
  {
    case 0x00: f.pctrltrail[0].checked = true; break;
    case 0x04: f.pctrltrail[1].checked = true; break;
    case 0x08: f.pctrltrail[2].checked = true; break;
    default: break;
  }
  // match bytes
  f.pctrlmdata1.value = hexcode(chanParams[SNDCHAR_OFF]);
  f.pctrlmdata2.value = hexcode(chanParams[SNDCHAR_OFF + 1]);

  // if CHAN_ID is other than 0, then we should show the disable serial port option.
  if (CHAN_ID != 0)
  {
    f.serdisyn.disabled = false;
  }
  else
    f.serdisyn.disabled = true;

  OnChgDisSerPort(f.serdisyn);

  // if UDP mode datagram type 01 is set we should not allow buffer flushing to be enabled
  // bug C-060227-77005  mfmfmf???
  curropt = chanParams[CMODE_OFF];
  // read the protocol option to determine how to populate each connection
  // section
  if((curropt & 0x0f) == UDP_MODE)
  { 
	curropt = chanParams[DMODE_OFF];
	if(( curropt & 0xff ) == 0x01 )
	{
		f.fliactconn[0].disabled = true;
		f.floactconn[0].disabled = true;
		f.fliactconn[1].disabled = true;
		f.floactconn[1].disabled = true;

		f.flipassconn[0].disabled = true;
		f.flopassconn[0].disabled = true;
		f.flipassconn[1].disabled = true;
		f.flopassconn[1].disabled = true;

		f.flidisc[0].disabled = true;
		f.flodisc[0].disabled = true;
		f.flidisc[1].disabled = true;
		f.flodisc[1].disabled = true;
	}
  }
  // enable/disable packing
  curropt = chanParams[FLMODE_OFF];
  (curropt & 0x80) ? f.packyn.checked = true
  			       : f.packyn.checked = false;
  OnChgPackCtrl(f.packyn);
}

// Called when Apply is selected; validates the fields, and if all is well,
// opens the status window, submits the form, and changes the frame contents.
function applyForm()
{
  var ok = true;
  var f = document.theform;
  var df = document.dform;
  var RecDoc = parent.frames.leftmenu;
  var idx, recval, chanOff;

  // get the chanParams offset.
  chanOff = CHAN_ID ? CHAN1_OFF : CHAN0_OFF;

  if (isNaN(parseInt(f.pctrlmdata1.value, 16)))
  {

    alert("Match Byte 1 contains invalid characters.\nValid characters are 0-9 and A-F or a-f");

    return false;
  }

  if (isNaN(parseInt(f.pctrlmdata2.value, 16)))
  {

    alert("Match Byte 2 contains invalid characters.\nValid characters are 0-9 and A-F or a-f");

    return false;
  }

  if (ok)
  {
    recval = 0;
    idx = f.serproto.selectedIndex;		    // serial protocol
    recval |= parseInt(f.serproto.options[idx].value);

    idx = f.data.selectedIndex;				// data bits
    recval |= parseInt(f.data.options[idx].value);

    idx = f.parity.selectedIndex;			// parity
    recval |= parseInt(f.parity.options[idx].value);

    idx = f.stop.selectedIndex;				// stop bits
    recval |= parseInt(f.stop.options[idx].value);

    rec0[chanOff + LINEIF_OFF] = recval;

    if ((CHAN_ID != 0) && (f.serdisyn.checked))
      rec0[chanOff + SPEED_OFF] = parseInt(f.serdisyn.value);
    else
    {
      idx = f.baud.selectedIndex;
      rec0[chanOff + SPEED_OFF] = parseInt(f.baud.options[idx].value);
    }

    idx = f.flow.selectedIndex;
    rec0[chanOff + FC_OFF] = parseInt(f.flow.options[idx].value);

    recval = 0;
    if (f.packyn.checked)
      recval |= parseInt(f.packyn.value);
    if (f.fliactconn[0].checked)
      recval |= parseInt(f.fliactconn[0].value);
    if (f.flipassconn[0].checked)
      recval |= parseInt(f.flipassconn[0].value);
    if (f.flidisc[0].checked)
      recval |= parseInt(f.flidisc[0].value);
    if (f.floactconn[0].checked)
      recval |= parseInt(f.floactconn[0].value);
    if (f.flopassconn[0].checked)
      recval |= parseInt(f.flopassconn[0].value);
    if (f.flodisc[0].checked)
      recval |= parseInt(f.flodisc[0].value);

    rec0[chanOff + FLMODE_OFF] = recval;

    recval = 0;
    idx = f.pctrlidle.selectedIndex;
    recval |= parseInt(f.pctrlidle.options[idx].value);

    if (f.pctrlmseq[0].checked)
      recval |= parseInt(f.pctrlmseq[0].value);
    if (f.pctrlsendf[0].checked)
      recval |= parseInt(f.pctrlsendf[0].value);

    if (f.pctrltrail[0].checked)
      recval |= parseInt(f.pctrltrail[0].value);
    else if (f.pctrltrail[1].checked)
      recval |= parseInt(f.pctrltrail[1].value);
    else if (f.pctrltrail[2].checked)
      recval |= parseInt(f.pctrltrail[2].value);

    rec0[chanOff + PCKCTRL_OFF] = recval;

    rec0[chanOff + SNDCHAR_OFF] = parseInt(f.pctrlmdata1.value, 16);
    rec0[chanOff + SNDCHAR_OFF + 1] = parseInt(f.pctrlmdata2.value, 16);

    recstr = rec0.join();
    RecDoc.SetRecord(0, recstr);
    reportDone();
  }

  return ok;
} // applyForm

// called when web page is loaded in the browser
function initPage()
{
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
  var table = document.getElementById("chaninfo");
  var rows = table.rows;
  var cells = rows[0].cells;

  recstr = RecDoc.GetRecord(0);
  rec0 = recstr.split(",");

  recstr = RecDoc.GetRecord(3);
  rec3 = recstr.split(",");

  recstr = RecDoc.GetSCR();
  scr = recstr.split(",");
  // setup the correct channel number:
  CHAN_ID = parseInt(RecDoc.GetCurrChanNo());

  cells[0].innerHTML = "Channel " + (CHAN_ID + 1);

  // populate the fields from the setup records array
  popFields();
} // initPage

-->
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>

<LINK href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/validate.js"></script>
<script language="JavaScript" src="js/util.js"></script>
<script language="JavaScript" src="servset.js"></script>

</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table cellSpacing=0 cellPadding=0 width="600" border=0>
  <tr>
    <td width=60>&nbsp;</td>

    <td class=datatitle width=480>Server Settings</td>


    <td width=60>&nbsp;</td>
  </tr>
  <tr>
    <td class=color1back colspan=3><img height=2 src="images/spacer.gif" width=600 border=0></td>
  </tr>
</table>

<form name=theform method=post>
<table cellSpacing=5 cellPadding=0 width="600" border=0 id="servsettbl">
  <tr>
    <td width=25><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=150><img height=1 src="images/spacer.gif" border=0></td>
    <td width=280><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>

    <td class=tabletitleleft colspan=4>Server Configuration</td>

  </tr>
  <tr>
   <tr>  

    <td class=datalabel colspan=2>Enhanced Password:</td>
    <td class=datavalue colspan=2>
       <input name=advpass type=radio onClick="advPassCheck()"  value='0x08'>Enable 
       <input name=advpass type=radio onClick="advPassCheck()" value='0x00'>Disable

    </td>
  </tr>
  
  

    <td class=datalabel colspan=2>Telnet/Web Manager Password:</td>

    <td class=datavalue colspan=2>
      <input type=password name=telpasswd size=16 maxlength=16  onChange="OnChgPasswd()"></td> 
    </td>
  </tr>
  <tr>

    <td class=datalabel colspan=2>Retype Password:</td>

    <td class=datavalue colspan=2>
      <input type=password name=telrepasswd size=16  maxlength=16  onChange="OnChgPasswd()"></td>
  </tr>
  <tr>
    <td colspan=4><img height=2 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>

    <td class=tabletitleleft colspan=4>Advanced</td>

  </tr>
  <tr>

    <td class=datalabel colspan=2>ARP Cache Timeout (secs):</td>

    <td class=datavalue colspan=2>
      <input type=text name=arpcato size=3 maxlength=3>
    </td>
  </tr>
  <tr>  

    <td class=datalabel colspan=2>TCP Keepalive (secs):</td>

    <td class=datavalue colspan=2>
      <input type=text name=tcpkeep size=3 maxlength=3>
    </td>
  </tr>
  <tr>  

    <td class=datalabel colspan=2>Monitor Mode @ Bootup:</td>
    <td class=datavalue colspan=2>
       <input name=disnmon type=radio value='0x00'>Enable 
       <input name=disnmon type=radio value='0x40'>Disable

    </td>
  </tr>

  <tr>
<td class=datalabel colspan=2>CPU Performance Mode:</td>
    <td class=datavalue colspan=2>
       <input name=cpuperf type=radio value='0x20'>Low
	   <!---  need ifdef WIPORT in here somewhere --->
	   <input name=cpuperf type=radio value='0x00'>Regular


	   <!--- end ifdef wiport --->
       <input name=cpuperf type=radio value='0x80'>High

    </td>
  </tr>

  <tr>

    <td class=datalabel colspan=2>HTTP Server Port:</td>

    <td class=datavalue colspan=2>
      <input type=text name=httpport size=5 maxlength=5>
    </td>
  </tr>
  <tr>

    <td class=datalabel colspan=2>Config Server Port:</td>

    <td class=datavalue colspan=2>
      <input type=text name=cfgport size=5 maxlength=5>
    </td>
  </tr>

  <tr>

    <td class=datalabel colspan=2>MTU Size:</td>

    <td class=datavalue colspan=2>
      <input type=text name=mtusize size=4 maxlength=4>
    </td>
  </tr>
  <tr>
  <td colspan=4><img height=2 src="images/spacer.gif" border=0></td>
  </tr>
<!-- Added ReTransmit-Time textInput --> 
  <tr>

    <td class=datalabel colspan=2>TCP Re-transmission timeout (ms):</td>

    <td class=datavalue colspan=2>
      <input type=text name=reTransmitTime size=5 maxlength=5>
    </td>
  </tr>
</table>
</form>

<div id="appdiv" style="visibility:visible;">
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>

       <input type=button value="    OK    " onClick="return applyForm()">

    </td>
    <td id="statmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>  
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>  
</div>

</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Setup Records Arrays
var rec0;
var rec1;
var rec3;

var passChg;		// password changed or not
var orig_httpport;
var orig_cfgport;

// #define equivalents
// rec0 offset
var PASSWD_OFF = 8;
var TCPKEEP_OFF = 7;

// rec3 offset
var ARPTO_OFF = 100;
var HTTPPORT_OFF = 110;
var MISC_OFF  = 116;
var DISNMON_MASK = 0x40; // Bit 6 @ Byte 116
var CPUPERF_MASK = 0x80; // Bit 7 @ byte 116
var MTUSIZE_OFF = 78;
var BAUD_OFF_1 = 17;
var BAUD_OFF_2 = 65;
var CFGPRT_OFF = 80;
var RETXTIME_OFF = 118;

//rec1 offset
var ADVPASSWDFLAG_OFF = 0;	//advance password flag offset
var ADVPASSWD_OFF = 17;   	//advanced password offset in setup record
var passwdSize;         	//To check the password length
var checkPass=true;         // checkbox  flag   
function OnChgPasswd()
{
  passChg = true;  
}
function advPassCheck()
{
  checkPass=false;
  popFields();
}

function popFields()
{
  var f = document.theform;
  var curropt;
  curropt = rec1[ADVPASSWDFLAG_OFF];
  if(checkPass)
    {
      (curropt & 0x08) ? f.advpass[0].checked = true : f.advpass[1].checked = true; 
      f.telrepasswd.value = "";
      passChg = false;
      if ( rec1[ADVPASSWDFLAG_OFF] & 0x08 )
        { 
 	      if (rec1[ADVPASSWD_OFF])
	        f.telpasswd.value = ArrToStr(rec1, ADVPASSWD_OFF, 16);
	      else
	        f.telpasswd = "";
        }
      else
        {
          if (rec0[PASSWD_OFF] )
		    {
		      f.telpasswd.value = ArrToStr(rec0, PASSWD_OFF, 4);
		      f.telrepasswd.value = ArrToStr(rec0, PASSWD_OFF, 4);
		    }	
          else
		    {
              f.telpasswd ="";
		    }	
        }
    }
  else
    {
	  if((f.advpass[1].checked))
	    {
	      f.telpasswd.value = ArrToStr(rec0, PASSWD_OFF, 4);
		  f.telrepasswd.value = ArrToStr(rec0, PASSWD_OFF, 4);
	    }
	  else
	    {
	      f.telpasswd.value = "";
          f.telrepasswd.value = "";
		}
    }
  // C-070827-98596 - for TCP keepalive 0 = disabled, but we store 255 in the setup record
  if( parseInt(rec0[TCPKEEP_OFF]) == 255 ) {
	f.tcpkeep.value = 0;
  } else {
	f.tcpkeep.value = parseInt(rec0[TCPKEEP_OFF]);
  }

  f.arpcato.value = parseInt(rec3[ARPTO_OFF]) + parseInt((rec3[ARPTO_OFF+1] << 8));
  
  f.httpport.value = parseInt(rec3[HTTPPORT_OFF]) + parseInt((rec3[HTTPPORT_OFF+1] << 8));
  orig_httpport = f.httpport.value;
  if (f.httpport.value == 0) f.httpport.value = 80;
  
  f.mtusize.value = parseInt(rec3[MTUSIZE_OFF])	+ parseInt((rec3[MTUSIZE_OFF+1] << 8));
  if (f.mtusize.value == 0) f.mtusize.value = 1400;

  f.reTransmitTime.value = parseInt(rec3[RETXTIME_OFF]) + parseInt((rec3[RETXTIME_OFF+1] << 8));
  if (f.reTransmitTime.value == 0) f.reTransmitTime.value = 500;

  curropt = rec3[MISC_OFF];
  (curropt & DISNMON_MASK) ? f.disnmon[1].checked = true : f.disnmon[0].checked = true;
  //(curropt & CPUPERF_MASK) ? f.cpuperf[1].checked = true : f.cpuperf[0].checked = true;

	f.cfgport.value = parseInt(rec3[CFGPRT_OFF]) + parseInt((rec3[CFGPRT_OFF+1] << 8));
	orig_cfgport = f.cfgport.value;
	if(f.cfgport.value == 0 ) f.cfgport.value = 30718;
	if( rec0[5] & 0x04 )f.cfgport.disabled = false;
	else{
		f.cfgport.disabled = true;
	}


// static compile flag to allow CPU performance mode selection
  curropt = rec3[MISC_OFF];
  if( curropt & 0x80 ){

	f.cpuperf[2].checked = true;

	f.cpuperf[0].checked = false;
	f.cpuperf[1].checked = false;
	// check to see if the baud rate is high, and if so disable CPU low, and med settings
	if( ( rec0[ BAUD_OFF_1 ] == 0x0b ) || ( rec0[ BAUD_OFF_1 ] == 0x0c ) ||
		( rec0[ BAUD_OFF_2 ] == 0x0b ) || ( rec0[ BAUD_OFF_2 ] == 0x0c )){
		f.cpuperf[0].disabled = true;
		f.cpuperf[1].disabled = true;
	}
	else{
		f.cpuperf[0].disabled = false;
		f.cpuperf[1].disabled = false;
	}

  }
  else if( curropt & 0x20 )
  {

	f.cpuperf[2].checked = false;

	f.cpuperf[0].checked = true;
	f.cpuperf[1].checked = false;
  }
  else {

	f.cpuperf[2].checked = false;

	f.cpuperf[0].checked = false;
	f.cpuperf[1].checked = true;
  }



}

// Called when Apply is selected; validates the fields, and if all is well,
// opens the status window, submits the form, and changes the frame contents.
function applyForm()
{
  var ok = true;
  var f = document.theform;
  var RecDoc = parent.frames.leftmenu;
  var recval;
  var tempArr = new Array();
  passwdSize = f.telpasswd.value;
  if (passChg && (f.telpasswd.value != f.telrepasswd.value))
  {

     alert("Passwords do not match. Please retry again.");

      f.telpasswd.value = "";
      f.telrepasswd.value = "";
     return false;
  }
  
   if (passChg && (f.advpass[1].checked) &&  (passwdSize.length >4) ) 
   {
	  alert("In Basic password mode, Password length should be less than 5 characters.");
	  f.telpasswd.value = "";
          f.telrepasswd.value = "";
	  return false;	 
   }

  ok = (verifyNumRange(f.arpcato.value, 1, 600, "ARP Cache Timeout (secs)", true) &&
        verifyNumRange(f.tcpkeep.value, 0, 65, "TCP Keepalive (secs)", true) && 
        verifyNumRange(f.httpport.value, 1, 65535, "HTTP Server Port", true) &&
	    verifyNumRange(f.cfgport.value, 1, 65535, "0x77FE Server Port", true)  &&
        verifyNumRange(f.mtusize.value, 512, 1400, "MTU Size", true) &&
	verifyNumRange(f.reTransmitTime.value, 500, 4000, "Re-transmit Time", false));

        
  if (ok)
  {         
    
	rec0[TCPKEEP_OFF] = parseInt(f.tcpkeep.value, 10);
	// C-070827-98596 - TCP Keepalive value of 0 = disabled, but in the setup record it
	// gets stored as 255
    if( rec0[TCPKEEP_OFF] == 0 ) {
		rec0[TCPKEEP_OFF] = 255;
	}
    recval = parseInt(f.arpcato.value, 10);
    rec3[ARPTO_OFF] = recval & 0xff;
    rec3[ARPTO_OFF + 1] = (recval >> 8) & 0xff;
    
   if (f.advpass[0].checked)
     {
        rec1[ADVPASSWDFLAG_OFF]=rec1[ADVPASSWDFLAG_OFF] | 0x08;
        tempArr = StrToArr(f.telpasswd.value, 16);
        UpdateArr(rec1,ADVPASSWD_OFF, 16, tempArr);
     }
   else
     {
	   rec1[ADVPASSWDFLAG_OFF]=rec1[ADVPASSWDFLAG_OFF] & 0xF7;
	   if ( passChg)
          { 
		    tempArr = StrToArr(f.telpasswd.value, 4);
		    UpdateArr(rec0, PASSWD_OFF, 4, tempArr);
		    tempArr = StrToArr("", 16);
		    UpdateArr(rec1,ADVPASSWD_OFF, 16, tempArr)
           }	   
     }	

	recval = parseInt(f.httpport.value, 10);
	if (((orig_httpport == 0) && (recval != 80)) ||
        ((orig_httpport != 0) && (recval != orig_httpport)) )
      RecDoc.UnitNWInfoChange(true);
    rec3[HTTPPORT_OFF] = recval & 0xff;
    rec3[HTTPPORT_OFF + 1] = (recval >> 8) & 0xff;
	recval = parseInt(f.cfgport.value, 10);
    if( recval != 0x77FE ){
		rec3[CFGPRT_OFF] = recval & 0xff;
		rec3[CFGPRT_OFF + 1] = (recval >> 8) & 0xff;
		if(!( rec0[5] & 0x04)){
			//alert("Changes to Config Port 0x77FE are only valid when bridging mode is enabled");
		}
	}


    recval = parseInt(f.mtusize.value, 10);
    rec3[MTUSIZE_OFF] = recval & 0xff;
    rec3[MTUSIZE_OFF + 1] = (recval >> 8) & 0xff;
      
    recval = rec3[MISC_OFF];

    if (f.disnmon[1].checked)
       recval |= f.disnmon[1].value;
    else
       recval &= ~(f.disnmon[1].value);
	


	if ( f.cpuperf[2].checked == true ){

	   recval |= 0x80;
	   recval &= ~0x20;
	}

    if ( f.cpuperf[0].checked == true ){
	   recval |= 0x20;
	   recval &= ~0x80;
    }
	else if ( f.cpuperf[1].checked == true ){
       if( recval & 0x80 )recval &= ~0x80;
	   if( recval & 0x20 )recval &= ~0x20;
	}

	rec3[MISC_OFF] = recval;

    recval = parseInt(f.reTransmitTime.value, 10);
    rec3[RETXTIME_OFF] = recval & 0xff;
    rec3[RETXTIME_OFF + 1] = (recval >> 8) & 0xff;

    recstr = rec0.join();
    RecDoc.SetRecord(0, recstr);
	
    recstr = rec1.join();
    RecDoc.SetRecord(1, recstr);
  
    recstr = rec3.join();
    RecDoc.SetRecord(3, recstr);
    reportDone();
  }




  return ok;    
} // applyForm

// called when web page is loaded in the browser
function initPage()
{
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
  
  recstr = RecDoc.GetRecord(0);
  rec0 = recstr.split(",");
  recstr = RecDoc.GetRecord(1);
  rec1 = recstr.split(",");
  recstr = RecDoc.GetRecord(3);
  rec3 = recstr.split(",");
  // populate the fields from the setup records array
  popFields(); 
} // initPage

-->
HTTP/1.0 200
Content-type: application/xml-dtd

<!ELEMENT SETUPREC (RECORD*,SCR)>
<!ELEMENT RECORD (NUM,DATA)>
<!ELEMENT NUM (#PCDATA)>
<!ELEMENT DATA (#PCDATA)>
<!ELEMENT SCR (#PCDATA)>
HTTP/1.0 200
Content-type: text/xml

<?xml version="1.0"?>
<!DOCTYPE SETUPREC SYSTEM "setuprec.dtd">
<SETUPREC>
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">

<LINK href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/validate.js"></script>
<script language="JavaScript" src="js/validatenetwork.js"></script>
<script language="JavaScript" src="js/util.js"></script>
<script language="JavaScript" src="smtpset.js"></script>

</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table cellSpacing=0 cellPadding=0 width="600" border=0>
  <tr>
    <td width=60>&nbsp;</td>
    <td class=datatitle width=480>Email Settings</td>
    <!--
    <td class=datatitlehelp width=60><a class=datatitlehelp target="help" href="help.htm"><img height=21 width=50 src="images/help.gif" border=0></a></td>
    -->
    <td width=60>&nbsp;</td>
  </tr>
  <tr>
    <td class=color1back colspan=3><img height=2 src="images/spacer.gif" width=600 border=0></td>
  </tr>
</table>

<form name=theform method=post>
<table cellSpacing=5 cellPadding=0 width="600" border=0 id="mailsettbl">
  <tr>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
    <td width=65><img height=1 src="images/spacer.gif" border=0></td>
    <td width=50><img height=1 src="images/spacer.gif" border=0></td>
    <td width=130><img height=1 src="images/spacer.gif" border=0></td>
    <td width=130><img height=1 src="images/spacer.gif" border=0></td>
    <td width=315><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td class=datalabel colspan=3>Server IP Address:</td>
    <td class=datavalue>
      <input type=text name=emsvrip size=15 maxlength=15></td> 
    </td>
    <td class=datalabel>Server Port:</td>
    <td class=datavalue>
      <input type=text name=emport size=5 maxlength=5>
    </td>
  </tr>
  <tr>
    <td class=datalabel colspan=3>Domain Name:</td>
    <td class=datavalue colspan=3>
      <input type=text name=emdnname size=23 maxlength=23></td>
  </tr>
  <tr>
    <td class=datalabel colspan=3>Unit Name:</td>
    <td class=datavalue colspan=3>
      <input type=text name=emuname size=23 maxlength=23></td>
  </tr>
  <tr>
    <td colspan=6><hr width="100%" /></td>
  </tr>
  <tr>
    <td class=tabletitleleft colspan=6>Recipients</td>
  </tr>
  <tr>
    <td></td>
    <td class=datalabelleft colspan=5>Recipient 1:</td>
  </tr>
  <tr>
    <td></td>
    <td class=datalabel colspan=2>Email Address:</td>
    <td class=datavalue colspan=3>
      <input type=text name=r1emaddr size=48 maxlength=48>
    </td>
  </tr>
  <tr>
    <td></td>
    <td class=datalabelleft colspan=5>Recipient 2:</td>
  </tr>
  <tr>  
    <td></td>
    <td class=datalabel colspan=2>Email Address:</td>
    <td class=datavalue colspan=3>
      <input type=text name=r2emaddr size=48 maxlength=48>
    </td>
  </tr>
</table>
</form>

<div id="appdiv" style="visibility:visible;">
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>
       <input type=button value="    OK    " onClick="return applyForm();">
    </td>
    <td id="statmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>  
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>  
</div>


</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Setup Records Arrays
var rec5;
var rec6;
var rec3;

// #define equivalents
// rec5 offsets
var SVRIP_OFF = 0;
var UNAME_OFF = 102;
var R1EM_OFF = 4;
var R2EM_OFF = 53;

// rec6 offset
var DNAME_OFF = 0;

//rec3 offsets
var SMTPPORT_OFF = 112;

function popFields()
{
  var f = document.theform;

  f.emsvrip.value= "";
  f.emsvrip.value = IPAddrToStr(rec5, SVRIP_OFF);
  f.emport.value = "";
  f.emport.value = parseInt(rec3[SMTPPORT_OFF]) + parseInt((rec3[SMTPPORT_OFF+1] << 8));
  if (f.emport.value == 0) f.emport.value = 25;
  f.emuname.value = "";
  f.emuname.value = ArrToStr(rec5, UNAME_OFF, 24);
  f.emdnname.value = "";
  f.emdnname.value = ArrToStr(rec6, DNAME_OFF, 24);
  f.r1emaddr.value = "";
  f.r1emaddr.value = ArrToStr(rec5, R1EM_OFF, 48);
  f.r2emaddr.value = "";
  f.r2emaddr.value = ArrToStr(rec5, R2EM_OFF, 48);
}

// Called when Apply is selected; validates the fields, and if all is well,
// opens the status window, submits the form, and changes the frame contents.

function applyForm()
{
  var ok = true;
  var f = document.theform;
  var RecDoc = parent.frames.leftmenu;
  var tempArr = new Array();
  var i, recval, rechex = "";
    
  ok = (verifyIP(f.emsvrip.value, "Mail Server IP Address", true, true) &&
        verifyEmail(f.r1emaddr.value, "Recipient 1 Email Address", false) &&
        verifyEmail(f.r2emaddr.value, "Recipient 2 Email Address", false) &&
		verifyNumRange(f.emport.value, 1, 65535, "Mail Server Port", true));




  if (ok)
  {   
     tempArr = StrToIPAddr(f.emsvrip.value);
     UpdateArr(rec5, SVRIP_OFF, 4, tempArr);

	 recval = parseInt(f.emport.value, 10);
     rec3[SMTPPORT_OFF] = recval & 0xff;
     rec3[SMTPPORT_OFF + 1] = (recval >> 8) & 0xff;

     tempArr = StrToArr(f.emuname.value, 24);
     UpdateArr(rec5, UNAME_OFF, 24, tempArr);
     
     tempArr = StrToArr(f.emdnname.value, 24);
     UpdateArr(rec6, DNAME_OFF, 24, tempArr);

     tempArr = StrToArr(f.r1emaddr.value, 49);
     UpdateArr(rec5, R1EM_OFF, 49, tempArr);

     tempArr = StrToArr(f.r2emaddr.value, 49);
     UpdateArr(rec5, R2EM_OFF, 49, tempArr);

     recstr = rec5.join();
     RecDoc.SetRecord(5, recstr); 
     recstr = rec6.join();
     RecDoc.SetRecord(6, recstr);   
	   recstr = rec3.join();
     RecDoc.SetRecord(3, recstr);
     reportDone();
  }

  return ok;  
  
} // applyForm


// called when web page is loaded in the browser
function initPage()
{
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
  
  recstr = RecDoc.GetRecord(5);
  rec5 = recstr.split(",");
  recstr = RecDoc.GetRecord(6);
  rec6 = recstr.split(",");
  recstr = RecDoc.GetRecord(3);
  rec3 = recstr.split(",");

  // populate the fields from the setup records array
  popFields();
  
} // initPage

-->
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//Dtd HTML 4.0 transitional//EN">
<html>
<head>
<META http-equiv=Content-Type content="text/html; charset=iso-8859-1">

<LINK href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/validate.js"></script>
<script language="JavaScript" src="js/validatenetwork.js"></script>
<script language="JavaScript" src="js/util.js"></script>
<script language="JavaScript" src="smtptrig.js"></script>

</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table cellSpacing=0 cellPadding=0 width="600" border=0>
  <tr>
    <td width=60>&nbsp;</td>
    <td class=datatitle width=480>Email Trigger Settings</td>
    <!--
    <td class=datatitlehelp width=60><a class=datatitlehelp target="help" href="help.htm"><img height=21 width=50 src="images/help.gif" border=0></a></td>
    -->
    <td width=60>&nbsp;</td>
  </tr>
  <tr>
    <td class=color1back colspan=3><img height=2 src="images/spacer.gif" width=600 border=0></td>
  </tr>
</table>

<form name=theform>
<table cellSpacing=5 cellPadding=0 width="600" border=0 id="smtptrigtbl">
  <tr>
    <td width=15><img height=1 src="images/spacer.gif" border=0></td>
	<td width=115><img height=1 src="images/spacer.gif" border=0></td>
    <td width=65><img height=1 src="images/spacer.gif" border=0></td>
    <td width=20><img height=1 src="images/spacer.gif" border=0></td>
    <td width=55><img height=1 src="images/spacer.gif" border=0></td>
    <td width=35><img height=1 src="images/spacer.gif" border=0></td>    
    <td width=20><img height=1 src="images/spacer.gif" border=0></td>
	<td width=65><img height=1 src="images/spacer.gif" border=0></td>
    <td width=50><img height=1 src="images/spacer.gif" border=0></td>
    <td width=50><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td class=datalabelleftlarge colspan=10>
    <!-- dynamic label gets inserted here via Javascript-->
    &nbsp;</td>
  </tr>
  <tr>
    <td class=tabletitleleft colspan=10>Conditions</td>
  </tr>
  <tr>
    <td></td>
    <td class=tabletitleleft colspan=4>Configurable Pins</td>
	<td class=tabletitleleft colspan=5>Serial Trigger</td>
  </tr>
  <tr>
    <td class=datalabel colspan=2>Trigger Input 1:</td>
    <td class=datavalue colspan=3>
        <select name=triginp1>
          <option value='0x01'>Active</option>
          <option value='0x00'>Inactive</option>
          <option value='0x00'>None</option>
        </select>
    </td>
    <td class=datavalueright>
      <input type=checkbox name=trigseryn onClick="OnChgSerTrig(this)" value='0x03'>
    </td>
    <td class=datalabelleft colspan=4>Enable Serial Trigger Input</td>
  </tr>   
  <tr>
    <td class=datalabel colspan=2>Trigger Input 2:</td>
    <td class=datavalue colspan=3>
        <select name=triginp2>
          <option value='0x02'>Active</option>
          <option value='0x00'>Inactive</option>
          <option value='0x00'>None</option>
        </select>
    </td>
    <td class=datalabel colspan=2>Channel:</td>
    <td class=datavalue colspan=3>
      <select name=trigchan>

        <option value='0x00'>Channel 1</option>


      </select>
    </td>
  </tr>
  <tr>
    <td class=datalabel colspan=2>Trigger Input 3:</td>
    <td class=datavalue colspan=3>
        <select name=triginp3>
          <option value='0x04'>Active</option>
          <option value='0x00'>Inactive</option>
          <option value='0x00'>None</option>
        </select>
    </td>
    <td class=datalabel colspan=2>Data Size:</td>
    <td class=datavalue colspan=3>
      <select name=trigdatsiz onChange="if (this.selectedIndex == 1) OnChgMatchBytes(true); else OnChgMatchBytes(false);">
          <option value='0x40'>One Byte</option>
          <option value='0x00'>Two Bytes</option>
      </select>
    </td>
  </tr>
  <tr>
    <td colspan=5></td>
    <td class=datalabel colspan=2>Match Data:</td>
    <td class=datavalue colspan=3>
      0x<input type=text name=trigdata1 size=2 maxlength=2> &nbsp;
      0x<input type=text name=trigdata2 size=2 maxlength=2> (in Hex)
    </td>
  </tr>
  <tr>
    <td colspan=10><img height=2 src="images/spacer.gif" border=0></td>
  </tr>  
  <tr>
    <td class=tabletitleleft colspan=10>Message Properties</td>
  </tr>
  <tr>
    <td class=datalabel colspan=2>Message:</td>
    <td class=datavalue colspan=3>
      <input type=text name=trigmesg size=24 maxlength=23>
    </td>
    <td class=datalabel colspan=2>Priority</td>
    <td class=datavalue colspan=3>
      <select name=trigprio>
        <option value='0x03'>Low</option>
        <option value='0x01'>High</option>
      </select>
    </td>
  </tr>
  <tr>
    <td class=datalabel colspan=2>Min. Notification Interval:</td>
    <td class=datavalue colspan=2>
      <input type=text name=trignotif size=5 maxlength=5> (secs)
    </td>
    <td class=datalabel colspan=3>Re-notification Interval:</td>
    <td class=datavalue colspan=3>
      <input type=text name=trigrenotif size=5 maxlength=5> (secs)
    </td>
  </tr>
</table>
</form>

<div id="appdiv" style="visibility:visible;">
<table cellSpacing=5 cellPadding=0 border=0 width="600" id="oktbl">
  <tr>
    <td width=240><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=100><img height=1 src="images/spacer.gif" border=0></td>
    <td width=135><img height=1 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td></td>
    <td class=databutton>
       <input type=button value="    OK    " onClick="return applyForm();">
    </td>
    <td id="statmesg" class=tabletitleleft style="visibility:hidden"> Done! </td>
    <td></td>
  </tr>  
  <tr>
    <td colspan=4><hr width="100%" /></td>
  </tr>
</table>  
</div>

</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Setup Records Arrays
var rec6;

var TRIG_ID;

// #define equivalents
var TRIG1_OFF = 24;
var TRIG2_OFF = 58;
var TRIG3_OFF = 92;
var TRIG_PARAM_SIZE = 34;

var NUM_TRIG_PINS = 3;

// relative offsets into the trigger parameters.
var TMASK_OFF = 0;
var TCMP_OFF = 1;
var TSER_OFF = 2;
var TMBYTE_OFF = 3;
var TMESG_OFF = 5;
var TPRIO_OFF = 29;
var TNOT_OFF = 30;
var TRENOT_OFF = 32;

function OnChgMatchBytes(mtwobytes)
{
  var f = document.theform;
  
  if (f.trigdatsiz.disabled)
    f.trigdata2.disabled = true;
  else
    f.trigdata2.disabled = !mtwobytes;
}

function OnChgSerTrig(tseryn)
{
  var f = document.theform;
  var dis = !(tseryn.checked);
  
  f.trigchan.disabled = dis;
  f.trigdatsiz.disabled = dis;
  f.trigdata1.disabled = dis;
  f.trigdata2.disabled = dis;
}

function popFields()
{
  var f = document.theform;
  var trigParams;
  var i, curropt;
  var cmp, idx;
  
  switch (TRIG_ID)
  {
     case 0: trigParams = rec6.slice(TRIG1_OFF, TRIG1_OFF + TRIG_PARAM_SIZE);
             break;
     case 1: trigParams = rec6.slice(TRIG2_OFF, TRIG2_OFF + TRIG_PARAM_SIZE);
             break; 
     case 2: trigParams = rec6.slice(TRIG3_OFF, TRIG3_OFF + TRIG_PARAM_SIZE);
             break;
  }           

  // setting up the trigger input selection     
  curropt = trigParams[TMASK_OFF];
  cmp = trigParams[TCMP_OFF];
  for (i = 0; i < NUM_TRIG_PINS; i++)
  {
     if (curropt & (1 << i))
       (cmp & (1 << i)) ? idx = 0 : idx = 1;
     else
       idx = 2;
     switch (i)
     {
       case 0: f.triginp1.options[idx].selected = true; break;
       case 1: f.triginp2.options[idx].selected = true; break;
       case 2: f.triginp3.options[idx].selected = true; break;
     }
  }     
        
  // serial trigger settings
  curropt = trigParams[TSER_OFF];
  switch (curropt & 0x0f)			// serial trig en/dis
  {
    case 0x00: f.trigseryn.checked = true; break;
    case 0x03: f.trigseryn.checked = false; break;
    default: break;
  }
  switch (curropt & 0x30)			// channel num
  {
     case 0x00: 
     default: 
     			f.trigchan.options[0].selected = true; break;

  }
  switch (curropt & 0xc0)			// num matching bytes
  {
     case 0x00: f.trigdatsiz.options[1].selected = true; break
     case 0x40: f.trigdatsiz.options[0].selected = true; break;
     default: break;
  }    
  
  f.trigdata1.value = hexcode(trigParams[TMBYTE_OFF]);
  f.trigdata2.value = hexcode(trigParams[TMBYTE_OFF+1]);

  OnChgSerTrig(f.trigseryn);

  // email message properties
  f.trigmesg.value = ArrToStr(trigParams, TMESG_OFF, 24);
  curropt = trigParams[TPRIO_OFF];;
  switch (curropt & 0xff)
  {
     case 0x01: f.trigprio.options[1].selected = true; break;
     case 0x03: f.trigprio.options[0].selected = true; break;
     default: break;
  }
  
  f.trignotif.value = parseInt(trigParams[TNOT_OFF]) + parseInt((trigParams[TNOT_OFF+1] << 8));
  f.trigrenotif.value = parseInt(trigParams[TRENOT_OFF]) + parseInt((trigParams[TRENOT_OFF+1] << 8));
    
}

// Called when Apply is selected; validates the fields, and if all is well,
// opens the status window, submits the form, and changes the frame contents.
function applyForm()
{
  var ok = true;
  var f = document.theform;
  var RecDoc = parent.frames.leftmenu;
  var i, idx;
  var trigOff, recval, mask;
  var tempArr = new Array();
  
  // get the chanParams offset.
  switch (TRIG_ID)
  {
    case 0: trigOff = TRIG1_OFF; break;
    case 1: trigOff = TRIG2_OFF; break;
    case 2: trigOff = TRIG3_OFF; break;
  }
  
  if (isNaN(parseInt(f.trigdata1.value, 16)))
  {
    alert("Serial Trigger Match Byte 1 contains invalid characters.\nValid characters are 0-9 and A-F or a-f");
    return false; 
  }

  if (isNaN(parseInt(f.trigdata2.value, 16)))
  {
    alert("Serial Trigger Match Byte 2 contains invalid characters.\nValid characters are 0-9 and A-F or a-f");
    return false; 
  }

  if (ok)
  {         
     ok = (verifyNumRange(f.trignotif.value, 0, 65535, "Notification Interval", true) &&
           verifyNumRange(f.trigrenotif.value, 0, 65535, "Re-Notification Interval", true));

     recval = 0;
     mask = 0;
     for (i = 0; i < NUM_TRIG_PINS; i++)
     {
        switch (i)
        {
          case 0: idx = f.triginp1.selectedIndex; 
                  recval |= parseInt(f.triginp1.options[idx].value);
                  break;
          case 1: idx = f.triginp2.selectedIndex;
                  recval |= parseInt(f.triginp2.options[idx].value); 
                  break;
          case 2: idx = f.triginp3.selectedIndex;
                  recval |= parseInt(f.triginp3.options[idx].value);
                  break; 
        } 
        if (idx != 2)		// pin used in trigger
          mask |= (1 << i);
     }
     
     rec6[trigOff + TMASK_OFF] = mask;
     rec6[trigOff + TCMP_OFF] = recval;

     recval = 0;
     if (!(f.trigseryn.checked))
       recval |= parseInt(f.trigseryn.value);
     idx = f.trigchan.selectedIndex;
     recval |= parseInt(f.trigchan.options[idx].value);
     idx = f.trigdatsiz.selectedIndex;
     recval |= parseInt(f.trigdatsiz.options[idx].value);
       
     rec6[trigOff + TSER_OFF] = recval;
       
     rec6[trigOff + TMBYTE_OFF] = parseInt(f.trigdata1.value, 16);
     rec6[trigOff + TMBYTE_OFF + 1] = parseInt(f.trigdata2.value, 16);

     tempArr = StrToArr(f.trigmesg.value, 24);
     UpdateArr(rec6, trigOff+TMESG_OFF, 24, tempArr);
    
     idx = f.trigprio.selectedIndex;
     rec6[trigOff + TPRIO_OFF] = parseInt(f.trigprio.options[idx].value);
      
     recval = parseInt(f.trignotif.value, 10);
     rec6[trigOff + TNOT_OFF] = recval & 0xff;
     rec6[trigOff + TNOT_OFF + 1] = (recval >> 8) & 0xff;
    
     recval = parseInt(f.trigrenotif.value, 10);
     rec6[trigOff + TRENOT_OFF] = recval & 0xff;
     rec6[trigOff + TRENOT_OFF + 1] = (recval >> 8) & 0xff;

     recstr = rec6.join();
     RecDoc.SetRecord(6, recstr);
     reportDone();
  }

  return ok;  
  
} // applyForm


// called when web page is loaded in the browser
function initPage()
{
  var RecDoc = parent.frames.leftmenu;
  var recstr = "";
  var table = document.getElementById("smtptrigtbl");
  var rows = table.rows;
  var cells = rows[1].cells;

  recstr = RecDoc.GetRecord(6);
  rec6 = recstr.split(",");

  // setup the correct channel number:
  TRIG_ID = parseInt(RecDoc.GetCurrTrigNo());
  cells[0].innerHTML = "Trigger " + (TRIG_ID + 1);

  // populate the fields from the setup records array
  popFields();
  
} // initPage

-->
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
<head>


<style type="text/css" screen="media">

</style>
<!-- <script language="JavaScript" src="applydef.js"></script> -->
<script language="Javascript">
var sTarget = "welcome.htm";

var apply_defaults_flag = 0;

function applyDef()
{
  if(apply_defaults_flag == 0)
    {
      var MenuDoc = parent.frames.leftmenu;
      MenuDoc.applyDefaults(MenuDoc);
    }
  else
    {
      alert("Please wait, the previous Apply Defaults request is in progress.");
    }
  apply_defaults_flag ++;
  return false;
}

function noSubmit()
{
  window.location.href = sTarget;
  return true;
}
</script>

</head>

<body text=#000000 bgColor=#ffffff leftMargin=0 topMargin=0 marginwidth="0" marginheight="0">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<table width=600 border=0 >
  <tr>
    <td>
      <p class=datalabelcenter><br><br>

         <b>Are you sure you want to Apply Factory Defaults?<br></b>

      </p>
    </td>
  </tr>  
  <tr>
    <td><img height=4 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td class=databutton align=center>

       <input type=button value="    YES    " onClick="return applyDef()">
       <img height=1 width=25 src="images/spacer.gif" border=0>
       <input type=button value="    NO    " onClick="return noSubmit()">

    </td>
  </tr>  
  <tr>
    <td><hr width="100%" /></td>
  </tr>
  <tr>
    <td><img height=10 src="images/spacer.gif" border=0></td>
  </tr>
  <tr>
    <td colspan=3>
      <p class=datalabelcenter id="dyn">  
      <!-- dynamic string gets inserted here.. -->
      </p>
    </td>   
  </tr>
</table>       

</body>
</html>
HTTP/1.0 200
Content-type: application/xml-dtd

<!ELEMENT UNITINFO (FW,MAC,VER?,IP?,GWAY?,DNS?,NETM?,DHCP?,MTU?,LINE?,LINE2?)>
<!ELEMENT FW (#PCDATA)>
<!ELEMENT MAC (#PCDATA)>
<!ELEMENT VER (#PCDATA)>
<!ELEMENT IP (#PCDATA)>
<!ELEMENT GWAY (#PCDATA)>
<!ELEMENT DNS (#PCDATA)>
<!ELEMENT NETM (#PCDATA)>
<!ELEMENT DHCP (#PCDATA)>
<!ELEMENT MTU (#PCDATA)>
<!ELEMENT LINE (#PCDATA)>
<!ELEMENT LINE2 (#PCDATA)>
<!-- NETM,DHCP,MTU,LINE fields are added newly -->

HTTP/1.0 200
Content-type: text/xml

<?xml version="1.0"?>
<!DOCTYPE UNITINFO SYSTEM "unitinfo.dtd">
<UNITINFO>
HTTP/1.0 200
Content-type: text/html

<!DOCTYPE html PUBLIC "-//W3C//Dtd html 4.0 transitional//EN">
<html>
<head>


<title>Lantronix  XPort   Device Server</title> 

<link href="images/ltrx_style.css" type=text/css rel=stylesheet>

<script language="JavaScript" src="js/validatenetwork.js"></script>
<script language="JavaScript" src="js/util.js"></script>
<script language="Javascript" src="welcome.js"></script>

</head>

<body text=#000000 bgColor=#ffffff leftMargin="2" topMargin="2" marginwidth="2" marginheight="2" onLoad="initPage()">
<!-- this top enclosing table is used to fix NN4 background image tiling issues -->
<xml id="unitinfo" src="unitinfo.xml"></xml>
<xml id="setuprec" src="setuprec.xml"></xml>

<table cellSpacing=0 cellPadding=0 width=600 border=0 >
	<tr>
		<td width=60>&nbsp;</td>
		<td class=datatitle width=480>Device Status </td>
		<td width=60>&nbsp;</td>
	</tr>
	<tr>
		<td class=color1back colspan=3><img height=2 src="images/spacer.gif" width=600 border=0></td>
	</tr>
	<tr>
		<td class=hometitle colspan=3>&nbsp;</td>
	</tr>
</table>
<table class=basicTable align="left" border="1">
	<tr class="statusHeader">
		<td colspan="3"><b> Product Information</b></td>
	</tr>
	<tr>
		<td><b> Firmware Version: </b></td>
		<td colspan="2" id = "fwver"></td>
	</tr>
	<tr>
		<td><b>Build Date:</b></td>
		<td colspan="2" id = "build"></td>
	</tr>
		<tr class="statusHeader">
		<td colspan="3"><b>Network Settings</b></td>
	</tr>
	<tr>
		<td><b>MAC Address:</b></td>
		<td colspan="2" id = "macp"></td>
	</tr>
	<tr>
		<td><b>Network Mode: </b></td>
		<td colspan="2" id = "netm"></td>
	</tr>
	<tr>
		<td><b>DHCP HostName:</b></td>
		<td colspan="2" id = "dhcp"></td>
	</tr>
	<tr>
		<td><b>IP Address:</b></td>
		<td colspan="2" id = "ipaddr"></td>
	</tr>
	<tr>
		<td><b>Default Gateway: </b></td>
		<td colspan="2" id = "gateway"></td>
	</tr>
	<tr>
		<td><b>DNS Server:</b></td>
		<td colspan="2" id = "dns"></td>
	</tr>
	<tr>
		<td><b>MTU:</b></td>
		<td colspan="2" id = "mtu"></td>
	</tr>
	<tr class="statusHeader">
		<td colspan="3"><b>Line settings</b></td>
	</tr>
	<tr>
		<td><b>Line 1:</b></td>
		<td colspan="2" id = "line"></td>
	</tr>

</table>
</body>
</html>
HTTP/1.0 200
Content-type: application/x-javascript

<!--
var nnXmlDoc; // global var for navigating 
var xmlDoc;


var NUM_INFO = 10;


// fills in the setup records array from the XML document
function fillIn(xmldoc)
{
  var unitinfo, nodeList, DhchHst;
  var recdata = new Array(NUM_INFO);
  var i = 0, NetworkMode, Hex, LineS, LineDisp=""; //variables to process the serial line settings

  var version, verstr, Bdatestr, Bdate; //variables for processing build date.
  
  unitinfo = xmldoc.getElementsByTagName('UNITINFO').item(0); // fill in the values in the fields
  nodeList = unitinfo.getElementsByTagName('FW');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;   
  nodeList = unitinfo.getElementsByTagName('MAC');
  recdata[i] = nodeList.item(0).firstChild.nodeValue;
  recdata[i] = recdata[i].replace(/:/g, "-");
  nodeList = unitinfo.getElementsByTagName('VER');
  recdata[++i] =  nodeList.item(0).firstChild.nodeValue; 
	version = recdata[i++];
	verstr = version.split("(");
	Bdatestr = verstr[1];
	Bdate = Bdatestr.replace(')', '');
  nodeList = unitinfo.getElementsByTagName('IP');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;
  nodeList = unitinfo.getElementsByTagName('GWAY');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;
  nodeList = unitinfo.getElementsByTagName('DNS');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;
  nodeList = unitinfo.getElementsByTagName('NETM');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;
  nodeList = unitinfo.getElementsByTagName('DHCP');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;
  nodeList = unitinfo.getElementsByTagName('MTU');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;
  nodeList = unitinfo.getElementsByTagName('LINE');
  recdata[i++] = nodeList.item(0).firstChild.nodeValue;

  
  var fw = document.getElementById("fwver");
  var bd = document.getElementById("build");
  var mac = document.getElementById("macp");
  var ipaddr = document.getElementById("ipaddr");
  var gt = document.getElementById("gateway");
  var dn=document.getElementById("dns");
  var nt=document.getElementById("netm");
  var dh=document.getElementById("dhcp");
  var mt=document.getElementById("mtu");
  var ln=document.getElementById("line"); 


  fw.innerHTML = recdata[0];
  macp.innerHTML = recdata[1];
  
  var dateCal = Bdate.substr(4, 4); //date            
  var mon = eval(Bdate.substr(2, 2)); //month           
  var yearCal = Bdate.substr(0, 2); //year
        
  var month = new Array(12);
    month[1] = "Jan";
    month[2] = "Feb";
    month[3] = "Mar";
    month[4] = "Apr";
    month[5] = "May";
    month[6] = "Jun";
    month[7] = "Jul";
    month[8] = "Aug";
    month[9] = "Sep";
    month[10] = "Oct";
    month[11] = "Nov";
    month[12] = "Dec";

  if (mon < 10) mon = eval(Bdate.substr(3, 1));          
  
  var monthstr = month[mon];
  var BuildDate = dateCal + "-" + monthstr + "-" + "20" + yearCal;
  
  bd.innerHTML = BuildDate; 
  ipaddr.innerHTML = recdata[3];
  gt.innerHTML = recdata[4];
  dn.innerHTML = recdata[5];
  NetworkMode = recdata[6];
  if (NetworkMode == 1)
    nt.innerHTML = "Wired";
  else
    nt.innerHTML = "Wireless";
  DhchHst = recdata[7];
  if (DhchHst == "None")
    DhchHst="< None >";
  dh.innerHTML = DhchHst;
  mt.innerHTML = recdata[8];
  LineS = recdata[9];
  LineS2 = recdata[10];
  
  Hex = LineS.substr(0,2);
  switch (parseInt(Hex, 16) & 0x03)  //parseInt() parses a string and returns an integer
  {
    case 0x00: LineDisp=LineDisp.concat("RS232, "); break;
    case 0x01: LineDisp=LineDisp.concat("RS485 4-wire, "); break;
    case 0x03: LineDisp=LineDisp.concat("RS485 2-wire, ");break;
    default: break;
  } 
  Hex = LineS.substr(3,2);
  switch (parseInt(Hex, 16) & 0xff)   //baud rate  
  {
    case 0x00: LineDisp=LineDisp.concat("38400, "); break;
    case 0x01: LineDisp=LineDisp.concat("19200, "); break;
    case 0x02: LineDisp=LineDisp.concat("9600, "); break;
    case 0x03: LineDisp=LineDisp.concat("4800, "); break;
    case 0x04: LineDisp=LineDisp.concat("2400, "); break;
    case 0x05: LineDisp=LineDisp.concat("1200, "); break;
    case 0x06: LineDisp=LineDisp.concat("600, ");  break;
    case 0x07: LineDisp=LineDisp.concat("300, ");  break;
    case 0x08: LineDisp=LineDisp.concat("115200, "); break;
    case 0x09: LineDisp=LineDisp.concat("57600, "); break;
    case 0x0a: LineDisp=LineDisp.concat("230400, "); break;
    case 0x0b: LineDisp=LineDisp.concat("460800, "); break;
    case 0x0c: LineDisp=LineDisp.concat("921600, "); break;         
    default:  break;
  }
  
  Hex = LineS.substr(0,2);
  switch (parseInt(Hex, 16) & 0x0c) //data size
  {
    case 0x08:LineDisp=LineDisp.concat("7, ");  break;
    case 0x0c: LineDisp=LineDisp.concat("8, "); break;
    default: break;
  }
  
  switch (parseInt(Hex, 16) & 0x30) //parity type
  {
    case 0x00:LineDisp=LineDisp.concat("None, ");  break;
    case 0x30:LineDisp=LineDisp.concat("Even, ");  break;
    case 0x10:LineDisp=LineDisp.concat("Odd, ");  break;
    default: break;
  }
  
  switch (parseInt(Hex, 16) & 0xc0) //stop size
  {
    case 0x40:LineDisp=LineDisp.concat("1, ");  break;
    case 0xc0:LineDisp=LineDisp.concat("2, "); break;
    default: break;
  }

  Hex = LineS.substr(6,2);
  switch(Hex & 0xff)     //flow control
  {
    case 0x00: LineDisp=LineDisp.concat("None."); break;
    case 0x01: LineDisp=LineDisp.concat("Software."); break;
    case 0x02: LineDisp=LineDisp.concat("Hardware."); break;
    case 0x05: LineDisp=LineDisp.concat("XON/XOFF, Pass Chars to Host."); break;
    default: break;
  }
  
  ln.innerHTML=LineDisp;


  
} // fillIn

// event handler for Netscape - called when XML document is loaded
function documentLoaded(e) 
{
  fillIn(nnXmlDoc);
} // documentLoaded

//Function to convert xml file from String to Document, utility for chrome browser.
function StringToDoc(text) 
{
	var parser = new DOMParser();
	return parser.parseFromString(text, 'text/xml');
}

// called when web page is loaded in the browser
// determines browser type and loads XML in the appropriate manner						
function initPage()
{
    var agt=navigator.userAgent.toLowerCase();
	if (agt.indexOf("chrome") != -1)  //chrome
	{
        xmlDoc = new XMLHttpRequest();
		if (xmlDoc.overrideMimeType) xmlDoc.overrideMimeType ('text/xml');
		
		xmlDoc.onreadystatechange = function ()
		{
		    if ((xmlDoc.readyState == 3)  && (xmlDoc.status == 200))
			{
			    fillIn (StringToDoc (xmlDoc.responseText));
			}
		}
		xmlDoc.open ("GET", "/secure/unitinfo.xml", true, "", "");
		xmlDoc.send (null);
		return;
	}
	if (agt.indexOf("firefox") != -1) 	//Firefox & Netscape browsers returns firefox index.
	{  
        xmlDoc = new XMLHttpRequest();
		xmlDoc.onreadystatechange = function ()
        {
            if (xmlDoc.readyState == 4 && xmlDoc.status == 200 )
            {
				fillIn(xmlDoc.responseXML);
            }
        }
		xmlDoc.open("GET", "/secure/unitinfo.xml" ,true ,"","");                       
		xmlDoc.send(null);
		return;
    }

	if (agt.indexOf("safari") != -1)    //'Safari';
	{
        	xmlDoc = new XMLHttpRequest();
		if (xmlDoc.overrideMimeType) xmlDoc.overrideMimeType ('text/xml');
		
		xmlDoc.onreadystatechange = function ()
		{
		    if ((xmlDoc.readyState == 3)  && (xmlDoc.status == 200))
			{
			    fillIn (StringToDoc (xmlDoc.responseText));
			}
		}
		xmlDoc.open ("GET", "/secure/unitinfo.xml", true, "", "");
		xmlDoc.send (null);
		return;
	}
	if ((agt.indexOf("msie") != -1) || (agt.indexOf("gecko") != -1))	// 'Internet Explorer';
	{
		var ie_version= parseFloat(agt.substring(agt.indexOf("msie")+5));
		if ((ie_version >= 10) || (agt.indexOf("gecko") != -1))           //IE10 & IE11
		{
			xmlDoc = new XMLHttpRequest();
			if (xmlDoc.overrideMimeType) xmlDoc.overrideMimeType ('text/xml');
		
			xmlDoc.onreadystatechange = function ()
			{
				if ((xmlDoc.readyState == 3)  && (xmlDoc.status == 200))
				{
					fillIn (StringToDoc (xmlDoc.responseText));
				}
			}
			xmlDoc.open ("GET", "/secure/unitinfo.xml", true, "", "");
			xmlDoc.send (null);
		}
		else
		{
			xmlDoc = document.getElementsByTagName('xml').item(0);
			fillIn(xmlDoc);
		}
		return;
	}

} // initPage
-->
HTTP/1.0 200
Content-type: image/gif

GIF89a  �  ���������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ,       : H����*\�0a��
��aŉ>$�Q"ƌ/���dI�SrD9R�˗0S ;HTTP/1.0 200
Content-type: image/gif

GIF89a  �  ���������                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                       ,       O H����*\�pa� 	>|`�C�)bDHq�Ƅ%�,8R���$7
����J�[��	��̚m*�y�#˟�
:0  ;HTTP/1.0 200
Content-type: image/gif

GIF89a� C �  �����卑���ԫ���g��3���¢�����p��ޛ�����������!�     ,    � C  �0 ��j�s�^�_)�䩦,�o�r�4n�����^�',�äQ�\:�P��9�R��lu��j���K���4z}n���<N����:~����|�~�������������������������������������������������������������[�HA�Q�3D���������9����.��@����  �� ���9x�lݎx�����E�w�vL|G�]�� ��2��/��,����x<��� x�x`���	b �Y@m�=��^�#�5�qQ��$;�\)���w������^�d&� 7�崐���<���mԘ�y�GU��1�8#k��e�>�Zv.��q:k����Y��{qD�@�s �I����Ƀ�oM��5bňyM���ȋ�L�Ci��r`Hy����pk��	y}�%1����̃���k�ط�x�}`�_��`��Ҵ�h��By>�WBO?!��B 4�mN-�@gb���g�q�m�H'�s�	v ed�w�f�����9���H#��!�!X*y�TX��5ARL�-�n9MP�U0�N#,`Wu�FmHt�n+	�cO�c"�-6S�A��֖0�W��6~��Ea �O	�Q����L1�iVa���̙�b���vsU����	�5�������%��0y�g�b���<L�]|F`�vH	�zgB�� ��^n,�C��I0ӱ�I�b�b���"�W�	A, �>�g����(�@�?��!�N�Ua����&|KA�Cl8��K���o <g`��%H���`��@m��B�AƮ�N^*�X�	3L���X�/���1M���v�	ƫ9��I�^�o�I�fɺ�\�fMf��J=�1��A���У�rd�����8\��;9��e�53�T�t����'צ���Qr ]��n;1Gk�C�Mp1����KFQuh$s���7���ދ������`i��n��4��.��a��p.�ת�!x����S�`.�0�%����8&�s�c���p^8<���b�`6	1{��^���'���GK��$M��e��ð�
������9_�d �L}�9n¯v5� ֋��z�E�Q��	bƍנ��[� y�:��Lz>ȠgХ�<'F�!ͩB�38kLi��vs��ʃ�3A�5�ֹ`8������ KA� ya�&P[V> ����O��1	i�XQb��l%2���x�)���"��/���Q��(��M�@x�t��Q��pX��Z�0�bv��&	$�i!�f����((�vX�@l�:� �x�WaH���&��\F�A�2F��`2���ӗXvˊ"
���a��À`{�����#�vN� ��̣>�
0R���(����Q��>���L�(g�Gu`�@:���_�r-:��39@/T��j2K��Я)� nm�@k�BLj���\W	�ق��R5|A&�C"�$�AI�Sw��q?���Ѐ��Ęii!U"f��I`�B��AժZժ!�A�0�f��QU����6���䱍#R%�	��BU�50(H@��`d����1�AX�����E�a���:V��mld+��R���ͬe5���z����h?;�В� H�jW��ֺ�����lgK������ͭnw��  ;A {
  COLOR: #542d81
}

TD.pagelink {
  COLOR: #542d81;
  FONT-WEIGHT: bold; 
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

A.pagelink {
  COLOR: #542d81;
  FONT-WEIGHT: bold; 
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

A.pagelinkdisabled {
  COLOR: #cccccc;
  FONT-WEIGHT: bold; 
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

A.pagelink:hover {
  COLOR: #ff6600; 
  FONT-WEIGHT: bold; 
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

TD.datalink {
  COLOR: #542d81;
  FONT-WEIGHT: bold; 
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

A.datalink {
  COLOR: #542d81;
  FONT-WEIGHT: bold; 
  TEXT-DECORATION: none
}

A.datalink:hover {
  COLOR: #ff6600; 
  FONT-WEIGHT: bold; 
  TEXT-DECORATION: none
}

TD.topnavcenter {
  BACKGROUND-COLOR: #542d81;
  COLOR: #ffffff;
  PADDING-TOP: 1px;
  PADDING-BOTTOM: 1px;
  TEXT-ALIGN: center;
  FONT-WEIGHT: bold; 
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

TD.topnav {
  BACKGROUND-COLOR: #542d81;
  COLOR: #ffffff;
  PADDING-LEFT: 10px;
  PADDING-TOP: 1px;
  PADDING-BOTTOM: 1px;
  TEXT-ALIGN: left;
  FONT-WEIGHT: bold; 
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

A.topnav {
  COLOR: #ffffff;
  TEXT-DECORATION: none
}

A.topnav:hover {
  COLOR: #cc6600; 
  TEXT-DECORATION: none
}

A.topnavcurr {
  COLOR: #ffff00;
  TEXT-DECORATION: none
}

TD.botnav {
  BACKGROUND-COLOR: #542d81;
  COLOR: #ffffff;
  PADDING-LEFT: 20px;
  PADDING-TOP: 1px;
  PADDING-BOTTOM: 1px;
  TEXT-ALIGN: left;
  FONT-WEIGHT: normal; 
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

A.botnav {
  COLOR: #ffffff;
  TEXT-DECORATION: none
}

A.botnav:hover {
  COLOR: #cc6600; 
  TEXT-DECORATION: none
}

.color1back {
  BACKGROUND-COLOR: #ff6600
}

.color2back {
  BACKGROUND-COLOR: #999999
}

TD.product {
  COLOR: #ff6702;
  TEXT-ALIGN: right;
  FONT-WEIGHT: bold; 
  FONT-SIZE: 20px; 
  FONT-STYLE: italic;
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

TD.backpanel {
  TEXT-ALIGN: center;
  FONT-SIZE: 10px;
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

TD.banner {
  TEXT-ALIGN: right;
  FONT-SIZE: 10px;
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.report {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: top;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Courier, Courier New, monospace
}

.datalabel {
  COLOR: #000000;
  TEXT-ALIGN: right;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datalabeltop {
  COLOR: #000000;
  TEXT-ALIGN: right;
  VERTICAL-ALIGN: top;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datalabellefttop {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: top;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datalabelleft {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datalabelright {
  COLOR: #000000;
  TEXT-ALIGN: right;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datalabelcenter {
  COLOR: #000000;
  TEXT-ALIGN: center;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datalabellarge {
  COLOR: #000000;
  TEXT-ALIGN: center;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 14px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datalabelleftlarge {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 14px; 
  FONT-WEIGHT: bold;
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.dataverbage {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 11px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datavalue {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datavaluetop {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: top;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datavaluecenter {
  COLOR: #000000;
  TEXT-ALIGN: center;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datavalueright {
  COLOR: #000000;
  TEXT-ALIGN: right;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datavalro {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold;
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datavalrotop {
  COLOR: #000000;
  TEXT-ALIGN: left;
  VERTICAL-ALIGN: top;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold;
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.hometitle {
  COLOR: #000000;
  TEXT-ALIGN: center;
  PADDING-TOP: 30px;
  FONT-SIZE: 20px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datatitle {
  COLOR: #000000;
  TEXT-ALIGN: center;
  PADDING-TOP: 2px;
  FONT-SIZE: 16px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.datatitlehelp {
  COLOR: #000000;
  TEXT-ALIGN: right;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 16px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

A.datatitlehelp:hover {
  COLOR: #000000;
  TEXT-DECORATION: none
}

A.datatitlehelp {
  COLOR: #000000;
  TEXT-DECORATION: none
}

.databutton {
  COLOR: #000000;
  TEXT-ALIGN: center;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.tabletitle {
  COLOR: #000000;
  TEXT-ALIGN: center;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.tabletitleleft {
  COLOR: #000000;
  TEXT-ALIGN: left;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.tableback {
  BORDER: 1px solid black;
  BACKGROUND-COLOR: #cccccc
}

.tableheader {
  PADDING: 2px;
  BACKGROUND-COLOR: white;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.tablefield {
  PADDING: 2px;
  BACKGROUND-COLOR: white;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.tablefieldcenter {
  PADDING: 2px;
  BACKGROUND-COLOR: white;
  TEXT-ALIGN: center;
  FONT-SIZE: 12px; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.tableblank {
  PADDING: 2px;
  BACKGROUND-COLOR: #cccccc
}

.tablelight {
  BORDER: 1px solid black;
  BACKGROUND-COLOR: #e6e6e6
}

.smbutton {
  PADDING: 0px;
}

.regbutton {
  FONT-SIZE: 12px;
  FONT-WEIGHT: normal;
}

TD.line {
  BORDER-TOP: 1px solid black;
}

.roinput {
  BORDER: 0px
}

.bpback {
  BORDER: 2px solid black;
  BACKGROUND-COLOR: #000000
}

TD.bpeth {
  COLOR: #ffffff;
  BACKGROUND-COLOR: #0000ff;
  WIDTH: 16px;
  HEIGHT: 16px;
  TEXT-ALIGN: center;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 10px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

TD.bpdev {
  COLOR: #ffffff;
  BACKGROUND-COLOR: #008000;
  WIDTH: 16px;
  HEIGHT: 16px;
  TEXT-ALIGN: center;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

TD.bpdevon {
  COLOR: #ffffff;
  BACKGROUND-COLOR: #542d81;
  WIDTH: 16px;
  HEIGHT: 16px;
  TEXT-ALIGN: center;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

TD.bppower {
  COLOR: #ffffff;
  BACKGROUND-COLOR: #999999;
  WIDTH: 16px;
  HEIGHT: 16px;
  TEXT-ALIGN: center;
  VERTICAL-ALIGN: middle;
  FONT-SIZE: 10px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

TD.bpblank {
  BACKGROUND-COLOR: #000000;
  WIDTH: 2px;
  HEIGHT: 17px
}

A.bp {
  COLOR: #ffffff;
  TEXT-DECORATION: none
}

A.bpcurr {
  COLOR: #ffff00; 
  TEXT-DECORATION: none
}

A.bp:hover {
  COLOR: #cc6600;
  FONT-SIZE: 10px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

A.about {
  COLOR: white;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif;
  TEXT-DECORATION: none
}

A.status {
  COLOR: white;
  FONT-SIZE: 12px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif;
  TEXT-DECORATION: none
}

.devicetitle {
  COLOR: #000000;
  TEXT-ALIGN: center;
  PADDING-TOP: 8px;
  FONT-SIZE: 14px; 
  FONT-WEIGHT: bold; 
  FONT-FAMILY: Arial, Helvetica, sans-serif
}

.statusHeader
{
  background-color: #bbb;
  color: #000;
  font-weight: bold;
  font-family: arial, helvetica, sans-serif;
  font-size: 10pt;
}

.basicTable
{
  width: 600;
  font-family: Arial,Helvetica,sans-serif;
  font-size: 12px;
  font-weight: normal;
  text-align: left;
  padding: 2px 5px;
  margin-left:5px;
  margin-right: auto;
  margin-top: auto;
  margin-bottom: auto;
  border:3px solid #bbb;
  border-collapse:collapse;
}  

.basicTable td
{
  padding: 2px 5px;
  color: #000;
  border:2px solid #bbb;
}

.footerContainer
{
  font-size: 11px;
  font-family: Arial,Helvetica,sans-serif;
  FONT-WEIGHT: normal;
}HTTP/1.0 200
Content-type: image/gif

GIF89a  �  ���   !�   ,       D ;HTTP/1.0 200
Content-type: image/gif

GIF89a C �  ������!�     ,     C  bx��
[|��;��x�r�7��Y  ;HTTP/1.0 200
Content-type: image/png

�PNG

   IHDR   �   0   ��    tIME�;��v�   	pHYs  �  ��o�d   gAMA  ���a  �IDATx��}	x\�y�{�>�$˛lɖmY6��xeKS�!@BHRHJIRڐ�iKV �	$m��?�ڐ��'!,!M�4���cv0���ak�f�����\���-K��K�O�}fF3s��|��-�!����
m۹K�KL�0^�;bDF��^|�e�[&��QU�A�z(�7n�4N�W�#=��C��/�"M��¹'
f�(�p����m�Ζ��j�!�c�ZZZ0�	b����֦,@OO^�g�u(
�~DF蘧I�&ᅗWHM�0m�T,8q�0M]�W*�0cZS�pho�`�J�ս�j�����ΒY�;`i���j�u���Vx�aO�= ����$R�zzlA�<���C8���9�N�O�g,[w��)u�Į֎~MaǄ#��׏S�{���ǞT����x1���	a[>p�\�u�7�Ξnd2��i�tv��]0�A���땿	�uW�[�����r`݈|z�I��	��~$1���0M�V���8/�'��a�t�tQ��A��2���da}������>���-��GK]tI:$?�"���-]G��m�I=z�r�fNk�a�����WW���H48b��=�t#e+!8��gΘ��Z4N������k�2����m�[������*���6�+���K�����>f��2B�Ez�����Q��u�>4	p|�@-_-�F�zF����s}�T 00�4A^7tYVAq�F��(�����_��yz��>��i²,�0*���&̟?D �Lӆ�[�H�A���2L���a�k�b���'��Aa�z���p
.�![h��V\�'�GA����|t����r�/܍b��4���! �cie��ħٿ�;���/�2��Y��{H��=�Lo���|0�y��u#�J�:[EG�!3�uwZ�n��6�س/�ě�H!��u����Y�#�Ə� �b�ޯcl.�+�/�DLÌ�%҄A�8_D�.�ģm��[�Ƚ5,�/����z�ADv	[�$���8��O\U�b��]$��ξ��K�T�ĸ�n���'�?�G�:��|ئ�\w�z�:�AH��u]pB��G��I����ǋ/��_���r��#�0L�,0Y�(�*v�F��E	����0��x� �CV ֔u�u $�l����Ky �/.���$�#��B�hhz��i��"d_t)R�A��� ����!m�ߡ���3&��#�E���E9:-D裐˩1i�R&�$l�	��Yt�z�ē����Ga���!z���?��/aѓ֯��Q��d9�1�轴A_&�3M��	��}D�������m�(�Gn��	���~�P*ާY�E>Չlk���������=�d�o$}T��Aʑ!Ơ�_����<�r{棥�]=�>�!ܚRqh�`�%��mFx���I(�r��a���Ȉ�-�U�/��˅_,H���$"�@�D��Wu��y��Y�	�=� ����4�rǠF��u������	p��p�O�K�E`CZ	D��@����\rp`��XWQ�[�n�\�j%v�ޭ�g,.	C$I�5	B�zO?��Ə�ucGa�d�)��\)P�̺�"w�N���.}ͦ���eD�I0���/?=��.�7���S�=[`{	�A8i�8KЄ��GZ��sa|鞣��f�l��ŅbZc#<���:�8b�>�$�=0TZ��Gz��4�%`k|D|�wSէ�/��W�/�6'�4�wf`dɈ`���.��/T�G~)��#}߁�yщ�QY;M�"� JC_p����ؓ>���qcƪDg&K��2ݼ`�<�֭ۆ�z;v�I.ضs����.�y��c���L�ݲ�����`���0l�bc��!>�]avuJ���#UeA��(��J�Hy�a����Z*%qѿ�y�g���M_EFZ�9��ژ�_�����
��3��|��2?c��=UU�Jk�J�H(
�@(��=XZ�u�ܵk:�������}%dlq�L�U�0'�Ҷ���J�M�8S��e�6l�.w�ܩ��ux�ʥ���Z�S��]����-�����Γݢ�<YKYCs���/���Z�!��a�s/J�Wm��e��:���^O_G�6�{��->��EA���5�ѵH�P<��m�kHxs)x��)lC����{J>u�����G��"KС�c��)GCw�b��g�
��g�j`�����)�㚕���N���{0Nܶ�]6N�$c��7�����ES"a��"L�|���aj{`��1�t�����Etv� �n��u�9���m�G&`ƌ�9m����ի����Ff|Ό�8��z1�f4�`����WW����B'�(TAE+��**ژ�2�*������<���H@8�>N�u<���oHq'��Dg�[�>����4C6��0K)�kJ�F�ÿ�������,���K��2�h�h"�!k	�F�7D5��h:��u�+utt� ��9Br��i�W{%��PI��#O>-7n܈�0��#�����(�o0�WHb�$�].�H(J�^Q>��X{��ށ�6aYʒ��IN;iѠ��JE�}B ��C��5������֑E�R�b�� K�	E�
�)�&�0@����Md���\t�a(z��#ɖ�����|���Q�ϑ�g&!�:{ SI|7�Ȅ��L���V�(SU͈���&�C�3���vh1K'�z��8�!����r�[�M[7��,�I���~�,�&��bLo��<E�}͛k��ӥ�8�ġU^Hf�D ��I�6��H͊���s�l+kHfV��0��Ĩ��Wp]<��e�ys�\�`��x薯�G9���H=3��_�qC"���qL#��J�{`Q�J��\W�����ބYRX���(xE���,"�PCc�C�@�W�H`����P�7�*�w�ȓ6�Fz��Lُ�
��A��D��rQ;�Ε�k�Pڝ�hh���u�Ǆ ,y�Q��Ѯ�I�h�t�S�!�z���3���ΖV��Ï��� �P��VyjFd��EI0��7���#3��ڟ���HĒ�}����qf�$?A1l��DCY�G�X�-o�'-X��q�5׉/��2����Tc.3)��v�]^���I)������x	D�
�bx��9 �s����G\Wd*�I͝�iI��]y��n� ڊ���집s�H��P�)�	����wIi2�䗜<��D�E��F7��@�������Z���v�i���כ+p,�\���3���QW��(�]��3�LUM��z#K�-S��>W,�U%�,M�<YA�\�����I��g�Vr�c��������]
���yh��m�!8�0M̥$���ڜ�{s�:�wv�OOY$Zo����*%_�s�8}�S���1?1~�hL�0�&5��4�G��;[�[omG!�8�)���2�5�=H�ܖ-߻�>hX7v̐��s�����[*q�Y�[�@X,	%eKp���Ұ�"JSE�\&8n�^ ܚ,�o�	m��' ��������m+٩���ͯd.�X�7���T>ςy'bڔ�Ꞟz�%���娪����_۴�'�PЅ手�\����:̝;sg��|�O��o�����
�nق�t��M�2[�p8[�⥒��H��N<��2D�&��>����3���oV�z�$VR�0�ւ���Y�ἳ߿���ԏtj�#G:�I��SO�OAF�D��_�kN��s"zix͓e$p�(B��(�	���Z0R�a\s#	���޳�A�}�.匙��<W^�2�i�Y�)��0G�jD���y+��@L�4혘�܌?9y���g_|Y	�F���� C��6�\����"�Q�Y�u湘�C��Bq�{O��$x/�X��6�S�:�P��8�/b�҇a}�òi��C�{b�%Pڗ4�3��t̝�?=m����$�d�*E÷���Ix�r��Hw�p�ĴkCz^� ��G�Q���vP���`�<X%�K���5Q"&�������b�~p���Α���{,�3�
'���{�:n,,Ls����g���i����^U���
,�Q�"?�XR��=�����_�C�w��N=I|�cC&�R�í�*�X".��Qհ�/[���~Ǟ�|ߪ��#Q�=
�� 0��*	�u���x����F�jH;��/�*���ҊȡK�q�qe�����1��W�Zem�
��2d��c�JRA�w̤R){��o�T!A�@�1#ׄz����0"-{|�t\x޹8㽧���S�_�Kց�c�I���b�1a'C��7g>���*���&���W��nTy<�%T�����5�^8��K���Kν����;��T>k��u{�[TN�}�}x�O��k���	+2���@�H�aQ�$Lt#@��@۫M�3Õ�M��+gX�8$���94��p
L��J$=�z�؝���;�έ=�/�G�;[L��NRj��˞���,�{���hnn��vz�}��?q�`�g�9���_��r8���Ue�s�d��Ĵi�OR-4�E��u�J}��H�����u)2���^�4P>�Ei��ʆH��o���NY5f���Ҟ1tv☡m���R�n���e͗2���$GBjkk1v�X����p�q��zM���$�U�����!����=�N=�<�t��T$�b_!	ur�*��6mB�ԁ��%����iD�ş�x�!���38bˎ�N8;�"F��zbXc�(v� �Fp�,�#&��Y�ۏW����22#7�O�����5�ྻL�l1�io��n*�����~?��BM��T�{>�4E�j���w�H�:�U�UY�"���3b���O�4<B��K�\r+������%�*�,)�=�S��Z��4A���3���cIV=���K�բe�� ���i�Ċ.�����<Y@�7;�_O�X1g�I8��pӔ���7#];
��K���D��g��� ����L����p�!��o��������BW�)��=��g��]:�3�8ş�ё��\�YE��������zް��&g/���̕&���}������sb�@!�J7	Pp��M��IɇJ��]_�z>�t�p�ưҐ� ڽ�����x����)TEJ�W	2?�!��`�oCtC\|9���Q���8��8��}��ɇ�v#]=
�˿~r��
B9~���� I�Tn�F���=zn�����,�>��?Jq/2�Ƶ�6�w��NR�U���!�!��nx�^�T��r%dmZxG�F�
��9�:�'�f��|Y��:d�o�-�E�����w)-x�!h�/K�s?.a���h�Ǣ������6)����z�,hX��OT$�v���pџ�D���9�c��f	��4n�~���=LC1��'�5���H�|�{��Y��E��_P5Dqh�'��Ŗ*�
Uy�3cA�w1:n�ʰX�rYqy�U�eo�[%i��Q���|ٛ\#��7���b����5���0n�IAK�H%�8Qn?É���(���1�棅-���e��o"�5�"m�.�Vn<a�!�"�jg� \��>��]r�0O�<dk���F@�P�Q�Қ%$o���?n���>�n⾦�lV���>E��(!���;v�q�ݰ^Y)�He�}��<&�����p���Ӡ��{�v����������@�֑&��5 ��o%8��TD_����1��X�C�"�f�lC�P=��/,��<LN��?����t�
BӴ�Pyg������T�E��k�m��-[��-y�1����������'|?s�#=m��,�s����Kh�LG��y+&��2��6�=.�9�~��k���_��Ƚ�n��J&�c�%f߻�/A�_/���3�w��2���{�֑w[���I���Go���X^y}���� ��|$.yP�1�0}�4̘:�m��*H�+���f�a�3~D���pi+�B��� |�.8cO�D�\�;�|6����%�R�Q�B���Y:'i���!|r�1)���%EQL�)�O�`�k�4𣏑 ��Z��cx����W��T��Ym�6pҢ�Gz��T�5��쏿��ӛ� ,�o��f�*�6�Q���f�W��\�C��5/"+�#�GH�㪒d�?V�H�4��,��1'���'Ξ��'�)_��g�q�Rj.������{�Ǌ����q��e�<��w��٩B��RA��\8o�N�l�h���`�R\�)�&t��#�5H0Ȥ��.�T!��jl�v��`�;�"�C�Ӆ~����7�k�jŮ~V�H�z~�
� ]�9��;�9A8����iM��s�cp��}�j���Gw��~�qێC�ǗV�&o����C�sD�L�[�r�C$pڢ?����l~F��W"��6P���+��l�J��3��v«n��00�_�?^�_��Ծ�Y���7��g"�up �FJ�o�:��X�Y�)=�}�s��#W��2��
M�,܎DO�Xr���o�����{PW7^�7L@sc#�c o�[/�nݮv����!�I�G_�2Lb�, �?a�p��'�CP^@�!ضV�?�;��7���vI�9��>BI=4�[��)b�o���I�y��_�AF߽Ǝ���6�t	YOS;�,�|�e+�������MS���uc]"����dCWQ�d ݃7�هJ���bLm�|i�
����d����4ro��0��:r$�X��jaJ����;H��������
�ĺhzo��To"K���*��s��-��P��O:	3�k;jKe�X-��u�
G�xD<�o�����>�$�Õ�F�k��V�K��#��MR��#�u=j����'��ȐHs��,���-��� �A ���4a\s���8�kC��b��X�F�"�hTW#]� ��5��d�hܷ�.iC�E��F�Q�_�`S��#E�.�'����U��m�%�����$�C�^�nr<��x�9�wt�S������@a[}��r�Ǳ,�'��1��y��p��2�u�t�ϑfFUb]۫{������'ʀ�L�V�+�kdٕKp����gA�ܢjݹ��i��m$����azW�V���
����цSD�OwI����ц��,2�<J���t`�����I�Z����8W<$�����h�v���y?/�`�'��n"9�4�P:�z�:���7��ގ|���õei��7�}xz߸��M5.�(�"�&T�Qc���@!ߥ� ��܌��c҄q�����^b�_T)
kl��5�sJ�J�߄�}�,c<�rh��,*�
�=��g�Ԧ- ������`@a�o$�.����XpA�8ɚy��e7���"��ɻ��$D�Gi��!���Q��������o�Ⱦcb�G��L�(I�oo0�c{�Ժ�>n��on�"7l؀�[[�ӓK���v����˂��o��P�B�,���v�����M��>��]��2�"bz�TH���4�b�� �O�w�8T��)��^M�"-��j�銭C����@�g��Yd"�i��v.},K7�+`����\�U��E�o�����Q���˻!�=�#��"�W�Ԇ�w�������:�y�m�&Ai���V����6�O���C�����7�����#ԓϡ��W-S��L{Z�r�9����2N
���0����S6C������Nj���s������Q�q����l��؆J��H�ߥ*�D%�`�����j�=R�{1y��)�	���ı��Q��҈��={���c��?v|�~����    IEND�B`�HTTP/1.0 200
Content-type: application/x-javascript

<!--

// verifies that there is a child node (avoids javascript error in IE)
// used for loading XML data where a value is empty or null
function checkForChildren(node)
{
  if (node.hasChildNodes())
    return node.firstChild.nodeValue;
  else
    return "";
} // checkForChildren

//First things first, set up our array that we are going to use.
var keyStr = "ABCDEFGHIJKLMNOPQRSTUVWXYZ" + //all caps
"abcdefghijklmnopqrstuvwxyz" + //all lowercase
"0123456789+/="; // all numbers plus +/=

//Heres the encode function
function encode64(inp)
{
var out = ""; //This is the output
var chr1, chr2, chr3 = ""; //These are the 3 bytes to be encoded
var enc1, enc2, enc3, enc4 = ""; //These are the 4 encoded bytes
var i = 0; //Position counter

do { //Set up the loop here
chr1 = inp[i++]; //Grab the first byte
chr2 = inp[i++]; //Grab the second byte
chr3 = inp[i++]; //Grab the third byte

//Here is the actual base64 encode part.
//There really is only one way to do it.
enc1 = chr1 >> 2;
enc2 = ((chr1 & 3) << 4) | (chr2 >> 4);
enc3 = ((chr2 & 15) << 2) | (chr3 >> 6);
enc4 = chr3 & 63;

if (isNaN(chr2)) {
enc3 = enc4 = 64;
} else if (isNaN(chr3)) {
enc4 = 64;
}

//Lets spit out the 4 encoded bytes
out = out + keyStr.charAt(enc1) + keyStr.charAt(enc2) + keyStr.charAt(enc3) + keyStr.charAt(enc4);

// OK, now clean out the variables used.
chr1 = chr2 = chr3 = "";
enc1 = enc2 = enc3 = enc4 = "";

} while (i < inp.length); //And finish off the loop

//Now return the encoded values.
return out;
}

//Heres the decode function
function decode64(inp)
{
var out = ""; //This is the output
var chr1, chr2, chr3 = 0; //These are the 3 decoded bytes
var enc1, enc2, enc3, enc4 = 0; //These are the 4 bytes to be decoded
var i = 0; //Position counter

// remove all characters that are not A-Z, a-z, 0-9, +, /, or =
var base64test = /[^A-Za-z0-9\+\/\=]/g;

if (base64test.exec(inp)) { //Do some error checking

alert("There were invalid base64 characters in the input text.\n" +
"Valid base64 characters are A-Z, a-z, 0-9, �+�, �/�, and �=�\n" +
"Expect errors in decoding.");

}
inp = inp.replace(/[^A-Za-z0-9\+\/\=]/g, "");

do { //Here's the decode loop.

//Grab 4 bytes of encoded content.
enc1 = keyStr.indexOf(inp.charAt(i++));
enc2 = keyStr.indexOf(inp.charAt(i++));
enc3 = keyStr.indexOf(inp.charAt(i++));
enc4 = keyStr.indexOf(inp.charAt(i++));

//Heres the decode part. There's really only one way to do it.
chr1 = (enc1 << 2) | (enc2 >> 4);
chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
chr3 = ((enc3 & 3) << 6) | enc4;

//Start to output decoded content
out = out + String.fromCharCode(chr1);

if (enc3 != 64) {
out = out + String.fromCharCode(chr2);
}
if (enc4 != 64) {
out = out + String.fromCharCode(chr3);
}

//now clean out the variables used
chr1 = chr2 = chr3 = 0;
enc1 = enc2 = enc3 = enc4 = 0;

} while (i < inp.length); //finish off the loop

//Now return the decoded values.
return out;
}

function isBitSet(arr, val) {
  var bnum = val >> 8; 
  var bit = val & 0xff;
  return (arr[bnum] & bit);
}


function popOptions(selObj, numOpts, optvalStr, selected)
{
  var i;

  for (i = selObj.options.length; i >= 0; i--) 
    selObj.options[i] = null; 
  for (i = 0; i < numOpts; i++) {
    selObj.options[i] = new Option(optvalStr[i*2]);   
    selObj.options[i].value = optvalStr[i*2+1];
    if (selected == i)
      selObj.options[i].selected = true;
  }
}

function hexcode(x) {
  var result = "";
  result = result + "0123456789ABCDEF".charAt((x/16)&0x0f);
  result = result + "0123456789ABCDEF".charAt((x/1)&0x0f);
  return result;
}

function getNetMask(val) {
   var counter = 0;
   var sub = new Array(0,0,0,0);
   var i, bytenum;
   
   if (val == 0)	// default - auto mask handling.
     return sub;
   for (bytenum = 3; bytenum >= 0; bytenum--) {
     for (i = 0; i < 8; i++) {
	    if(val <= counter)
	       sub[bytenum] += (1 << i);
	    counter++;
     }
   }
   return sub;
}

// function to obtain the netmask integer from the ip address 
// formatted netmask string.
function StrToNetMask(nmaskStr) {
   var retval = 0;
   var i, j;
   var ipArray = nmaskStr.split(".");

   if ((nmaskStr == "") || (nmaskStr == "0.0.0.0"))
      return retval;
   for (i = 0; i < ipArray.length; i++) {
      if (ipArray[i] == 255){
         retval += 8;
         continue;
      }
      for (j = 0; j < 8; j++) {
         if (ipArray[i] & (0x80 >> j))
           retval += 1;  
         else
           break;
      }
   }
   return (32 - retval);
}

// takes the address string (already validated) and returns 
// the iparray
function StrToIPAddr(addrStr) {
   var i;
   var retArr = new Array(4);
   var ipArray = addrStr.split(".");

   for (i = 0; i < ipArray.length; i++){
       retArr[i] = parseInt(ipArray[i],10);
   }
   
   return retArr;
}

// takes an array and offset into the array from which the ip 
// addr is read and returns a string representation of the addr.
function IPAddrToStr(arr, off) {
   var result = "";
   var i;
   for (i = off; i < off + 4; i++) {
      result = result + arr[i];
      if (i < (off + 3))
        result = result + ".";
   }
   return result;
}

// takes a string and converts it into an array of byte values
// of the specified length filling up the remaining space with 0
function StrToArr(str, arrlen) {
   var result = new Array(arrlen);
   var i;
   if (str.length <= arrlen) { 
     for (i = 0; i < str.length; i++)
        result[i] = str.charCodeAt(i);
     for (i = str.length; i < arrlen; i++)
        result[i] = 0;
   }
   else
     for (i = 0; i < arrlen; i++)
        result[i] = str.charCodeAt(i);
   return result;
}

// takes an array and offset into the array from which a string of
// 'length' characters will be created and returned.
function ArrToStr(arr, off, length) {
  var i, retval = "";
  for (i = off; i < off + length; i++) {
	//to terminate strings
	if( arr[i] == 0)break;
    retval = retval + String.fromCharCode(arr[i]);
  } 
  return retval;
}

// takes a hex string and converts it into an array of byte values
// of the specified length filling up the remaining space with 0
function HexStrToArr(str, arrlen) {
   var result = new Array(arrlen);
   var i, j;
   for (i = 0, j = 0; i < str.length; i+= 2, j++)
       result[j] = (parseInt(str.substr(i, 2), 16));
   for (i = str.length; i < arrlen; i++)
       result[i] = 0;
   return result;
}

// takes an array and offset into the array from which a string of
// 'length' characters will be returned as a hex char string.
function ArrToHexStr(arr, off, length) {
  var i, retval = "";
  for (i = off; i < off + length; i++)
     retval = retval + hexcode(arr[i]);
  return retval;
}

// function that updates elements in one array from another array
// if howMany = 0, then no old elements are removed, only new 
// elements are added.
function UpdateArr(oldarr, off, howMany, newarr) {
   var i;
   var result = oldarr.splice(off, howMany);
   for (i = off; i < (off + newarr.length); i++)
      oldarr.splice(i, 0, newarr[i - off]);
   return result;
}
 
// function for handling the div based visibility of sections of html
function getStyleObject(objectId) {
  // checkW3C DOM, then MSIE 4, then NN 4.
  if(document.getElementById && document.getElementById(objectId)) {
	return document.getElementById(objectId).style;
  }
  else if (document.all && document.all(objectId)) {  
	return document.all(objectId).style;
  } 
  else if (document.layers && document.layers[objectId]) { 
	return document.layers[objectId];
  } else {
    return false;
  }
}

function changeObjectVisibility(objectId, newVisibility) {
    // first get the object's stylesheet
    var styleObject = getStyleObject(objectId);

    // then if we find a stylesheet, set its visibility
    // as requested
    if (styleObject) {
	  styleObject.visibility = newVisibility;
	  return true;
    } else {
	  return false;
    }
}

function clearDone()
{
  changeObjectVisibility("statmesg", "hidden");
}



function reportDone() {
  changeObjectVisibility("statmesg", "visible");
  window.setTimeout("clearDone()", 5000);       
}

function uclearDone()
{
  changeObjectVisibility("ustatmesg", "hidden");
}

function ureportDone() {
  changeObjectVisibility("ustatmesg", "visible");
  window.setTimeout("uclearDone()", 5000);       
}

-->
HTTP/1.0 200
Content-type: application/x-javascript

<!--
// Verifies a number is within a range
function verifyNumRange (numValue, lowNum, hiNum, theName, required)
{
    var errorString = "";

    // Some fields do not require that a value be entered
    if (numValue == "")
    {
      if (required)
      {

        alert(theName + ': required field.');

        return false;
      }
      else
        return true;
    }
    
    // looks for one or more numbers with any number of leading/trailing spaces
    if (/^ *[0-9]+ *$/.test(numValue))
    {
        if (numValue < lowNum || numValue > hiNum)
        {

            errorString = theName + ' must be in the range ' + lowNum + '-' + hiNum + '.';

            alert(errorString);
            return false;
        }
        else
            return true;
    }
    else
    {

        errorString = theName + ": contains invalid characters.\nValid characters are 0-9.";

        alert(errorString);
        return false;
    }
} // verifyNumRange

// Verifies a number range, allowing a non-contiguous 'special' value
function verifyNumRangeSpecial (numValue, lowNum, hiNum, specValue, theName, required)
{
    var errorString = "";

    // Some fields do not require that a value be entered
    if (numValue == "")
    {
      if (required)
      {
        alert(theName + ': required field.');
        return false;
      }
      else
        return true;
    }
    
    // looks for one or more numbers with any number of leading/trailing spaces
    if (/^ *[0-9]+ *$/.test(numValue))
    {
        if ((numValue < lowNum || numValue > hiNum) && (numValue != specValue))
        {
            errorString = theName + ' must be in the range ' + lowNum + '-' + hiNum + ' or ' + specValue + '.';
            alert(errorString);
            return false;
        }
        else
            return true;
    }
    else
    {
        errorString = theName + ": contains invalid characters.\nValid characters are 0-9.";
        alert(errorString);
        return false;
    }
} // verifyNumRange


// verifies an email address
function verifyEmail(email, theName, required)
{
    var errorString = "";
    var filter = /^([a-zA-Z0-9_.-])+@(([a-zA-Z0-9-])+.)+([a-zA-Z0-9]{2,4})+$/;

    if (email == "")
    {
        if (required)
        {

          alert (theName + ': required field.');

          return false;
        }
        else
          return true;
    }

    if (filter.test(email))
    {
        return true;
    }
    else
    {

        errorString = theName + ': invalid email address.'; 

        alert(errorString);
        return false;
    }
} // verifyEmail

// function to verify that the entered string is a valid key
// of hexadecimal characters and of a certain length.
function verifyKey(key, length, theName, required)
{
   var errorString = "";
   var str = (String(key));
   if ((key == "") && (required))
   {

      alert (theName + ': required field.');

      return false;
   }
   if (str.length != length)
    {

        errorString = theName + ': must be ' + length + ' characters.';

        alert (errorString);
        return false;
    }
    //if (/^[A-Fa-f0-9]+$/.test(key))
	if (/^[!-~\s]+$/.test(key))
    {
        return true;
    }
    else
    {

        errorString = theName + ': invalid key.\nValid characters are hexidecimal characters.';

        alert(errorString);
        return false;
    }
}

// function to verify that the entered string is a valid passphrase
// and if needed check that it is of a certain length.
function verifyPassphrase(key)
{
  var errorString = "";
  var str = (String(key));
  
  if (str.length < 8)
  {
     errorString = 'Minimum Passphrase Length is 8 characters. Recommended length for better security is 20 characters';
     alert(errorString);
     return false;
  }
  if (str.length > 63)
  {
     errorString = 'Maximum Passphrase Length is 63 characters.';
     alert(errorString);
     return false;
  }
  //if (str.length < 20)
  //{
  //   errorString = 'Recommended length for better security is 20 characters';
  //   alert(errorString);
  //}
  //if (/^[A-Za-z0-9\s]+$/.test(key))
  if (/^[!-~\s]+$/.test(key))
  {
     return true;
  }
  else
  {
     errorString = 'invalid key.\nValid characters are alphanumeric and spaces';
	 alert(errorString);
     return false;
  }
}
-->
HTTP/1.0 200
Content-type: application/x-javascript

<!--

// Verifies an IP address
function verifyIP (ipValue, theName, required, zeroOk) 
{
    var errorString = "";

    var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
    var ipArray = ipValue.match(ipPattern); 

    // Some fields do not require that an IP address be entered
    if (ipValue == "")
    {
        if (required)
        {

          alert(theName + ': required field.');

          return false;
        }
        else
          return true;
    }
    
    // Check for special cases
    if ((!zeroOk) && (ipValue == "0.0.0.0"))

        errorString = theName + ': '+ipValue+' is a special IP address and cannot be used.';

    else if (ipValue == "255.255.255.255")

        errorString = theName + ': '+ipValue+' is a special IP address and cannot be used.';

    else if (ipArray == null)
    {

        errorString = theName + ': '+ipValue+' is not a valid IP address.';

    }
    else 
    {
        for (i = 1; i <= 4; i++) 
        {
            thisSegment = ipArray[i];
            if (thisSegment > 255) 
            {

                errorString = theName + ': '+ipValue+' is not a valid IP address.';

                i = 4;
            }
        }
    }
    if (errorString == "")
    {
        return true;
    }
    else
    {
        alert (errorString);
        return false;
    }
}  // verifyIP


// Verifies a subnet mask
function verifyMask (ipValue, theName) {
    errorString = "";

    errString = theName + ': ' + ipValue + ' is not a valid network mask.';

    var maskEnd = 0;
    var val, calc;
    var ipPattern = /^(\d{1,3})\.(\d{1,3})\.(\d{1,3})\.(\d{1,3})$/;
    var ipArray = ipValue.match(ipPattern); 

    if (ipArray == null) {
      errorString = errString;
    }
    else 
    {
      for (i = 1; i <= 4; i++) {
        thisSegment = ipArray[i];
        if (thisSegment > 255) {
          errorString = errString;
          break;
        }
        if (maskEnd > 0) {
          if (thisSegment != 0) {
            errorString = errString;
            break;
          }
        } 
        if (thisSegment < 255) {	// mask ending in this byte
          val = 0;
          for (j = 0; j < 8; j++) {
            calc = (thisSegment & (0x80 >> j));
            if (calc) 
              val += calc;
            else
              break;
          }
          if (thisSegment != val) {	// error not contiguous bits.
            errorString = errString;
            break;
          }
          else
            maskEnd = i;            
        }
      }
    }
    if (errorString == "") {
      return true;
    }
    else {
      alert (errorString);
      return false;
    }
}  // verifyMask

-->
