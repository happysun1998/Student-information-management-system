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
<!-- 员工修改的模态框 -->
<div class="modal fade" id="stuUpdateModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title">学生信息修改</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="stuName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <p class="form-control-static" id="stuName_update_static"></p>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_update_input" value="M" checked="checked">
                                男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_update_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stuEmail_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="stuEmail_update_input"
                                   placeholder="aaa@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id--%>
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="stu_update_btn">更新</button>
            </div>
        </div>
    </div>
</div>
<!-- 员工添加的模态框 -->
<div class="modal fade" id="stuAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span>
                </button>
                <h4 class="modal-title" id="myModalLabel">添加学生</h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal">
                    <div class="form-group">
                        <label for="stuName_add_input" class="col-sm-2 control-label">姓名</label>
                        <div class="col-sm-10">
                            <input type="text" name="stuName" class="form-control" id="stuName_add_input"
                                   placeholder="张三">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性别</label>
                        <div class="col-sm-10">
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender1_add_input" value="M" checked="checked"> 男
                            </label>
                            <label class="radio-inline">
                                <input type="radio" name="gender" id="gender2_add_input" value="F"> 女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="stuEmail_add_input" class="col-sm-2 control-label">邮箱</label>
                        <div class="col-sm-10">
                            <input type="email" name="email" class="form-control" id="stuEmail_add_input"
                                   placeholder="aaa@163.com">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">部门</label>
                        <div class="col-sm-4">
                            <%--部门提交部门id--%>
                            <select class="form-control" name="dId">

                            </select>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
                <button type="button" class="btn btn-primary" id="stu_save_btn">保存</button>
            </div>
        </div>
    </div>
</div>

<!-- 搭建显示页面 -->
<div class="container">
    <%--标题--%>
    <div class="row">
        <div class="col-md-12">
            <h1>学生信息管理系统</h1>
        </div>
        <div class="row">
            <div class="col-lg-3">
                <div class="input-group">
                    <input type="text" class="form-control" placeholder="输入学生姓名" size="10" id="stuName">
                    <span class="input-group-btn">
        <button class="btn btn-default" type="button" id="searchByStuName">搜索</button>
      </span>
                </div><!-- /input-group -->
            </div><!-- /.col-lg-6 -->
        </div><!-- /.row -->
    </div>
    <%--按钮--%>
    <div class="row">
        <div class="col-md-4 col-md-offset-9">
            <button class="btn btn-primary" id="stu_add_modal_btn">新增</button>
            <button class="btn btn-danger" id="stu_delete_all_btn">批量删除</button>
        </div>

    </div>
    <%--显示表格数据--%>
    <div class="row">
        <div class="col-md-12">
            <table class="table table-hover" id="emps_table">
                <thead>
                <tr>
                    <th>
                        <input type="checkbox" id="check_all"/>
                    </th>
                    <th>id</th>
                    <th>name</th>
                    <th>gender</th>
                    <th>email</th>
                    <th>deptname</th>
                    <th>操作</th>
                </tr>
                </thead>
                <tbody>

                </tbody>
            </table>
        </div>
    </div>
    <%--显示分页信息--%>
    <div class="row">
        <%--分页文字信息--%>
        <div class="col-md-6" id="page_info_area">

        </div>
        <%--分页条信息--%>
        <div class="col-md-6" id="page_nav_area">

        </div>
    </div>
