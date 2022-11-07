<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>게시판 보기</title>
<style type="text/css">
	a {
	  color: green;
	  text-decoration: none;
	}
	
	a:visited{
		color: purple;
		text-decoration: none;
	}
	
	a:hover {
	  color: hotpink;
	  text-decoration: none;
	}
	
	a:active {
	  color: blue;
	  text-decoration: none;
	}
	
	.button {
		  background-color: white; /* Green */
		  border: 2px solid #4CAF50;
		  color: black;
		  padding: 5px;
		  text-align: center;
		  text-decoration: none;
		  display: inline-block;
		  font-size: 14px;
		  margin: 2px 0px;
		  transition-duration: 0.4s;
		  cursor: pointer;
		  border-radius: 20%;
		}
	
	.button:hover {
	  background-color: #4CAF50;
	  border-radius: 20%;
	  color: white;
	}
	
	.button2 {
	  background-color: lightgray;
	  border: 2px solid black;
	  border-radius: 20%;
	  color: black;
	}
	
	.button2:hover {
	  background-color: lightgray;
	  border: 2px solid black;
	  border-radius: 20%;
	  color: black;
	  cursor: not-allowed;
	}
</style>
</head>
<body>
	
	<table  width="1000" align="center" border="1" cellpadding="5" cellspacing="0">
		<tr>
			<th colspan="5">게시판 보기</th>
		</tr>
		<tr>
			<td colspan="5" align="right">
				${boardList.totalCount}(${boardList.currentPage} / ${boardList.totalPage})
			</td>
		</tr>
		<tr>
			<th width="70">글번호</th>
			<th width="620">제목</th>
			<th width="120">이름</th>
			<th width="120">작성일</th>
			<th width="70">조회수</th>
		</tr>
		
		<c:set var="list" value="${boardList.list}"></c:set>
		<c:if test="${list.size() == 0}">
			<tr>
				<td colspan="5">
					<marquee>게시판에 글이 없습니다.</marquee>
				</td>
			</tr>
		</c:if>
		<c:if test="${list.size() != 0}">
			<c:forEach var="vo" items="${list}">
				<tr>
					<td align="center">${vo.idx}</td>
					<td>
						<!-- 글 레벨에 따른 들여쓰기 -->
						<c:if test="${vo.lev > 0}">
							<c:forEach var="i" begin="1" end="${vo.lev}" step="1">
								&nbsp;&nbsp;&nbsp;
							</c:forEach>
							Re.
						</c:if>
						<c:set var="subject" value="${fn:replace(vo.subject, '<', '&lt;')}"></c:set>
						<c:set var="subject" value="${fn:replace(subject, '>', '&gt;')}"></c:set>
						<a href="increment.nhn?idx=${vo.idx}&currentPage=${boardList.currentPage}">
								${vo.subject}
						</a>
					</td>
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
			</c:forEach>
		</c:if>
		
		<tr>
			<td align="center" colspan="5">
				<!-- 처음으로 -->
				<c:if test="${boardList.currentPage > 1}">
					<button class="button" type="button" onclick="location.href='?currentPage=1'" title="첫페이지로 이동합니다.">처음</button>
				</c:if>
				<c:if test="${boardList.currentPage <= 1}">
					<button class="button button2" type="button" disabled="disabled" title="이미 첫페이지입니다.">처음</button>
				</c:if>
				<c:if test="${boardList.startPage > 1}">
					<button class="button" type="button" onclick="location.href='?currentPage=${boardList.startPage - 1}'" title="이전페이지로 이동합니다.">이전</button>
				</c:if>
				<c:if test="${boardList.startPage <= 1}">
					<button class="button button2" type="button" disabled="disabled" title="이미 첫페이지입니다.">이전</button>
				</c:if>
				<c:forEach var="i" begin="${boardList.startPage}" end="${boardList.endPage}">
					<c:if test="${boardList.currentPage == i}">
						<button class="button button2" type="button" disabled="disabled">${i}</button>
					</c:if>
					<c:if test="${boardList.currentPage != i}">
						<button class="button" type="button" onclick="location.href='?currentPage=${i}'">${i}</button>
					</c:if>
				</c:forEach>
				<c:if test="${boardList.endPage < boardList.totalPage}">
					<button class="button" type="button" onclick="location.href='?currentPage=${boardList.endPage+1}'" title="다음페이지로 이동합니다.">다음</button>
				</c:if>
				<c:if test="${boardList.endPage >= boardList.totalPage}">
					<button class="button button2" type="button" disabled="disabled" title="이미 마지막 페이지입니다.">다음</button>
				</c:if>
				<c:if test="${boardList.currentPage < boardList.totalPage}">
					<button class="button" type="button" onclick="location.href='?currentPage=${boardList.totalPage}'"title="마지막 페이지로 이동합니다.">마지막</button>	
				</c:if>
				<c:if test="${boardList.currentPage >= boardList.totalPage}">
					<button class="button button2" type="button" disabled="disabled" title="이미 마지막 페이지입니다.">마지막</button>
				</c:if>
				
			</td>
		</tr>
		<tr>
			<td align="right" colspan="5">
				<input class="button" type="button" value="글쓰기" onclick="location.href='insert.nhn'">
			</td>
		</tr>
	</table>
	
</body>
</html>




































