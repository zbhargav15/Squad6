<%-- 
    Document   : showtrainlist
    Created on : Mar 19, 2017, 3:31:57 PM
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
        <title>JSP Page</title>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- jQuery UI -->
        <link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet" media="screen">

        <!-- Bootstrap -->
        <link href="/IndianRailway/bootstrap.min.css" rel="stylesheet">
        <!-- styles -->
        <link href="/IndianRailway/styles.css" rel="stylesheet">
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
                <div class="col-md-10">
                    <div class="content-box-large">
                        <div class="panel-heading">
                            <h4>Train List</h4><br>
                        </div>
                        <div class="panel-body container-fluid">
                            <div class="table-responsive">
                                <table style='font-size: 12px;' cellpadding='0' cellspacing='0' border='0' class='table table-striped table-bordered'>
                                <thead>
                                    <tr>
                                        <th>Tain number</th>
                                        <th>Source station code</th>
                                        <th>Destination station code</th>
                                        <th>Departure time</th>
                                        <th>arrival time</th>
                                        <th>Days</th>
                                    </tr>
                                </thead>
                                <%
                                    try {
                                        String url = "jdbc:mysql://192.168.43.33/indianrail";
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection(url, "thompson", "root");
                                        String query = "select * from trains";
                                        Statement stmt = con.createStatement();
                                        ResultSet rs = stmt.executeQuery(query);
                                        while (rs.next()) {

                                %>
                                <tbody>
                                    <TR>
                                        <TD><%=rs.getString("train_no")%></TD>
                                        <TD><%=rs.getString("src_station_code")%></TD>
                                        <TD><%=rs.getString("dest_station_code")%></TD>
                                        <TD><%=rs.getString("depart_time")%></TD>
                                        <TD><%=rs.getString("arrival_time")%></TD>
                                        <TD><%=rs.getString("days")%></TD>
                                    </TR>
                                    <%

                                        }
                                    %>
                                </tbody>
                            </table>
                            </div>
                            <%
                                    rs.close();
                                    stmt.close();
                                    con.close();
                                } catch (Exception e) {
                                    e.printStackTrace();
                                }


                            %>
                        </div>
                    </div>
                </div>
            </div>
        </div>






    </body>
</html>
