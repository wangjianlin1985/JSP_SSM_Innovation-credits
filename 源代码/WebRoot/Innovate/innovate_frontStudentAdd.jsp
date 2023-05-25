<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.InnovateType" %>
<%@ page import="com.chengxusheji.po.Student" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>学生创新添加</title>
<link href="<%=basePath %>plugins/bootstrap.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-dashen.css" rel="stylesheet">
<link href="<%=basePath %>plugins/font-awesome.css" rel="stylesheet">
<link href="<%=basePath %>plugins/animate.css" rel="stylesheet">
<link href="<%=basePath %>plugins/bootstrap-datetimepicker.min.css" rel="stylesheet" media="screen">
</head>
<body style="margin-top:70px;">
<jsp:include page="../header.jsp"></jsp:include>
<div class="container">
	<div class="row">
		<div class="col-md-12 wow fadeInUp" data-wow-duration="0.5s">
			<div>
				<!-- Nav tabs -->
				<ul class="nav nav-tabs" role="tablist">
			    	<li role="presentation" ><a href="<%=basePath %>Innovate/studentFrontlist">学生创新列表</a></li>
			    	<li role="presentation" class="active"><a href="#innovateAdd" aria-controls="innovateAdd" role="tab" data-toggle="tab">学生创新申请</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="innovateList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="innovateAdd"> 
				      	<form class="form-horizontal" name="innovateAddForm" id="innovateAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="innovate_innovateTypeObj_innovateTypeId" class="col-md-2 text-right">创新类型:</label>
						  	 <div class="col-md-8">
							    <select id="innovate_innovateTypeObj_innovateTypeId" name="innovate.innovateTypeObj.innovateTypeId" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="innovate_innovateTitle" class="col-md-2 text-right">创新项目标题:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="innovate_innovateTitle" name="innovate.innovateTitle" class="form-control" placeholder="请输入创新项目标题">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="innovate_innovateContent" class="col-md-2 text-right">创新项目描述:</label>
						  	 <div class="col-md-8">
							    <textarea name="innovate.innovateContent" id="innovate_innovateContent" style="width:100%;height:500px;"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="innovate_innovateFile" class="col-md-2 text-right">创新项目文件:</label>
						  	 <div class="col-md-8">
							    <a id="innovate_innovateFileImg" border="0px"></a><br/>
							    <input type="hidden" id="innovate_innovateFile" name="innovate.innovateFile"/>
							    <input id="innovateFileFile" name="innovateFileFile" type="file" size="50" />
						  	 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="innovate_innovateScore" class="col-md-2 text-right">申请创新学分:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="innovate_innovateScore" name="innovate.innovateScore" class="form-control" placeholder="请输入申请创新学分">
							 </div>
						  </div>
						  <div class="form-group" style="display:none;">
						  	 <label for="innovate_studentObj_user_name" class="col-md-2 text-right">申请的学生:</label>
						  	 <div class="col-md-8">
							    <select id="innovate_studentObj_user_name" name="innovate.studentObj.user_name" class="form-control">
							    </select>
						  	 </div>
						  </div>
						  <div class="form-group" style="display:none;">
						  	 <label for="innovate_sqTimeDiv" class="col-md-2 text-right">申请时间:</label>
						  	 <div class="col-md-8">
				                <div id="innovate_sqTimeDiv" class="input-group date innovate_sqTime col-md-12" data-link-field="innovate_sqTime">
				                    <input class="form-control" id="innovate_sqTime" name="innovate.sqTime" size="16" type="text" value="" placeholder="请选择申请时间" readonly>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-remove"></span></span>
				                    <span class="input-group-addon"><span class="glyphicon glyphicon-calendar"></span></span>
				                </div>
						  	 </div>
						  </div>
						  <div class="form-group" style="display:none;">
						  	 <label for="innovate_shenHeState" class="col-md-2 text-right">审核状态:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="innovate_shenHeState" name="innovate.shenHeState" class="form-control" placeholder="请输入审核状态">
							 </div>
						  </div>
						  <div class="form-group" style="display:none;">
						  	 <label for="innovate_innovateChengji" class="col-md-2 text-right">创新项目成绩:</label>
						  	 <div class="col-md-8">
							    <textarea id="innovate_innovateChengji" name="innovate.innovateChengji" rows="8" class="form-control" placeholder="请输入创新项目成绩"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxInnovateAdd();" class="btn btn-primary bottom5 top5">提交申请</span>
				          </div>
						</form> 
				        <style>#innovateAddForm .form-group {margin:10px;}  </style>
					</div>
				</div>
			</div>
		</div>
	</div> 
