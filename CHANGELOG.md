# ufw Cookbook CHANGELOG
This file is used to list changes made in each version of the ufw cookbook.

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
