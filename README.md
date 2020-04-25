This playbook triggers a nightly build of the moxie GNU toolchain on
travis-ci.

In order for the playbook to work, we need:

- a Project called `moxie`
- an image stream created by `oc create -f ImageStream.yaml`
- a container image created by `oc create -f BuildConfig.yaml`

Ansible Tower runs this playbook as a scheduled task every night.


