package org.unibl.etf.company.service;

import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.util.Arrays;
import java.util.List;

public class BackendService {
    private static final String BASE_URL = "http://localhost:8080/api";
    private final Client client;
    private static BackendService instance;

    private BackendService() {
        this.client = ClientBuilder.newClient();
    }

    public static synchronized BackendService getInstance() {
        if (instance == null) instance = new BackendService();
        return instance;
    }

    public <T> T get(String endpoint, Class<T> responseType) {
        try {
            return client.target(BASE_URL).path(endpoint)
                    .request(MediaType.APPLICATION_JSON)
                    .get(responseType);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public <T> List<T> getList(String endpoint, Class<T[]> responseArrayType) {
        try {
            T[] array = client.target(BASE_URL).path(endpoint)
                    .request(MediaType.APPLICATION_JSON)
                    .get(responseArrayType);
            return array != null ? Arrays.asList(array) : List.of();
        } catch (Exception e) {
            e.printStackTrace();
            return List.of(); 
        }
    }

    public <T> T post(String endpoint, Object body, Class<T> responseType) {
        try {
            return client.target(BASE_URL).path(endpoint)
                    .request(MediaType.APPLICATION_JSON)
                    .post(Entity.entity(body, MediaType.APPLICATION_JSON), responseType);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }

    public boolean put(String endpoint, Object body) {
        try {
            client.target(BASE_URL).path(endpoint)
                    .request(MediaType.APPLICATION_JSON)
                    .put(Entity.entity(body, MediaType.APPLICATION_JSON));
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean delete(String endpoint) { 
        try {
            client.target(BASE_URL).path(endpoint).request().delete();
            return true;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

  
    public <T> T patch(String endpoint, Object body, Class<T> responseType) {
        try {
            return client.target(BASE_URL).path(endpoint)
                    .request(MediaType.APPLICATION_JSON)
                    .method("PATCH", Entity.entity(body, MediaType.APPLICATION_JSON), responseType);
        } catch (Exception e) {
            e.printStackTrace();
            return null;
        }
    }
}