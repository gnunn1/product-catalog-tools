echo "Creating projects"
oc new-project product-catalog-dev
oc new-project product-catalog-test
oc new-project product-catalog-cicd

echo "Adding rolebindings"
oc apply -k ./security/bases

# echo "Deploy nexus"
# oc apply -k ./nexus/bases

kustomize build ./demo/overlays/rhpds --reorder none | oc apply -f -
