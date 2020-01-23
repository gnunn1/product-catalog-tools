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

1. Update the vars/vars.yml file to reflect your cluster
2. Login into your OpenShift cluster using the oc tool with the credentials you want the demo running under
3. Switch to the ansible directory and run the following command:

```ansible-playbook install.yml```

Once the playbook has finished executing, a Jenkins pipeline will build the images and deploy the client and server applications. If you go to the Developer console (4.2) and view the topology it will appear as follows:

![alt text](https://raw.githubusercontent.com/gnunn1/product-catalog-tools/master/docs/img/client-server-database.png)

### Test CI/CD

To test the CI/CD, you can add a logo to the product catalog. The code to do this is commented out and can be found in the [nav.jsx](https://github.com/gnunn1/quarkus-product-catalog/blob/master/client/src/js/components/layouts/nav.jsx#L45) file.

Note that at the moment it takes approximately 10 minutes to run the pipeline with 6 of those minutes compiling quarkus (on a m4.xlarge).


### Uninstall from OpenShift

To uninstall the demo, use the following:

```ansible-playbook uninstall.yml```
