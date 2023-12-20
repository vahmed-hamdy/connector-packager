package com.example.spiversionlogger.controller;


import com.example.spiversionlogger.model.ConnectorVersionWithPath;
import com.example.spiversionlogger.service.VersionService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;

@RestController
@AllArgsConstructor
@RequestMapping("/version")
@Slf4j
public class VersionController {

    private final VersionService service;
    @GetMapping(value = "/image")
    @ResponseStatus(HttpStatus.OK)
    public String getImageVersion(){
        return service.getImageVersion();
    }
    @GetMapping(value = "/connectors/{flinkImageId}")
    @ResponseStatus(HttpStatus.OK)
    public String getConnectorsVersions(@PathVariable String flinkImageId){
        return service.getConnectorIdentifiers(flinkImageId);
    }

    @PostMapping(value = "/connectors/{flinkImageId}")
    @ResponseStatus(HttpStatus.CREATED)
    public void setConnectorsVersions(@PathVariable String flinkImageId, @RequestBody String s3Path){
        service.setConnectorId(ConnectorVersionWithPath.builder().flinkVersion(flinkImageId).s3Path(s3Path).build());
    }

    @GetMapping(value = "/healthz")
    @ResponseStatus(HttpStatus.OK)
    public void healthProbe(){

    }
}
