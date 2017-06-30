# gjchen/gitea@Dockerhub
Alpine Linux with gitea configured.

Volumes:
* /data for persistant data

Environment Variables:
* GITEA_CUSTOM="/data/gitea" for custom location of gitea
* USER="git" for ssh login user

Examples:
```
docker run -d --name gitea \
  -e TIMEZOEN="Asia/Taipei" \
  -v /opt/gitea:/data \
  -p 3000:3000 -p 2222:22 \
  --restart unless-stopped 
  gjchen/gitea
```
