package com.tjoeun.service;

import java.util.HashMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.ibatis.session.SqlSession;

import com.tjoeun.dao.MvcBoardDAO;
import com.tjoeun.mybatis.MySession;
import com.tjoeun.vo.MvcBoardList;
import com.tjoeun.vo.MvcBoardVO;

public class MvcBoardService {
	
	private static MvcBoardService instance = new MvcBoardService();
	
	private MvcBoardService() {}
	
	public static MvcBoardService getInstance() {
		return instance;
	}
	
	private MvcBoardDAO dao = MvcBoardDAO.getInstance();
	
//	컨트롤러에 insertOK.nhn이라는 요청이 들어오면 컨트롤러에서 호출하는 메소드
	public void insert(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcBoardService의 insert()");
		SqlSession mapper = MySession.getSession();
		
//		insert.jsp에서 입력한 request 객체에 저장되서 넘어오는 데이터를 받아서 받아서 MvcBoardVO 클래스 객체에
//		저장한다.
		MvcBoardVO vo = new MvcBoardVO();
		vo.setName(request.getParameter("name"));
		vo.setSubject(request.getParameter("subject"));
		vo.setContent(request.getParameter("content"));
//		System.out.println(vo);
		
		dao.insert(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}

//	컨트롤러에 list.nhn 이라는 요청이 들어오면 컨트롤러에서 호출하는 메소드로 mapper를 얻어온 후
//	MvcboardDAO 클래스의 브라우저에 출력한 1페이지 분량의 글 목록과 페이징 작업에 사용할 8개 변수가
//	저장된 클래스 객체를 만들어 request 영역에 저장하는 메소드를 호출하는 메소드
	public void selectList(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcBoardService의 selectList()");
		SqlSession mapper = MySession.getSession();
		
//		list.nhn이 요청될 때 넘어오는 브라우저에 표시할 페이지 번호를 받는다.
//		브라우저에 표시할 페이지 번호가 정상적으로 넘어왔으면 넘어온 페이지 번호로, 정상적으로 넘어오지
//		않았다면 1로 브라우저에 표시할 페이지 번호를 설정한다.
		int currentPage = 1;
		try {
			currentPage = Integer.parseInt(request.getParameter("currentPage"));
		} catch (Exception e) {
			
		}
		
//		1페이지에 표시할 글의 개수를 정한다.
		int pageSize = 10;
		int totalCount = dao.selectCount(mapper);
//		System.out.println(totalCount);
//		테이블에 저장된 전체 글의 개수를 얻어온다.
		MvcBoardList boardList = new MvcBoardList(pageSize, totalCount, currentPage);
		HashMap<String, Integer> hmap = new HashMap<>();
		hmap.put("startNo", boardList.getStartNo());
		hmap.put("endNo", boardList.getEndNo());
		boardList.setList(dao.selectList(mapper, hmap));
//		System.out.println(boardList.getList());
		request.setAttribute("boardList", boardList);
		
		mapper.close();
	}

	public void increment(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcBoardService의 increment()");
		SqlSession mapper = MySession.getSession();
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		dao.increment(mapper, idx);
		
		mapper.commit();
		mapper.close();
	}

	public void selectByIdx(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcBoardService의 selectByIdx()");
		SqlSession mapper = MySession.getSession();
		int idx = Integer.parseInt(request.getParameter("idx"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		
		MvcBoardVO vo = dao.selectByIdx(mapper, idx);
//		System.out.println(vo);
		
//		브라우저에 표시할 글이 저장된 객체(vo), 작업후 돌아갈 페이지 번호(currentPage), 줄바꿈에
//		이스케이프 시퀀스 (\r\n)를 request 영역에 저장한다.
		request.setAttribute("vo", vo);
		request.setAttribute("currentPage", currentPage);
		request.setAttribute("enter", "\r\n");
		
		mapper.close();
	}

	public void update(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcBoardService의 update()");
		SqlSession mapper = MySession.getSession();
		
//		request 객체로 넘어오는 수정할 데이터를 받아서 MvcBoardVO 클래스 객체에 저장한다.
		MvcBoardVO vo = new MvcBoardVO();
		vo.setIdx(Integer.parseInt(request.getParameter("idx")));
		vo.setSubject(request.getParameter("subject"));
		vo.setContent(request.getParameter("content"));
//		System.out.println(vo);
		
//		글 1건을 수정하는 메소드를 호출한다.
		dao.update(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}

	public void delete(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcBoardService의 delete()");
		SqlSession mapper = MySession.getSession();
		
		int idx = Integer.parseInt(request.getParameter("idx"));
		
		dao.delete(mapper, idx);
		
		mapper.commit();
		mapper.close();
	}

	public void replyInsert(HttpServletRequest request, HttpServletResponse response) {
		System.out.println("MvcBoardService의 replyInsert()");
		SqlSession mapper = MySession.getSession();
		
//		request 객체로 넘어오는 답글 정보를 받는다.
		int idx = Integer.parseInt(request.getParameter("idx"));
		int gup = Integer.parseInt(request.getParameter("gup"));
		int lev = Integer.parseInt(request.getParameter("lev"));
		int seq = Integer.parseInt(request.getParameter("seq"));
		int currentPage = Integer.parseInt(request.getParameter("currentPage"));
		String name = request.getParameter("name");
		String subject = request.getParameter("subject");
		String content = request.getParameter("content");
		
//		넘겨받은 답글 정보를 MvcBoardVO 클래스 객체에 저장한다.
//		이 때, lev와 seq는 1씩 증가시켜 저장한다.
		MvcBoardVO vo = new MvcBoardVO();
		vo.setIdx(idx);
		vo.setGup(gup);
		vo.setLev(lev + 1);
		vo.setSeq(seq + 1);
		vo.setName(name);
		vo.setSubject(subject);
		vo.setContent(content);
		
//		같은 글 그룹(gup)에서 답글이 표시될 위치(seq) 이후의 모든 글이 출력될 위치를 1씩
//		증가시키는 메소드를 실행한다.
		HashMap<String, Integer>hmap = new HashMap<>();
		hmap.put("gup", vo.getGup());
		hmap.put("seq", vo.getSeq());
		dao.incrementSeq(mapper, hmap);
		
		dao.replyInsert(mapper, vo);
		
		mapper.commit();
		mapper.close();
	}

	
}























