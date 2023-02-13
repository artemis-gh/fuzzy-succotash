package main

import (
	"fmt"
	"net/http"
	"os"

	"github.com/gin-gonic/gin"
)

func main() {

	r := gin.Default()

	r.Handle(http.MethodGet, "/", func(ctx *gin.Context) {
		ctx.JSON(http.StatusOK, struct {
			Status  string
			Message string
		}{Status: "2000", Message: "Hello world"})
	})

	httpPort := os.Getenv("HTTP_PORT")
	if httpPort == "" {
		fmt.Println("No HTTP_PORT found, so switching to default HTTP port 8080...")
		httpPort = "8080"
	}

	fmt.Println("Listening and serving at", httpPort, "...")
	r.Run(":" + httpPort)

}
