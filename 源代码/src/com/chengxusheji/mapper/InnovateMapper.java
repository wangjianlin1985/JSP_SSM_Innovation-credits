package com.chengxusheji.mapper;

import java.util.ArrayList;
import org.apache.ibatis.annotations.Param;
import com.chengxusheji.po.Innovate;

public interface InnovateMapper {
	/*添加学生创新信息*/
	public void addInnovate(Innovate innovate) throws Exception;

	/*按照查询条件分页查询学生创新记录*/
	public ArrayList<Innovate> queryInnovate(@Param("where") String where,@Param("startIndex") int startIndex,@Param("pageSize") int pageSize) throws Exception;

	/*按照查询条件查询所有学生创新记录*/
	public ArrayList<Innovate> queryInnovateList(@Param("where") String where) throws Exception;

	/*按照查询条件的学生创新记录数*/
	public int queryInnovateCount(@Param("where") String where) throws Exception; 

	/*根据主键查询某条学生创新记录*/
	public Innovate getInnovate(int innovateId) throws Exception;

	/*更新学生创新记录*/
	public void updateInnovate(Innovate innovate) throws Exception;

	/*删除学生创新记录*/
	public void deleteInnovate(int innovateId) throws Exception;

}
