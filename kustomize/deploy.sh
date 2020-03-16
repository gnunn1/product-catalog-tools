echo "Creating projects"
oc new-project product-catalog-dev
oc new-project product-catalog-test
oc new-project product-catalog-cicd

echo "Adding rolebindings"
oc apply -k ./security/bases

echo "Deploy nexus"
oc apply -k ./nexus/bases

echo "Creating product-catalog-dev project"
kustomize build ./app/overlays/dev --reorder none | oc apply -f -
echo "Creating product-catalog-test project"
kustomize build ./app/overlays/test --reorder none | oc apply -f -
echo "Creating product-catalog-cicd project"
kustomize build ./cicd/overlays/std --reorder none | oc apply -f -
