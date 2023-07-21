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
 * Servlet implementation class CreatePoll
 */
@WebServlet("/CreatePoll")
public class CreatePoll extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public CreatePoll() {
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
		int oid=Integer.parseInt(request.getParameter("oid"));
		Connection con=DbConnection.connect();
		String pname=request.getParameter("name");
		String op1=request.getParameter("op1");
		String op2=request.getParameter("op2");
		String op3=request.getParameter("op3");
		String op4=request.getParameter("op4");
		
		try {
			PreparedStatement psmt = con.prepareStatement("insert into polls values(?,?,?,?,?,?,?)");
			psmt.setInt(1, 0);
			psmt.setString(2, pname);
			psmt.setInt(3, oid);
			psmt.setString(4, op1);
			psmt.setString(5, op2);
			psmt.setString(6, op3);
			psmt.setString(7, op4);
			
			if(psmt.executeUpdate()==1){
				response.sendRedirect("createPoll.jsp?oid="+Integer.toString(oid));
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
