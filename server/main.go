package main

import (
	"fog-forcast-server/config"
	"fog-forcast-server/lib"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func main() {
	config := lib.LoadConfig[config.Config]()
	db := lib.NewDB(&config.DatabaseConfig, func(db *gorm.DB) error {
		return db.AutoMigrate()
	})

	router := gin.Default()
	api := router.Group("/api/v1")
	lib.AddLoginAPI(api, "/login", db)
	lib.AddStatic(router, []string{"./dist"})
	router.Run(config.Server.Port)
}
