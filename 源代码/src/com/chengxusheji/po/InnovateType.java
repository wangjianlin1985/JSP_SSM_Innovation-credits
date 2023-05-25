package com.chengxusheji.po;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.NotEmpty;
import org.json.JSONException;
import org.json.JSONObject;

public class InnovateType {
    /*创新类型id*/
    private Integer innovateTypeId;
    public Integer getInnovateTypeId(){
        return innovateTypeId;
    }
    public void setInnovateTypeId(Integer innovateTypeId){
        this.innovateTypeId = innovateTypeId;
    }

    /*创新类型名称*/
    @NotEmpty(message="创新类型名称不能为空")
    private String innovateTypeName;
    public String getInnovateTypeName() {
        return innovateTypeName;
    }
    public void setInnovateTypeName(String innovateTypeName) {
        this.innovateTypeName = innovateTypeName;
    }

    /*实践内容*/
    @NotEmpty(message="实践内容不能为空")
    private String sjnr;
    public String getSjnr() {
        return sjnr;
    }
    public void setSjnr(String sjnr) {
        this.sjnr = sjnr;
    }

    /*学分*/
    @NotNull(message="必须输入学分")
    private Float xuefen;
    public Float getXuefen() {
        return xuefen;
    }
    public void setXuefen(Float xuefen) {
        this.xuefen = xuefen;
    }

    /*成绩记载*/
    @NotEmpty(message="成绩记载不能为空")
    private String cjjz;
    public String getCjjz() {
        return cjjz;
    }
    public void setCjjz(String cjjz) {
        this.cjjz = cjjz;
    }

    public JSONObject getJsonObject() throws JSONException {
    	JSONObject jsonInnovateType=new JSONObject(); 
		jsonInnovateType.accumulate("innovateTypeId", this.getInnovateTypeId());
		jsonInnovateType.accumulate("innovateTypeName", this.getInnovateTypeName());
		jsonInnovateType.accumulate("sjnr", this.getSjnr());
		jsonInnovateType.accumulate("xuefen", this.getXuefen());
		jsonInnovateType.accumulate("cjjz", this.getCjjz());
		return jsonInnovateType;
    }}