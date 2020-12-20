package main

import (
	"fmt"
	"os"
	"os/exec"

	"github.com/neovim/go-client/nvim"
)

func main() {
	addr := os.Getenv("NVIM_LISTEN_ADDRESS")
	if addr == "" {
		editor := os.Getenv("REALEDITOR")
		cmd := exec.Command(editor, os.Args[1:]...)
		cmd.Stdin = os.Stdin
		cmd.Stdout = os.Stdout

		if err := cmd.Run(); err != nil {
			fmt.Println(err)
			os.Exit(1)
		}
		os.Exit(0)
	}

	fileNames := os.Args[1:]
	if len(fileNames) == 0 {
		fmt.Println("No arguments given")
		os.Exit(1)
	}

	filePaths, err := getAbsolutePaths(fileNames...)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	v, err := nvim.Dial(addr)
	if err != nil {
		fmt.Println(err)
		os.Exit(1)
	}

	defer v.Close()

	b := v.NewBatch()
	b.Command(":bd!")

	for _, filePath := range filePaths {
		b.Command(":e " + filePath)
	}

	if err := b.Execute(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}

func getAbsolutePaths(fileNames ...string) ([]string, error) {
	pwd, err := os.Getwd()
	if err != nil {
		return nil, err
	}

	absolutePaths := make([]string, len(fileNames))

	for _, filePath := range fileNames {
		if filePath[0] != '/' {
			filePath = pwd + "/" + filePath
		}
		absolutePaths = append(absolutePaths, filePath)
	}

	return absolutePaths, nil
}
