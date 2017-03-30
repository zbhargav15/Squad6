<%-- 
    
--%>


<%@page contentType="text/html" pageEncoding="UTF-8"
        %>


<!DOCTYPE html>


<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Home Page</title>
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
                            <h3>Welcome to Indian Railway!</h3>
                        </div>
                        <div class="panel-body">
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
