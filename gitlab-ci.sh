# See .gitlab-ci.yml
echo "{\"auths\":{\"$CI_REGISTRY\":{\"username\":\"$CI_REGISTRY_USER\",\"password\":\"$CI_REGISTRY_PASSWORD\"}}}" > /kaniko/.docker/config.json

/kaniko/executor --context $CI_PROJECT_DIR \
                 --dockerfile $CI_PROJECT_DIR/Dockerfile \
                 --destination $CI_REGISTRY_IMAGE:$CI_COMMIT_TAG
