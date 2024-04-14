package main

import (
	"fog-forcast-server/config"
	"fog-forcast-server/lib"
	"fog-forcast-server/model"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func main() {
	config := lib.LoadConfig[config.Config]()
	db := lib.NewDB(&config.DatabaseConfig, func(db *gorm.DB) error {
		return db.AutoMigrate(&model.City{}, &model.Weather{})
	})

	router := gin.Default()
	apiRouter := router.Group("/api/v1")
	apiRouter.GET("/city", lib.GetAll[model.City](db, nil))
	apiRouter.POST("/city/by_pos", handleGetCityByPos(db, config))
	apiRouter.POST("/weather/by_city", handleGetWeather("city", config))
	apiRouter.POST("/weather/by_pos", handleGetWeather("pos", config))
	apiRouter.POST("/aqi/by_pos", handleGetAQIByPos(config))
	router.Run(config.Server.Port)
}
