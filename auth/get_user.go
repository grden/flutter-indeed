package auth

import (
	"context"

	"github.com/grden/indeed/server/db/model"
	"go.mongodb.org/mongo-driver/bson"
	"go.mongodb.org/mongo-driver/mongo"
)

func GetUser(collection *mongo.Collection, context context.Context, email string) (*model.UserModel, error) {
	filter := bson.M{"email": email}
	var user model.UserModel
	err := collection.FindOne(context, filter).Decode(&user)
	if err == mongo.ErrNoDocuments {
		return nil, ErrUserNotFound
	} else if err != nil {
		return nil, err
	}
	return &user, nil
}
