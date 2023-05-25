<%@ page language="java" import="java.util.*"  contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>

<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/innovateType.css" />
<div id="innovateTypeAddDiv">
	<form id="innovateTypeAddForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">创新类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="innovateType_innovateTypeName" name="innovateType.innovateTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">实践内容:</span>
			<span class="inputControl">
				<textarea id="innovateType_sjnr" name="innovateType.sjnr" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div>
			<span class="label">学分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="innovateType_xuefen" name="innovateType.xuefen" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">成绩记载:</span>
			<span class="inputControl">
				<textarea id="innovateType_cjjz" name="innovateType.cjjz" rows="6" cols="80"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="innovateTypeAddButton" class="easyui-linkbutton">添加</a>
			<a id="innovateTypeClearButton" class="easyui-linkbutton">重填</a>
		</div> 
	</form>
</div>
<script src="${pageContext.request.contextPath}/InnovateType/js/innovateType_add.js"></script> 
