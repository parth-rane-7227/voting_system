package com.votingSystem;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class VoterAuth
 */
@WebServlet("/VoterAuth")
public class VoterAuth extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public VoterAuth() {
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
		Connection con=DbConnection.connect();
		String email=request.getParameter("email");
		String password=request.getParameter("password");
		try {
			PreparedStatement psmt = con.prepareStatement("select * from voter where voter_email=? and password=?");
			psmt.setString(1,email);
			psmt.setString(2,password);
			ResultSet rs=psmt.executeQuery();
			int voterId=-1;
			while(rs.next()){
				voterId=rs.getInt(1);
			}
			if(voterId<0){
				response.sendRedirect("index.jsp");
			}
			else{
				response.sendRedirect("voter.jsp?value="+Integer.toString(voterId));
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
