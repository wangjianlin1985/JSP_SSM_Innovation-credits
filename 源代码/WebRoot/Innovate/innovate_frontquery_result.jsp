<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.Innovate" %>
<%@ page import="com.chengxusheji.po.InnovateType" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<Innovate> innovateList = (List<Innovate>)request.getAttribute("innovateList");
    //获取所有的innovateTypeObj信息
    List<InnovateType> innovateTypeList = (List<InnovateType>)request.getAttribute("innovateTypeList");
    //获取所有的studentObj信息
    List<Student> studentList = (List<Student>)request.getAttribute("studentList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    InnovateType innovateTypeObj = (InnovateType)request.getAttribute("innovateTypeObj");
    String innovateTitle = (String)request.getAttribute("innovateTitle"); //创新项目标题查询关键字
    Student studentObj = (Student)request.getAttribute("studentObj");
    String sqTime = (String)request.getAttribute("sqTime"); //申请时间查询关键字
    String shenHeState = (String)request.getAttribute("shenHeState"); //审核状态查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>学生创新查询</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<div class="container">
<jsp:include page="../header.jsp"></jsp:include>
	<div class="row"> 
		<div class="col-md-9 wow fadeInDown" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li><a href="<%=basePath %>index.jsp">首页</a></li>
			    	<li role="presentation" class="active"><a href="#innovateListPanel" aria-controls="innovateListPanel" role="tab" data-toggle="tab">学生创新列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>Innovate/innovate_frontAdd.jsp" style="display:none;">添加学生创新</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="innovateListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>创新类型</td><td>创新项目标题</td><td>创新项目文件</td><td>申请创新学分</td><td>申请的学生</td><td>申请时间</td><td>审核状态</td><td>创新项目成绩</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<innovateList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		Innovate innovate = innovateList.get(i); //获取到学生创新对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=innovate.getInnovateTypeObj().getInnovateTypeName() %></td>
 											<td><%=innovate.getInnovateTitle() %></td>
 											<td><%=innovate.getInnovateFile().equals("")?"暂无文件":"<a href='" + basePath + innovate.getInnovateFile() + "' target='_blank'>" + innovate.getInnovateFile() + "</a>"%>
 											<td><%=innovate.getInnovateScore() %></td>
 											<td><%=innovate.getStudentObj().getName() %></td>
 											<td><%=innovate.getSqTime() %></td>
 											<td><%=innovate.getShenHeState() %></td>
 											<td><%=innovate.getInnovateChengji() %></td>
 											<td>
 												<a href="<%=basePath  %>Innovate/<%=innovate.getInnovateId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="innovateEdit('<%=innovate.getInnovateId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="innovateDelete('<%=innovate.getInnovateId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
 											</td> 
 										</tr>
 										<%}%>
				    				</table>
				    				</div>
				    			</div>
				    		</div>

				    		<div class="row">
					            <div class="col-md-12">
						            <nav class="pull-left">
						                <ul class="pagination">
						                    <li><a href="#" onclick="GoToPage(<%=currentPage-1 %>,<%=totalPage %>);" aria-label="Previous"><span aria-hidden="true">&laquo;</span></a></li>
						                     <%
						                    	int startPage = currentPage - 5;
						                    	int endPage = currentPage + 5;
						                    	if(startPage < 1) startPage=1;
						                    	if(endPage > totalPage) endPage = totalPage;
						                    	for(int i=startPage;i<=endPage;i++) {
						                    %>
						                    <li class="<%= currentPage==i?"active":"" %>"><a href="#"  onclick="GoToPage(<%=i %>,<%=totalPage %>);"><%=i %></a></li>
						                    <%  } %> 
						                    <li><a href="#" onclick="GoToPage(<%=currentPage+1 %>,<%=totalPage %>);"><span aria-hidden="true">&raquo;</span></a></li>
						                </ul>
						            </nav>
						            <div class="pull-right" style="line-height:75px;" >共有<%=recordNumber %>条记录，当前第 <%=currentPage %>/<%=totalPage %> 页</div>
					            </div>
				            </div> 
				    </div>
				</div>
			</div>
		</div>
	<div class="col-md-3 wow fadeInRight">
		<div class="page-header">
    		<h1>学生创新查询</h1>
		</div>
		<form name="innovateQueryForm" id="innovateQueryForm" action="<%=basePath %>Innovate/frontlist" class="mar_t15" method="post">
            <div class="form-group">
            	<label for="innovateTypeObj_innovateTypeId">创新类型：</label>
                <select id="innovateTypeObj_innovateTypeId" name="innovateTypeObj.innovateTypeId" class="form-control">
                	<option value="0">不限制</option>
	 				<%
	 				for(InnovateType innovateTypeTemp:innovateTypeList) {
	 					String selected = "";
 					if(innovateTypeObj!=null && innovateTypeObj.getInnovateTypeId()!=null && innovateTypeObj.getInnovateTypeId().intValue()==innovateTypeTemp.getInnovateTypeId().intValue())
 						selected = "selected";
	 				%>
 				 <option value="<%=innovateTypeTemp.getInnovateTypeId() %>" <%=selected %>><%=innovateTypeTemp.getInnovateTypeName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="innovateTitle">创新项目标题:</label>
				<input type="text" id="innovateTitle" name="innovateTitle" value="<%=innovateTitle %>" class="form-control" placeholder="请输入创新项目标题">
			</div>






            <div class="form-group">
            	<label for="studentObj_user_name">申请的学生：</label>
                <select id="studentObj_user_name" name="studentObj.user_name" class="form-control">
                	<option value="">不限制</option>
	 				<%
	 				for(Student studentTemp:studentList) {
	 					String selected = "";
 					if(studentObj!=null && studentObj.getUser_name()!=null && studentObj.getUser_name().equals(studentTemp.getUser_name()))
 						selected = "selected";
	 				%>
 				 <option value="<%=studentTemp.getUser_name() %>" <%=selected %>><%=studentTemp.getName() %></option>
	 				<%
	 				}
	 				%>
 			</select>
            </div>
			<div class="form-group">
				<label for="sqTime">申请时间:</label>
				<input type="text" id="sqTime" name="sqTime" class="form-control"  placeholder="请选择申请时间" value="<%=sqTime %>" onclick="SelectDate(this,'yyyy-MM-dd')" />
			</div>
			<div class="form-group">
				<label for="shenHeState">审核状态:</label>
				<input type="text" id="shenHeState" name="shenHeState" value="<%=shenHeState %>" class="form-control" placeholder="请输入审核状态">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="innovateEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" style="width:900px;" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;学生创新信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
      	<form class="form-horizontal" name="innovateEditForm" id="innovateEditForm" enctype="multipart/form-data" method="post"  class="mar_t15">
		  <div class="form-group">
			 <label for="innovate_innovateId_edit" class="col-md-3 text-right">创新记录id:</label>
			 <div class="col-md-9"> 
			 	<input type="text" id="innovate_innovateId_edit" name="innovate.innovateId" class="form-control" placeholder="请输入创新记录id" readOnly>
			 </div>
		  </div> 
		  <div class="form-group">
		  	 <label for="innovate_innovateTypeObj_innovateTypeId_edit" class="col-md-3 text-right">创新类型:</label>
		  	 <div class="col-md-9">
			    <select id="innovate_innovateTypeObj_innovateTypeId_edit" name="innovate.innovateTypeObj.innovateTypeId" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovate_innovateTitle_edit" class="col-md-3 text-right">创新项目标题:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="innovate_innovateTitle_edit" name="innovate.innovateTitle" class="form-control" placeholder="请输入创新项目标题">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovate_innovateContent_edit" class="col-md-3 text-right">创新项目描述:</label>
		  	 <div class="col-md-9">
			 	<textarea name="innovate.innovateContent" id="innovate_innovateContent_edit" style="width:100%;height:500px;"></textarea>
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovate_innovateFile_edit" class="col-md-3 text-right">创新项目文件:</label>
		  	 <div class="col-md-9">
			    <a id="innovate_innovateFileA" target="_blank"></a><br/>
			    <input type="hidden" id="innovate_innovateFile" name="innovate.innovateFile"/>
			    <input id="innovateFileFile" name="innovateFileFile" type="file" size="50" />
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovate_innovateScore_edit" class="col-md-3 text-right">申请创新学分:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="innovate_innovateScore_edit" name="innovate.innovateScore" class="form-control" placeholder="请输入申请创新学分">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovate_studentObj_user_name_edit" class="col-md-3 text-right">申请的学生:</label>
		  	 <div class="col-md-9">
			    <select id="innovate_studentObj_user_name_edit" name="innovate.studentObj.user_name" class="form-control">
			    </select>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovate_sqTime_edit" class="col-md-3 text-right">申请时间:</label>
		  	 <div class="col-md-9">
                <div class="input-group date innovate_sqTime_edit col-md-12" data-link-field="innovate_sqTime_edit">
                    <input class="form-control" id="innovate_sqTime_edit" name="innovate.sqTime" size="16" type="text" value="" placeholder="请选择申请时间" readonly>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
                </div>
		  	 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovate_shenHeState_edit" class="col-md-3 text-right">审核状态:</label>
		  	 <div class="col-md-9">
			    <input type="text" id="innovate_shenHeState_edit" name="innovate.shenHeState" class="form-control" placeholder="请输入审核状态">
			 </div>
		  </div>
		  <div class="form-group">
		  	 <label for="innovate_innovateChengji_edit" class="col-md-3 text-right">创新项目成绩:</label>
		  	 <div class="col-md-9">
			    <textarea id="innovate_innovateChengji_edit" name="innovate.innovateChengji" rows="8" class="form-control" placeholder="请输入创新项目成绩"></textarea>
			 </div>
		  </div>
		</form> 
	    <style>#innovateEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxInnovateModify();">提交</button>
      </div>
    </div><!-- /.modal-content -->
  </div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js"></script>
<script src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js"></script>
<script type="text/javascript" src="<%=basePath %>js/jsdate.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var innovate_innovateContent_edit = UE.getEditor('innovate_innovateContent_edit'); //创新项目描述编辑器
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.innovateQueryForm.currentPage.value = currentPage;
    document.innovateQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.innovateQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.innovateQueryForm.currentPage.value = pageValue;
    documentinnovateQueryForm.submit();
}

/*弹出修改学生创新界面并初始化数据*/
function innovateEdit(innovateId) {
	$.ajax({
		url :  basePath + "Innovate/" + innovateId + "/update",
		type : "get",
		dataType: "json",
		success : function (innovate, response, status) {
			if (innovate) {
				$("#innovate_innovateId_edit").val(innovate.innovateId);
				$.ajax({
					url: basePath + "InnovateType/listAll",
					type: "get",
					success: function(innovateTypes,response,status) { 
						$("#innovate_innovateTypeObj_innovateTypeId_edit").empty();
						var html="";
		        		$(innovateTypes).each(function(i,innovateType){
		        			html += "<option value='" + innovateType.innovateTypeId + "'>" + innovateType.innovateTypeName + "</option>";
		        		});
		        		$("#innovate_innovateTypeObj_innovateTypeId_edit").html(html);
		        		$("#innovate_innovateTypeObj_innovateTypeId_edit").val(innovate.innovateTypeObjPri);
					}
				});
				$("#innovate_innovateTitle_edit").val(innovate.innovateTitle);
				innovate_innovateContent_edit.setContent(innovate.innovateContent, false);
				$("#innovate_innovateFile").val(innovate.innovateFile);
				$("#innovate_innovateFileA").text(innovate.innovateFile);
				$("#innovate_innovateFileA").attr("href", basePath +　innovate.innovateFile);
				$("#innovate_innovateScore_edit").val(innovate.innovateScore);
				$.ajax({
					url: basePath + "Student/listAll",
					type: "get",
					success: function(students,response,status) { 
						$("#innovate_studentObj_user_name_edit").empty();
						var html="";
		        		$(students).each(function(i,student){
		        			html += "<option value='" + student.user_name + "'>" + student.name + "</option>";
		        		});
		        		$("#innovate_studentObj_user_name_edit").html(html);
		        		$("#innovate_studentObj_user_name_edit").val(innovate.studentObjPri);
					}
				});
				$("#innovate_sqTime_edit").val(innovate.sqTime);
				$("#innovate_shenHeState_edit").val(innovate.shenHeState);
				$("#innovate_innovateChengji_edit").val(innovate.innovateChengji);
				$('#innovateEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除学生创新信息*/
function innovateDelete(innovateId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "Innovate/deletes",
			data : {
				innovateIds : innovateId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#innovateQueryForm").submit();
					//location.href= basePath + "Innovate/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
}

/*ajax方式提交学生创新信息表单给服务器端修改*/
function ajaxInnovateModify() {
	$.ajax({
		url :  basePath + "Innovate/" + $("#innovate_innovateId_edit").val() + "/update",
		type : "post",
		dataType: "json",
		data: new FormData($("#innovateEditForm")[0]),
		success : function (obj, response, status) {
            if(obj.success){
                alert("信息修改成功！");
                $("#innovateQueryForm").submit();
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

    /*申请时间组件*/
    $('.innovate_sqTime_edit').datetimepicker({
    	language:  'zh-CN',  //语言
    	format: 'yyyy-mm-dd hh:ii:ss',
    	weekStart: 1,
    	todayBtn:  1,
    	autoclose: 1,
    	minuteStep: 1,
    	todayHighlight: 1,
    	startView: 2,
    	forceParse: 0
    });
})
</script>
</body>
</html>

