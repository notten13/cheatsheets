# NPM

## Version range syntax

| Syntax   | Example          | What it means                                        |
| -------- | ---------------- | ---------------------------------------------------- |
| Exact    | "1.2.3"          | Install version 1.2.3 exactly and never update       |
| Tilde    | "~1.2.3"         | Accepts patches: >= 1.2.3 < 1.3.0                    |
| Caret    | "^1.2.3"         | Accepts patches and minor upgrades: >= 1.2.3 < 2.0.0 |
| Wildcard | "*"              | Accepts any version                                  |
| Ranges   | ">1.2.3 < 1.5.4" | Custom range                                         |

## Commands

Some are confusing especially `install` vs. `update`:

### `npm install`

- installs all dependencies as defined in the lockfile.
- package.json and lockfile unchanged.

### `npm install <package_name>`

- installs the latest version that matches the range in package.json
- both package.json and lockfile are updated
- Example:
  - package.json specifies `"lodash": "^3.0.0"`
  - lockfile has "3.0.0"
  - `npm install lodash`
  - package.json: `"lodash": "^3.10.1"` (the last published version that matches
    "^3.0.0")
  - Same in lockfile
  - Version 4 is not considered

### `npm install <package_name>@<version_range>`

- installs the latest version that matches version range
- updates both package.json and lockfile

### `npm update`

- updates all packages to the latest version that matches their version range in
  package.json
- **DOES NOT UPDATE package.json**
- updates lockfile

- `npm update <package_name>`

- same as above, for specified package
