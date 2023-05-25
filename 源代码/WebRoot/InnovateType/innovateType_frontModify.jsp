<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.InnovateType" %>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    InnovateType innovateType = (InnovateType)request.getAttribute("innovateType");

%>
<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
  <TITLE>修改创新类型信息</TITLE>
  <link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
  <link href="<%=basePath %>plugins/animate.css" rel="stylesheet"> 
</head>
<body style="margin-top:70px;"> 
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="col-md-9 wow fadeInLeft">
	<ul class="breadcrumb">
  		<li><a href="<%=basePath %>index.jsp">首页</a></li>
  		<li class="active">创新类型信息修改</li>
	</ul>
		<div class="row"> 
      	<form class="form-horizontal" name="innovateTypeEditForm" id="innovateTypeEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="innovateType_innovateTypeId_edit" class="col-md-3 text-right">创新类型id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="innovateType_innovateTypeId_edit" name="innovateType.innovateTypeId" class="form-control" placeholder="请输入创新类型id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="innovateType_innovateTypeName_edit" class="col-md-3 text-right">创新类型名称:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="innovateType_innovateTypeName_edit" name="innovateType.innovateTypeName" class="form-control" placeholder="请输入创新类型名称">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovateType_sjnr_edit" class="col-md-3 text-right">实践内容:</label>
		  	 <div class="col-md-9">
			    <textarea id="innovateType_sjnr_edit" name="innovateType.sjnr" rows="8" class="form-control" placeholder="请输入实践内容"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovateType_xuefen_edit" class="col-md-3 text-right">学分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="innovateType_xuefen_edit" name="innovateType.xuefen" class="form-control" placeholder="请输入学分">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovateType_cjjz_edit" class="col-md-3 text-right">成绩记载:</label>
		  	 <div class="col-md-9">
			    <textarea id="innovateType_cjjz_edit" name="innovateType.cjjz" rows="8" class="form-control" placeholder="请输入成绩记载"></textarea>
			 </div>
		  </div>
			  <div class="form-group">
			  	<span class="col-md-3""></span>
			  	<span onclick="ajaxInnovateTypeModify();" class="btn btn-primary bottom5 top5">修改</span>
			  </div>
		</form> 
	    <style>#innovateTypeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
   </div>
</div>


<jsp:include page="../footer.jsp"></jsp:include>
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script>
var basePath = "<%=basePath%>";
/*弹出修改创新类型界面并初始化数据*/
function innovateTypeEdit(innovateTypeId) {
	$.ajax({
		url :  basePath + "InnovateType/" + innovateTypeId + "/update",
		type : "get",
		dataType: "json",
		success : function (innovateType, response, status) {
			if (innovateType) {
				$("#innovateType_innovateTypeId_edit").val(innovateType.innovateTypeId);
				$("#innovateType_innovateTypeName_edit").val(innovateType.innovateTypeName);
				$("#innovateType_sjnr_edit").val(innovateType.sjnr);
				$("#innovateType_xuefen_edit").val(innovateType.xuefen);
				$("#innovateType_cjjz_edit").val(innovateType.cjjz);
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*ajax方式提交创新类型信息表单给服务器端修改*/
function ajaxInnovateTypeModify() {
	$.ajax({
		url :  basePath + "InnovateType/" + $("#innovateType_innovateTypeId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#innovateTypeEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                location.reload(true);
                $("#innovateTypeQueryForm").submit();
            }else{
                alert(obj.message);
            } 
		},
		processData: false,
		contentType: false,
	});
}

$(function(){
        /*小屏幕导航点击关闭菜单*/
        $('.navbar-collapse a').click(function(){
            $('.navbar-collapse').collapse('hide');
        });
        new WOW().init();
    innovateTypeEdit("<%=request.getParameter("innovateTypeId")%>");
 })
 </script> 
</body>
</html>

