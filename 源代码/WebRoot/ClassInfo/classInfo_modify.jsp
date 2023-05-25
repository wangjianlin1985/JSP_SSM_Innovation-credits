<%@ page language="java" contentType="text/html;charset=UTF-8"%>
<jsp:include page="../check_logstate.jsp"/>
<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/classInfo.css" />
<div id="classInfo_editDiv">
	<form id="classInfoEditForm" enctype="multipart/form-data"  method="post">
		<div>
			<span class="label">班级编号:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_classNo_edit" name="classInfo.classNo" value="<%=request.getParameter("classNo") %>" style="width:200px" />
			</span>
		</div>

		<div>
			<span class="label">班级名称:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_className_edit" name="classInfo.className" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在学院:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_collegeName_edit" name="classInfo.collegeName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">所在专业:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_specialName_edit" name="classInfo.specialName" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">班主任:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_mainTeacher_edit" name="classInfo.mainTeacher" style="width:200px" />

			</span>

		</div>
		<div>
			<span class="label">成立日期:</span>
			<span class="inputControl">
				<input class="textbox" type="text" id="classInfo_bornDate_edit" name="classInfo.bornDate" />

			</span>

		</div>
		<div class="operation">
			<a id="classInfoModifyButton" class="easyui-linkbutton">更新</a> 
		</div>
	</form>
</div>
<script src="${pageContext.request.contextPath}/ClassInfo/js/classInfo_modify.js"></script> 
