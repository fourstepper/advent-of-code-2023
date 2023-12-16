package main

import (
	"fmt"
	"os"
	"strings"
)

func main() {
	file, err := os.ReadFile("input.txt")
	if err != nil {
		fmt.Println("Something went wrong!")
	}

	data := strings.Split(strings.TrimSpace(string(file)), "\n")
	for _, v := range data {
		fmt.Println(v)
	}
}
