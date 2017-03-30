<%-- 
    Document   : login.jsp
    Created on : Mar 15, 2017, 4:47:39 PM
    Author     : Hemal
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Bootstrap -->
        <link href="/IndianRailway/bootstrap.min.css" rel="stylesheet">
        <!-- styles -->
        <link href="/IndianRailway/styles.css" rel="stylesheet">

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
                        msgText.innerHTML = "Please Enter passward of atleast 8 char";
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

            function loginSubmitForm() {
                var inputField_username = document.getElementById("username");
                var inputField_password = document.getElementById("password");
                var isUserNameValid = validateNonEmpty(inputField_username, document.getElementById('username_help'));
                var isPasswordValid = ValidatePasswordLength(inputField_password, document.getElementById('password_help'));

                if (isUserNameValid && isPasswordValid) {
                    document.getElementById("loginForm").submit();
                }
            }


            setTimeout(function () {
                document.getElementById("submit_help").style.visibility = "hidden";
            }, 3000);





        </script>



    </head>
    <body class="login-bg">
        <div class="header">
            <div class="container">
                <div class="row">
                    <div class="col-md-12">
                        <!-- Logo -->
                        <div class="logo">
                            <h1 style="color:white">Indian Railways</h1>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="page-content container">
            <div class="row">
                <div class="col-md-4 col-md-offset-4">
                    <div class="login-wrapper">
                        <div class="box">
                            <div class="content-wrap">
                                <h6>LogIn</h6>
                                <!-- <form action="HomeServlet" method="post"> -->
                                <form id="loginForm" action="HomeServlet" method="post">
                                    <input class="form-control" id="username" type="text" name="username" value="shraddha" placeholder="Username">
                                    <span id="username_help"></span>
                                    <input  class="form-control" id="password" type="password" name="password" value="shraddha123" placeholder="Password">
                                    <span id ="password_help"></span>
                                    <div class="action">
                                        <input class="btn btn-primary signup" type="button" value="Login" onclick="loginSubmitForm()">
                                    </div><br><br>
                                    <span id ="submit_help">  <%=  request.getParameter("invalidate") != null ? request.getParameter("invalidate") : ""%> </span>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>



        <script src="https://code.jquery.com/jquery.js"></script>
        <!-- Include all compiled plugins (below), or include individual files as needed -->
        <script src="/IndianRailway/bootstrap.min.js"></script>
        <script src="/IndianRailway/custom.js"></script>




    </body>
</html>
