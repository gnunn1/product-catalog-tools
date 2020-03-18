echo "Creating projects"
oc new-project product-catalog-dev
oc new-project product-catalog-test
oc new-project product-catalog-cicd

echo "Adding rolebindings"
oc apply -k ./security/bases

# echo "Deploy nexus"
# oc apply -k ./nexus/bases

# Use the overlay that makes sense, here we are using a Code Ready Containers overlay
kustomize build ./demo/overlays/crc --reorder none | oc apply -f -