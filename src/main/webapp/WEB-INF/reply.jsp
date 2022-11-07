<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	
	<form action="update.nhn" method="post">
		<table width="600" align="center" border="1" cellpadding="5" cellspacing="0">
			<tr>
				<th colspan="4">질문글 보기</th>
			</tr>
			<tr>
				<th width="80">글번호</th>
				<th width="290">이름</th>
				<th width="150">작성일</th>
				<th width="80">조회수</th>
			</tr>
			<tr>
				<td align="center">${vo.idx}</td>
				<td align="center">
					<c:set var="name" value="${fn:replace(vo.name, '<', '&lt;')}"></c:set>
					<c:set var="name" value="${fn:replace(name, '>', '&gt;')}"></c:set>
					${name}
				</td>
				<td align="center">
					<fmt:formatDate value="${vo.writeDate}" pattern="yyyy.MM.dd(E)"/>
				</td>
				<td align="center">
					${vo.hit}
				</td>
			</tr>
			<tr>
				<th>제목</th>
				<td colspan="3">
					<input type="text" name="subject" value="${vo.subject}" style="width: 98%">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td colspan="3">
					<textarea rows="10" name="content" style="resize: none; width: 98%;">${vo.content}</textarea>
				</td>
			</tr>
		</table><br/>
	</form>
	<form action="replyInsert.nhn" method="post">
		
		<input type="hidden" name="idx" value="${vo.idx}">
		<input type="hidden" name="gup" value="${vo.gup}">
		<input type="hidden" name="lev" value="${vo.lev}">
		<input type="hidden" name="seq" value="${vo.seq}">
		<input type="hidden" name="currentPage" value="${currentPage}">
		
		<table width="600" align="center" border="1" cellpadding="5" cellspacing="0">
			<tr>
				<th colspan="2">답글 쓰기</th>
			</tr>
			<tr>
				<th width="100">이름</th>
				<th width="500" align="left">
					<input type="text" name="name">
				</th>
			</tr>
			<tr>
				<th>제목</th>
				<td>
					<input type="text" name="subject" style="width: 98%">
				</td>
			</tr>
			<tr>
				<th>내용</th>
				<td>
					<textarea rows="10" name="content" style="resize: none; width: 98%"></textarea>
				</td>
			</tr>
			<tr>
				<td colspan="2" align="center">
					<input type="submit" value="저장하기">
					<input type="reset" value="다시쓰기">
					<input type="button" value="돌아가기" onclick="history.back()">
					<input type="button" value="목록보기" onclick="location.href='list.nhn?currentPage=${currentPage}'">
				</td>
			</tr>
		</table>
	</form>
</body>
</html>


























