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
 * Servlet implementation class Vote
 */
@WebServlet("/Vote")
public class Vote extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public Vote() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
		Connection con=DbConnection.connect();
		String op=request.getParameter("op");
		int vid=Integer.parseInt(request.getParameter("vid"));
		int pid=Integer.parseInt(request.getParameter("pid"));
		
		try {
			PreparedStatement psmt0=con.prepareStatement("select * from voter where voter_id=?");
			psmt0.setInt(1, vid);
			ResultSet rs=psmt0.executeQuery();
			String vemail=null;
			while(rs.next()){
				vemail=rs.getString(3);
			}
			
			
			PreparedStatement psmt = con.prepareStatement("update add_voters set vote='voted' where vemail=? and pid=?");
			psmt.setString(1, vemail);
			psmt.setInt(2, pid);
			psmt.executeUpdate();
			String salt=Salt.getSalt(op.length());
			String saltedVote=op+salt;
			PreparedStatement psmt1 = con.prepareStatement("insert into result values(?,?,?,?,aes_encrypt(?,?),?)");
			psmt1.setInt(1, 0);
			psmt1.setInt(2, vid);
			psmt1.setString(3, vemail);
			psmt1.setInt(4, pid);
			psmt1.setString(5, saltedVote);
			psmt1.setString(6, SecurityKey.getKey());
			psmt1.setString(7, salt);
			if(psmt1.executeUpdate()==1){
				response.sendRedirect("voter.jsp?value="+Integer.toString(vid));
			}
			else{
				response.sendRedirect("failure.html");
			}

		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
		
	}

}
