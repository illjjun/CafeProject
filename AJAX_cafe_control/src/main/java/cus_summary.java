

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class cus_summary
 */
@WebServlet("/cus_summary")
public class cus_summary extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public cus_summary() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
	      response.setContentType("text/html; charset=utf-8");
	      Connection conn=null;
	      Statement stmt=null;
	      ResultSet rs=null;
	      
	      String strReturn="";
	      String url="jdbc:oracle:thin:@localhost:1521:orcl";   /* 다른사람 db접속하려면 @뒤에 IP주소 넣으면 됨 */
	      String userid="ora_user";
	      String passcode="human123";
	      String sql="select mobile,sum(total) from cafe_sales group by mobile order by sum(total) desc";
	      
	      try {
	         Class.forName("oracle.jdbc.driver.OracleDriver");  
	         conn=DriverManager.getConnection(url,userid,passcode); 
	         stmt=conn.createStatement(); 
	         rs=stmt.executeQuery(sql);   
	         while(rs.next()){ 
	        	
	            if(!strReturn.equals(""))strReturn+=";";
	            strReturn+=rs.getString("mobile")+","+rs.getInt("sum(total)");
	         }
	      } catch (Exception e) {
	         e.printStackTrace();
	      }   
	       finally{
	           try {
	            if(stmt!=null)stmt.close();
	            if(conn!=null)conn.close();
	            } catch (SQLException e) {
	               e.printStackTrace();
	             }
	        }
	      response.getWriter().print(strReturn);
	   }
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
