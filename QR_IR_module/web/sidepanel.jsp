<%-- 
    Document   : sidepanel
    Created on : Mar 15, 2017, 11:20:58 AM
    Author     : Hemal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet" media="screen">
        <!-- Bootstrap -->
        <link href="/IndianRailway/bootstrap.min.css" rel="stylesheet">
        <!-- styles -->
        <link href="/IndianRailway/styles.css" rel="stylesheet">

        <link href="//netdna.bootstrapcdn.com/font-awesome/4.0.3/css/font-awesome.css" rel="stylesheet">
        <link href="/IndianRailway/bootstrap-formhelpers.min.css" rel="stylesheet">
        <link href="/IndianRailway/bootstrap-select.min.css" rel="stylesheet">
        <link href="/IndianRailway/bootstrap-tags.css" rel="stylesheet">

        <link href="/IndianRailway/forms.css" rel="stylesheet">

        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery.js"></script>
        <!-- jQuery UI -->
        <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="/IndianRailway/bootstrap.min.js"></script>
        <script src="/IndianRailway/bootstrap-formhelpers.js"></script>
        <script src="/IndianRailway/bootstrap-select.min.js"></script>
        <script src="/IndianRailway/bootstrap-tags.min.js"></script>
        <script src="/IndianRailway/jquery.maskedinput.min.js"></script>
        <script src="/IndianRailway/moment.min.js"></script>
        <script src="/IndianRailway/jquery.bootstrap.wizard.min.js"></script>

        <!-- bootstrap-datetimepicker -->

        <link href="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet"/>
        <script src="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/js/bootstrap-editable.min.js"></script>

        <script src="/IndianRailway/custom.js"></script>
        <script src="/IndianRailway/forms.js"></script>
<style>
   
</style>

        <title>JSP Page</title>
    </head>
    <body>

        <div class="col-md-2" >
            <div class="sidebar content-box" style="display: block;" >
                <ul class="test nav" >
                    <!-- Main menu -->
                    <li><a href="home.jsp"><i class="glyphicon glyphicon-home"></i> Home</a></li>
                    <li><a href="collectparcel.jsp"><i class="glyphicon glyphicon-inbox"></i>Prepare Parcel</a></li>
                    <li><a href="showtrainlist.jsp"><i class="glyphicon glyphicon-list"></i>Show Train List</a></li>
                    <li><a href="showlost.jsp"><i class="glyphicon glyphicon-list"></i>Show Lost Packages</a></li>
                    <li><a href="viastation_QR.jsp"><i class="glyphicon glyphicon-list"></i>Generate QR for Via Station</a></li>
                    <li><a href="LogoutServlet"><i class="glyphicon glyphicon-log-out"></i> Log out</a></li>
                </ul>
            </div>

        </div>


        <!--
                <div id="sidepanel">
                    <a href="collectparcel.jsp">Collect Parcel</a>
                    <a href="showtrainlist.jsp">Show Train List</a>
                    <a href="showlost.jsp">Show Lost Packages</a>
                    <a href="LogoutServlet">Logout</a>
                </div>
        
        -->
        <script src="https://code.jquery.com/jquery.js"></script>

    </body>
</html>
