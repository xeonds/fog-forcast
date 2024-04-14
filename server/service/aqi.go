package service

import (
	"encoding/json"
	"fmt"
	"fog-forcast-server/model"
	"net/http"
)

const airQualityUrl = "https://api.openweathermap.org/data/2.5/air_pollution"

func GetAirQualityByPos(lat, lon, apiKey string) (*model.AirQuality, error) {
	response, err := http.Get(fmt.Sprintf("%s?lat=%s&lon=%s&appid=%s", airQualityUrl, lat, lon, apiKey))
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
