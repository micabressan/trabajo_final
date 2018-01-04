package main
 
import (
    "fmt"
    "os"
    "time"
    "github.com/veandco/go-sdl2/sdl"
)
 
func main() {
    /* Initialize SDL. */
    err := sdl.Init(sdl.INIT_EVERYTHING)
    if err != nil {
        fmt.Fprintf(os.Stderr, "could not initialize SDL: %v", err)
    }
 
    // Create the window where we will draw.
    w, r, err := sdl.CreateWindowAndRenderer(900, 600, sdl.WINDOW_SHOWN)
    _, _ = w, r
 
    // Select the color for drawing.
    r.SetDrawColor(128, 128, 128, 255)
 
    // Clear the entire screen to our selected color.
    r.Clear()
 
    // Draw single Pixel
    r.SetDrawColor(255, 0, 0, 255)
    r.DrawPoint(12, 12)
 
    /* Up until now everything was drawn behind the scenes.
       This will show the new, red contents of the window.*/
    r.Present()
 
    // Keep Window open 5 seconds
    time.Sleep(5 * time.Second)
 
    // Quit properly
    defer sdl.Quit()
    defer w.Destroy()
}