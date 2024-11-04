package main

import (
    "net/http"
    "net/http/httptest"
    "os"
    "testing"
)

func TestHelloWorldHandler(t *testing.T) {
    // Set the environment variable for the test
    os.Setenv("API_KEY", "test_secret_value")
    defer os.Unsetenv("API_KEY") // Clean up after the test

    // Create a request to pass to the handler
    req, err := http.NewRequest("GET", "/", nil)
    if err != nil {
        t.Fatal(err)
    }

    // Record the response
    rr := httptest.NewRecorder()
    handler := http.HandlerFunc(helloWorldHandler)

    // Serve the request
    handler.ServeHTTP(rr, req)

    // Check the status code
    if status := rr.Code; status != http.StatusOK {
        t.Errorf("Handler returned wrong status code: got %v want %v", status, http.StatusOK)
    }

    // Check the response body
    expected := "Hello, World! Test 1. Secret value is: test_secret_value"
    if rr.Body.String() != expected {
        t.Errorf("Handler returned unexpected body: got %v want %v", rr.Body.String(), expected)
    }
}
