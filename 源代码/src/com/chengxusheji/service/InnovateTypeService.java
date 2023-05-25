package com.chengxusheji.service;

import java.util.ArrayList;
import javax.annotation.Resource; 
import org.springframework.stereotype.Service;
import com.chengxusheji.po.InnovateType;

import com.chengxusheji.mapper.InnovateTypeMapper;
@Service
public class InnovateTypeService {

	@Resource InnovateTypeMapper innovateTypeMapper;
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

    /*添加创新类型记录*/
    public void addInnovateType(InnovateType innovateType) throws Exception {
    	innovateTypeMapper.addInnovateType(innovateType);
    }

    /*按照查询条件分页查询创新类型记录*/
    public ArrayList<InnovateType> queryInnovateType(String innovateTypeName,int currentPage) throws Exception { 
     	String where = "where 1=1";
    	if(!innovateTypeName.equals("")) where = where + " and t_innovateType.innovateTypeName like '%" + innovateTypeName + "%'";
    	int startIndex = (currentPage-1) * this.rows;
    	return innovateTypeMapper.queryInnovateType(where, startIndex, this.rows);
    }

    /*按照查询条件查询所有记录*/
    public ArrayList<InnovateType> queryInnovateType(String innovateTypeName) throws Exception  { 
     	String where = "where 1=1";
    	if(!innovateTypeName.equals("")) where = where + " and t_innovateType.innovateTypeName like '%" + innovateTypeName + "%'";
    	return innovateTypeMapper.queryInnovateTypeList(where);
    }

    /*查询所有创新类型记录*/
    public ArrayList<InnovateType> queryAllInnovateType()  throws Exception {
        return innovateTypeMapper.queryInnovateTypeList("where 1=1");
    }

    /*当前查询条件下计算总的页数和记录数*/
    public void queryTotalPageAndRecordNumber(String innovateTypeName) throws Exception {
     	String where = "where 1=1";
    	if(!innovateTypeName.equals("")) where = where + " and t_innovateType.innovateTypeName like '%" + innovateTypeName + "%'";
        recordNumber = innovateTypeMapper.queryInnovateTypeCount(where);
        int mod = recordNumber % this.rows;
        totalPage = recordNumber / this.rows;
        if(mod != 0) totalPage++;
    }

    /*根据主键获取创新类型记录*/
    public InnovateType getInnovateType(int innovateTypeId) throws Exception  {
        InnovateType innovateType = innovateTypeMapper.getInnovateType(innovateTypeId);
        return innovateType;
    }

    /*更新创新类型记录*/
    public void updateInnovateType(InnovateType innovateType) throws Exception {
        innovateTypeMapper.updateInnovateType(innovateType);
    }

    /*删除一条创新类型记录*/
    public void deleteInnovateType (int innovateTypeId) throws Exception {
        innovateTypeMapper.deleteInnovateType(innovateTypeId);
    }

    /*删除多条创新类型信息*/
    public int deleteInnovateTypes (String innovateTypeIds) throws Exception {
    	String _innovateTypeIds[] = innovateTypeIds.split(",");
    	for(String _innovateTypeId: _innovateTypeIds) {
    		innovateTypeMapper.deleteInnovateType(Integer.parseInt(_innovateTypeId));
    	}
    	return _innovateTypeIds.length;
    }
}
