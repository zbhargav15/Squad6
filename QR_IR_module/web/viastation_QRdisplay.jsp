<%-- 
    Document   : testbill.jsp
    Created on : Mar 28, 2017, 9:04:11 PM
    Author     : Hemal
--%>

<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="com.sun.xml.rpc.processor.modeler.j2ee.xml.string"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<!doctype html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet" media="screen">

        <!-- Bootstrap -->
        <link href="/IndianRailway/bootstrap.min.css" rel="stylesheet">
        <!-- styles -->
        <link href="/IndianRailway/styles.css" rel="stylesheet">
        <link href="/IndianRailway/forms.css" rel="stylesheet">
        <!--        <script src="/IndianRailway/forms.js"></script>
        -->
        <title>Parcel Bill</title>

        <script>
            //function myFunction() {
            //  window.print();
            //}

            function printDiv(divName) {
                var printContents = document.getElementById(divName).innerHTML;
                var originalContents = document.body.innerHTML;

                document.body.innerHTML = printContents;

                window.print();
                document.body.innerHTML = originalContents;
            }
        </script>


        <style>
            .invoice-box{
                max-width:800px;
                margin:auto;
                padding:30px;
                border:1px solid #eee;
                box-shadow:0 0 10px rgba(0, 0, 0, .15);
                font-size:16px;
                line-height:24px;
                font-family:'Helvetica Neue', 'Helvetica', Helvetica, Arial, sans-serif;
                color:#555;
            }

            .invoice-box table{
                width:100%;
                line-height:inherit;
                text-align:left;
            }

            .invoice-box table td{
                padding:5px;
                vertical-align:top;
            }

            .invoice-box table tr td:nth-child(2){
                text-align:right;
            }

            .invoice-box table tr.top table td{
                padding-bottom:20px;
            }

            .invoice-box table tr.top table td.title{
                font-size:45px;
                line-height:45px;
                color:#333;
            }

            .invoice-box table tr.information table td{
                padding-bottom:40px;
            }

            .invoice-box table tr.heading td{
                background:#eee;
                border-bottom:1px solid #ddd;
                font-weight:bold;
            }

            .invoice-box table tr.details td{
                padding-bottom:20px;
            }

            .invoice-box table tr.item td{
                border-bottom:1px solid #eee;
            }

            .invoice-box table tr.item.last td{
                border-bottom:none;
            }

            .invoice-box table tr.total td:nth-child(2){
                border-top:2px solid #eee;
                font-weight:bold;
            }

            @media only screen and (max-width: 600px) {
                .invoice-box table tr.top table td{
                    width:100%;
                    display:block;
                    text-align:center;
                }

                .invoice-box table tr.information table td{
                    width:100%;
                    display:block;
                    text-align:center;
                }
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
                <div class="col-md-6">
                    <div class="content-box-large">
                        <div class="panel-heading">

                        </div>
                        <div class="panel-body">
                            <div id="printableArea">
                                <div class="invoice-box">
                                    <table cellpadding="0" cellspacing="0">
                                        <tr class="top">
                                            <td colspan="2">
                                                <table>
                                                    <tr>
                                                        

                                                        <%
                                                            try {
                                                                String url = "jdbc:mysql://192.168.43.33/indianrail";
                                                                Class.forName("com.mysql.jdbc.Driver");
                                                                Connection con = DriverManager.getConnection(url, "thompson", "root");
                                                                //Connection con = DBconnect.getCon();

                                                                Statement stmt = con.createStatement();

                                                                String 
                                                               
                                                             
                                                        %>

                                                        <td class="title">
                                                            <image  src="/IndianRailway/QRcodeServlet?id=<%=request.getParameter("packageId")%>" width="200" height="200"></image>
                                                        </td>

                                                        <td>
                                                            
                                                        </td>
                                                    </tr>
                                                </table>
                                            </td>
                                        </tr>



                                    </table>
                                    <%

                                            con.close();
                                            rs.close();
                                            stmt.close();

                                        } catch (Exception e) {
                                        }
                                    %>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="col-md-4">
                    <div class="content-box-large">
                        <div class="panel-heading">
                            <input class="btn btn-primary" type="button" onclick="printDiv('printableArea')" value="PRINT BILL" width="150px" height="50px" />
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
