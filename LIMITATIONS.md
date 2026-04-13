# Limitations

## Package Availability

### APT (Debian/Ubuntu)

- Debian 12 (Bookworm): `ufw` is available as the distro package `0.36.2-1`
- Debian 13 (Trixie): `ufw` is available as the distro package `0.36.2-9`
- Ubuntu 22.04 (Jammy): `ufw` is available as the distro package `0.36.1-4ubuntu0.1`
- Ubuntu 24.04 (Noble): `ufw` is available as the distro package `0.36.2-6`

`ufw` is shipped by Debian and Ubuntu directly rather than through a separate upstream vendor
APT repository, so this cookbook should rely on the platform package manager instead of adding a
custom repository.

### DNF/YUM (RHEL family)

- No official `ufw` package path was identified for RHEL-family distributions that aligns with the
  current cookbook scope

### Zypper (SUSE)

- No official `ufw` package path was identified for SUSE distributions that aligns with the
  current cookbook scope

## Architecture Limitations

- Ubuntu publishes the `ufw` source package for architecture `all`, which indicates the package is
  architecture-independent
- Debian publishes `ufw` from a single source package across the supported Debian suites in this
  cookbook, so the cookbook does not need architecture-specific package selection logic

## Source/Compiled Installation

### Build Dependencies

| Platform Family | Packages |
|-----------------|----------|
| Debian          | None for normal cookbook usage |

`ufw` is packaged as a distro-managed userspace tool and does not require a compiled-from-source
installation flow for the supported Debian and Ubuntu targets in this cookbook.

## Known Issues

- This cookbook should stay Debian/Ubuntu-only unless a separate, verified package source is added
  for other platform families
- Ubuntu 20.04 is no longer in standard support as of April 13, 2026, so it should not remain in
  the active test matrix
- Debian 10 and Ubuntu 18.04 are fully out of support and should not remain in the active test
  matrix
