<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
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
<title>创新类型添加</title>
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
			    	<li role="presentation" ><a href="<%=basePath %>InnovateType/frontlist">创新类型列表</a></li>
			    	<li role="presentation" class="active"><a href="#innovateTypeAdd" aria-controls="innovateTypeAdd" role="tab" data-toggle="tab">添加创新类型</a></li>
				</ul>
				<!-- Tab panes -->
				<div class="tab-content">
				    <div role="tabpanel" class="tab-pane" id="innovateTypeList">
				    </div>
				    <div role="tabpanel" class="tab-pane active" id="innovateTypeAdd"> 
				      	<form class="form-horizontal" name="innovateTypeAddForm" id="innovateTypeAddForm" enctype="multipart/form-data" method="post"  class="mar_t15">
						  <div class="form-group">
						  	 <label for="innovateType_innovateTypeName" class="col-md-2 text-right">创新类型名称:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="innovateType_innovateTypeName" name="innovateType.innovateTypeName" class="form-control" placeholder="请输入创新类型名称">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="innovateType_sjnr" class="col-md-2 text-right">实践内容:</label>
						  	 <div class="col-md-8">
							    <textarea id="innovateType_sjnr" name="innovateType.sjnr" rows="8" class="form-control" placeholder="请输入实践内容"></textarea>
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="innovateType_xuefen" class="col-md-2 text-right">学分:</label>
						  	 <div class="col-md-8">
							    <input type="text" id="innovateType_xuefen" name="innovateType.xuefen" class="form-control" placeholder="请输入学分">
							 </div>
						  </div>
						  <div class="form-group">
						  	 <label for="innovateType_cjjz" class="col-md-2 text-right">成绩记载:</label>
						  	 <div class="col-md-8">
							    <textarea id="innovateType_cjjz" name="innovateType.cjjz" rows="8" class="form-control" placeholder="请输入成绩记载"></textarea>
							 </div>
						  </div>
				          <div class="form-group">
				             <span class="col-md-2""></span>
				             <span onclick="ajaxInnovateTypeAdd();" class="btn btn-primary bottom5 top5">添加</span>
				          </div>
						</form> 
				        <style>#innovateTypeAddForm .form-group {margin:10px;}  </style>
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
<script>
var basePath = "<%=basePath%>";
	//提交添加创新类型信息
	function ajaxInnovateTypeAdd() { 
		//提交之前先验证表单
		$("#innovateTypeAddForm").data('bootstrapValidator').validate();
		if(!$("#innovateTypeAddForm").data('bootstrapValidator').isValid()){
			return;
		}
		jQuery.ajax({
			type : "post",
			url : basePath + "InnovateType/add",
			dataType : "json" , 
			data: new FormData($("#innovateTypeAddForm")[0]),
			success : function(obj) {
				if(obj.success){ 
					alert("保存成功！");
					$("#innovateTypeAddForm").find("input").val("");
					$("#innovateTypeAddForm").find("textarea").val("");
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
	//验证创新类型添加表单字段
	$('#innovateTypeAddForm').bootstrapValidator({
		feedbackIcons: {
			valid: 'glyphicon glyphicon-ok',
			invalid: 'glyphicon glyphicon-remove',
			validating: 'glyphicon glyphicon-refresh'
		},
		fields: {
			"innovateType.innovateTypeName": {
				validators: {
					notEmpty: {
						message: "创新类型名称不能为空",
					}
				}
			},
			"innovateType.sjnr": {
				validators: {
					notEmpty: {
						message: "实践内容不能为空",
					}
				}
			},
			"innovateType.xuefen": {
				validators: {
					notEmpty: {
						message: "学分不能为空",
					},
					numeric: {
						message: "学分不正确"
					}
				}
			},
			"innovateType.cjjz": {
				validators: {
					notEmpty: {
						message: "成绩记载不能为空",
					}
				}
			},
		}
	}); 
})
</script>
</body>
</html>
