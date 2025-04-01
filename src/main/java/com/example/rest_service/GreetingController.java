package com.example.rest_service;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.concurrent.atomic.AtomicLong;

@RestController
public class GreetingController {

    private static final String template = "Hello, %s!";
    private final AtomicLong counter = new AtomicLong();

    public String select = """ 
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
                    -- 1) przedział czasowy
                    swd.appointment_start_date_time BETWEEN :startDate AND :endDate
                    
                    -- 2) filtr po kategorii (opcjonalny)
                    AND (
                      :categoryName IS NULL 
                      OR c.name = :categoryName
                    )
                    
                    -- 3) filtr po specjalizacji (opcjonalny)
                    AND (
                      :specialization IS NULL
                      OR e.specialization = :specialization
                    )
                    
                    -- 4) wykluczenie już zajętych terminów
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
                ORDER BY
                    CASE 
                        WHEN :sortBy = 'price' THEN s.price
                        ELSE NULL
                    END ASC,  -- sortowanie rosnąco po cenie, jeśli :sortBy='price'
                
                    CASE 
                        WHEN :sortBy = 'rating' THEN AVG(r.rating)
                        ELSE NULL
                    END DESC; -- sortowanie malejąco po średniej ocenie, jeśli :sortBy='rating'

            """;

    @GetMapping("/greeting")
    public Greeting gretting(@RequestParam(value = "name", defaultValue = "World") String name) {

        System.out.println("CHECK gretting was called");
        return new Greeting(counter.incrementAndGet(), String.format(template, name));
    }
}
