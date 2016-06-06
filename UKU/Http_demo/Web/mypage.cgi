t <html><head><title>Short value</title>
t <script language=JavaScript type="text/javascript" src="xml_http.js"></script>
t <script language=JavaScript type="text/javascript">
# Define URL and refresh timeout
t var formUpdate = new periodicObj("mypage.cgx", 300);
t function periodicUpdate() {
t   updateMultiple(formUpdate);
t   periodicFormTime = setTimeout("periodicUpdate()", formUpdate.period);
t }
t </script></head>
# i pg_header.inc
t <body style="width: 833; height: 470">
t <h3 align="center"><br>Short value on the board</h3>
t <form action="buttons.cgi" method="post" id="form1" name="form1">
t <table border="0" width=99%><font size="3">
t <tr bgcolor=#aaccff>
t  <th width=40%>Item</th>
t  <th width=60%>Status</th>
t </tr>
t <tr>
t <td><img src="pabb.gif">Buttons [7..0]:</td>
t <td id = "value1"> Value33 </td>
t </tr>
t <tr>
t </tr>
t </font></table>
t <p align="center">
t  <input type="button" id="refreshBtn" value="Refresh" onclick="updateMultiple(formUpdate)">
t  Periodic:<input type="checkbox" id="refreshChkBox" onclick="periodicUpdate()">
t </p></form>
# i pg_footer.inc
t </body>
. End of script must be closed with period.