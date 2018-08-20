# Wercker `npm-ci` step

Excecutes `npm ci` command for **strict** project installations that utilize a
`package-lock.json` or `npm-shrinkwrap.json` file intended for automation
environments.

Key differences from [`npm-install`](https://app.wercker.com/steps/wercker/npm-install) are:

- Project **must** have `package-lock.json` or `npm-shrinkwrap.json`
- If `node_modules` is present, it will be removed before install
- Dependency check failures will fail instead of updating package lock

## Options

| | Description | Optional | Default |
|--|--|--|--|
| `use-cache` | Utilize the npm cache | ✅  | `true` |
| `clear-cache-on-failed` | If command fails, clear cache and try again | ✅  | `true` |
| `options` | Arbitrary options passed to `npm ci` command | ✅  | |

## Example

```yaml
build:
  steps:
    - mvandervliet/npm-ci
```

## Credit

The code in this wercker step is essentially a clone of
[wercker/step-npm-install](https://github.com/wercker/step-npm-install), and
simply modified for the purposes of executing `npm ci` instead.

## License

The MIT License (MIT)