</div>

<jsp:include page="../footer.jsp"></jsp:include> 
<script src="<%=basePath %>plugins/jquery.min.js"></script>
<script src="<%=basePath %>plugins/bootstrap.js"></script>
<script src="<%=basePath %>plugins/wow.min.js"></script>
<script src="<%=basePath %>plugins/bootstrapvalidator/js/bootstrapValidator.min.js"></script>
<script type="text/javascript" src="<%=basePath %>plugins/bootstrap-datetimepicker.min.js" charset="UTF-8"></script>
<script type="text/javascript" src="<%=basePath %>plugins/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/ueditor.all.min.js"> </script>
<!--建议手动加在语言，避免在ie下有时因为加载语言失败导致编辑器加载失败-->
<!--这里加载的语言文件会覆盖你在配置项目里添加的语言类型，比如你在配置项目里配置的是英文，这里加载的中文，那最后就是中文-->
<script type="text/javascript" charset="utf-8" src="${pageContext.request.contextPath}/ueditor1_4_3/lang/zh-cn/zh-cn.js"></script>
<script>
//实例化编辑器
var innovate_innovateContent_editor = UE.getEditor('innovate_innovateContent'); //创新项目描述编辑器
var basePath = "<%=basePath%>";
	//提交添加学生创新信息
	function ajaxInnovateAdd() { 
		//提交之前先验证表单
		$("#innovateAddForm").data('bootstrapValidator').validate();
		if(!$("#innovateAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		if(innovate_innovateContent_editor.getContent() == "") {
			alert('创新项目描述不能为空');
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "Innovate/studentAdd",
			dataType : "json" , 
			data: new FormData($("#innovateAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#innovateAddForm").find("input").val("");
					$("#innovateAddForm").find("textarea").val("");
					innovate_innovateContent_editor.setContent("");
				} else {
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
	//验证学生创新添加表单字段
	$('#innovateAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"innovate.innovateTitle": {
				validators: {
					notEmpty: {
						message: "创新项目标题不能为空",
					}
				}
			},
			"innovate.innovateScore": {
				validators: {
					notEmpty: {
						message: "申请创新学分不能为空",
					},
					numeric: {
						message: "申请创新学分不正确"
					}
				}
			},
			 
			 
		}
	}); 
	//初始化创新类型下拉框值 
	$.ajax({
		url: basePath + "InnovateType/listAll",
		type: "get",
		success: function(innovateTypes,response,status) { 
			$("#innovate_innovateTypeObj_innovateTypeId").empty();
			var html="";
    		$(innovateTypes).each(function(i,innovateType){
    			html += "<option value='" + innovateType.innovateTypeId + "'>" + innovateType.innovateTypeName + "</option>";
    		});
    		$("#innovate_innovateTypeObj_innovateTypeId").html(html);
    	}
	});
	//初始化申请的学生下拉框值 
	$.ajax({
		url: basePath + "Student/listAll",
		type: "get",
		success: function(students,response,status) { 
			$("#innovate_studentObj_user_name").empty();
			var html="";
    		$(students).each(function(i,student){
    			html += "<option value='" + student.user_name + "'>" + student.name + "</option>";
    		});
    		$("#innovate_studentObj_user_name").html(html);
    	}
	});
	//申请时间组件
	$('#innovate_sqTimeDiv').datetimepicker({
		language:  'zh-CN',  //显示语言
		format: 'yyyy-mm-dd hh:ii:ss',
		weekStart: 1,
		todayBtn:  1,
		autoclose: 1,
		minuteStep: 1,
		todayHighlight: 1,
		startView: 2,
		forceParse: 0
	}).on('hide',function(e) {
		//下面这行代码解决日期组件改变日期后不验证的问题
		$('#innovateAddForm').data('bootstrapValidator').updateStatus('innovate.sqTime', 'NOT_VALIDATED',null).validateField('innovate.sqTime');
	});
})
</script>
</body>
</html>
