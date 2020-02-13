package org.js.movie.member.dao;

import java.util.List;

import org.js.movie.member.domain.CustomMemberVO;
import org.js.movie.member.domain.MemberVO;
import org.js.movie.member.domain.Role;
import org.mybatis.spring.SqlSessionTemplate;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository("memberDAO")
public class MemberDAOImpl implements MemberDAO {

	@Autowired
	private SqlSessionTemplate sql;
	
	@Override
	public List<MemberVO> selectAll() {

		return sql.selectList("MemberMapper.selectAll");
	}

	@Override
	public void insert(MemberVO vo) {

		sql.insert("MemberMapper.insert", vo);
	}

	@Override
	public MemberVO selectOne(String memberId) {

		return sql.selectOne("MemberMapper.selectOne", memberId); //인자 넘겨주는 부분 없어서 nullpointer Exception.
	}

	@Override
	public void update(CustomMemberVO vo) {

		sql.update("MemberMapper.update", vo);
	}

	@Override
	public void delete(String memberId) {

		sql.delete("MemberMapper.delete", memberId);
	}
	
	/*
	 * @Override public MemberVO login(MemberVO vo) { return
	 * sql.selectOne("MemberMapper.login", vo); }
	 */
	@Override
	public CustomMemberVO login(String memberId) {
		
		return sql.selectOne("MemberMapper.login", memberId);
	}

	@Override
	public void insertRole(Role role) {
		
		sql.insert("MemberRole.insert", role);

	}

	@Override
	public Role selectRole(String memberId) {
		
		return sql.selectOne("MemberRole.select", memberId);
	}

	@Override
	public void deleteRole(String memberId) {
		
		sql.delete("MemberRole.delete", memberId);
	}


}
