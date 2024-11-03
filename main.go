package main

import (
    "fmt"
    "net/http"
)

func helloWorldHandler(w http.ResponseWriter, r *http.Request) {
    fmt.Fprintf(w, "Hello, World! This is a test. Number 5")
}

func main() {
    http.HandleFunc("/", helloWorldHandler)

    fmt.Println("Server is listening on port 8080...")
    if err := http.ListenAndServe(":8080", nil); err != nil {
        fmt.Println("Error starting server:", err)
    }
}
