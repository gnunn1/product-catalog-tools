echo "Creating projects"
oc new project product-catalog-dev
oc new-project product-catalog-test
oc new-project product-catalog-cicd

echo "Creating product-catalog-dev project"
kustomize build ./app/overlays/dev --reorder none | oc create -f -
echo "Creating product-catalog-test project"
kustomize build ./app/overlays/test --reorder none | oc create -f -
echo "Creating product-catalog-cicd project"
kustomize build ./cicd/overlays/std --reorder none | oc create -f -