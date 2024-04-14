package service_test

import (
	"fog-forcast-server/config"
	"fog-forcast-server/lib"
	"fog-forcast-server/service"
	"os"
	"testing"
)

var conf *config.Config

func init() {
	conf = lib.LoadConfig[config.Config]()
}

func TestGetCityByPos(t *testing.T) {
	res, err := service.GetCityName(35.6895, 139.6917, conf.OpenWeatherKey)
	if err != nil {
		t.Error(err)
	}
	if err := os.WriteFile("city_lonlat.json", []byte(res), 0644); err != nil {
		t.Error(err)
	}
}
