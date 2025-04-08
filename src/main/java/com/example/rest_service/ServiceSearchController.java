package com.example.rest_service;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;

@RestController
class ServiceSearchController {

    private final ServiceSearchService serviceSearchService;

    public ServiceSearchController(ServiceSearchService serviceSearchService) {
        this.serviceSearchService = serviceSearchService;
    }

    @GetMapping("/api/services/available")
    public List<ServiceSearchResultDto> getAvailableServices(
            @RequestParam String startDate,
            @RequestParam String endDate,
            @RequestParam(required = false) String categoryName,
            @RequestParam(required = false) String specialization,
            @RequestParam(defaultValue = "price") String sortBy
    ) {

        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        LocalDateTime start = LocalDateTime.parse(startDate, formatter);
        LocalDateTime end = LocalDateTime.parse(endDate, formatter);

        return serviceSearchService.findAvailableServices(
                start, end, categoryName, specialization, sortBy
        );
    }
}