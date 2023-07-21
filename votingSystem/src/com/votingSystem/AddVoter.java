package com.votingSystem;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class AddVoter
 */
@WebServlet("/AddVoter")
public class AddVoter extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddVoter() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		int pid=Integer.parseInt(request.getParameter("pid"));
		Connection con=DbConnection.connect();
		String vemail=request.getParameter("email");
		
		try {
			PreparedStatement psmt = con.prepareStatement("insert into add_voters values(?,?,?,?)");
			psmt.setInt(1, 0);
			psmt.setString(2, vemail);
			psmt.setInt(3, pid);
			psmt.setString(4, "null");
			if(psmt.executeUpdate()==1){
				response.sendRedirect("addVoters.jsp?pid="+Integer.toString(pid));
			}
			else{
				response.sendRedirect("failure.html");
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
