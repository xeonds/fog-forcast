package service

import (
	"encoding/json"
	"errors"
	"fmt"
	"io"
	"net/http"
	"strings"
)

func GetCityName(lat, lon float64, apiKey string) (string, error) {
	url := fmt.Sprintf("%s?lat=%f&lon=%f&appid=%s", geoUrl, lat, lon, apiKey)

	resp, err := http.Get(url)
	if err != nil {
		return "", err
	}
	defer resp.Body.Close()

	body, err := io.ReadAll(resp.Body)
	if err != nil {
		return "", err
	}

	var result []struct {
		Name string `json:"name"`
	}

	err = json.Unmarshal(body, &result)
	if err != nil {
		return "", err
	}

	if len(result) == 0 {
		return "", errors.New(strings.ToLower("No city found for the given position"))
	}

	return result[0].Name, nil
}
