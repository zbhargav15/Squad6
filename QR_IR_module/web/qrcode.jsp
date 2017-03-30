<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title> QRcode </title>

        <link href="https://code.jquery.com/ui/1.10.3/themes/redmond/jquery-ui.css" rel="stylesheet" media="screen">

        <!-- Bootstrap -->
        <link href="/IndianRailway/bootstrap.min.css" rel="stylesheet">
        <!-- styles -->
        <link href="/IndianRailway/styles.css" rel="stylesheet">
        <link href="/IndianRailway/forms.css" rel="stylesheet">
<!--        <script src="/IndianRailway/forms.js"></script>-->


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
                <div class="col-md-10">
                    <div class="content-box-large">
                        <div class="panel-heading">
                            <h3>For Package ID : ${param.message} </h3> <br><br>
                        </div>
                        <div class="panel-body">
                            <form action="/IndianRailway/qrdisplay.jsp" method="post">
                                <div>
                                    <input class="btn btn-primary" type="submit" value="Generate Bill" style="align-content: center; ">
                                </div>
                                <input type="hidden" name="packageId" value="${param.message}"/>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>







<!--        <a href="http://localhost:8080/IndianRailway/qrdisplay.jsp?pkg_id=${param.message}">
           <input type="button" value="generate qrcode" name="generate_qr" />
        </a>-->



    </body>
</html>
