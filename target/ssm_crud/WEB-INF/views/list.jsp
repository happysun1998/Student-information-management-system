<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>学生列表</title>
    <%
        pageContext.setAttribute("APP_PATH", request.getContextPath());
    %>

    <%--
    不以/开始的相对路径，找资源，以当前资源的路径为基准，经常容易出现问题
    以/开始的相对路径，找资源以服务器的路径为标准
    --%>

    <script type="text/javascript" src="${APP_PATH }/static/js/jquery-1.12.4.min.js"></script>
    <link href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>
</head>
<body>
<!-- 搭建显示页面 -->
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>SSM学生信息管理系统</h1>
        </div>
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-8">
            <button class="btn btn-primary">新增</button>
            <button class="btn btn-danger">删除</button>
        </div>

    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover">
                <tr>
                    <th>id</th>
                    <th>name</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptname</th>
                    <th>操作</th>
                </tr>
                <c:forEach items="${PageInfo.list}" var="student">
                    <tr>
                        <th>${student.stuId}</th>
                        <th>${student.stuName}</th>
                        <th>${student.gender == "M" ? "男" : "女"}</th>
                        <th>${student.email}</th>
                        <th>${student.department.deptName}</th>
                        <th>
                            <button class="btn btn-primary btn-sm">
                                <span class="glyphicon glyphicon-pencil" aria-hidden="true"></span>
                                编辑
                            </button>
                            <button class="btn btn-danger btn-sm">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                                删除
                            </button>
                        </th>
                    </tr>
                </c:forEach>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6">
            当前 ${PageInfo.pageNum }页 , 总${PageInfo.pages }页 , 总 ${PageInfo.total } 条记录
        </div>
        <%--分页条信息--%>
        <div class="col-md-6">
            <nav aria-label="Page navigation">
                <ul class="pagination">
                    <li><a href="${APP_PATH }/?pn=1">首页</a></li>
                    <c:if test="${PageInfo.hasPreviousPage}">
                        <li>
                            <a href="${APP_PATH }/?pn=${PageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!PageInfo.hasPreviousPage}">
                        <li class="disabled">
                            <a href="${APP_PATH }/?pn=${PageInfo.pageNum-1}" aria-label="Previous">
                                <span aria-hidden="true">&laquo;</span>
                            </a>
                        </li>
                    </c:if>

                    <c:forEach items="${PageInfo.navigatepageNums}" var="page_Num">
                        <c:if test="${page_Num == PageInfo.pageNum}">
                            <li class="active"><a href="#">${page_Num}</a></li>
                        </c:if>
                        <c:if test="${page_Num != PageInfo.pageNum }">
                            <li><a href="${APP_PATH }/?pn=${page_Num }">${page_Num}</a></li>
                        </c:if>
                    </c:forEach>
                    <c:if test="${PageInfo.hasNextPage}">
                        <li>
                            <a href="${APP_PATH }/?pn=${PageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <c:if test="${!PageInfo.hasNextPage}">
                        <li class="disabled">
                            <a href="${APP_PATH }/?pn=${PageInfo.pageNum+1}" aria-label="Next">
                                <span aria-hidden="true">&raquo;</span>
                            </a>
                        </li>
                    </c:if>
                    <li><a href="${APP_PATH}/?pn=${PageInfo.pages}">末页</a></li>
                </ul>
            </nav>
        </div>
    </div>
</div>
</body>
</html>
