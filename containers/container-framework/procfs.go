package main
import (
        "fmt"
        "os"
        "os/exec"
        "path/filepath"
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
func pivotRoot(newroot string) error {
    putold := filepath.Join(newroot, "/.pivot_root")
    // bind mount newroot to itself - this is a slight hack needed to satisfy the
    // pivot_root requirement that newroot and putold must not be on the same
    // filesystem as the current root
    if err := syscall.Mount(newroot, newroot, "", syscall.MS_BIND|syscall.MS_REC, ""); err != nil {
         return err
    }
    // create putold directory
    if err := os.MkdirAll(putold, 0700); err != nil {
        return err
    }
    // call pivot_root
    if err := syscall.PivotRoot(newroot, putold); err != nil {
        return err
    }
    // ensure current working directory is set to new root
    if err := os.Chdir("/"); err != nil {
        return err
    }
    // umount putold, which now lives at /.pivot_root putold = "/.pivot_root"
    putold = "/.pivot_root"
    if err := syscall.Unmount(putold, syscall.MNT_DETACH); err != nil {
        return err
    }
    // remove putold
    if err := os.RemoveAll(putold); err != nil{
        return err
    }
    return nil
}
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
func child () {
    cmd := exec.Command(os.Args[2], os.Args[3:]...)
    cmd.Stdin = os.Stdin
    cmd.Stdout = os.Stdout
    cmd.Stderr = os.Stderr
    //make a call to mountProc function which would mount the proc filesystem to the already
    //created mount namespace
    must(mountProc("/root/book_prep/rootfs"))
    must(syscall.Sethostname([]byte("myhost")))
    if err := pivotRoot("/root/book_prep/rootfs"); err != nil {
        fmt.Printf("Error running pivot_root - %s\n", err)
        os.Exit(1)
    }
    must(cmd.Run())
}
func must(err error) {
    if err != nil {
             fmt.Printf("Error - %s\n", err)
    }
}
// this function mounts the proc filesystem within the
// new mount namespace
func mountProc(newroot string) error {
    source := "proc"
    target := filepath.Join(newroot, "/proc")
    fstype := "proc"
    flags := 0
    data := ""

    //make a Mount system call to mount the proc filesystem within the mount namespace
    os.MkdirAll(target, 0755)
    if err := syscall.Mount(
            source,
            target,
            fstype,
            uintptr(flags),
            data,
    ); err != nil {
            return err
    }
    return nil
}