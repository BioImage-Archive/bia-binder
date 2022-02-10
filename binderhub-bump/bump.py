#!/usr/bin/env python
# Must be run from the directory containing helmsman.yaml

import requests
from ruamel.yaml import YAML
# semver>=3.0.0-dev.2
import semver


# Using ruamel instead of pyyaml allows round-tripping (preserves formatting)
# of the input YAML file
yaml = YAML(typ='rt')
yaml.preserve_quotes = True
yaml.indent(mapping=2, offset=2, sequence=4)


with open('helmsman.yaml') as fin:
    helmsman = yaml.load(fin)
current = helmsman['appsTemplates']['binderhub']['version']
print(f'Current version: {current}')


helmindex = 'https://jupyterhub.github.io/helm-chart/index.yaml'
y = yaml.load(requests.get(helmindex).content)
component = y['entries']['binderhub']
# component = y['entries']['jupyterhub']

valid_semver = []
invalid_semver = []
for e in component:
    try:
        e['semver'] = semver.Version.parse(e['version'])
        valid_semver.append(e)
    except ValueError:
        invalid_semver.append(e)

ordered_by_version = sorted(valid_semver, key=lambda e: e['semver'])
releases = [e for e in ordered_by_version if not e['semver'].prerelease]

print(f'Found {len(component)} versions including {len(releases)} releases')
print(f'Ignored {len(invalid_semver)} invalid versions')
if releases:
    print(f"Latest available release: {releases[-1]['version']}")
latest = ordered_by_version[-1]['version']
print(f'Latest available version including prereleases: {latest}')

if current != latest:
    print(f'Updating version: {current} ➜ {latest}')
    helmsman['appsTemplates']['binderhub']['version'] = latest
    with open('helmsman.yaml', 'w') as fout:
        yaml.dump(helmsman, fout)
else:
    print(f'Already up to date: {current}')
