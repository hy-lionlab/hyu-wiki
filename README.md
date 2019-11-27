hy-wiki

```bash
docker build -f Dockerfile-base -t hywiki/base:v0 .
```

```
cat docker-compose.prod.yml | container-transform -v
```

이후

`Dockerrun.aws.json` 파일 내 `volumes`에 상대 경로를 `${PWD}`로 변경한다. `MAC` 기준이기 때문에 달라질 수 있음. (`eb local run -v` 테스트를 위해)

`github actions` 또는 `eb deploy` 전에 `${PWD}` 경로를 인스턴스의 `/vap/app/current`로 변경하는 스크립트를 실행하도록 설정해야한다.

### TODO

- `Dockerrun.aws.json` gitignore 추가, ebignore 최신화
- `Dockerrun.aws.json` 빌드 스테이징에 따라 다르게 생성 + 수정할 수 있도록 shell script 추가 (memory, absolute path)

