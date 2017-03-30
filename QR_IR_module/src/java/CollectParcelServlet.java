
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.Date;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/CollectParcelServlet"})
public class CollectParcelServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        PrintWriter out = response.getWriter();
        System.out.println("before HttpSession");
        //check session
        HttpSession session = null;
        session = request.getSession(false);
        System.out.println(session.getAttribute("staffID"));
        if (session == null || session.getAttribute("staffID") == null) {
            response.sendRedirect("/IndianRailway/login.jsp");
        }

        System.out.println("after HttpSession");

        try {
//            //db connection + get value from collectparcel.jsp form
//            System.out.println("before forName");
//            String url = "jdbc:mysql://192.168.43.33/indianrail";
//            //String url = "jdbc:mysql://192.168.43.122:3303/indianrail";
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection(url, "thompson", "root");
//            System.out.println("after forName");

            Connection con = DBconnect.getCon();

            String sname = request.getParameter("sname");
            long sphone = Long.parseLong(request.getParameter("sphone"));
            String semail = request.getParameter("semail");
            String saddress = request.getParameter("saddress");

            String rname = request.getParameter("rname");
            long rphone = Long.parseLong(request.getParameter("rphone"));
            String remail = request.getParameter("remail");
            String raddress = request.getParameter("raddress");

            String pkg_weight = request.getParameter("pkg_weight");
            String pkg_type = request.getParameter("pkg_type");
            String sourcecode = request.getParameter("sourcecode");
            sourcecode = sourcecode.split("\\(")[0];
            System.out.println(sourcecode);

            String destcode = request.getParameter("destcode");
            destcode = destcode.split("\\(")[0];
            System.out.println(destcode);

            String scaletype = request.getParameter("scaletype");
            scaletype = scaletype.split("\\(")[0];
            System.out.println(scaletype);
            
            
            int no_of_pkg = Integer.parseInt(request.getParameter("no_of_pkg"));

            int fixed_cost_price = 50;
            int sid = 0, rid = 0;//fixed prize of one package
            Statement stmt = null;

            out.println("On CollectParcelServlet before query");

            //for sender
            String squery = "insert into contacts (cname, address, phone, email) values('" + sname + "','" + saddress + "'," + sphone + ",'" + semail + "')";
            stmt = con.createStatement();
            stmt.executeUpdate(squery);
            ResultSet rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                sid = rs.getInt(1);
            }
            out.println(sid);

            //for receiver
            String rquery = "insert into contacts (cname, address, phone, email) values('" + rname + "','" + raddress + "'," + rphone + ",'" + remail + "')";
            stmt = con.createStatement();
            stmt.executeUpdate(rquery);
            rs = stmt.getGeneratedKeys();
            if (rs.next()) {
                rid = rs.getInt(1);
            }
            out.println(rid);

            out.println("On it :(");

            Timestamp creation_date = new Timestamp(System.currentTimeMillis());
            //out.println("\n" + creation_date.toString());
            int staffID = (int) session.getAttribute("staffID");
            //out.println("\n" + staffID);
            DateFormat dateFormat = new SimpleDateFormat("yyyyMMddHHmmss");
            Calendar cal = Calendar.getInstance();
            //out.println("\n" + dateFormat.format(cal.getTime()));
            String pkg_id = sourcecode + dateFormat.format(cal.getTime()) + staffID;
            //out.println(pkg_id);
            int total_cost = no_of_pkg * fixed_cost_price;

            //store data in package_details table.
            out.println("\n" + "before insert_pkg_query");
            String insert_pkg_query = "insert into package_details"
                    + " (pkg_id, sender_cid, receiver_cid, src_station_code, dest_station_code, creation_date, createdby_staffid, payment_amount, pkg_weight_grams, pkg_type, scale_transport_type) "
                    + "values('" + pkg_id + "'," + sid + "," + rid + ",'" + sourcecode + "','" + destcode + "','" + creation_date.toString() + "'," + staffID + "," + total_cost + "," + pkg_weight + ",'" + pkg_type + "','" + scaletype + "')";

            System.out.println("\n" + insert_pkg_query);
            stmt = con.createStatement();
            //out.println("\n" + "before executeUpdate");
            stmt.executeUpdate(insert_pkg_query);
            //out.println("\n" + "after executeUpdate");

            //add values package_train_mapping table with status 'P'
            String pkg_map_query = "insert into package_train_mapping (pkg_id,load_unload_status, load_time, unload_time) values('" + pkg_id + "','P',null,null)";
            System.out.println("\n" + pkg_map_query);
            stmt = con.createStatement();
            out.println("\n" + "before pkg_map_query");
            stmt.executeUpdate(pkg_map_query);
            out.println("\n" + "after pkg_map_query");

            //goes to qr generation part
            response.sendRedirect("qrcode.jsp?message=" + URLEncoder.encode(pkg_id, "UTF-8"));

            stmt.close();
            con.close();

        } catch (Exception e) {
            System.out.println(""+e.getMessage());
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
