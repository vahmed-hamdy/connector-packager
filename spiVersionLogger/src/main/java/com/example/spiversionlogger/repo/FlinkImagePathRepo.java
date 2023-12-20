package com.example.spiversionlogger.repo;

import com.example.spiversionlogger.model.ConnectorVersionWithPath;
import org.springframework.stereotype.Repository;

import java.util.HashMap;

@Repository
public class FlinkImagePathRepo {

    private HashMap<String, ConnectorVersionWithPath> map = new HashMap<>();

    public FlinkImagePathRepo() {
        map.put("1.12", ConnectorVersionWithPath.builder().flinkVersion("1.12").s3Path("s3:blalba").build());
    }

    public ConnectorVersionWithPath getOne(String id) {
        return map.get(id);
    }

    public void saveAndFlush(ConnectorVersionWithPath connectorVersionWithPath) {
        map.put(connectorVersionWithPath.getFlinkVersion(), connectorVersionWithPath);
    }
}
