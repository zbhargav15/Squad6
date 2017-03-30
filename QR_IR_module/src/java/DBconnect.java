
import java.io.PrintWriter;
import java.sql.Connection;
import java.sql.DriverManager;


public class DBconnect {
    static Connection con =null;

    static Connection getCon() {
        try {
            //out.print("<h1>Success</h1>");

            // assuming "DataSource" is your DataSource name
            String url = "jdbc:mysql://192.168.43.33/indianrail";
            System.out.println("before con");
            //String url = "jdbc:mysql://192.168.43.122:3303/indianrail";
            Class.forName("com.mysql.jdbc.Driver");
            System.out.println("before con class");
            con = DriverManager.getConnection(url, "thompson", "root");
            System.out.println("after con");
        } catch(Exception e){
        
        }
        return con;

    }

}
