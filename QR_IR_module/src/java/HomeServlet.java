/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import javax.servlet.RequestDispatcher;

/**
 *
 * @author Hemal
 */
@WebServlet(urlPatterns = {"/HomeServlet"})
public class HomeServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=UTF-8");

        try {
            PrintWriter out = response.getWriter();
            //out.print("<h1>Success</h1>");

            // assuming "DataSource" is your DataSource name
//            String url = "jdbc:mysql://192.168.43.33/indianrail";
//            System.out.println("before ngrok");
//            //String url = "jdbc:mysql://192.168.43.122:3303/indianrail";
//            Class.forName("com.mysql.jdbc.Driver");
//            System.out.println("before ngrok class");
//
//            Connection con = DriverManager.getConnection(url, "thompson", "root");
            System.out.println("before DBconnect.getCon");
            Connection con = DBconnect.getCon();
            System.out.println("after DBconnect.getCon");

            String username = request.getParameter("username");
            String password = request.getParameter("password");

            System.out.println(username + " " + password);

            PreparedStatement ps = con.prepareStatement(
                    "select staff_id from staff where username=? and password=?");
            ps.setString(1, username);
            ps.setString(2, password);

            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                int staffID = rs.getInt("staff_id");
                out.println("Login Successful! " + staffID);

                HttpSession session = request.getSession();
                session.setAttribute("staffID", staffID);

                //request.setAttribute("staffID", staffID);
                //RequestDispatcher rd = request.getRequestDispatcher("/IndianRailway/home.jsp");
                //rd.forward(request, response);
                response.sendRedirect("/IndianRailway/home.jsp");
            } else {

//                String nextJSP = "/IndianRailway/login.jsp";
//                request.setAttribute("invalidate", "Invalid Credentials");
//                RequestDispatcher dispatcher = getServletContext().getRequestDispatcher(nextJSP);
//                dispatcher.forward(request, response);
                //request.setAttribute("invalidate", "Invalid Credentials");
                //response.setHeader("invalidate", "Invalid Credentials");
                response.sendRedirect("/IndianRailway/login.jsp?invalidate=Invalid Credentials");
                //out.println("invalid credentials!");
            }

            ps.close();
            rs.close();
            con.close();
        } catch (Exception e) {
            System.out.println("" + e.getMessage());
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
