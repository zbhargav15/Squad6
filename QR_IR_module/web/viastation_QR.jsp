<%-- 
    Document   : viastation_QR
    Created on : Mar 29, 2017, 11:00:47 AM
    Author     : Hemal
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- jQuery UI -->
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


        <title>JSP Page</title>
    </head>
    <body>
        <div class="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-5">
                        <!-- Logo -->
                        <div class="logo">
                            <h1><a href="home.jsp">Indian Railways</a></h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>





        <div class="page-content">
            <div class="row">
                <jsp:include page="sidepanel.jsp" />
                <%                    try {
                        //db connection + get value from collectparcel.jsp form
                        System.out.println("before forName");
                        String url = "jdbc:mysql://192.168.43.33/indianrail";
                        Class.forName("com.mysql.jdbc.Driver");
                        Connection con = DriverManager.getConnection(url, "thompson", "root");

                        String query = "select * from stations";
                        Statement stmt = con.createStatement();
                        ResultSet rs = stmt.executeQuery(query);
                %>


                <div class="col-md-10">
                    <div class="content-box-large">
                        <div class="panel-heading">
                            <div class="panel-title">PARCEL FORM</div>
                        </div>
                        <div class="panel-body">
                            <form id="collectParcelForm" action='CollectParcelServlet' method="post">
                                <fieldset>
                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Package ID :</label>
                                        <input class="form-control" id="sname" type="text" name="sname" placeholder="sender name" >
                                        <span id="sname_help"></span>
                                    </div>
                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Source Station:</label>
                                        <input class="form-control" id="src_code" type="text" name="src_code" placeholder="source code" >
                                        <span id="sphone_help">
                                    </div>

                                    <div class="form-group">
                                        <label>Destination Code:</label>
                                        <input class="form-control" id="dstn_code" type="email" name="dstn_code" placeholder="destination code" >
                                        <span id="semail_help">
                                    </div>

                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Package scale transport type:</label>
                                        <input class="form-control" id="scale" type="text" name="scale" placeholder="scale" >
                                        <span id="saddress_help">
                                    </div>
                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Sender's name:</label>
                                        <input class="form-control" id="sname" type="text" name="sname" placeholder="sender's name" >
                                        <span id="saddress_help">
                                    </div>
                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Receiver's name:</label>
                                        <input class="form-control" id="rname" type="text" name="rname" placeholder="receiver's name" >
                                        <span id="saddress_help">
                                    </div>
                                </fieldset>
                                <div>
                                    <input class="btn btn-primary" type="button" value="Generate QR" onclick="saveNextForm()">
                                </div>
                            </form>
                        </div>
                    </div>
                </div>
            </div>               
        </div>

        <%
            } catch (Exception e) {
            }
        %>     









    </body>
</html>
