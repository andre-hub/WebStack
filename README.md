# WebStack

WebStack is a minimal stack for modern web development.

**Based on
 - bower (nodejs, npm)
 - material-design-lite
 - html5shiv.js
 - lodash.js
 - validate.js
 - react

### Install

Download the [latest release](https://raw.githubusercontent.com/andre-hub/WebStack/master/make-webstack.sh)
```
$ curl https://raw.githubusercontent.com/andre-hub/WebStack/master/make-webstack.sh > make-webstack.sh \
	&& chmod +x make-webstack.sh && ./make-webstack.sh
```

### Make our website / webapp


Download the project maker and set variables for the projectname and license.
Supported licenses: mit, bsd, apache, gpl3, public (domain)

```
$ projectName="NewProject"; license="gpl3,mit,apache, ..." && \
curl https://raw.githubusercontent.com/andre-hub/WebStack/master/make-new-project.sh > make-new-project.sh \
&& chmod +x make-new-project.sh && ./make-new-project.sh ${projectName} ${license}
```

## License

Created by and copyright André Grötschel
Released under the [MIT license](LICENSE.md).