</div>
<script type="text/javascript">
    //页面加载完成以后，发送ajax请求，得到分页数据
    $(function () {
        to_page(1)
    });

    //跳转到指定页面
    function to_page(pn) {
        $.ajax({
            url: "${APP_PATH}/students",
            data: "pn=" + pn,
            type: "GET",

            //result获取到了返回的Msg对象(JSON数据)
            success: function (result) {

                //1、解析并显示学生数据
                build_students_table(result);

                //2、解析并显示分页信息
                build_page_info(result);

                //3、解析显示分页条数据
                build_page_nav(result);
            }
        });
    }

    function build_students_table(result) {
        //每次显示一页的数据之前应该将之前的内容都清空，因为使用的都是append，
        //查询新的一页时会在之前的内容之上append，可能会出现两个导航条之类的错误

        //清空table表格中的学生数据
        $("#emps_table tbody").empty();

        var students = result.mapData.PageInfo.list;
        $.each(students, function (index, item) {
            //获取到学生信息中每项信息
            var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
            var empIdTd = $("<td></td>").append(item.stuId);
            var empNameTd = $("<td></td>").append(item.stuName);
            var genderTd = $("<td></td>").append(item.gender == 'M' ? "男" : "女");
            var emailTd = $("<td></td>").append(item.email);
            var deptNameTd = $("<td></td>").append(item.department.deptName);
            //每行中的编辑按钮
            var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
            //为编辑按钮添加一个自定义属性，表示当前学生的id
            editBtn.attr("edit-id", item.stuId);
            //每行中的删除按钮
            var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
            //为删除按钮添加一个自定义属性，表示当前学生的id
            delBtn.attr("del-id", item.stuId);

            //将两个按钮整合在一起
            var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

            //将以上数据拼成一行
            $("<tr></tr>")
                .append(checkBoxTd)
                .append(empIdTd)
                .append(empNameTd)
                .append(genderTd)
                .append(emailTd)
                .append(deptNameTd)
                .append(btnTd)
                .appendTo("#emps_table tbody");
        });
    }

    //2、解析并显示分页信息
    function build_page_info(result) {
        //清空分页信息
        $("#page_info_area").empty();

        $("#page_info_area").append("当前第 " + result.mapData.PageInfo.pageNum + " 页, 共 " +
            result.mapData.PageInfo.pages + " 页, 共 " +
            result.mapData.PageInfo.total + " 条记录");

        totalRecord = result.mapData.PageInfo.total;
        currentPage = result.mapData.PageInfo.pageNum;
    }

    //3.解析显示分页条信息
    function build_page_nav(result) {
        //清空分页条信息
        $("#page_nav_area").empty();

        //Bootstrap中的写法，导航条中的信息都要写在ul变量中
        var ul = $("<ul></ul>").addClass("pagination");

        //首页
        var firstPageLi = $("<li></li>").append($("<a></a>").append("首页").attr("href", "#"));

        //前一页
        var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;"));

        //如果当前遍历的页码是首页(没有前一页)，让首页和上一页不可点击
        if (result.mapData.PageInfo.hasPreviousPage == false) {
            //disabled是Bootstrap中的写法
            firstPageLi.addClass("disabled");
            prePageLi.addClass("disabled");
        } else {
            //为首页和前一页添加点击翻页的事件
            firstPageLi.click(function () {
                to_page(1);
            });
            prePageLi.click(function () {
                to_page(result.mapData.PageInfo.pageNum - 1);
            });
        }

        //后一页
        var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;"));

        //末页
        var lastPageLi = $("<li></li>").append($("<a></a>").append("末页").attr("href", "#"));

        //如果当前遍历的页码是末页(没有下一页)，让末页和下一页不可点击
        if (result.mapData.PageInfo.hasNextPage == false) {
            nextPageLi.addClass("disabled");
            lastPageLi.addClass("disabled");
        } else {
            //为下一页和末页添加点击翻页的事件
            nextPageLi.click(function () {
                to_page(result.mapData.PageInfo.pageNum + 1);
            });
            lastPageLi.click(function () {
                to_page(result.mapData.PageInfo.pages);
            });
        }

        //导航条中添加首页和前一页
        ul.append(firstPageLi).append(prePageLi);

        //遍历1，2，3之类的页码
        $.each(result.mapData.PageInfo.navigatepageNums, function (index, item) {

            //numLi / item表示遍历到的1，2，3之类的页码
            var numLi = $("<li></li>").append($("<a></a>").append(item));

            //如果当前遍历的页码就是当前的页码，让其高亮显示
            if (result.mapData.PageInfo.pageNum == item) {
                //active是Bootstrap中的写法
                numLi.addClass("active");
            }

            //单击事件，跳转到对应页面
            numLi.click(function () {
                to_page(item);
            });

            //向导航条中添加1，2，3之类的页码
            ul.append(numLi);
        });

        //导航条中添加下一页和末页
        ul.append(nextPageLi).append(lastPageLi);

        //把ul导航条添加到导航条在页面中的位置
        var navEle = $("<nav></nav>").append(ul);
        navEle.appendTo("#page_nav_area");
    }

    //清空表单样式与内容
    function reset_form(ele) {
        $(ele)[0].reset();
        //表单样式
        $(ele).find("*").removeClass("has-error has-success");
        $(ele).find(".help-block").text("");
    }

    /*点击新增按钮弹出模态框*/
    $("#stu_add_modal_btn").click(function () {
        //清楚表单数据（表单重置）
        reset_form("#stuAddModal form");
        // $("#stuAddModal form")[0].reset();
        //发送ajax请求，查出部门信息，显示在下拉框中
        getDepts("#stuAddModal select");
        //弹出模态框
        $("#stuAddModal").modal({
            backdrop: "static"
        });
    });

    function getDepts(ele) {
        // //清空之前下拉列表的值
        $(ele).empty();
        $.ajax({
            url: "${APP_PATH}/depts",
            type: "GET",
            success: function (result) {
                //{"code":100,"msg":"处理成功！",
                //"extend":{"depts":[{"deptId":1,"deptName":"开发部"},{"deptId":2,"deptName":"测试部"}]}}
                // console.log(result);
                //显示部门信息在下拉列表中
                $("#stuAddModal select").append("")
                $.each(result.mapData.depts, function () {
                    var optionEle = $("<option></option>").append(this.deptName).attr("value", this.deptId);
                    optionEle.appendTo(ele);
                });
            }
        });
    }

    //校验表单数据
    function validate_add_form() {
        //1、拿到要校验的数据，使用正则表达式
        var stuName = $("#stuName_add_input").val();
        var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
        if (!regName.test(stuName)) {
            // alert("用户名可以是2-5位中文或者6-16位英文和数字的组合");
            show_validate_msg("#stuName_add_input", "error", "用户名可以是2-5位中文或者6-16位英文和数字的组合");
            return false;
        } else {
            show_validate_msg("#stuName_add_input", "success", "");
        }

        //2、校验邮箱信息
        var email = $("#stuEmail_add_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#stuEmail_add_input", "error", "邮箱格式不正确");
            /* $("#email_add_input").parent().addClass("has-error");
            $("#email_add_input").next("span").text("邮箱格式不正确"); */
            return false;
        } else {
            show_validate_msg("#stuEmail_add_input", "success", "");
        }
        return true;
    }

    //显示校验结果的提示信息
    function show_validate_msg(ele, status, msg) {
        //清除当前元素的校验状态
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    //校验用户名是否可用
    $("#stuName_add_input").change(function () {
        //发送ajax请求校验用户名是否可用
        var stuName = this.value;
        $.ajax({
            url: "${APP_PATH}/checkuser",
            data: "stuName=" + stuName,
            type: "POST",
            success: function (result) {
                if (result.code == 100) {
                    show_validate_msg("#stuName_add_input", "success", "用户名可用");
                    $("#stu_save_btn").attr("ajax-va", "success");
                } else {
                    show_validate_msg("#stuName_add_input", "error", result.mapData.va_msg);
                    $("#stu_save_btn").attr("ajax-va", "error");
                }
            }
        });
    });

    //点击保存，保存员工
    $("#stu_save_btn").click(function () {
        //1、模态框中填写的表单数据提交给服务器进行保存
        //1、先对要提交给服务器的数据进行校验
        if (!validate_add_form()) {
            return false;
        }
        //1、判断之前的ajax用户名校验是否成功。如果成功。
        if ($(this).attr("ajax-va") == "error") {
            return false;
        }
        //2、发送ajax请求保存员工
        $.ajax({
            url: "${APP_PATH}/stu",
            type: "POST",
            data: $("#stuAddModal form").serialize(),
            success: function (result) {
                if (result.code == 100) {
                    //员工保存成功；
                    //1、关闭模态框
                    $("#stuAddModal").modal('hide');

                    //2、来到最后一页，显示刚才保存的数据
                    //发送ajax请求显示最后一页数据即可
                    to_page(totalRecord);
                } else {
                    //显示失败信息
                    // console.log(result);
                    //有哪个字段的错误信息就显示哪个字段的；
                    if (undefined != result.mapData.errorFields.email) {
                        //显示邮箱错误信息
                        show_validate_msg("#stuEmail_add_input", "error", result.mapData.errorFields.email);
                    }
                    if (undefined != result.mapData.errorFields.empName) {
                        //显示员工名字的错误信息
                        show_validate_msg("#stuName_add_input", "error", result.mapData.errorFields.empName);
                    }
                }
            },
            error: function () {
                alert(b)
            }
        });
    });

    //点击更新，更新员工信息
    $(document).on("click", ".edit_btn", function () {
        //1.查出部门信息，并显示部门列表
        getDepts("#stuUpdateModal select");
        //2.查出员工信息，并显示员工信息
        getStu($(this).attr("edit-id"));
        //3.把学生的id传递给模态框的更新按钮
        $("#stu_update_btn").attr("edit-id", $(this).attr("edit-id"));
        $("#stuUpdateModal").modal({
            backdrop: "static"
        });
    });

    function getStu(id) {
        $.ajax({
            url: "${APP_PATH}/stu/" + id,
            type: "GET",
            success: function (result) {
                var stuEle = result.mapData.stu;
                $("#stuName_update_static").text(stuEle.stuName);
                $("#stuEmail_update_input").val(stuEle.email);
                $("#stuUpdateModal input[name=gender]").val([stuEle.gender]);
                $("#stuUpdateModal select").val([stuEle.dId]);
            }
        });
    }

    //点击更新，更新员工信息
    $("#stu_update_btn").click(function () {
        //验证邮箱是否合法
        //1、校验邮箱信息
        var email = $("#stuEmail_update_input").val();
        var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
        if (!regEmail.test(email)) {
            //alert("邮箱格式不正确");
            //应该清空这个元素之前的样式
            show_validate_msg("#stuEmail_update_input", "error", "邮箱格式不正确");
            return false;
        } else {
            show_validate_msg("#stuEmail_update_input", "success", "");
        }

        //2、发送ajax请求保存更新的员工数据
        $.ajax({
            url: "${APP_PATH}/stu/" + $(this).attr("edit-id"),
            type: "PUT",
            data: $("#stuUpdateModal form").serialize(),
            success: function (result) {
                //alert(result.msg);
                //1、关闭对话框
                $("#stuUpdateModal").modal("hide");
                // //回到当前页面
                to_page(currentPage);
            }
        });
    });

    //点击删除，删除员工信息
    $(document).on("click", ".delete_btn", function () {
        //1.弹出确认删除的对话框
        var stuName = $(this).parents("tr").find("td:eq(2)").text();
        var stuId = $(this).attr("del-id");
        // alert($(this).parents("tr").find("td:eq(2)").text());
        if (confirm("确认删除【" + stuName + "】吗？")) {
            $.ajax({
                url: "${APP_PATH}/stu/" + stuId,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    //回到本页
                    to_page(currentPage);
                }
            });
        }
    });

    //完成全选和全不选
    $("#check_all").click(function () {
        $(".check_item").prop("checked", $(this).prop("checked"));
    });

    //check_item
    $(document).on("click", ".check_item", function () {
        //判断当前选择中的元素是否5个
        var flag = $(".check_item:checked").length == $(".check_item").length;
        $("#check_all").prop("checked", flag);
    });

    // stu_delete_all_btn
    //点击全部删除，就批量删除
    $("#stu_delete_all_btn").click(function () {
        //
        var empNames = "";
        var del_idstr = "";
        $.each($(".check_item:checked"), function () {
            //this
            empNames += $(this).parents("tr").find("td:eq(2)").text() + ",";
            //组装员工id字符串
            del_idstr += $(this).parents("tr").find("td:eq(1)").text() + "-";
        });
        //去除empNames多余的,
        empNames = empNames.substring(0, empNames.length - 1);
        //去除删除的id多余的-
        del_idstr = del_idstr.substring(0, del_idstr.length - 1);
        if (confirm("确认删除【" + empNames + "】吗？")) {
            //发送ajax请求删除
            $.ajax({
                url: "${APP_PATH}/stu/" + del_idstr,
                type: "DELETE",
                success: function (result) {
                    alert(result.msg);
                    //回到当前页面
                    to_page(currentPage);
                }
            });
        }
    });

    /*点击新增按钮弹出模态框*/
    $("#searchByStuName").click(function () {
        var name = $("#stuName").val();
        getStuByName(name)
    });

    function getStuByName(name) {
        $.ajax({
            url: "${APP_PATH}/stu/sn/" + name,
            type: "GET",
            success: function (result) {
                var stuEle = result.mapData.stu;
                // alert(stuEle)
                $("#emps_table tbody").empty();
                //获取到学生信息中每项信息
                var checkBoxTd = $("<td><input type='checkbox' class='check_item'/></td>");
                var empIdTd = $("<td></td>").append(stuEle.stuId);
                var empNameTd = $("<td></td>").append(stuEle.stuName);
                var genderTd = $("<td></td>").append(stuEle.gender == 'M' ? "男" : "女");
                var emailTd = $("<td></td>").append(stuEle.email);
                var deptNameTd = $("<td></td>").append(stuEle.department.deptName);
                //每行中的编辑按钮
                var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm edit_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
                //为编辑按钮添加一个自定义属性，表示当前学生的id
                editBtn.attr("edit-id", stuEle.stuId);
                //每行中的删除按钮
                var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm delete_btn")
                    .append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
                //为删除按钮添加一个自定义属性，表示当前学生的id
                delBtn.attr("del-id", stuEle.stuId);

                //将两个按钮整合在一起
                var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);

                //将以上数据拼成一行
                $("<tr></tr>")
                    .append(checkBoxTd)
                    .append(empIdTd)
                    .append(empNameTd)
                    .append(genderTd)
                    .append(emailTd)
                    .append(deptNameTd)
                    .append(btnTd)
                    .appendTo("#emps_table tbody");
            }
        });
    }


</script>
</body>
</html>
