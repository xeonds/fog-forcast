package service_test

import (
	"encoding/json"
	"fog-forcast-server/service"
	"os"
	"testing"
)

func TestGetWeatherByPos(t *testing.T) {
	res, err := service.GetWeatherByPos("35.6895", "139.6917", conf.OpenWeatherKey)
	if err != nil {
		t.Error(err)
	}

	// Write res to res.json
	data, err := json.Marshal(&res)
	if err != nil {
		t.Error(err)
	}

	err = os.WriteFile("res_lonlat.json", data, 0644)
	if err != nil {
		t.Error(err)
	}
}

func TestGetWeatherByCityId(t *testing.T) {
	res, err := service.GetWeatherByCityId("1850147", conf.OpenWeatherKey)
	if err != nil {
		t.Error(err)
	}

	// Write res to res.json
	data, err := json.Marshal(&res)
	if err != nil {
		t.Error(err)
	}

	err = os.WriteFile("res_city_id.json", data, 0644)
	if err != nil {
		t.Error(err)
	}
}
