package com.example.spiversionlogger.model;


import javax.persistence.Entity;
import javax.persistence.Id;
import lombok.Builder;
import lombok.Data;
import lombok.ToString;

@Entity
@Data
@Builder
@ToString
public class ConnectorVersionWithPath {
    @Id
    private String flinkVersion;
    private String s3Path;
}
