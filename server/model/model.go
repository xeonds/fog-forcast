package model

import "time"

type City struct {
	Id      uint32  `gorm:"primary_key;auto_increment" json:"id"`
	Name    string  `gorm:"type:varchar(255);not null" json:"name"`
	Country string  `gorm:"type:varchar(255);not null" json:"country"`
	Lon     float64 `gorm:"not null" json:"lon"`
	Lat     float64 `gorm:"not null" json:"lat"`
}

type Weather struct {
	Coord struct {
		Lon float64 `json:"lon"`
		Lat float64 `json:"lat"`
	} `json:"coord" gorm:"serializer:json"`
	Weather []struct {
		ID          int    `json:"id"`
		Main        string `json:"main"`
		Description string `json:"description"`
		Icon        string `json:"icon"`
	} `json:"weather" gorm:"serializer:json"`
	Base string `json:"base"`
	Main struct {
		Temp      float64 `json:"temp"`
		FeelsLike float64 `json:"feels_like"`
		TempMin   float64 `json:"temp_min"`
		TempMax   float64 `json:"temp_max"`
		Pressure  int     `json:"pressure"`
		Humidity  int     `json:"humidity"`
		SeaLevel  int     `json:"sea_level"`
		GrndLevel int     `json:"grnd_level"`
	} `json:"main" gorm:"serializer:json"`
	Visibility int `json:"visibility"`
	Wind       struct {
		Speed float64 `json:"speed"`
		Deg   int     `json:"deg"`
		Gust  float64 `json:"gust"`
	} `json:"wind" gorm:"serializer:json"`
	Rain struct {
		OneH float64 `json:"1h"`
	} `json:"rain" gorm:"serializer:json"`
	Clouds struct {
		All int `json:"all"`
	} `json:"clouds" gorm:"serializer:json"`
	Dt  int `json:"dt"`
	Sys struct {
		Type    int    `json:"type"`
		ID      int    `json:"id"`
		Country string `json:"country"`
		Sunrise int    `json:"sunrise"`
		Sunset  int    `json:"sunset"`
	} `json:"sys" gorm:"serializer:json"`
	Timezone int    `json:"timezone"`
	ID       int    `json:"id"`
	CityId   uint32 `gorm:"not null" json:"city_id"`
	Name     string `json:"name"`
	Cod      int    `json:"cod"`
}

type AirQuality struct {
	Id     uint32    `gorm:"primary_key;auto_increment" json:"id"`
	Date   time.Time `gorm:"type:date;not null" json:"date"`
	CityId uint32    `gorm:"not null" json:"city_id"`
	Aqi    uint32    `gorm:"not null" json:"aqi"`
	Pm25   uint32    `gorm:"not null" json:"pm25"`
	Pm10   uint32    `gorm:"not null" json:"pm10"`
	O3     uint32    `gorm:"not null" json:"o3"`
	Co     uint32    `gorm:"not null" json:"co"`
	So2    uint32    `gorm:"not null" json:"so2"`
	No2    uint32    `gorm:"not null" json:"no2"`
}
