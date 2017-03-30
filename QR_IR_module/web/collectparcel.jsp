<%-- 
    Document   : collectparcel
    Created on : Mar 15, 2017, 11:14:33 AM
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
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.1.1/jquery.min.js"></script>

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


        <title>collect parcel</title>

        <script>


            function validateNonEmpty(inputField, msgText)
            {
                //see if the input value contains any text
                if (inputField.value.length == 0)
                {
                    //data is invalid , so set appropriate msg
                    if (msgText != null)
                        inputField.style.background = '#FA9595';
                    msgText.innerHTML = "Please enter the value";
                    return false;
                } else
                {
                    //The data is ok.so clear the message
                    if (msgText != null) {
                        inputField.style.background = 'white';
                        msgText.innerHTML = " ";
                    }
                    return true;
                }
            }

            function ValidatePasswordLength(inputField, msgText)
            {
                if (validateNonEmpty(inputField, msgText)) {

                    if (inputField.value.length < 8)
                    {
                        inputField.style.background = '#FA9595';
                        //alert("Password with insufficient length!!!Please Enter passward with atleast 8 characters.");
                        msgText.innerHTML = "Please Enter passward of atleast 8 char  ";
                        return false;
                    }
                    return true;
                } else
                {
                    //data is invalid , so set appropriate msg
                    if (msgText != null)
                        inputField.style.background = '#FA9595';
                    msgText.innerHTML = "Please enter the value";
                    return false;
                }
            }

            function validateRegEx(regex, input, helpText, helpMessage) {
// See if the input data validates OK
                if (!regex.test(input)) {
                    // The data is invalid , so set the help message and return false
                    if (helpText != null)
                        helpText.style.background = 'yellow';
                    helpText.innerHTML = helpMessage;
                    return false;
                } else {
                    // The data is OK, so clear the help message and return true
                    if (helpText != null)
                        helpText.innerHTML = "";
                    return true;
                }
            }

            function validatePhone(inputField, helpText) {

                // First see if the input value contains data
                if (!validateNonEmpty(inputField, helpText))
                    return false;

                // Then see if the input value is a phone number
                return validateRegEx(/^\d{10}$/, inputField.value, helpText, "Please enter a phone number (for example , 123-456-7890).");
            }

            function validateEmail(inputField, helpText) {

                // Then see if the input value is an email address
                if (inputField.value.length != 0) {
                    return validateRegEx(/^[\w\.-_\+]+@[\w-]+(\.\w{2,3})+$/, inputField.value, helpText, "Please enter an email address (for example , abc@xyz.com).");
                } else {
                    return true;
                }

            }

            function saveNextForm() {
                var isValidDetails = false;
                isValidDetails = validateNonEmpty(document.getElementById("sname"), document.getElementById('sname_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("sphone"), document.getElementById('sphone_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validatePhone(document.getElementById("sphone"), document.getElementById('sphone_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("saddress"), document.getElementById('saddress_help'));
                if (!isValidDetails) {
                    return;
                }

                isValidDetails = validateNonEmpty(document.getElementById("pkg_weight"), document.getElementById('pkg_weight_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("pkg_type"), document.getElementById('pkg_type_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("rname"), document.getElementById('rname_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("rphone"), document.getElementById('rphone_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("raddress"), document.getElementById('raddress_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("sourcecode"), document.getElementById('sourcecode_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("destcode"), document.getElementById('destcode_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("scaletype"), document.getElementById('scaletype_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateNonEmpty(document.getElementById("no_of_pkg"), document.getElementById('no_of_pkg_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validatePhone(document.getElementById("sphone"), document.getElementById('sphone_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validatePhone(document.getElementById("rphone"), document.getElementById('rphone_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateEmail(document.getElementById("semail"), document.getElementById('semail_help'));
                if (!isValidDetails) {
                    return;
                }
                isValidDetails = validateEmail(document.getElementById("remail"), document.getElementById('remail_help'));
                if (!isValidDetails) {
                    return;
                }
                if (isValidDetails) {
                    document.getElementById("collectParcelForm").submit();
                }
            }


            $('#destcode').change(onChange);
            function onChange() {
                var selectedOption = $('#destcode option:selected');
                var date = selectedOption.data("date");
                console.log(date);
                System.out.println("Destination CODE: "+date)
            }


        </script>

        <style>
            .compulsary{
                color : red;
            }
        </style>

    </head>
    <body>


        <%
            session = request.getSession(false);
            if (session.getAttribute("staffID") == null) {
                response.sendRedirect("login.jsp");
            } else {
            }

        %>

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
                                    <legend>Sender Info</legend>
                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Name :</label>
                                        <input class="form-control" id="sname" type="text" name="sname" placeholder="sender name" >
                                        <span id="sname_help"></span>
                                    </div>


                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Phone :</label>
                                        <input class="form-control" id="sphone" type="text" name="sphone" placeholder="sender phone" >
                                        <span id="sphone_help">
                                    </div>

                                    <div class="form-group">
                                        <label>Email :</label>
                                        <input class="form-control" id="semail" type="email" name="semail" placeholder="sender email" >
                                        <span id="semail_help">
                                    </div>

                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Address :</label>
                                        <input class="form-control" id="saddress" type="text" name="saddress" placeholder="sender address" >
                                        <span id="saddress_help">
                                    </div></fieldset><br>
                                <fieldset>
                                    <legend>Receiver Info</legend>
                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Name :</label>
                                        <input class="form-control" id="rname" type="text" name="rname" placeholder="receiver name" >
                                        <span id="rname_help"></span>
                                    </div>


                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Phone :</label>
                                        <input class="form-control" id="rphone" type="text" name="rphone" placeholder="receiver phone" >
                                        <span id="rphone_help">
                                    </div>

                                    <div class="form-group">
                                        <label>Email :</label>
                                        <input class="form-control" id="remail" type="email" name="remail" placeholder="receiver email" >
                                        <span id="remail_help">
                                    </div>

                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Address :</label>
                                        <input class="form-control" id="raddress" type="text" name="raddress" placeholder="receiver address" >
                                        <span id="raddress_help">
                                    </div>
                                </fieldset><br>
                                <fieldset>
                                    <legend>Package Info</legend>
                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Package Weight :</label>
                                        <input class="form-control" id="pkg_weight" type="text" name="pkg_weight" placeholder="package weight" >
                                        <span id="pkg_weight_help"></span>
                                    </div>


                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Package Type :</label>
                                        <input class="form-control" id="pkg_type" type="text" name="pkg_type" placeholder="package type" >
                                        <span id="pkg_type_help">
                                    </div>

                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Source Station Code :</label>
                                        <!--
                                        <input class="form-control" id="sourcecode" type="text" name="sourcecode" placeholder="source station code" >
                                        -->
                                        <select class="form-control" id="sourcecode" type="text" name="sourcecode" placeholder="source station code" >
                                            <option></option>
                                            <%  while (rs.next()) {%> 
                                            <option><%= rs.getString(1)%>(<%= rs.getString(2)%>)</option>
                                            <% } %>
                                        </select>

                                        <span id="sourcecode_help">
                                    </div>

                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Destination Station Code :</label>

                                        <select class="form-control" id="destcode" type="text" name="destcode" placeholder="destination station code">
                                            <option></option>
                                            <%  rs.beforeFirst();

                                                while (rs.next()) {
                                                    //String dest_current = rs.getString(1) + "(" + rs.getString(2) + ")";
                                                    //String source_current = request.getParameter("sourcecode");

                                                    //if (!dest_current.equals(source_current)) {
%>
                                            <option data-date="Feb 10, 1999"> <%= rs.getString(1)%>(<%= rs.getString(2)%>)</option>
                                            <%  //}
                                                } %>
                                        </select>

                                        <span id="destcode_help">
                                    </div>

                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Scale Transport Type :</label>
                                        <!--
                                        <input class="form-control" id="scaletype" type="text" name="scaletype" placeholder="scale transort type" >
                                        -->
                                        <select class="form-control" id="scaletype" type="text" name="scaletype" placeholder="scale transort type">
                                            <option></option>
                                            <option>L (Luggage Parcel Service - for luggage booking in all trains)</option>
                                            <option>R (Rajdhani Parcel Service)</option>
                                            <option>P (Premier Parcel Service)</option>
                                            <option>S (Standard Parcel Service)</option>
                                        </select>

                                        <span id="scaletype_help">
                                    </div>

                                    <div class="form-group">
                                        <span class="compulsary">* </span><label>Number of Packages :</label>
                                        <input class="form-control" id="no_of_pkg" type="number" name="no_of_pkg" placeholder="number of packages" >
                                        <span id="no_of_pkg_help">
                                    </div>
                                </fieldset>
                                <div>
                                    <input class="btn btn-primary" type="button" value="Save & Next" onclick="saveNextForm()">

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

        <!--
    <form id="collectParcelForm" action='CollectParcelServlet' method="post">
        Enter sender name :<span class="compulsary">* </span><input id="sname" type="text" name="sname"><span id="sname_help"></span><br>
        Enter sender phone :<span class="compulsary">* </span><input id="sphone" type="text" name="sphone"><span id="sphone_help"></span><br>
        Enter sender email :<input id="semail" type="email" name="semail"><span id="semail_help"></span><br>
        Enter sender address :<span class="compulsary">* </span><input id="saddress" type="text" name="saddress"><span id="saddress_help"></span><br><br>

        Enter package weight :<span class="compulsary">* </span><input id="pkg_weight" type="text" name="pkg_weight"><span id="pkg_weight_help"></span><br>
        Enter package type :<span class="compulsary">* </span><input id="pkg_type" type="text" name="pkg_type"><span id="pkg_type_help"></span><br><br>

        Enter receiver name :<span class="compulsary">* </span><input id="rname" type="text" name="rname"><span id="rname_help"></span> <br>
        Enter receiver phone :<span class="compulsary">* </span><input id="rphone" type="text" name="rphone"><span id="rphone_help"></span><br>
        Enter receiver email :<input id="remail" type="email" name="remail"><span id="remail_help"></span><br>
        Enter receiver address :<span class="compulsary">* </span><input id="raddress" type="text" name="raddress"><span id="raddress_help"></span><br><br>

        Enter source station code :<span class="compulsary">* </span><input id="sourcecode" type="text" name="sourcecode"><span id="sourcecode_help"></span><br>
        Enter destination station code :<span class="compulsary">* </span><input id="destcode" type="text" name="destcode"><span id="destcode_help"></span><br>
        Enter scale transport type :<span class="compulsary">* </span><input id="scaletype" type="text" name="scaletype"><span id="scaletype_help"></span><br>
        Enter no. of package:<span class="compulsary">* </span><input id="no_of_pkg" type="number" name="no_of_pkg"><span id="no_of_pkg_help"></span><br><br><br>

        <input type="button" value="Save & Next" onclick="saveNextForm()">
    </form>
        -->
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="https://code.jquery.com/jquery.js"></script>
        <!-- jQuery UI -->
        <script src="https://code.jquery.com/ui/1.10.3/jquery-ui.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="/IndianRailway/bootstrap.min.js"></script>
        <!-- 
        <script src="vendors/form-helpers/js/bootstrap-formhelpers.min.js"></script>
        -->
        <script src="/IndianRailway/bootstrap-select.min.js"></script>

        <script src="/IndianRailway/bootstrap-tags.min.js"></script>

        <script src="/IndianRailway/jquery.maskedinput.min.js"></script>

        <script src="/IndianRailway/moment.min.js"></script>

        <script src="/IndianRailway/jquery.bootstrap.wizard.min.js"></script>

        <!-- bootstrap-datetimepicker -->



        <link href="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/css/bootstrap-editable.css" rel="stylesheet"/>
        <script src="//cdnjs.cloudflare.com/ajax/libs/x-editable/1.5.0/bootstrap3-editable/js/bootstrap-editable.min.js"></script>

        <script src="/IndianRailway/custom.js"></script>
        <!--        <script src="/IndianRailway/forms.js"></script>-->

    </body>
</html>
