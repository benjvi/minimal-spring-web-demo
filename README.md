# minimal-spring-web-demo

This is a minimal Spring Boot service, used to demonstrate Continuous Integration and Continuous Delivery workflows, working together with [a GitOps repo](https://github.com/benjvi/apps-gitops) to do the deployment.

# Post-integration workflow

This workflow is called, "Deploy via GitOps". You can view the config [here](https://github.com/benjvi/minimal-spring-web-demo/blob/main/.github/workflows/deploy.yml) or the workflow runs [here](https://github.com/benjvi/minimal-spring-web-demo/actions/workflows/deploy.yml). Several checks are done on the code whilst, in parallel, Tanzu Build Service (specifically, its 'kpack controller') triggers the build and publishing of a container image. Once done, the [kubernetes manifests](https://github.com/benjvi/minimal-spring-web-demo/tree/main/k8s) are updated with the image (using kustomize), and are checked into the [GitOps repo nonprod folder](https://github.com/benjvi/apps-gitops/tree/main/nonprod-cluster/spring-app). The following diagram describes this flow:

![post integration flow](https://github.com/benjvi/minimal-spring-web-demo/raw/main/tbs-post-integration-flow.png)

You can get more details about how the Continuous Deployment part of this flow works in the [apps-gitops repo readme](https://github.com/benjvi/apps-gitops/blob/main/README.md).
