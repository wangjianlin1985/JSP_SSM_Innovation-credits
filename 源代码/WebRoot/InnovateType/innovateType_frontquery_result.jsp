<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%> 
<%@ page import="com.chengxusheji.po.InnovateType" %>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
    List<InnovateType> innovateTypeList = (List<InnovateType>)request.getAttribute("innovateTypeList");
    int currentPage =  (Integer)request.getAttribute("currentPage"); //当前页
    int totalPage =   (Integer)request.getAttribute("totalPage");  //一共多少页
    int recordNumber =   (Integer)request.getAttribute("recordNumber");  //一共多少记录
    String innovateTypeName = (String)request.getAttribute("innovateTypeName"); //创新类型名称查询关键字
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1 , user-scalable=no">
<title>创新类型查询</title>
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
			    	<li role="presentation" class="active"><a href="#innovateTypeListPanel" aria-controls="innovateTypeListPanel" role="tab" data-toggle="tab">创新类型列表</a></li>
			    	<li role="presentation" ><a href="<%=basePath %>InnovateType/innovateType_frontAdd.jsp" style="display:none;">添加创新类型</a></li>
				</ul>
			  	<!-- Tab panes -->
			  	<div class="tab-content">
				    <div role="tabpanel" class="tab-pane active" id="innovateTypeListPanel">
				    		<div class="row">
				    			<div class="col-md-12 top5">
				    				<div class="table-responsive">
				    				<table class="table table-condensed table-hover">
				    					<tr class="success bold"><td>序号</td><td>创新类型名称</td><td>实践内容</td><td>学分</td><td>成绩记载</td><td>操作</td></tr>
				    					<% 
				    						/*计算起始序号*/
				    	            		int startIndex = (currentPage -1) * 5;
				    	            		/*遍历记录*/
				    	            		for(int i=0;i<innovateTypeList.size();i++) {
					    	            		int currentIndex = startIndex + i + 1; //当前记录的序号
					    	            		InnovateType innovateType = innovateTypeList.get(i); //获取到创新类型对象
 										%>
 										<tr>
 											<td><%=currentIndex %></td>
 											<td><%=innovateType.getInnovateTypeName() %></td>
 											<td><%=innovateType.getSjnr() %></td>
 											<td><%=innovateType.getXuefen() %></td>
 											<td><%=innovateType.getCjjz() %></td>
 											<td>
 												<a href="<%=basePath  %>InnovateType/<%=innovateType.getInnovateTypeId() %>/frontshow"><i class="fa fa-info"></i>&nbsp;查看</a>&nbsp;
 												<a href="#" onclick="innovateTypeEdit('<%=innovateType.getInnovateTypeId() %>');" style="display:none;"><i class="fa fa-pencil fa-fw"></i>编辑</a>&nbsp;
 												<a href="#" onclick="innovateTypeDelete('<%=innovateType.getInnovateTypeId() %>');" style="display:none;"><i class="fa fa-trash-o fa-fw"></i>删除</a>
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
    		<h1>创新类型查询</h1>
		</div>
		<form name="innovateTypeQueryForm" id="innovateTypeQueryForm" action="<%=basePath %>InnovateType/frontlist" class="mar_t15" method="post">
			<div class="form-group">
				<label for="innovateTypeName">创新类型名称:</label>
				<input type="text" id="innovateTypeName" name="innovateTypeName" value="<%=innovateTypeName %>" class="form-control" placeholder="请输入创新类型名称">
			</div>






            <input type=hidden name=currentPage value="<%=currentPage %>" />
            <button type="submit" class="btn btn-primary">查询</button>
        </form>
	</div>

		</div>
	</div> 
<div id="innovateTypeEditDialog" class="modal fade" tabindex="-1" role="dialog">
  <div class="modal-dialog" role="document">
    <div class="modal-content">
      <div class="modal-header">
        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
        <h4 class="modal-title"><i class="fa fa-edit"></i>&nbsp;创新类型信息编辑</h4>
      </div>
      <div class="modal-body" style="height:450px; overflow: scroll;">
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
		</form> 
	    <style>#innovateTypeEditForm .form-group {margin-bottom:5px;}  </style>
      </div>
      <div class="modal-footer"> 
      	<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
      	<button type="button" class="btn btn-primary" onclick="ajaxInnovateTypeModify();">提交</button>
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
<script>
var basePath = "<%=basePath%>";
/*跳转到查询结果的某页*/
function GoToPage(currentPage,totalPage) {
    if(currentPage==0) return;
    if(currentPage>totalPage) return;
    document.innovateTypeQueryForm.currentPage.value = currentPage;
    document.innovateTypeQueryForm.submit();
}

/*可以直接跳转到某页*/
function changepage(totalPage)
{
    var pageValue=document.innovateTypeQueryForm.pageValue.value;
    if(pageValue>totalPage) {
        alert('你输入的页码超出了总页数!');
        return ;
    }
    document.innovateTypeQueryForm.currentPage.value = pageValue;
    documentinnovateTypeQueryForm.submit();
}

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
				$('#innovateTypeEditDialog').modal('show');
			} else {
				alert("获取信息失败！");
			}
		}
	});
}

/*删除创新类型信息*/
function innovateTypeDelete(innovateTypeId) {
	if(confirm("确认删除这个记录")) {
		$.ajax({
			type : "POST",
			url : basePath + "InnovateType/deletes",
			data : {
				innovateTypeIds : innovateTypeId,
			},
			success : function (obj) {
				if (obj.success) {
					alert("删除成功");
					$("#innovateTypeQueryForm").submit();
					//location.href= basePath + "InnovateType/frontlist";
				}
				else 
					alert(obj.message);
			},
		});
	}
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

})
</script>
</body>
</html>

