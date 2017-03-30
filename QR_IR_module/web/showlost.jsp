<%-- 
    Document   : showlost
    Created on : Mar 19, 2017, 3:15:16 PM
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
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- jQuery UI -->
        <link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet" media="screen">

        <!-- Bootstrap -->
        <link href="/IndianRailway/bootstrap.min.css" rel="stylesheet">
        <!-- styles -->
        <link href="/IndianRailway/styles.css" rel="stylesheet">

        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Lost Packages</title>
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
                <div class="col-md-8">
                    <div class="content-box-large">
                        <div class="panel-heading">
                            <h4>Lost Package List</h4><br> 
                        </div>
                        <div class="panel-body container-fluid">
                            <div class="table-responsive">
                                <table style='font-size: 12px;' cellpadding='0' cellspacing='0' border='0' class='table table-striped table-bordered'>
                                <thead>
                                    <tr>
                                        <th>Package ID</th>
                                        <th>Lost station</th>
                                        <th>Source station</th>
                                        <th>Destination station</th>
                                        <th>Scale transport type</th>
                                    </tr>
                                </thead>
                                <%                try {
                                        String url = "jdbc:mysql://192.168.43.33/indianrail";
                                        Class.forName("com.mysql.jdbc.Driver");
                                        Connection con = DriverManager.getConnection(url, "thompson", "root");
                                        //Connection con = DBconnect.getCon();
                                        String query = "select * from lost_package";
                                        Statement stmt = con.createStatement();
                                        ResultSet rs = stmt.executeQuery(query);
                                        while (rs.next()) {

                                %>
                                <tbody>
                                    <TR>
                                        <TD><%=rs.getString("pkg_id")%></TD>
                                        <TD><%=rs.getString("lost_station")%></TD>
                                        <TD><%=rs.getString("source_station")%></TD>
                                        <TD><%=rs.getString("dest_station")%></TD>
                                        <TD><%=rs.getString("scale_transport_type")%></TD>
                                    </TR>
                                </tbody>
                                <%

                                    }
                                %>
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
