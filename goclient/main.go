package main

import (
	"context"
	"fmt"
	"gcli/stubs"
	"log"

	"google.golang.org/grpc"
	"google.golang.org/grpc/codes"
	"google.golang.org/grpc/credentials/insecure"
	"google.golang.org/grpc/status"
)

func main() {
	opts := []grpc.DialOption{grpc.WithTransportCredentials(insecure.NewCredentials())}
	conn, err := grpc.Dial("localhost:8080", opts...)
	if err != nil {
		log.Fatalf("fail to dial: %v", err)
	}
	defer conn.Close()
	client := stubs.NewFileServiceClient(conn)

	for i := 0; i < 10; i++ {
		err = iterate(client)
		if err != nil {
			log.Fatalf("failed to iterate: %v", err)
		}
	}

	conn.Close()
}

func iterate(client stubs.FileServiceClient) error {
	ctx, cancel := context.WithCancel(context.Background())
	defer cancel()
	stream, err := client.GetFiles(ctx, &stubs.Empty{})
	if err != nil {
		return err
	}

	count := 0
	for {
		count++
		response, err := stream.Recv()
		if err != nil {
			if status.Code(err) == codes.Canceled {
				log.Printf("Stream cancelled: %v", err)
			} else {
				log.Fatalf("Failed to receive a message: %v", err)
			}
			break
		}

		fmt.Printf("Received file with %d bytes (count=%d)\n", len(response.Contents), count)

		if count > 5 {
			fmt.Printf("Cancelling at count %d\n\n", count)
			cancel()
			break
		}
	}
	return nil
}
