package main
import (
  "fmt"
  "os"
  "os/exec"
  "syscall"
)
func main() {
  cmd := exec.Command("/bin/bash")
  // The statements below refer to the input, output and error streams of the process created (cmd)
  cmd.Stdin = os.Stdin
  cmd.Stdout = os.Stdout
  cmd.Stderr = os.Stderr
  //setting an environment variable
  cmd.Env = []string{"name=shashank"}
  // the command below creates a UTS namespace for the process
  cmd.SysProcAttr = &syscall.SysProcAttr{
     Cloneflags: syscall.CLONE_NEWUTS,
  }
  if err := cmd.Run(); err != nil {
        fmt.Printf("Error running the /bin/bash command - %s\n", err)
        os.Exit(1)
  }
}