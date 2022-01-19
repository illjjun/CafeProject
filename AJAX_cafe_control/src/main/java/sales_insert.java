

import java.io.IOException;
import java.sql.Connection;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class sales_insert
 */
@WebServlet("/sales_insert")
public class sales_insert extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public sales_insert() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html, charset=utf-8");
		
		Connection conn=null;
		PreparedStatement pstmt=null;
		
		String url="jdbc:oracle:thin:@localhost:1521:orcl";
		String userid="ora_user";
		String passcode="human123";
		String sql="insert into cafe_sales(order_no,mobile,menu_code,qty,total,sold_time) "+
						"values(order_number.nextval,?,?,?,?,sysdate)";
		
		try {
			
			Class.forName("oracle.jdbc.driver.OracleDriver"); //driver (ojdbc6.jar)
			conn=DriverManager.getConnection(url,userid,passcode); //null if connection failed
			pstmt=conn.prepareStatement(sql);
			
			
			pstmt.setString(1, request.getParameter("mobile"));
			pstmt.setInt(2, Integer.parseInt(request.getParameter("code")));
			pstmt.setInt(3, Integer.parseInt(request.getParameter("qty")));
			pstmt.setInt(4, Integer.parseInt(request.getParameter("total")));

			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
				try {
					
					if(pstmt != null ) pstmt.close();
					if(conn != null) conn.close();
				} catch (SQLException e) {
					e.printStackTrace();
				}
	}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
