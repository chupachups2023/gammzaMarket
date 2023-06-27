package com.gammza.chupachups.common.typehandler;

import static org.springframework.test.web.servlet.result.MockMvcResultMatchers.model;

import java.sql.CallableStatement;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import org.apache.ibatis.type.BaseTypeHandler;
import org.apache.ibatis.type.JdbcType;
import org.apache.ibatis.type.MappedJdbcTypes;
import org.apache.ibatis.type.MappedTypes;

@MappedTypes(String[].class) // java type이 String배열을 DB type인 varchar2로 바꾸기
@MappedJdbcTypes(JdbcType.VARCHAR) // DB type인 varchar2를 java type의 String배열로 바꿀때
public class StringArrayTypeHandler extends BaseTypeHandler<String[]> {

	/*
		java객체 -> PreparedStatement값 대입
	  - setter
	  
		ResultSet -> java객체
	*/
	@Override
	public void setNonNullParameter(PreparedStatement ps, int i, String[] parameter, JdbcType jdbcType)
			throws SQLException {
		// ["java", "c", "python"] => "java, c, python"
		String value = String.join(",", parameter);
		ps.setString(i, value);		

	}

	@Override
	public String[] getNullableResult(ResultSet rs, String columnName) throws SQLException {
		String value = rs.getString(columnName);
		return value != null ? value.split(",") : null; // value가 null이 아니면 split을 이용해 ','를 기준으로 나눈다. null이 들어오면 null을 넣어준다.
	}

	@Override
	public String[] getNullableResult(ResultSet rs, int columnIndex) throws SQLException {
		String value = rs.getString(columnIndex);
		return value != null ? value.split(",") : null;
	}

	@Override
	public String[] getNullableResult(CallableStatement cs, int columnIndex) throws SQLException {
		String value = cs.getString(columnIndex);
		return value != null ? value.split(",") : null;
		
	}
	 
}
