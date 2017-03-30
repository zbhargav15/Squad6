
import java.io.IOException;
import java.io.PrintWriter;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import com.google.zxing.BarcodeFormat;
import com.google.zxing.EncodeHintType;
import com.google.zxing.WriterException;
import com.google.zxing.common.BitMatrix;
import com.google.zxing.qrcode.QRCodeWriter;
import com.google.zxing.qrcode.decoder.ErrorCorrectionLevel;
import java.io.OutputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.EnumMap;
import java.util.Map;
import javax.imageio.ImageIO;
import javax.servlet.RequestDispatcher;
import javax.servlet.http.HttpSession;

@WebServlet(urlPatterns = {"/QRcodeServlet"})
public class QRcodeServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = null;
        session = request.getSession(false);
        //out.println(session.getAttribute("staffID"));
        if (session == null || session.getAttribute("staffID") == null) {
            response.sendRedirect("/IndianRailway/login.jsp");
        }

        try {
            String myCodeText = request.getParameter("id");
            //PrintWriter pw = response.getWriter();

//            String url = "jdbc:mysql://192.168.43.33/indianrail";
//            Class.forName("com.mysql.jdbc.Driver");
//            Connection con = DriverManager.getConnection(url, "thompson", "root");

            Connection con = DBconnect.getCon();

            //String query = "SELECT src_station_code, dest_station_code, scale_transport_type FROM package_details where pkg_id='"+myCodeText+"'";
            PreparedStatement ps = con.prepareStatement(
                    "SELECT src_station_code, dest_station_code, scale_transport_type, sender_cid, receiver_cid FROM package_details where pkg_id=?");
            ps.setString(1, myCodeText);

            System.out.println("before executeQuery");
            ResultSet rs = ps.executeQuery();
            System.out.println("after executeQuery");

            String src_station_code = null, dest_station_code = null, scale_transport_type = null;
            int sender_cid = 0, receiver_cid = 0;
            if (rs.next()) {
                src_station_code = rs.getString(1);
                dest_station_code = rs.getString(2);
                scale_transport_type = rs.getString(3);
                sender_cid = rs.getInt("sender_cid");
                receiver_cid = rs.getInt("receiver_cid");
                System.out.println("src_station_code: " + src_station_code);
            }

            Statement stmt = con.createStatement();
            String query = "select * from contacts where cid=" + sender_cid;
            System.out.println(query);
            rs = stmt.executeQuery(query);
            String sname = null, rname = null;
            while (rs.next()) {
                sname = rs.getString("cname");
            }
            query = "select * from contacts where cid=" + receiver_cid;
            System.out.println(query);
            rs = stmt.executeQuery(query);
            while (rs.next()) {
                rname = rs.getString("cname");
            }

            con.close();
            ps.close();
            rs.close();
            System.out.println("ITS: "+scale_transport_type);
            myCodeText = myCodeText + "," + src_station_code + "," + dest_station_code + "," + scale_transport_type + "," + sname + "," + rname;
            System.out.println("packageId: " + myCodeText);
            String filePath = "/IndianRailway/"; // stored as variable_name.png
            int size = 250;
            String fileType = "png";
            //File myFile = new File(filePath);
            // try {

            Map<EncodeHintType, Object> hintMap = new EnumMap<EncodeHintType, Object>(EncodeHintType.class);
            hintMap.put(EncodeHintType.CHARACTER_SET, "UTF-8");
            hintMap.put(EncodeHintType.MARGIN, 1);
            hintMap.put(EncodeHintType.ERROR_CORRECTION, ErrorCorrectionLevel.L);

            QRCodeWriter qrCodeWriter = new QRCodeWriter();
            BitMatrix byteMatrix = qrCodeWriter.encode(myCodeText, BarcodeFormat.QR_CODE, size,
                    size, hintMap);
            int Width = byteMatrix.getWidth();
            BufferedImage image = new BufferedImage(Width, Width,
                    BufferedImage.TYPE_INT_RGB);
            image.createGraphics();

            Graphics2D graphics = (Graphics2D) image.getGraphics();
            graphics.setColor(Color.WHITE);
            graphics.fillRect(0, 0, Width, Width);
            graphics.setColor(Color.BLACK);

            for (int i = 0; i < Width; i++) {
                for (int j = 0; j < Width; j++) {
                    if (byteMatrix.get(i, j)) {
                        graphics.fillRect(i, j, 1, 1);
                    }
                }
            }
            //ImageIO.write(image, fileType, myFile);

            response.setContentType("image/png");
            OutputStream out = response.getOutputStream();
            ImageIO.write(image, "png", out);
            out.close();

            //response.sendRedirect("/IndianRailway/qrdisplay.jsp");
            //} catch (WriterException e) {
            //  e.printStackTrace();
            //} catch (IOException e) {
            //  e.printStackTrace();
            //}
            System.out.println("\n\nYou have successfully created QR Code.");

        } catch (Exception e) {
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

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
