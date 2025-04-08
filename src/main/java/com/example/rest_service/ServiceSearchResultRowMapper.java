package com.example.rest_service;

import org.springframework.jdbc.core.RowMapper;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ServiceSearchResultRowMapper implements RowMapper<ServiceSearchResultDto> {
    @Override
    public ServiceSearchResultDto mapRow(ResultSet rs, int rowNum) throws SQLException {
        return new ServiceSearchResultDto(
                rs.getLong("service_id"),
                rs.getString("service_name"),
                rs.getBigDecimal("price"),
                rs.getInt("duration_minutes"),
                rs.getLong("employee_id"),
                rs.getString("specialization"),
                rs.getTimestamp("appointment_start_date_time").toLocalDateTime(),
                rs.getDouble("average_rating")
        );
    }
}