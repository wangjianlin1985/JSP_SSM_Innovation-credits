package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class Innovate {
    /*创新记录id*/
    private Integer innovateId;
    public Integer getInnovateId(){
        return innovateId;
    }
    public void setInnovateId(Integer innovateId){
        this.innovateId = innovateId;
    }

    /*创新类型*/
    private InnovateType innovateTypeObj;
    public InnovateType getInnovateTypeObj() {
        return innovateTypeObj;
    }
    public void setInnovateTypeObj(InnovateType innovateTypeObj) {
        this.innovateTypeObj = innovateTypeObj;
    }

    /*创新项目标题*/
    @NotEmpty(message="创新项目标题不能为空")
    private String innovateTitle;
    public String getInnovateTitle() {
        return innovateTitle;
    }
    public void setInnovateTitle(String innovateTitle) {
        this.innovateTitle = innovateTitle;
    }

    /*创新项目描述*/
    @NotEmpty(message="创新项目描述不能为空")
    private String innovateContent;
    public String getInnovateContent() {
        return innovateContent;
    }
    public void setInnovateContent(String innovateContent) {
        this.innovateContent = innovateContent;
    }

    /*创新项目文件*/
    private String innovateFile;
    public String getInnovateFile() {
        return innovateFile;
    }
    public void setInnovateFile(String innovateFile) {
        this.innovateFile = innovateFile;
    }

    /*申请创新学分*/
    @NotNull(message="必须输入申请创新学分")
    private Float innovateScore;
    public Float getInnovateScore() {
        return innovateScore;
    }
    public void setInnovateScore(Float innovateScore) {
        this.innovateScore = innovateScore;
    }

    /*申请的学生*/
    private Student studentObj;
    public Student getStudentObj() {
        return studentObj;
    }
    public void setStudentObj(Student studentObj) {
        this.studentObj = studentObj;
    }

    /*申请时间*/
    @NotEmpty(message="申请时间不能为空")
    private String sqTime;
    public String getSqTime() {
        return sqTime;
    }
    public void setSqTime(String sqTime) {
        this.sqTime = sqTime;
    }

    /*审核状态*/
    @NotEmpty(message="审核状态不能为空")
    private String shenHeState;
    public String getShenHeState() {
        return shenHeState;
    }
    public void setShenHeState(String shenHeState) {
        this.shenHeState = shenHeState;
    }

    /*创新项目成绩*/
    @NotEmpty(message="创新项目成绩不能为空")
    private String innovateChengji;
    public String getInnovateChengji() {
        return innovateChengji;
    }
    public void setInnovateChengji(String innovateChengji) {
        this.innovateChengji = innovateChengji;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonInnovate=new JSONObject(); 
		jsonInnovate.accumulate("innovateId", this.getInnovateId());
		jsonInnovate.accumulate("innovateTypeObj", this.getInnovateTypeObj().getInnovateTypeName());
		jsonInnovate.accumulate("innovateTypeObjPri", this.getInnovateTypeObj().getInnovateTypeId());
		jsonInnovate.accumulate("innovateTitle", this.getInnovateTitle());
		jsonInnovate.accumulate("innovateContent", this.getInnovateContent());
		jsonInnovate.accumulate("innovateFile", this.getInnovateFile());
		jsonInnovate.accumulate("innovateScore", this.getInnovateScore());
		jsonInnovate.accumulate("studentObj", this.getStudentObj().getName());
		jsonInnovate.accumulate("studentObjPri", this.getStudentObj().getUser_name());
		jsonInnovate.accumulate("sqTime", this.getSqTime().length()>19?this.getSqTime().substring(0,19):this.getSqTime());
		jsonInnovate.accumulate("shenHeState", this.getShenHeState());
		jsonInnovate.accumulate("innovateChengji", this.getInnovateChengji());
		return jsonInnovate;
    }}