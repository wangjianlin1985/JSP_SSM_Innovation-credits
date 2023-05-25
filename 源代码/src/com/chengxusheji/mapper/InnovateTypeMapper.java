package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.InnovateType;

public interface InnovateTypeMapper {
	/*添加创新类型信息*/
	public void addInnovateType(InnovateType innovateType) throws Exception;

	/*按照查询条件分页查询创新类型记录*/
	public ArrayList<InnovateType> queryInnovateType(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有创新类型记录*/
	public ArrayList<InnovateType> queryInnovateTypeList(@Param("where") String where) throws Exception;

	/*按照查询条件的创新类型记录数*/
	public int queryInnovateTypeCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条创新类型记录*/
	public InnovateType getInnovateType(int innovateTypeId) throws Exception;

	/*更新创新类型记录*/
	public void updateInnovateType(InnovateType innovateType) throws Exception;

	/*删除创新类型记录*/
	public void deleteInnovateType(int innovateTypeId) throws Exception;

}
