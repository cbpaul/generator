package ${basepackage}.controller;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.fasterxml.jackson.databind.ObjectMapper;

import ${basepackage}.utils.ObjectUtils;
import ${basepackage}.utils.ServiceUtils;


public class QueryPage {

	private Integer displayStart = 0;// 开始数据下标
	private Integer displayLength = 0;// 查询数据长度
	private Integer dsplayPageNumber = 0;// 开始查询数据页数
	private Integer sEcho = 0;
	private Map<String, Object> paramMap;// 用户查询条件

	public QueryPage() {
	}

	/**
	 * 
	 * @param aoData
	 *            分页数据(必填)
	 * @param userData
	 *            用户查询条件
	 */
	@SuppressWarnings("unchecked")
	public QueryPage(String aoData, String userData) {
		try {
			if (ObjectUtils.isNotEmpty(aoData)) {
				ObjectMapper objectMapper = new ObjectMapper();
				// 解析分页参数
				List<HashMap<String, Object>> aoDataList = objectMapper
						.readValue(aoData, List.class);
				for (HashMap<String, Object> map : aoDataList) {
					if ("sEcho".equals(map.get("name"))) {
						setsEcho(ObjectUtils.toInteger(map.get("value")));
					}
					if ("iDisplayStart".equals(map.get("name"))) {
						setDisplayStart(ObjectUtils.toInteger(map.get("value")));
					}
					if ("iDisplayLength".equals(map.get("name"))) {
						setDisplayLength(ObjectUtils
								.toInteger(map.get("value")));
					}
				}
				if (ObjectUtils.isNotEmpty(userData)) {
					// 解析用户查询条件
					Map<String, Object> userDataMap = objectMapper.readValue(
							userData, Map.class);
					setParamMap(userDataMap);
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	/**
	 * 输出分页查询数据
	 * 
	 * @param writer
	 * @param aaData
	 *            查询出的分页数据
	 * @param totalData
	 *            总共数据量
	 */
	public void writePageData(Writer writer, Object aaData, long totalData) {
		ObjectMapper objectMapper = new ObjectMapper();
		try {
			String json = "{\"sEcho\":" + this.sEcho + ",\"iTotalRecords\":"
					+ totalData + ",\"iTotalDisplayRecords\":" + totalData
					+ ",\"aaData\":" + objectMapper.writeValueAsString(aaData)
					+ "}";
			ServiceUtils.writer(writer, json);
		} catch (Exception e) {
			e.printStackTrace();
			ServiceUtils
					.writer(writer,
							"{\"sEcho\":1,\"iTotalRecords\":0,\"iTotalDisplayRecords\":0,\"aaData\":[]}");
		}
	}

	/**
	 * 通过参数名获取参数值
	 * 
	 * @param paramName
	 *            参数名称
	 * @return 参数值
	 */
	public Object getUserParamBName(String paramName) {
		if (ObjectUtils.isNotEmpty(this.paramMap)) {
			return this.paramMap.get(paramName);
		}
		return null;
	}

	public Integer getDisplayStart() {
		return displayStart;
	}

	public void setDisplayStart(Integer displayStart) {
		this.displayStart = displayStart;
		if (displayStart != null && this.displayLength != null
				&& this.displayLength != 0) {
			setDsplayPageNumber(displayStart / displayLength);
		}
	}

	public Integer getDisplayLength() {
		return displayLength;
	}

	public void setDisplayLength(Integer displayLength) {
		this.displayLength = displayLength;
		if (this.displayStart != null && displayLength != null
				&& displayLength != 0) {
			setDsplayPageNumber(this.displayStart / displayLength);
		}
	}

	public Integer getDsplayPageNumber() {
		return dsplayPageNumber;
	}

	public void setDsplayPageNumber(Integer dsplayPageNumber) {
		this.dsplayPageNumber = dsplayPageNumber;
	}

	public Integer getsEcho() {
		return sEcho;
	}

	public void setsEcho(Integer sEcho) {
		this.sEcho = sEcho;
	}

	public Map<String, Object> getParamMap() {
		return paramMap;
	}

	public void setParamMap(Map<String, Object> paramMap) {
		this.paramMap = paramMap;
	}

}
