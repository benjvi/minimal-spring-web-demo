# minimal-spring-web-demo

This is a minimal Spring Boot service, used to demonstrate Continuous Integration and Continuous Delivery workflows, working together with [a GitOps repo](https://github.com/benjvi/apps-gitops) to do the deployment.

# Post-integration workflow

This workflow is called, "Deploy via GitOps". You can view the config here](https://github.com/benjvi/minimal-spring-web-demo/blob/main/.github/workflows/deploy.yml) or the workflow runs [here](https://github.com/benjvi/minimal-spring-web-demo/actions/workflows/deploy.yml). Several checks are done on the code whilst, in parallel, Tanzu Build Service (specifically, its 'kpack controller') trigger the build and publishing of a container image. Once done, the [kubernetes manifests](https://github.com/benjvi/minimal-spring-web-demo/tree/main/k8s) are updated with the image using kustomize, and are checked into the GitOps repo nonprod folder. The following diagram covers this flow:

![diagram TODO]()
