# ArgoCD

Here's a rough recipe for what I've managed to get working with IAM roles scoped to a Kubernetes ServiceAccount and a single AWS account:

1. use the `latest` tag for the images. I couldn't get this to work with v1.6.
2. you'll need to set the fsGroup for the securityContext to 999.
3. setup the IAM OpenID Connect provider for the EKS cluster running Argo CD by following https://docs.aws.amazon.com/eks/latest/userguide/enable-iam-roles-for-service-accounts.html
4. create one IAM policy and one role following https://docs.aws.amazon.com/eks/latest/userguide/create-service-account-iam-policy-and-role.html

  * there needs to be 2 trust relationships for the one role: one for the `argocd-server` ServiceAccount and one for the `argocd-application-controller` ServiceAccount
  * the policy should allow `AssumeRole` and `AssumeRoleWithWebIdentity` for the STS service with the resources for the policy limited to the ARN for the IAM role
5. you'll need to add an annotation to the `argocd-server` and `argocd-application-controller` ServiceAccounts following https://docs.aws.amazon.com/eks/latest/userguide/specify-service-account-role.html
6. for the EKS clusters that Argo CD will deploying apps into, add a new entry into the `aws-auth` ConfigMap by following https://docs.aws.amazon.com/eks/latest/userguide/add-user-role.html
   
  * the `rolearn` and `username` values should match (though I'm not certain that this is required)
  * for `groups`, you could use `system:masters` but you might want to restrict scope further
7. for the Secret for each cluster, follow https://argoproj.github.io/argo-cd/operator-manual/declarative-setup/#clusters
   
  * be sure to add the label to the Secret as shown in the docs
  * for the Secret data:
     
    * `name` should be the ARN of the EKS cluster
    * `server` should be the URL of the Kubernetes API for the EKS cluster.
    * in the `config` block only set the following:
       
      * `awsAuthConfig` where:
         
        * `clusterName` is the name of the EKS cluster as returned by `aws eks list-clusters`
        * `roleARN` is the ARN of the IAM role
      * `tlsClientConfig` where:

        * `insecure` is `false`. This might not be required but it doesn't hurt to be explicit.
        * `caData` is the certificate returned by `aws eks describe-cluster --query "cluster.certificateAuthority" --output text`. It should already be base64 encoded.
8. when creating an app with `argocd app create`, set `--dest-server` to the URL of the Kubernetes API for the cluster.

