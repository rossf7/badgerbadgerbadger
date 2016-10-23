# badgerbadgerbadger

[![](https://images.microbadger.com/badges/image/rossf7/badgerbadgerbadger.svg)](https://microbadger.com/images/rossf7/badgerbadgerbadger "Get your own image badge on microbadger.com") [![](https://images.microbadger.com/badges/version/rossf7/badgerbadgerbadger.svg)](https://microbadger.com/images/rossf7/badgerbadgerbadger "Get your own version badge on microbadger.com") [![](https://images.microbadger.com/badges/commit/rossf7/badgerbadgerbadger.svg)](https://microbadger.com/images/rossf7/badgerbadgerbadger "Get your own commit badge on microbadger.com")

Demo of using introspection with Docker containers to access their own metadata.

# Build

Compiles the Go binary and builds the image with dynamic metadata. Needs Go to be installed and has been tested with Go 1.7.

```
$ make
```

# Run

```
$ docker run -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock rossf7/badgerbadgerbadger
```

# Run (runtime label)

```
$ docker run --label com.microbadger.youtube-video=EllYgcWmcAY -p 8080:8080 -v /var/run/docker.sock:/var/run/docker.sock rossf7/badgerbadgerbadger
```
