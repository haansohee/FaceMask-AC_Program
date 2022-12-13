package sw;

import sw.MemberDTO;
import sw.MemberDAO;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

@WebServlet("/BookServlet")
public class MemberServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        doGet(request, response);
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        response.setContentType("text/html; charset = UTF-8");
        PrintWriter out = response.getWriter();

        MemberDAO dao = new MemberDAO(); // DAO 객체 호출(DB driver 메모리에 올라감)
        ArrayList<MemberDTO> list = dao.select(); // DAO 객체의 select 메서드 호출

        // 출력해보기
        for(int i=0;i<list.size();i++){
        	MemberDTO dto = list.get(i);

            String qid = dto.getId();
            String qname = dto.getName();
            String qwhether = dto.getWhether();

            out.print("book id: "+ qid+ ", ");
            out.print("book name: "+ qname+ ", ");
            out.print("book location: "+ qwhether+ "<br>  ");
        }
    }
}
