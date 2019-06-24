<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<div >
    <a href="${pageContext.request.contextPath}">
        <img id="simpleLogo" class="simpleLogo" src="img/site/simpleLogo.png">
    </a>
    <form action="search" method="get" >
        <div class="simpleSearchDiv pull-right">
            <input type="text" placeholder="平衡车 原汁机"  name="keyword">
            <button class="searchButton" type="submit">搜天猫</button>
            <div class="searchBelow">
                <c:forEach items="${application.categories_below_search}" var="c" varStatus="st">
                <c:if test="${status.index>=7 && status.index<=10}">
                    <a href="category?cid='+${c.id}">${c.name}</a>
                    <c:if test="${status.index!=10}">
                        <span>|</span>
                    </c:if>
                </c:if>
                </c:forEach>
                <%--<span th:each="c,status: ${application.categories_below_search}" th:if="${status.index>=7 && status.index<=10}">--%>
                    <%--<a th:href="@{'category?cid='+${c.id}}" th:text="${c.name}" ></a>--%>
                    <%--<span th:if="${status.index!=10}">|</span>--%>
                <%--</span>--%>
            </div>
        </div>
    </form>
    <div style="clear:both"></div>
</div>