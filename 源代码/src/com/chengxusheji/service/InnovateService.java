package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.InnovateType;
import com.chengxusheji.po.Student;
import com.chengxusheji.po.Innovate;

import com.chengxusheji.mapper.InnovateMapper;
@Service
public class InnovateService {

	@Resource InnovateMapper innovateMapper;
    /*每页显示记录数目*/
    private int rows = 10;;
    public int getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
	}

    /*保存查询后总的页数*/
    private int totalPage;
    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
    public int getTotalPage() {
        return totalPage;
    }

    /*保存查询到的总记录数*/
    private int recordNumber;
    public void setRecordNumber(int recordNumber) {
        this.recordNumber = recordNumber;
    }
    public int getRecordNumber() {
        return recordNumber;
    }

    /*添加学生创新记录*/
    public void addInnovate(Innovate innovate) throws Exception {
    	innovateMapper.addInnovate(innovate);
    }

    /*按照查询条件分页查询学生创新记录*/
    public ArrayList<Innovate> queryInnovate(InnovateType innovateTypeObj,String innovateTitle,Student studentObj,String sqTime,String shenHeState,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(null != innovateTypeObj && innovateTypeObj.getInnovateTypeId()!= null && innovateTypeObj.getInnovateTypeId()!= 0)  where += " and t_innovate.innovateTypeObj=" + innovateTypeObj.getInnovateTypeId();
    	if(!innovateTitle.equals("")) where = where + " and t_innovate.innovateTitle like '%" + innovateTitle + "%'";
    	if(null != studentObj &&  studentObj.getUser_name() != null  && !studentObj.getUser_name().equals(""))  where += " and t_innovate.studentObj='" + studentObj.getUser_name() + "'";
    	if(!sqTime.equals("")) where = where + " and t_innovate.sqTime like '%" + sqTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_innovate.shenHeState like '%" + shenHeState + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return innovateMapper.queryInnovate(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<Innovate> queryInnovate(InnovateType innovateTypeObj,String innovateTitle,Student studentObj,String sqTime,String shenHeState) throws Exception  { 
     	String where = "where 1=1";
    	if(null != innovateTypeObj && innovateTypeObj.getInnovateTypeId()!= null && innovateTypeObj.getInnovateTypeId()!= 0)  where += " and t_innovate.innovateTypeObj=" + innovateTypeObj.getInnovateTypeId();
    	if(!innovateTitle.equals("")) where = where + " and t_innovate.innovateTitle like '%" + innovateTitle + "%'";
    	if(null != studentObj &&  studentObj.getUser_name() != null && !studentObj.getUser_name().equals(""))  where += " and t_innovate.studentObj='" + studentObj.getUser_name() + "'";
    	if(!sqTime.equals("")) where = where + " and t_innovate.sqTime like '%" + sqTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_innovate.shenHeState like '%" + shenHeState + "%'";
    	return innovateMapper.queryInnovateList(where);
    }

    /*查询所有学生创新记录*/
    public ArrayList<Innovate> queryAllInnovate()  throws Exception {
        return innovateMapper.queryInnovateList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(InnovateType innovateTypeObj,String innovateTitle,Student studentObj,String sqTime,String shenHeState) throws Exception {
     	String where = "where 1=1";
    	if(null != innovateTypeObj && innovateTypeObj.getInnovateTypeId()!= null && innovateTypeObj.getInnovateTypeId()!= 0)  where += " and t_innovate.innovateTypeObj=" + innovateTypeObj.getInnovateTypeId();
    	if(!innovateTitle.equals("")) where = where + " and t_innovate.innovateTitle like '%" + innovateTitle + "%'";
    	if(null != studentObj &&  studentObj.getUser_name() != null && !studentObj.getUser_name().equals(""))  where += " and t_innovate.studentObj='" + studentObj.getUser_name() + "'";
    	if(!sqTime.equals("")) where = where + " and t_innovate.sqTime like '%" + sqTime + "%'";
    	if(!shenHeState.equals("")) where = where + " and t_innovate.shenHeState like '%" + shenHeState + "%'";
        recordNumber = innovateMapper.queryInnovateCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取学生创新记录*/
    public Innovate getInnovate(int innovateId) throws Exception  {
        Innovate innovate = innovateMapper.getInnovate(innovateId);
        return innovate;
    }

    /*更新学生创新记录*/
    public void updateInnovate(Innovate innovate) throws Exception {
        innovateMapper.updateInnovate(innovate);
    }

    /*删除一条学生创新记录*/
    public void deleteInnovate (int innovateId) throws Exception {
        innovateMapper.deleteInnovate(innovateId);
    }

    /*删除多条学生创新信息*/
    public int deleteInnovates (String innovateIds) throws Exception {
    	String _innovateIds[] = innovateIds.split(",");
    	for(String _innovateId: _innovateIds) {
    		innovateMapper.deleteInnovate(Integer.parseInt(_innovateId));
    	}
    	return _innovateIds.length;
    }
}
