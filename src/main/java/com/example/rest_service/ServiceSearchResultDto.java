package com.example.rest_service;

import java.math.BigDecimal;
import java.time.LocalDateTime;

public record ServiceSearchResultDto(
        Long serviceId,
        String serviceName,
        BigDecimal price,
        Integer durationMinutes,
        Long employeeId,
        String specialization,
        LocalDateTime appointmentStartDateTime,
        Double averageRating
) {}
