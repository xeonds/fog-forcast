package config

import "fog-forcast-server/lib"

type Config struct {
	// 服务器配置
	Server struct {
		Port               string `yaml:"port"`
		InsecureSkipVerify bool   `yaml:"insecureSkipVerify"`
	}
	// 数据库配置
	lib.DatabaseConfig
	// 数据目录配置
	OpenWeatherKey string `yaml:"openWeatherKey"`
}
