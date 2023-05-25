package com.chengxusheji.controller;

import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import com.chengxusheji.utils.ExportExcelUtil;
import com.chengxusheji.utils.UserException;
import com.chengxusheji.service.InnovateService;
import com.chengxusheji.po.Innovate;
import com.chengxusheji.service.InnovateTypeService;
import com.chengxusheji.po.InnovateType;
import com.chengxusheji.service.StudentService;
import com.chengxusheji.po.Student;

//Innovate管理控制层
@Controller
@RequestMapping("/Innovate")
public class InnovateController extends BaseController {

    /*业务层对象*/
    @Resource InnovateService innovateService;

    @Resource InnovateTypeService innovateTypeService;
    @Resource StudentService studentService;
	@InitBinder("innovateTypeObj")
	public void initBinderinnovateTypeObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("innovateTypeObj.");
	}
	@InitBinder("studentObj")
	public void initBinderstudentObj(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("studentObj.");
	}
	@InitBinder("innovate")
	public void initBinderInnovate(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("innovate.");
	}
	/*跳转到添加Innovate视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new Innovate());
		/*查询所有的InnovateType信息*/
		List<InnovateType> innovateTypeList = innovateTypeService.queryAllInnovateType();
		request.setAttribute("innovateTypeList", innovateTypeList);
		/*查询所有的Student信息*/
		List<Student> studentList = studentService.queryAllStudent();
		request.setAttribute("studentList", studentList);
		return "Innovate_add";
	}

	/*客户端ajax方式提交添加学生创新信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated Innovate innovate, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
		innovate.setInnovateFile(this.handleFileUpload(request, "innovateFileFile"));
        innovateService.addInnovate(innovate);
        message = "学生创新添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	

	/*客户端ajax方式提交添加学生创新信息*/
	@RequestMapping(value = "/studentAdd", method = RequestMethod.POST)
	public void studentAdd(Innovate innovate, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response,HttpSession session) throws Exception {
		String message = "";
		boolean success = false;
		 
		innovate.setInnovateFile(this.handleFileUpload(request, "innovateFileFile"));
		
		Student student = new Student();
		student.setUser_name(session.getAttribute("user_name").toString());
		innovate.setStudentObj(student);
		
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		innovate.setSqTime(sdf.format(new java.util.Date()));
		
		innovate.setShenHeState("待审核");
		innovate.setInnovateChengji("--");
		
		
        innovateService.addInnovate(innovate);
        message = "学生创新添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	
	
	
	/*ajax方式按照查询条件分页查询学生创新信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(@ModelAttribute("innovateTypeObj") InnovateType innovateTypeObj,String innovateTitle,@ModelAttribute("studentObj") Student studentObj,String sqTime,String shenHeState,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (innovateTitle == null) innovateTitle = "";
		if (sqTime == null) sqTime = "";
		if (shenHeState == null) shenHeState = "";
		if(rows != 0)innovateService.setRows(rows);
		List<Innovate> innovateList = innovateService.queryInnovate(innovateTypeObj, innovateTitle, studentObj, sqTime, shenHeState, page);
	    /*计算总的页数和总的记录数*/
	    innovateService.queryTotalPageAndRecordNumber(innovateTypeObj, innovateTitle, studentObj, sqTime, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = innovateService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = innovateService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(Innovate innovate:innovateList) {
			JSONObject jsonInnovate = innovate.getJsonObject();
			jsonArray.put(jsonInnovate);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询学生创新信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<Innovate> innovateList = innovateService.queryAllInnovate();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(Innovate innovate:innovateList) {
			JSONObject jsonInnovate = new JSONObject();
			jsonInnovate.accumulate("innovateId", innovate.getInnovateId());
			jsonInnovate.accumulate("innovateTitle", innovate.getInnovateTitle());
			jsonArray.put(jsonInnovate);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询学生创新信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(@ModelAttribute("innovateTypeObj") InnovateType innovateTypeObj,String innovateTitle,@ModelAttribute("studentObj") Student studentObj,String sqTime,String shenHeState,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (innovateTitle == null) innovateTitle = "";
		if (sqTime == null) sqTime = "";
		if (shenHeState == null) shenHeState = "";
		List<Innovate> innovateList = innovateService.queryInnovate(innovateTypeObj, innovateTitle, studentObj, sqTime, shenHeState, currentPage);
	    /*计算总的页数和总的记录数*/
	    innovateService.queryTotalPageAndRecordNumber(innovateTypeObj, innovateTitle, studentObj, sqTime, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = innovateService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = innovateService.getRecordNumber();
	    request.setAttribute("innovateList",  innovateList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("innovateTypeObj", innovateTypeObj);
	    request.setAttribute("innovateTitle", innovateTitle);
	    request.setAttribute("studentObj", studentObj);
	    request.setAttribute("sqTime", sqTime);
	    request.setAttribute("shenHeState", shenHeState);
	    List<InnovateType> innovateTypeList = innovateTypeService.queryAllInnovateType();
	    request.setAttribute("innovateTypeList", innovateTypeList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "Innovate/innovate_frontquery_result"; 
	}
	
	
	
	/*前台按照查询条件分页查询学生创新信息*/
	@RequestMapping(value = { "/studentFrontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String studentFrontlist(@ModelAttribute("innovateTypeObj") InnovateType innovateTypeObj,String innovateTitle,@ModelAttribute("studentObj") Student studentObj,String sqTime,String shenHeState,Integer currentPage, Model model, HttpServletRequest request,HttpSession session) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (innovateTitle == null) innovateTitle = "";
		if (sqTime == null) sqTime = "";
		if (shenHeState == null) shenHeState = "";
		studentObj = new Student();
		studentObj.setUser_name(session.getAttribute("user_name").toString());
		
		List<Innovate> innovateList = innovateService.queryInnovate(innovateTypeObj, innovateTitle, studentObj, sqTime, shenHeState, currentPage);
	    /*计算总的页数和总的记录数*/
	    innovateService.queryTotalPageAndRecordNumber(innovateTypeObj, innovateTitle, studentObj, sqTime, shenHeState);
	    /*获取到总的页码数目*/
	    int totalPage = innovateService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = innovateService.getRecordNumber();
	    request.setAttribute("innovateList",  innovateList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("innovateTypeObj", innovateTypeObj);
	    request.setAttribute("innovateTitle", innovateTitle);
	    request.setAttribute("studentObj", studentObj);
	    request.setAttribute("sqTime", sqTime);
	    request.setAttribute("shenHeState", shenHeState);
	    List<InnovateType> innovateTypeList = innovateTypeService.queryAllInnovateType();
	    request.setAttribute("innovateTypeList", innovateTypeList);
	    List<Student> studentList = studentService.queryAllStudent();
	    request.setAttribute("studentList", studentList);
		return "Innovate/innovate_studentFrontquery_result"; 
	}
	
	

     /*前台查询Innovate信息*/
	@RequestMapping(value="/{innovateId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer innovateId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键innovateId获取Innovate对象*/
        Innovate innovate = innovateService.getInnovate(innovateId);

        List<InnovateType> innovateTypeList = innovateTypeService.queryAllInnovateType();
        request.setAttribute("innovateTypeList", innovateTypeList);
        List<Student> studentList = studentService.queryAllStudent();
        request.setAttribute("studentList", studentList);
        request.setAttribute("innovate",  innovate);
        return "Innovate/innovate_frontshow";
	}

	/*ajax方式显示学生创新修改jsp视图页*/
	@RequestMapping(value="/{innovateId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer innovateId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键innovateId获取Innovate对象*/
        Innovate innovate = innovateService.getInnovate(innovateId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonInnovate = innovate.getJsonObject();
		out.println(jsonInnovate.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新学生创新信息*/
	@RequestMapping(value = "/{innovateId}/update", method = RequestMethod.POST)
	public void update(@Validated Innovate innovate, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		String innovateFileFileName = this.handleFileUpload(request, "innovateFileFile");
		if(!innovateFileFileName.equals(""))innovate.setInnovateFile(innovateFileFileName);
		try {
			innovateService.updateInnovate(innovate);
			message = "学生创新更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "学生创新更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除学生创新信息*/
	@RequestMapping(value="/{innovateId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer innovateId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  innovateService.deleteInnovate(innovateId);
	            request.setAttribute("message", "学生创新删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "学生创新删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条学生创新记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String innovateIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = innovateService.deleteInnovates(innovateIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出学生创新信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(@ModelAttribute("innovateTypeObj") InnovateType innovateTypeObj,String innovateTitle,@ModelAttribute("studentObj") Student studentObj,String sqTime,String shenHeState, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(innovateTitle == null) innovateTitle = "";
        if(sqTime == null) sqTime = "";
        if(shenHeState == null) shenHeState = "";
        List<Innovate> innovateList = innovateService.queryInnovate(innovateTypeObj,innovateTitle,studentObj,sqTime,shenHeState);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "Innovate信息记录"; 
        String[] headers = { "创新记录id","创新类型","创新项目标题","申请创新学分","申请的学生","申请时间","审核状态","创新项目成绩"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<innovateList.size();i++) {
        	Innovate innovate = innovateList.get(i); 
        	dataset.add(new String[]{innovate.getInnovateId() + "",innovate.getInnovateTypeObj().getInnovateTypeName(),innovate.getInnovateTitle(),innovate.getInnovateScore() + "",innovate.getStudentObj().getName(),innovate.getSqTime(),innovate.getShenHeState(),innovate.getInnovateChengji()});
        }
        /*
        OutputStream out = null;
		try {
			out = new FileOutputStream("C://output.xls");
			ex.exportExcel(title,headers, dataset, out);
		    out.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/
		OutputStream out = null;//创建一个输出流对象 
		try { 
			out = response.getOutputStream();//
			response.setHeader("Content-disposition","attachment; filename="+"Innovate.xls");//filename是下载的xls的名，建议最好用英文 
			response.setContentType("application/msexcel;charset=UTF-8");//设置类型 
			response.setHeader("Pragma","No-cache");//设置头 
			response.setHeader("Cache-Control","no-cache");//设置头 
			response.setDateHeader("Expires", 0);//设置日期头  
			String rootPath = request.getSession().getServletContext().getRealPath("/");
			ex.exportExcel(rootPath,_title,headers, dataset, out);
			out.flush();
		} catch (IOException e) { 
			e.printStackTrace(); 
		}finally{
			try{
				if(out!=null){ 
					out.close(); 
				}
			}catch(IOException e){ 
				e.printStackTrace(); 
			} 
		}
    }
}
