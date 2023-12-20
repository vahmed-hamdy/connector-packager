package com.example.spiversionlogger.model;

import lombok.Data;
import lombok.Getter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Data
@ConfigurationProperties(prefix = "image-props")
@Configuration
public class ImageVersion {
    private String version;
}
