package main

import (
    "fmt"
    "net/http"
    "os"
)

func helloWorldHandler(w http.ResponseWriter, r *http.Request) {
    secretValue := os.Getenv("API_KEY")
    fmt.Fprintf(w, "Hello, World! Test 2. Secret value is: %s", secretValue)
}

func main() {
    http.HandleFunc("/", helloWorldHandler)

    fmt.Println("Server is listening on port 8080...")
    if err := http.ListenAndServe(":8080", nil); err != nil {
        fmt.Println("Error starting server:", err)
    }
}
