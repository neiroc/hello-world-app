package main

import (
    "io" // Import the io package
    "net/http"
    "net/http/httptest"
    "testing"
)

func TestHelloWorldHandler(t *testing.T) {
    req := httptest.NewRequest("GET", "/", nil)
    w := httptest.NewRecorder()
    helloWorldHandler(w, req)

    res := w.Result()
    if res.StatusCode != http.StatusOK {
        t.Errorf("expected status OK; got %v", res.Status)
    }
    // Check body content
    body, _ := io.ReadAll(res.Body)
    if string(body) != "Hello, World! This is a test. Number 1" {
        t.Errorf("expected body 'Hello, World!'; got '%s'", string(body))
    }
}
