package sw;

import java.sql.Connection;
import sw.MemberDTO;

import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

public class MemberDAO {

	private Connection conn = null;
	
    // driver loading을 위한 기본 정보
    String url = "jdbc:mysql://127.0.0.1:3306/FaceMask_Program?characterEncoding=UTF-8&serverTimezone=UTC";
	String root = "sohee";
	String pwd ="wnsgur0702";
	String driverName = "com.mysql.jdbc.Driver";

    // BookDAO가 생성되면서 같이 드라이버도 메모리에 올라갈 수 있도록 생성자에 코딩
    public MemberDAO() {
        try{
        	Class.forName(driverName);
        	
        	conn = (Connection) DriverManager.getConnection(url, root, pwd); 
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 실제로 DB에 접근하여 데이터를 가져오는 역할을 하는 메서드
    public ArrayList<MemberDTO> select() {
        ArrayList<MemberDTO> list = new ArrayList<MemberDTO>();

        // 연결을 위한 Connection 객체
        
        // 통신하기 위한 PreparedStatement 객체
        PreparedStatement pstmt = null;
        // select 결과 값을 담기 위한 ResultSet 객체
        ResultSet rs = null;

        // 실제로 DB에 접근하는 부분
        try{
            // connection
            String sql = "SELECT * FROM FaceMask"; // query
            pstmt = conn.prepareStatement(sql); // preparedStatement
            rs = pstmt.executeQuery(); // run

            while(rs.next()){
                String newid = rs.getString("id");
                String newname = rs.getString("name");
                String newwhether = rs.getString("whether");

                MemberDTO dto = new MemberDTO(newid, newname, newwhether); // DTO 객체에 DB에서 읽어온 값 넣어서 호출
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            try {
                if(rs != null) rs.close();
                if(pstmt != null) pstmt.close();
                if(conn != null) conn.close();
            } catch (Exception e2) {
                e2.printStackTrace();
            }
        }
		return list;
        
    }
}
