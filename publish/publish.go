package publish

import (
	"fmt"
	"github.com/nats-io/stan.go"
)

var message = []byte("Hello World!")

func main() {
	sc, err := stan.Connect("test-cluster", "my-subject")
	if err != nil {
		fmt.Println(err.Error())
		return
	}

	sc.Publish("my-subject", message)
}
