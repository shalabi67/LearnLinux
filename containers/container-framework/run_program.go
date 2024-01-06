package main
import (
        "fmt"
        "os"
        "os/exec"
        "syscall"
)
func main() {
switch os.Args[1] {
        case "parent":
                parent()
        case "child":
                child()
        default:
               panic("help")
        }
}
// the parent function invoked from the main program which sets up the needed namespaces
func parent() {
        cmd := exec.Command("/proc/self/exe", append([]string{"child"}, os.Args[2:]...)...)
        cmd.Stdin = os.Stdin
        cmd.Stdout = os.Stdout
        cmd.Stderr = os.Stderr
        cmd.Env = []string{"name=shashank"}
        cmd.SysProcAttr = &syscall.SysProcAttr{
                Cloneflags: syscall.CLONE_NEWNS |
                        syscall.CLONE_NEWUTS |
                        syscall.CLONE_NEWIPC |
                        syscall.CLONE_NEWPID |
                        syscall.CLONE_NEWNET |
                        syscall.CLONE_NEWUSER,
        UidMappings: []syscall.SysProcIDMap{
                        {
                                ContainerID: 0,
                                HostID: os.Getuid(),
                                Size: 1,
                        },
               },
               GidMappings: []syscall.SysProcIDMap{
                      {
                                ContainerID: 0,
                                HostID: os.Getgid(),
                                Size: 1,
                      },
               },
        }
        must(cmd.Run())
}
// this is the child process which is a copy of the parent program itself.
func child () {
    cmd := exec.Command(os.Args[2], os.Args[3:]...)
            cmd.Stdin = os.Stdin
            cmd.Stdout = os.Stdout
            cmd.Stderr = os.Stderr
    //the command below sets the hostname to myhost. Idea here is to showcase the use of UTS namespace
    must(syscall.Sethostname([]byte("myhost")))
    // this command executes the shell which is passed as a program argument
    must(cmd.Run())
}
func must(err error) {
    if err != nil {
             fmt.Printf("Error - %s\n", err)
    }
}