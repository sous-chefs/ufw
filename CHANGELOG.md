# ufw Cookbook CHANGELOG
This file is used to list changes made in each version of the ufw cookbook.

## 3.1.1 (2018-01-03)

- Fix failure in recipes recipe from issue #21
- Update apache2 license string
- Call 'concat' on an array instead of on the node object

## 3.1.0 (2017-03-02)

- Add use of the default['firewall']['allow_ssh'] attribute in the default recipe. Default for this cookbook is set to true, as the default recipe assumed that ssh would be enabled.

## 3.0.0 (2017-03-01)
- Require Chef 12.4 (Depends on firewall which requires Chef 12.4+ at this point)
- Update default to remove installation of ufw which is duplication from firewall cookbook, and remove state changes
  - Due to the change in default recipe, bumping major version in case this is breaking change for some.
- Added debian platform as firewall cookbook supports ufw on debian

## 2.0.0 (2016-11-25)
- Add chef_version metadata + remove chef 11 compat
- Replace node.set with node.normal
- Require Chef 12.1
- Fix the recipe to properly converge

## v1.0.0 (12-14-2015)
- Update to use / require the Firewall v2.0.0+ cookbook, which requires Chef 12
- Updated all Opscode references to Chef Software Inc.
- Updated testing, contributing, and maintainers docs
- Added source_url and issues_url metadata for supermarket
- Resolved all rubocop warnings and add the standard Chef rubocop file
- Added travis and supermarket version badges to the readme
- Added requirements section to the readme
- Added a chefignore file
- Added a Rakefile for simplified testing
- Added a basic converge chefspec

## v0.7.4
No change. Version bump for toolchain

## v0.7.2
Updating metadata to depend on firewall >= 0.9

## v0.7.0
[COOK-3592] - allow source ports to be defined as a range in ufw

## v0.6.4
### Bug
- **[COOK-3316](https://tickets.chef.io/browse/COOK-3316)** - Fix README.md example

## v0.6.2
### Bug
- [COOK-2487]: when setting a node attribute you must specify the precedence
- [COOK-2982]: ufw cookbook has foodcritic failures
