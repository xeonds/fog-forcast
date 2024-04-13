package main

import (
	"fog-forcast-server/config"
	"fog-forcast-server/model"
	"fog-forcast-server/service"
	"net/http"

	"github.com/gin-gonic/gin"
	"gorm.io/gorm"
)

func handleGetWeather(mode string, config *config.Config) gin.HandlerFunc {
	return func(c *gin.Context) {
		switch mode {
		case "city":
			lat := c.Query("lat")
			lon := c.Query("lon")
			weather, err := service.GetWeatherByPos(lat, lon, config.OpenWeatherKey)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			} else {
				c.JSON(http.StatusOK, weather)
			}
		case "pos":
			city := c.Query("city")
			weather, err := service.GetWeatherByCityId(city, config.OpenWeatherKey)
			if err != nil {
				c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
			} else {
				c.JSON(http.StatusOK, weather)
			}
		}
	}
}

func handleGetCityByPos(db *gorm.DB, config *config.Config) gin.HandlerFunc {
	return func(c *gin.Context) {
		request := new(struct {
			Lat float64 `json:"lat"`
			Lon float64 `json:"lon"`
		})
		if err := c.ShouldBindJSON(request); err != nil {
			c.JSON(http.StatusBadRequest, gin.H{"error": err.Error()})
			return
		}
		name, err := service.GetCityName(request.Lat, request.Lon, config.OpenWeatherKey)
		if err != nil {
			c.JSON(http.StatusInternalServerError, gin.H{"error": err.Error()})
		} else {
			db.Create(&model.City{Name: name, Lat: request.Lat, Lon: request.Lon})
			c.JSON(http.StatusOK, gin.H{"name": name})
		}
	}
}
