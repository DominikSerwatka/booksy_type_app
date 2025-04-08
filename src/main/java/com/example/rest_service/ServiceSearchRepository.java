package com.example.rest_service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.BeanPropertyRowMapper;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;
import org.springframework.stereotype.Repository;

import java.sql.Types;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Repository
public class ServiceSearchRepository {

    private final NamedParameterJdbcTemplate namedParameterJdbcTemplate;

    @Autowired
    public ServiceSearchRepository(NamedParameterJdbcTemplate namedParameterJdbcTemplate) {
        this.namedParameterJdbcTemplate = namedParameterJdbcTemplate;
    }

    private static final String BASE_SEARCH_SQL = """
        SELECT 
            s.id AS service_id,
            s.name AS service_name,
            s.price,
            s.duration_minutes,
            e.id AS employee_id,
            e.specialization,
            swd.appointment_start_date_time,
            AVG(r.rating) AS average_rating
        FROM services s
        JOIN service_with_date swd 
            ON swd.service_id = s.id
        JOIN employees e 
            ON e.id = swd.employee_id
        LEFT JOIN reviews r 
            ON r.service_id = s.id
        LEFT JOIN services_categories sc
            ON sc.service_id = s.id
        LEFT JOIN categories c
            ON c.id = sc.category_id
        WHERE
            swd.appointment_start_date_time BETWEEN :startDate AND :endDate
            AND (
              :categoryName IS NULL OR c.name = :categoryName
            )
            AND (
              :specialization IS NULL OR e.specialization = :specialization
            )
            AND swd.id NOT IN (
                SELECT service_with_date_id
                FROM appointments
                WHERE status IN ('confirmed', 'pending')
            )
        GROUP BY 
            s.id, 
            s.name, 
            s.price,
            s.duration_minutes,
            e.id, 
            e.specialization, 
            swd.appointment_start_date_time
        """;

    private static final String ORDER_BY = """
        ORDER BY
            CASE 
                WHEN :sortBy = 'price' THEN s.price
                ELSE NULL
            END ASC,
            CASE 
                WHEN :sortBy = 'rating' THEN AVG(r.rating)
                ELSE NULL
            END DESC
        """;


    public List<ServiceSearchResultDto> searchServices(
            LocalDateTime startDate,
            LocalDateTime endDate,
            String categoryName,
            String specialization,
            String sortBy
    ) {
        MapSqlParameterSource params = new MapSqlParameterSource();
        params.addValue("startDate", startDate);
        params.addValue("endDate", endDate);

        params.addValue("categoryName", categoryName, Types.VARCHAR);
        params.addValue("specialization", specialization, Types.VARCHAR);
        params.addValue("sortBy", sortBy, Types.VARCHAR);

        String finalQuery = BASE_SEARCH_SQL + "\n" + ORDER_BY;

        return namedParameterJdbcTemplate.query(
                finalQuery,
                params,
                new ServiceSearchResultRowMapper()
        );

    }
}
