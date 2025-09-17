# ufw Cookbook CHANGELOG

This file is used to list changes made in each version of the ufw cookbook.

## Unreleased

Standardise files with files in sous-chefs/repo-management

## 4.0.9 - *2025-09-04*

## 4.0.8 - *2024-11-18*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 4.0.7 - *2024-07-15*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 4.0.6 - *2024-05-03*

## 4.0.5 - *2024-05-03*

## 4.0.4 - *2023-09-28*

## 4.0.3 - *2023-09-11*

## 4.0.2 - *2023-07-10*

## 4.0.1 - *2023-05-17*

## 4.0.0 - *2023-04-25*

- Finalaize Sous-Chefs adoption
- Update workflow to 2.0.2
- Require Chef 15.3
- Change node.normal for node.default
  - Chef/Correctness/NodeNormal: Do not use node.normal. Replace with default/override/force_default/force_override attribute levels. (<https://docs.chef.io/workstation/cookstyle/chef_correctness_nodenormal>)

## 3.2.14 - *2023-04-07*

Standardise files with files in sous-chefs/repo-management

## 3.2.13 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 3.2.12 - *2023-04-01*

Standardise files with files in sous-chefs/repo-management

## 3.2.11 - *2023-03-20*

Standardise files with files in sous-chefs/repo-management

## 3.2.10 - *2023-03-15*

Standardise files with files in sous-chefs/repo-management

## 3.2.9 - *2023-02-27*

## 3.2.8 - *2023-02-27*

## 3.2.7 - *2023-02-23*

Standardise files with files in sous-chefs/repo-management

## 3.2.6 - *2023-02-15*

## 3.2.5 - *2023-02-15*

Standardise files with files in sous-chefs/repo-management

## 3.2.4 - *2022-12-15*

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

Standardise files with files in sous-chefs/repo-management

## 3.2.3 - *2021-08-30*

- Standardise files with files in sous-chefs/repo-management

## 3.2.2 - *2021-06-01*

- resolved cookstyle error: recipes/default.rb:36:15 convention: `Style/HashEachMethods`
- resolved cookstyle error: recipes/default.rb:44:7 convention: `Style/HashEachMethods`

## 3.2.1 (2018-10-04)

- Update README.md formatting

## 3.2.0 (2018-07-24)

- allow rules attribute to be specified as Hash

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

- [COOK-3592] - allow source ports to be defined as a range in ufw

## v0.6.4

### Bug

- [COOK-3316] - Fix README.md example

## v0.6.2

### Bug

- [COOK-2487]: when setting a node attribute you must specify the precedence
- [COOK-2982]: ufw cookbook has foodcritic failures
