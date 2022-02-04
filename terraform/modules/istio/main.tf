resource "kubernetes_namespace" "istio_system" {
  depends_on = [
    var.eks_cluster_id
  ]
  metadata {
    name = "istio-system"

    annotations = {
      name = "istio-system"
    }
  }
}

resource "helm_release" "istio_base" {
  depends_on = [
    kubernetes_namespace.istio_system
  ]

  name       = "istio-base"
  chart      = "base"
  repository = "https://istio-release.storage.googleapis.com/charts"
  namespace  = "istio-system"
}

resource "helm_release" "istiod" {
  depends_on = [
    helm_release.istio_base
  ]

  name       = "istiod"
  chart      = "istiod"
  repository = "https://istio-release.storage.googleapis.com/charts"
  namespace  = "istio-system"
}

# resource "helm_release" "istio_ingress" {
#   depends_on = [
#     helm_release.istio_base
#   ]

#   name       = "istio-ingress"
#   chart      = "gateway"
#   repository = "https://istio-release.storage.googleapis.com/charts"
#   namespace  = "istio-system"

#   values = [
#     <<EOT
# name: istio-ingressgateway
# labels:
#   app: ""
#   istio: ingressgateway
# service:
#   type: NodePort
#     EOT
#   ]
# }

# provider "kubectl" {
#   host                   = var.cluster_endpoint
#   cluster_ca_certificate = var.cluster_ca_certificate
#   token                  = var.cluster_token
#   load_config_file       = false
# }

# resource "null_resource" "istio_ingressgateway_annotations" {
#   depends_on = [
#     helm_release.istio_ingress
#   ]
#   triggers = {
#     always_run = "${timestamp()}"
#   }
#   provisioner "local-exec" {
#     command = <<EOT
# echo "Annotating Istio Ingress Gateway Service (START)"
# INGRESS_SERVICE_NODEPORT=$(kubectl get service -n istio-system istio-ingressgateway -o json | jq -c '.spec.ports[] | select( .name == "status-port" ).nodePort') && \
#   kubectl annotate service -n istio-system istio-ingressgateway alb.ingress.kubernetes.io/healthcheck-port="$INGRESS_SERVICE_NODEPORT" --overwrite=true && \
#   kubectl annotate service -n istio-system istio-ingressgateway alb.ingress.kubernetes.io/healthcheck-path=/healthz/ready --overwrite=true
# echo "Annotating Istio Ingress Gateway Service (DONE)"
# EOT
#   }
# }

# resource "kubectl_manifest" "istio_alb_ingress" {
#   depends_on = [
#     null_resource.istio_ingressgateway_annotations
#   ]
#   yaml_body = <<YAML
# apiVersion: extensions/v1beta1
# kind: Ingress
# metadata:
#   name: istio-ingress-alb
#   namespace: istio-system
#   annotations:
#     kubernetes.io/ingress.class: alb
#     alb.ingress.kubernetes.io/scheme: internet-facing
#     alb.ingress.kubernetes.io/certificate-arn: "${var.acm_certificate_arn}"
#     alb.ingress.kubernetes.io/listen-ports: '[{"HTTP": 80}, {"HTTPS":443}]'
#     alb.ingress.kubernetes.io/actions.ssl-redirect: '{"Type": "redirect", "RedirectConfig": { "Protocol": "HTTPS", "Port": "443", "StatusCode": "HTTP_301"}}'
#     external-dns.alpha.kubernetes.io/hostname: ${var.ingress_hostname}
# spec:
#   rules:
#   - http:
#       paths:
#         - path: /*
#           backend:
#             serviceName: ssl-redirect
#             servicePort: use-annotation
#         - path: /*
#           backend:
#             serviceName: istio-ingressgateway
#             servicePort: 80
#   YAML
# }
