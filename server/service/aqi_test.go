package service_test

import (
	"encoding/json"
	"fog-forcast-server/service"
	"os"
	"testing"
)

func TestGetAQIByPos(t *testing.T) {
	res, err := service.GetAirQualityByPos("50", "50", conf.OpenWeatherKey)
	if err != nil {
		t.Error(err)
	}

	data, err := json.Marshal(&res)
	if err != nil {
		t.Error(err)
	}

	if err := os.WriteFile("aqi_lonlat.json", []byte(data), 0644); err != nil {
		t.Error(err)
	}
}
