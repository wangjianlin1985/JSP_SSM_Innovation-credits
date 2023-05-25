<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/innovateType.css" />
<div id="innovateType_editDiv">
	<form id="innovateTypeEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">创新类型id:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="innovateType_innovateTypeId_edit" name="innovateType.innovateTypeId" value="<%=request.getParameter("innovateTypeId") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">创新类型名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="innovateType_innovateTypeName_edit" name="innovateType.innovateTypeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">实践内容:</span>
			<span class="inputControl">
				<textarea id="innovateType_sjnr_edit" name="innovateType.sjnr" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div>
			<span class="label">学分:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="innovateType_xuefen_edit" name="innovateType.xuefen" style="width:80px" />

			</span>

		</div>
		<div>
			<span class="label">成绩记载:</span>
			<span class="inputControl">
				<textarea id="innovateType_cjjz_edit" name="innovateType.cjjz" rows="8" cols="60"></textarea>

			</span>

		</div>
		<div class="operation">
			<a id="innovateTypeModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/InnovateType/js/innovateType_modify.js"></script> 
