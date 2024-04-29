package service

import (
	"encoding/json"
	"fmt"
	"fog-forcast-server/model"
	"net/http"
	"time"
)

const (
	airQualityUrl = "https://api.openweathermap.org/data/2.5/air_pollution"
	sevenDaysAgo  = 7 * 24 * time.Hour
)

func GetAirQualityByPos(lat, lon, apiKey string) (*model.AirQuality, error) {
	end := time.Now().Unix()
	start := time.Now().Add(-sevenDaysAgo).Unix()

	url := fmt.Sprintf("%s/history?lat=%s&lon=%s&start=%d&end=%d&appid=%s", airQualityUrl, lat, lon, start, end, apiKey)
	response, err := http.Get(url)
	if err != nil {
		return nil, err
	}
	defer response.Body.Close()

	if response.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("failed to get air quality data. Status: %s", response.Status)
	}

	airQuality := new(model.AirQuality)
	if err := json.NewDecoder(response.Body).Decode(airQuality); err != nil {
		return nil, err
	}

	return airQuality, nil
}
