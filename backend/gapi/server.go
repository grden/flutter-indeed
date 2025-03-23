package gapi

import (
	"fmt"
	"sync"

	"github.com/grden/indeed/server/db"
	"github.com/grden/indeed/server/pb"
	"github.com/grden/indeed/server/token"
	"github.com/grden/indeed/server/utils"
)

type Server struct {
	pb.GrpcServerServiceServer
	clients      map[string]pb.GrpcServerService_SendMessageServer
	mu           sync.Mutex
	config       utils.ViperConfig
	dbCollection db.MongoCollections

	tokenMaker token.Maker
}

func NewServer(config utils.ViperConfig, dbCollection db.MongoCollections) (*Server, error) {
	tokenMaker, err := token.NewJwtMaker(config.TokkenStructureKey)
	if err != nil {
		return nil, fmt.Errorf("cannot create token maker: %w", err)
	}

	server := &Server{
		config:       config,
		dbCollection: dbCollection,
		tokenMaker:   tokenMaker,
	}

	return server, nil
}
