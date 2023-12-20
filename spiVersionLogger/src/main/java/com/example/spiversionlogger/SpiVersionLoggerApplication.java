package com.example.spiversionlogger;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;

@SpringBootApplication
@EnableJpaRepositories("com.example.spiversionlogger.repo")
public class SpiVersionLoggerApplication {

    public static void main(String[] args) {
        SpringApplication.run(SpiVersionLoggerApplication.class, args);
    }

}
