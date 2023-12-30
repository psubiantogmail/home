docker build --file .\Dockerfile -t ghcr.io/psubiantogmail/home-ghcr:latest .
docker push ghcr.io/psubiantogmail/home-ghcr:latest
rem docker run -d -p 80:80 ghcr.io/psubiantogmail/home-ghcr:latest 
