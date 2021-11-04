# clang-format-checker

Create a `clang-format-check.yml` file in `.github/workflows/`.
Paste this code into the file:

```yml
name: clang-format-checker
on: push
jobs:
  lint:
    name: clang-format-checker
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/clang-format-check'
    steps:
      - uses: actions/checkout@v2
      - uses: amahanna/clang-format-checker@v0.0.8
        with:
          sources: "src/*.cpp,src/*.h"
```
