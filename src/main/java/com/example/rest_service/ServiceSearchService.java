package com.example.rest_service;

import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ServiceSearchService {

    private final ServiceSearchRepository serviceSearchRepository;

    public ServiceSearchService(ServiceSearchRepository serviceSearchRepository) {
        this.serviceSearchRepository = serviceSearchRepository;
    }

    public List<ServiceSearchResultDto> findAvailableServices(
            LocalDateTime startDate,
            LocalDateTime endDate,
            String categoryName,
            String specialization,
            String sortBy
    ) {
        return serviceSearchRepository.searchServices(
                startDate, endDate, categoryName, specialization, sortBy
        );
    }
}
