#
# This script is invoked from  .gitlab-ci.yml.  Hm, the shell from the
# shebang line #!/bin/sh  is not found in the kaniko  debug image! The
# shell is instaled as /busybox/sh there, likely intentionally.
#
# When pulling  external base Images  Kaniko may  need a proxy  set in
# "https_proxy",  "http_proxy" &  "no_proxy" env  vars ---  "no_proxy"
# should at least  contain the domain of your GitLab  Instance for the
# runner (?)  to be able to  clone the repo.  Configure this in GitLab
# UI ->  Project -> Settings ->  CI/CD -> Variables [1].   It would be
# probably a bad  idea to hardwire your corporate in  the source code.
# See also predefined variables [2].
#
# The next Problem  will be that the Docker RUN  commands such as "yum
# install  -y ..."   will not  be  able to  get to  the Intrnets,  see
# --build-arg below  [3]. For some  reason "yum" still  uses "http://"
# URLs and will require properly set http_proxy too.
#
# [1] https://docs.gitlab.com/ee/ci/variables/#create-a-custom-variable-in-the-ui
# [2] https://docs.gitlab.com/ee/ci/variables/predefined_variables.html
# [3] https://github.com/GoogleContainerTools/kaniko/issues/713
#

#DONT: export https_proxy="http://...:3128"
#DONT: export no_proxy="example.com"

echo "=== ENVIRONMENT ==="
env
echo "==================="
echo "{\"auths\":{\"$CI_REGISTRY\":{\"username\":\"$CI_REGISTRY_USER\",\"password\":\"$CI_REGISTRY_PASSWORD\"}}}" > /kaniko/.docker/config.json

/kaniko/executor --context $CI_PROJECT_DIR \
                 --dockerfile $CI_PROJECT_DIR/Dockerfile \
                 --destination $CI_REGISTRY_IMAGE:$CI_COMMIT_TAG \
                 --build-arg https_proxy="$https_proxy" \
                 --build-arg http_proxy="$http_proxy" \
                 --build-arg no_proxy="$no_proxy"
