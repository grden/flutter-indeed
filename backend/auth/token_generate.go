package auth

import (
	"time"

	"github.com/grden/indeed/server/token"
)

func CreateToken(tokenMaker token.Maker, email string, userId int64, duration time.Duration) (string, error) {
	accesstoken, err := tokenMaker.CreateToken(userId, email, duration)
	if err != nil {
		return "", err
	}
	return accesstoken, nil

}
