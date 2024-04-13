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
	Id       uint32    `gorm:"primary_key;auto_increment" json:"id"`
	Date     time.Time `gorm:"type:date;not null" json:"date"`
	CityId   uint32    `gorm:"not null" json:"city_id"`
	Temp     float32   `gorm:"not null" json:"temp"`
	Humidity float32   `gorm:"not null" json:"humidity"`
	Pressure float32   `gorm:"not null" json:"pressure"`
	Weather  string    `gorm:"type:varchar(255);not null" json:"weather"`
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
