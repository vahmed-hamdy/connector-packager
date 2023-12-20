package com.example.spiversionlogger.service;

import com.example.spiversionlogger.exception.NotFoundException;
import com.example.spiversionlogger.model.ConnectorVersionWithPath;
import com.example.spiversionlogger.model.ImageVersion;
import com.example.spiversionlogger.repo.FlinkImagePathRepo;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Component;

import java.util.Optional;

@Component
@AllArgsConstructor
public class VersionService {

    private ImageVersion version;

    private FlinkImagePathRepo flinkImagePathRepo;

    public String getImageVersion() {
        return version.getVersion();
    }

    public String getConnectorIdentifiers(final String flinkImageId) {
        return Optional.ofNullable(flinkImagePathRepo.getOne(flinkImageId)).map(ConnectorVersionWithPath::getS3Path)
                .orElseThrow(NotFoundException::new);
    }

    public void setConnectorId(final ConnectorVersionWithPath versionWithPath) {
        flinkImagePathRepo.saveAndFlush(versionWithPath);
    }
}
