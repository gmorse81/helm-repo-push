# Helm Repo Push
A Drone.io plugin for packaging and pushing a helm chart to a chartmuseum repo.

example usage:

```yaml
helm_chart_build:
  image: gmorse81/helm-repo-push
  repo_name: my-helm-repo-alias
  chart_subdir: name-of-chart
  update_dependencies: "true"
  secrets: [ helm_repo_url ]
  when:
    event: [pull_request, push]
    branch: master
    status: [ success ]
```

### Notes

1. This plugin expects a file named .tags in in your WORKDIR that contains the version number of the chart.
1. This plugin is specifically built to push to a chartmuseum repo using curl.
1. helm_repo_url is a secret in case it requires basic auth.
1. This plugin expects your chart to be inside a directory at `repo_name`.
1. By default, this plugin will update dependencies unless the environment variable PLUGIN_UPDATE_DEPENDENCIES="false".
