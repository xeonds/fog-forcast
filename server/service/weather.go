package service

import (
	"encoding/json"
	"fmt"
	"fog-forcast-server/model"
	"net/http"
)

const weatherUrl = "https://api.openweathermap.org/data/2.5/weather"
const geoUrl = "http://api.openweathermap.org/geo/1.0/reverse"

func GetWeatherByPos(lat, lon, apiKey string) (*model.Weather, error) {
	response, err := http.Get(fmt.Sprintf("%s?lat=%s&lon=%s&appid=%s&units=metric", weatherUrl, lat, lon, apiKey))
	if err != nil {
		return nil, err
	}
	defer response.Body.Close()

	if response.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("failed to get weather data. Status: %s", response.Status)
	}

	weather := new(model.Weather)
	if err := json.NewDecoder(response.Body).Decode(weather); err != nil {
		return nil, err
	}

	return weather, nil
}

func GetWeatherByCityId(cityId, apiKey string) (*model.Weather, error) {
	response, err := http.Get(fmt.Sprintf("%s?id=%s&appid=%s&units=metric", weatherUrl, cityId, apiKey))
	if err != nil {
		return nil, err
	}
	defer response.Body.Close()
	if response.StatusCode != http.StatusOK {
		return nil, fmt.Errorf("failed to get weather data. Status: %s", response.Status)
	}
	weather := new(model.Weather)
	if err := json.NewDecoder(response.Body).Decode(weather); err != nil {
		return nil, err
	}
	return weather, nil
}
