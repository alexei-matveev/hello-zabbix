#
# This script is invoked from  .gitlab-ci.yml.  Hm, the shell from the
# shebang line #!/bin/sh  is not found in the kaniko  debug image! The
# shell is instaled as /busybox/sh there, likely intentionally.
#
# When pulling  external base Images  Kaniko may  need a proxy  set in
# HTTPS_PROXY  env var.   Configur this  in  GitLab UI  -> Project  ->
# Settings -> CI/CD -> Variables [1].  It would be probably a bad idea
# to hardwire your corporate in  the source code.  See also predefined
# variables [2].
#
# [1] https://docs.gitlab.com/ee/ci/variables/#create-a-custom-variable-in-the-ui
# [2] https://docs.gitlab.com/ee/ci/variables/predefined_variables.html
#

#DONT: export HTTPS_PROXY="http://...:3128"

echo "=== ENVIRONMENT ==="
env
echo "==================="
echo "{\"auths\":{\"$CI_REGISTRY\":{\"username\":\"$CI_REGISTRY_USER\",\"password\":\"$CI_REGISTRY_PASSWORD\"}}}" > /kaniko/.docker/config.json

/kaniko/executor --context $CI_PROJECT_DIR \
                 --dockerfile $CI_PROJECT_DIR/Dockerfile \
                 --destination $CI_REGISTRY_IMAGE:$CI_COMMIT_TAG
