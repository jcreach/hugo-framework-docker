# hugo-framework-docker

Hugo framework docker image

## Overview

Hugo is a static HTML and CSS website generator written in Go. See this link : [Hugo](https://gohugo.io/).

## How to use

### Use pre-built docker image

You can find the pre-build docker image on [Docker Hub](https://hub.docker.com/r/jcreach/hugo-framework).

Pull it :

```powershell
docker pull jcreach/hugo-framework
```

Run it like that : 

```powershell
docker run -name hello-hugo -p 1313:1313 -v c:\path\to\hugo\project:c:\hugo-site -e HUGO_BASEURL=http://localhost jcreach/hugo-framework:latest
```

### Build your own

```powershell
docker build --pull --rm -f "dockerfile" -t <image_name>:<tag> .
```
