package auth

import (
	"github.com/grden/indeed/server/db/model"
	pb "github.com/grden/indeed/server/pb"
)

func ConvertUserObjectToUser(model *model.UserModel) *pb.User {
	return &pb.User{
		Email: model.Email,
		Name:  model.Name,
		Id:    int32(model.ID.Timestamp().Day()),
	}
}
