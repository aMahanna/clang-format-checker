# clang-format-checker

Checks your files using the `.clang-format` of your repo. Fails on any clang-format error.

Create a `clang-format-checker.yml` file in `.github/workflows/`.
Paste this code into the file:

```yml
name: clang-format-checker
on: push
jobs:
  lint:
    name: clang-format-checker
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: aMahanna/clang-format-checker@v1.1.0
        with:
          sources: "src/Card.h src/Card.cpp lib/**/*.h"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```

### Common use case:

See https://github.com/Ana06/get-changed-files

```yml
name: clang-format-checker
on: push
jobs:
  lint:
    name: clang-format-checker
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - uses: Ana06/get-changed-files@v2.0.0
        id: gcf
        with:
          filter: |
            **/*.cpp
            **/*.hpp
            **/*.c
            **/*.h
      - uses: aMahanna/clang-format-checker@v1.1.0
        with:
          sources: "${{ steps.gcf.outputs.added_modified }}"
        env:
          GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```