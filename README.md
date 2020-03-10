### Introduction

This is an OpenShift demo of a product catalog using React for the front-end with Quarkus providing APIs as the back-end. The back-end was originally written in PHP and then ported to Quarkus.

![alt text](https://raw.githubusercontent.com/gnunn1/product-catalog-tools/master/docs/img/screenshot.png)

### Running demo locally

To run the demo locally on your laptop, you will need to have a MySQL or MariaDB database available. You will need to create a product database using the SQL in this repo and then update the quarkus application.properties file to reflect the location of the database.

To run the quarkus application, execute ```mvn quarkus:dev``` from the root directory.

To run the client application, go into the client directory and run ```npm run start```.

### Install on OpenShift

To install the application in OpenShift, use the ansible-playbook in the ansible directory. Note that this playbook uses the [k8s](https://docs.ansible.com/ansible/latest/modules/k8s_module.html) module so you will need to ensure you have it's pre-reqs installed.

Please follow these steps to install the demo:

1. Update the vars/vars.yml file to reflect your cluster, **specifically your wildcard domain if you don't it will not work!**
2. Login into your OpenShift cluster using the oc tool with the credentials you want the demo running under
3. Switch to the ansible directory and run the following command:

```ansible-playbook install.yml```

Once the playbook has finished executing, a Jenkins pipeline will build the images and deploy the client and server applications. If you go to the Developer console (4.2) and view the topology it will appear as follows:

![alt text](https://raw.githubusercontent.com/gnunn1/product-catalog-tools/master/docs/img/client-server-database.png)

### Test CI/CD

When you install the demo, you have a choice to install it using Jenkins or Tekton for CI/CD. Note that Tekton is in tech preview and if you want to use it you must first install the OpenShift Pipelines operator.

To test the CI/CD, you can add a logo to the product catalog. The code to do this is commented out and can be found in the [nav.jsx](https://github.com/gnunn1/quarkus-product-catalog/blob/master/client/src/js/components/layouts/nav.jsx#L45) file.

Once you make the code change, start the client pipeline (Jenkins or Tekton). Note that in Tekton the GUI does not support creating a new PipelineRunTask with a workspace, if you want to drive it from a GUI go into the PipelineRuns and simple rerun an existing one.

![alt text](https://raw.githubusercontent.com/gnunn1/product-catalog-tools/master/docs/img/tekton-rerun.png)


### Uninstall from OpenShift

To uninstall the demo, use the following:

```ansible-playbook uninstall.yml```