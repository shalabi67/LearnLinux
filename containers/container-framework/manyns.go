package main
import (
    "fmt"
    "os"
    "os/exec"
    "syscall"
)
func main() {
    cmd := exec.Command("/bin/bash")
    cmd.Stdin = os.Stdin
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr
    cmd.Env = []string{"name=shashank"}
    //command below creates the UTS, PID and IPC , NETWORK and USERNAMESPACES
    cmd.SysProcAttr = &syscall.SysProcAttr{
            Cloneflags: syscall.CLONE_NEWNS |
                    syscall.CLONE_NEWUTS |
                    syscall.CLONE_NEWIPC |
                    syscall.CLONE_NEWPID |
                    syscall.CLONE_NEWNET |
                    syscall.CLONE_NEWUSER,
    }
    if err := cmd.Run(); err != nil {
      fmt.Printf("Error running the /bin/bash command - %s\n", err)
      os.Exit(1)
    }
}
