# clang-format-checker

Create a `clang-format-check.yml` file in `.github/workflows/`.
Paste this code into the file:

```yml
on: push
name: Clang Format Checker
jobs:
  lint:
    name: Clang Format Checker
    runs-on: ubuntu-latest
    steps:
    - name: Clang Format Checker
      uses: amhanna/clang-format-checker@v0.0.0
      env:
        GITHUB_TOKEN: ${{ secrets.GITHUB_TOKEN }}
```
