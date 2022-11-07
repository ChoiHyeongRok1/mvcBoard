package com.tjoeun.dao;

import java.util.ArrayList;
import java.util.HashMap;

import org.apache.ibatis.session.SqlSession;

import com.tjoeun.vo.MvcBoardVO;

public class MvcBoardDAO {
	private static MvcBoardDAO instance = new MvcBoardDAO();
	
	private MvcBoardDAO() {}
	
	public static MvcBoardDAO getInstance() {
		return instance;
	}

	public void insert(SqlSession mapper, MvcBoardVO vo) {
		System.out.println("MvcBoardVO의 insert()");
		mapper.insert("insert", vo);
	}

	public int selectCount(SqlSession mapper) {
		System.out.println("MvcBoardVO의 selectCount()");
		return (int) mapper.selectOne("selectCount", mapper);
	}

	public ArrayList<MvcBoardVO> selectList(SqlSession mapper, HashMap<String, Integer> hmap) {
		System.out.println("MvcBoardVO의 selectList()");
		return (ArrayList<MvcBoardVO>) mapper.selectList("selectList", hmap);
	}

	public void increment(SqlSession mapper, int idx) {
		System.out.println("MvcBoardVO의 increment()");
		mapper.update("increment", idx);
	}

	public MvcBoardVO selectByIdx(SqlSession mapper, int idx) {
		System.out.println("MvcBoardVO의 selectByIdx()");
		return (MvcBoardVO) mapper.selectOne("selectByIdx", idx);
	}

	public void update(SqlSession mapper, MvcBoardVO vo) {
		System.out.println("MvcBoardVO의 update()");
		mapper.update("update", vo);
	}

	public void delete(SqlSession mapper, int idx) {
		System.out.println("MvcBoardVO의 delete()");
		mapper.delete("delete", idx);
	}

	public void incrementSeq(SqlSession mapper, HashMap<String, Integer> hmap) {
		System.out.println("MvcBoardVO의 incrementSeq()");
		mapper.update("incrementSeq", hmap);
	}

	public void replyInsert(SqlSession mapper, MvcBoardVO vo) {
		System.out.println("MvcBoardVO의 replyInsert()");
		mapper.insert("replyInsert", vo);
	}
	
	
	
}























