# BinderHub Custom Files

This repository holds a template for customising a Binder homepage.

See the [BinderHub Customisation documentation](https://binderhub.readthedocs.io/en/latest/customizing.html#template-customization) for more details.

## How to change the logo on your Binder homepage

#### 1. Fork this repo.

#### 2. Upload your custom logo image into the `static` folder in your fork.

This can be any valid image type, for example PNG, JPEG, SVG...

#### 3. Edit `page.html` in the `templates` folder in your fork.

Change `<custom-logo-file>` on line 3 of [`page.html`](templates/page.html) to the name of your custom logo file.

#### 4. Edit your `config.yaml` file

Add the following  to your `config.yaml` file.

```
config:
  BinderHub:
    template_path: /etc/binderhub/custom/templates
    extra_static_path: /etc/binderhub/custom/static
    extra_static_url_prefix: /extra_static/
    template_variables:
        EXTRA_STATIC_URL_PREFIX: "/extra_static/"

initContainers:
  - name: git-clone-templates
    image: alpine/git
    args:
      - clone
      - --single-branch
      - --branch=master
      - --depth=1
      - --
      - https://github.com/<your-github-username>/binderhub-custom-files
      - /etc/binderhub/custom
    securityContext:
      runAsUser: 0
    volumeMounts:
      - name: custom-templates
        mountPath: /etc/binderhub/custom
extraVolumes:
  - name: custom-templates
    emptyDir: {}
extraVolumeMounts:
  - name: custom-templates
    mountPath: /etc/binderhub/custom
```

**NOTES:**
* Remember to replace `<your-github-username>` in the repo URL
* If you have commited the changes in steps [2](#2-upload-your-custom-logo-image-into-the-static-folder-in-your-fork) or [3](#3-edit-pagehtml-in-the-templates-folder-in-your-fork) to any other branch of your fork, you either need to merge to `master` or change the `--branch=` argument to match the name of your branch.

#### 5. Upgrade your BinderHub and visit the Binder page

Upgrade your BinderHub with the following command.

```
helm upgrade <hub-name> jupyterhub/binderhub --version=0.2.0-<commit-hash> -f path/to/secret.yaml -f path/to/config.yaml
```

where `<hub-name>` is the `nam`/`namespace` you gave to your BinderHub when you deployed it, and `<commit-hash>` is the version of the BinderHub Helm Chart you deployed.
Other Helm Chart commit hashes are available [here](https://jupyterhub.github.io/helm-chart/#development-releases-binderhub).

Now visit your Binder page to see your new logo!
To get the IP address, run the following command and copy the output of `EXTERNAL-IP` into a browser.

```
kubectl get svc binder --namespace <hub-name>
```
