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
import com.chengxusheji.service.InnovateTypeService;
import com.chengxusheji.po.InnovateType;

//InnovateType管理控制层
@Controller
@RequestMapping("/InnovateType")
public class InnovateTypeController extends BaseController {

    /*业务层对象*/
    @Resource InnovateTypeService innovateTypeService;

	@InitBinder("innovateType")
	public void initBinderInnovateType(WebDataBinder binder) {
		binder.setFieldDefaultPrefix("innovateType.");
	}
	/*跳转到添加InnovateType视图*/
	@RequestMapping(value = "/add", method = RequestMethod.GET)
	public String add(Model model,HttpServletRequest request) throws Exception {
		model.addAttribute(new InnovateType());
		return "InnovateType_add";
	}

	/*客户端ajax方式提交添加创新类型信息*/
	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public void add(@Validated InnovateType innovateType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
		boolean success = false;
		if (br.hasErrors()) {
			message = "输入信息不符合要求！";
			writeJsonResponse(response, success, message);
			return ;
		}
        innovateTypeService.addInnovateType(innovateType);
        message = "创新类型添加成功!";
        success = true;
        writeJsonResponse(response, success, message);
	}
	/*ajax方式按照查询条件分页查询创新类型信息*/
	@RequestMapping(value = { "/list" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void list(String innovateTypeName,Integer page,Integer rows, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		if (page==null || page == 0) page = 1;
		if (innovateTypeName == null) innovateTypeName = "";
		if(rows != 0)innovateTypeService.setRows(rows);
		List<InnovateType> innovateTypeList = innovateTypeService.queryInnovateType(innovateTypeName, page);
	    /*计算总的页数和总的记录数*/
	    innovateTypeService.queryTotalPageAndRecordNumber(innovateTypeName);
	    /*获取到总的页码数目*/
	    int totalPage = innovateTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = innovateTypeService.getRecordNumber();
        response.setContentType("text/json;charset=UTF-8");
		PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象
		JSONObject jsonObj=new JSONObject();
		jsonObj.accumulate("total", recordNumber);
		JSONArray jsonArray = new JSONArray();
		for(InnovateType innovateType:innovateTypeList) {
			JSONObject jsonInnovateType = innovateType.getJsonObject();
			jsonArray.put(jsonInnovateType);
		}
		jsonObj.accumulate("rows", jsonArray);
		out.println(jsonObj.toString());
		out.flush();
		out.close();
	}

	/*ajax方式按照查询条件分页查询创新类型信息*/
	@RequestMapping(value = { "/listAll" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void listAll(HttpServletResponse response) throws Exception {
		List<InnovateType> innovateTypeList = innovateTypeService.queryAllInnovateType();
        response.setContentType("text/json;charset=UTF-8"); 
		PrintWriter out = response.getWriter();
		JSONArray jsonArray = new JSONArray();
		for(InnovateType innovateType:innovateTypeList) {
			JSONObject jsonInnovateType = new JSONObject();
			jsonInnovateType.accumulate("innovateTypeId", innovateType.getInnovateTypeId());
			jsonInnovateType.accumulate("innovateTypeName", innovateType.getInnovateTypeName());
			jsonArray.put(jsonInnovateType);
		}
		out.println(jsonArray.toString());
		out.flush();
		out.close();
	}

	/*前台按照查询条件分页查询创新类型信息*/
	@RequestMapping(value = { "/frontlist" }, method = {RequestMethod.GET,RequestMethod.POST})
	public String frontlist(String innovateTypeName,Integer currentPage, Model model, HttpServletRequest request) throws Exception  {
		if (currentPage==null || currentPage == 0) currentPage = 1;
		if (innovateTypeName == null) innovateTypeName = "";
		List<InnovateType> innovateTypeList = innovateTypeService.queryInnovateType(innovateTypeName, currentPage);
	    /*计算总的页数和总的记录数*/
	    innovateTypeService.queryTotalPageAndRecordNumber(innovateTypeName);
	    /*获取到总的页码数目*/
	    int totalPage = innovateTypeService.getTotalPage();
	    /*当前查询条件下总记录数*/
	    int recordNumber = innovateTypeService.getRecordNumber();
	    request.setAttribute("innovateTypeList",  innovateTypeList);
	    request.setAttribute("totalPage", totalPage);
	    request.setAttribute("recordNumber", recordNumber);
	    request.setAttribute("currentPage", currentPage);
	    request.setAttribute("innovateTypeName", innovateTypeName);
		return "InnovateType/innovateType_frontquery_result"; 
	}

     /*前台查询InnovateType信息*/
	@RequestMapping(value="/{innovateTypeId}/frontshow",method=RequestMethod.GET)
	public String frontshow(@PathVariable Integer innovateTypeId,Model model,HttpServletRequest request) throws Exception {
		/*根据主键innovateTypeId获取InnovateType对象*/
        InnovateType innovateType = innovateTypeService.getInnovateType(innovateTypeId);

        request.setAttribute("innovateType",  innovateType);
        return "InnovateType/innovateType_frontshow";
	}

	/*ajax方式显示创新类型修改jsp视图页*/
	@RequestMapping(value="/{innovateTypeId}/update",method=RequestMethod.GET)
	public void update(@PathVariable Integer innovateTypeId,Model model,HttpServletRequest request,HttpServletResponse response) throws Exception {
        /*根据主键innovateTypeId获取InnovateType对象*/
        InnovateType innovateType = innovateTypeService.getInnovateType(innovateTypeId);

        response.setContentType("text/json;charset=UTF-8");
        PrintWriter out = response.getWriter();
		//将要被返回到客户端的对象 
		JSONObject jsonInnovateType = innovateType.getJsonObject();
		out.println(jsonInnovateType.toString());
		out.flush();
		out.close();
	}

	/*ajax方式更新创新类型信息*/
	@RequestMapping(value = "/{innovateTypeId}/update", method = RequestMethod.POST)
	public void update(@Validated InnovateType innovateType, BindingResult br,
			Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
		String message = "";
    	boolean success = false;
		if (br.hasErrors()) { 
			message = "输入的信息有错误！";
			writeJsonResponse(response, success, message);
			return;
		}
		try {
			innovateTypeService.updateInnovateType(innovateType);
			message = "创新类型更新成功!";
			success = true;
			writeJsonResponse(response, success, message);
		} catch (Exception e) {
			e.printStackTrace();
			message = "创新类型更新失败!";
			writeJsonResponse(response, success, message); 
		}
	}
    /*删除创新类型信息*/
	@RequestMapping(value="/{innovateTypeId}/delete",method=RequestMethod.GET)
	public String delete(@PathVariable Integer innovateTypeId,HttpServletRequest request) throws UnsupportedEncodingException {
		  try {
			  innovateTypeService.deleteInnovateType(innovateTypeId);
	            request.setAttribute("message", "创新类型删除成功!");
	            return "message";
	        } catch (Exception e) { 
	            e.printStackTrace();
	            request.setAttribute("error", "创新类型删除失败!");
				return "error";

	        }

	}

	/*ajax方式删除多条创新类型记录*/
	@RequestMapping(value="/deletes",method=RequestMethod.POST)
	public void delete(String innovateTypeIds,HttpServletRequest request,HttpServletResponse response) throws IOException, JSONException {
		String message = "";
    	boolean success = false;
        try { 
        	int count = innovateTypeService.deleteInnovateTypes(innovateTypeIds);
        	success = true;
        	message = count + "条记录删除成功";
        	writeJsonResponse(response, success, message);
        } catch (Exception e) { 
            //e.printStackTrace();
            message = "有记录存在外键约束,删除失败";
            writeJsonResponse(response, success, message);
        }
	}

	/*按照查询条件导出创新类型信息到Excel*/
	@RequestMapping(value = { "/OutToExcel" }, method = {RequestMethod.GET,RequestMethod.POST})
	public void OutToExcel(String innovateTypeName, Model model, HttpServletRequest request,HttpServletResponse response) throws Exception {
        if(innovateTypeName == null) innovateTypeName = "";
        List<InnovateType> innovateTypeList = innovateTypeService.queryInnovateType(innovateTypeName);
        ExportExcelUtil ex = new ExportExcelUtil();
        String _title = "InnovateType信息记录"; 
        String[] headers = { "创新类型id","创新类型名称","实践内容","学分","成绩记载"};
        List<String[]> dataset = new ArrayList<String[]>(); 
        for(int i=0;i<innovateTypeList.size();i++) {
        	InnovateType innovateType = innovateTypeList.get(i); 
        	dataset.add(new String[]{innovateType.getInnovateTypeId() + "",innovateType.getInnovateTypeName(),innovateType.getSjnr(),innovateType.getXuefen() + "",innovateType.getCjjz()});
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
			response.setHeader("Content-disposition","attachment; filename="+"InnovateType.xls");//filename是下载的xls的名，建议最好用英文 
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
