# commit-prettier
<p align="center">
  <img width="600" alt="commit-prettier" src="https://github.com/Hephaest/commit-prettier/assets/37981444/7e70db6b-d064-4ced-9e9c-567b77855537">
</p>

`commit-prettier` is an innovative tool that enhances your commit messages by appending an emoji related to the type of commit you make. It seamlessly integrates with `commitlint`, supporting all standard commit types including:
| Type  | Emoji |
| ------------- | ------------- |
| build  | 🏗️  |
| chore  | 🧹  |
| ci  | 👷  |
| docs  | 📄  |
| feat  | ✨  |
| fix  | 🐞  |
| perf  | ⚡️  |
| refactor  | ♻️  |
| revert  | ⏪️  |
| style  | 🌈  |
| test  | 🧪  |

## Features
- **Emoji Prefixes:** Automatically adds an emoji as a prefix to your commit messages after they pass commitlint checks, making your commit history more expressive and easier to navigate.
- **Commitlint Compatibility:** Fully compatible with all commitlint types, ensuring your commit messages are both fun and professional.
- **Easy Integration:** Works with existing git hooks and can be integrated smoothly into your workflow.

## Getting Started
### Installation
Using npm:
```bash
npm install --save-dev commit-prettier
```
or if you prefer using Yarn:
```bash
yarn add --dev commit-prettier
```
### Setup
To integrate `commit-prettier` with Husky (version >= 8.0.0), follow these steps:

1. First, ensure you have Husky installed. If not, please follow the [instructions](https://www.npmjs.com/package/husky).
2. Create a `commit-msg` file in the `.husky` directory with the following content:
```sh
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run commit-prettier $1
```

**NOTE:** 
Make sure to make the script executable by running:
```bash
chmod +x .husky/commit-msg
```
## Usage
Once everything is set up, you can start committing with:
```bash
git commit -m "feat(homepage): achieve UI revamp 2.0"
```
This will trigger the commit message hook, and after passing the commitlint check, commit-prettier will automatically prepend an appropriate emoji, resulting in:
```bash
✨ feat(homepage): achieve UI revamp 2.0
```
