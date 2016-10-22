package main

import (
	"html/template"
	"net/http"
	"os"

	"github.com/fsouza/go-dockerclient"
	"github.com/op/go-logging"
)

var (
	dockerHost = "unix:///var/run/docker.sock"
	log        = logging.MustGetLogger("badger3")
)

// Container stores the metadata.
type Container struct {
	ID           string
	Hostname     string
	Image        string
	Labels       map[string]string
	YoutubeVideo string
}

func main() {
	log.Info("Starting server on port 8080.")

	http.HandleFunc("/", handler)
	http.ListenAndServe(":8080", nil)
}

// Inspect the running container and render the page.
func handler(w http.ResponseWriter, r *http.Request) {
	container, err := selfInspect()
	if err != nil {
		log.Errorf("Error self inspecting this container - %v", err)
	}

	t, err := template.ParseFiles("index.html")
	if err != nil {
		log.Errorf("Error loading template - %v", err)
	}

	t.Execute(w, container)
}

// Self inspect uses the Docker API to get the image and labels for this container.
func selfInspect() (*Container, error) {
	hostname, err := os.Hostname()
	if err != nil {
		log.Errorf("Error getting hostname - %v", err)
		return nil, err
	}

	client, err := docker.NewClient(dockerHost)
	if err != nil {
		log.Errorf("Error creating Docker client - %v", err)
		return nil, err
	}

	c, err := client.InspectContainer(hostname)
	if err != nil {
		log.Errorf("Error inspecting container - %v", err)
		return nil, err
	}

	i, err := client.InspectImage(c.Image)
	if err != nil {
		log.Errorf("Error inspecting image - %v", err)
		return nil, err
	}

	container := &Container{
		ID:           c.ID,
		Hostname:     hostname,
		Image:        i.RepoTags[0],
		Labels:       c.Config.Labels,
		YoutubeVideo: c.Config.Labels["com.microbadger.youtube-video"],
	}

	return container, err
}
