# minimal-spring-web-demo

This is a minimal Spring Boot service, used to demonstrate Continuous Integration and Continuous Delivery workflows, working together with [a GitOps repo](https://github.com/benjvi/apps-gitops) to do the deployment.

# Post-integration workflow

This workflow is called, "Deploy via GitOps". It runs after code has been merged, or "integrated", onto the main branch. You can view the config [here](https://github.com/benjvi/minimal-spring-web-demo/blob/main/.github/workflows/deploy.yml) or the workflow runs [here](https://github.com/benjvi/minimal-spring-web-demo/actions/workflows/deploy.yml). 

According to trunk-based development, code on the main branch is intended to be ready for production. However, we still need to validate the integrated code. Several checks are done on the code whilst, in parallel, Tanzu Build Service (specifically, its 'kpack controller') triggers the build and publishing of a container image. Once done, the [kubernetes manifests](https://github.com/benjvi/minimal-spring-web-demo/tree/main/k8s) are updated with the image (using kustomize), and are checked into the [GitOps repo nonprod folder](https://github.com/benjvi/apps-gitops/tree/main/nonprod-cluster/spring-app). The following diagram describes this flow:

![post integration flow](https://github.com/benjvi/minimal-spring-web-demo/raw/main/tbs-post-integration-flow.png)

You can get more details about how the Continuous Deployment part of this flow works in the [apps-gitops repo readme](https://github.com/benjvi/apps-gitops/blob/main/README.md).

# Kpack Image

The `kpack-image.yml` defines how the Docker images are produced for this repo, based on Tanzu Build Service constructs. It is configured to match your context:
  - `spec.source.git` to match your Git repo
  - `spec.builder` to match a builder available in your Tanzu Build Service installation. In this repo, we are using a custom [builder](https://github.com/pivotal/kpack/blob/main/docs/builders.md)
  - `spec.tag` to match a docker image tag that Tanzu Build Service can push

This Kpack `Image` must be installed in your Tanzu Build Service installation with `kubectl apply -f kpack-image.yml` for Tanzu Build Serivce to start building Docker images based on the code found in the repo.
