# README

<!-- File: README.md -->
<!-- Author: YJ -->
<!-- Email: yj1516268@outlook.com -->
<!-- Created Time: 2021-04-23 16:46:31 -->

---

## Table of Contents

<!-- vim-markdown-toc GFM -->

* [Build & Upload](#build--upload)
    * [Build](#build)
    * [Upload](#upload)
* [Example configuration](#example-configuration)
* [Usage](#usage)

<!-- vim-markdown-toc -->

---

Python log wrapper

---

## Build & Upload

### Build

1. `python3 -m pip install --upgrade build`
2. `python3 -m build`

### Upload

1. `python3 -m pip install --upgrade twine`
2. `python3 -m twine upload --repository pypi dist/*`

## Example configuration

```toml
[log]
to_console = true
console_level = 'DEBUG'
to_file = true
format = '%(asctime)s | %(levelname)-8s | <%(threadName)s> %(module)s.%(funcName)s [%(lineno)d]: %(message)s'
```

- `to_console`: whether to output log to STDOUT, use it during debugging, and close it during formal deployment
- `console_level`: log level, optional values are 'DEBUG', 'INFO', 'WARNING', 'ERROR', 'CRITICAL'
- `to_file`: whether to output log to file
- `format`: format of the log

## Usage

```python
from logwrapper import get_logger

log_conf = {
    'to_console': True,
    'console_level': 'DEBUG',
    'to_file': True,
    'format': '''%(asctime)s | %(levelname)-8s | <%(threadName)s> %(module)s.%(funcName)s [%(lineno)d]: %(message)s'''
}


def main():
    """docstring for main"""
    logger = get_logger(logfolder='logs', config=log_conf)

    logger.warning('Warning text')
    logger.error('Error text')
    logger.critical('Error text')


if __name__ == "__main__":
    main()
```
