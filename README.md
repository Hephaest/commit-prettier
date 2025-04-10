# commit-prettier
<p align="center">
  <img width="600" alt="commit-prettier" src="https://github.com/Hephaest/commit-prettier/assets/37981444/7e70db6b-d064-4ced-9e9c-567b77855537">
</p>

`commit-prettier` is a light-weight CLI that enhances your commit messages by appending an emoji related to the type of commit you make. It seamlessly integrates with `commitlint`, supporting all standard commit types including:
| Type  | Emoji |
| ------------- | ------------- |
| build  | 🏗️  |
| chore  | 🧹  |
| ci  | 👷  |
| docs  | 📄  |
| feat  | ✨  |
| fix  | 🐛  |
| perf  | ⚡️  |
| refactor  | ♻️  |
| revert  | ⏪️  |
| style  | 🌈  |
| test  | 🧪  |

## Features
- **Emoji Prefixes:** Automatically adds an emoji as a prefix to your commit messages after they pass commitlint checks, making your commit history more expressive and easier to navigate.
- **Branch Name Prefixes:** Automatically adds branch name into commit scope if there is no scope provided (default is off).
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
To integrate `commit-prettier` with Husky (version >= 6.0.0), follow these steps:

1. First, ensure you have Husky installed. If not, please follow the [instructions](https://www.npmjs.com/package/husky).
2. Create a `commit-msg` file in the `.husky` directory with the following content:
```sh
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run commit-prettier $1
```
3. Add `commit-prettier` command into `package.json`:
```json
{
  "scripts": {
    "commit-prettier": "commit-prettier --branch"
  }
}
```

**NOTE:**
Make sure to make the script executable by running:
```bash
chmod +x .husky/commit-msg
```

That's all!

**Optional: work with conventional commits**

It's a great idea to integrate `commit-prettier` with `commitlint`. To make it work, please follow the following steps:
1. Install [@commitlint/cli](https://www.npmjs.com/package/@commitlint/cli) and [@commitlint/config-conventional](https://www.npmjs.com/package/@commitlint/config-conventional) and save as `devDependencies`:
```bash
npm install --save-dev @commitlint/cli @commitlint/config-conventional
```
or
```bash
yarn add --dev @commitlint/cli @commitlint/config-conventional
```
2. Inside the `.husky/commit-msg`:
```bash
#!/usr/bin/env sh
. "$(dirname -- "$0")/_/husky.sh"

npm run commitlint $1 # Add this command before commit-prettier

npm run commit-prettier $1
```
3. Add `commitlint` command into `package.json`:
```json
{
  "scripts": {
    "commitlint": "commitlint --edit"
  }
}
```
4. Add `commitlint.config.js` in the project root directory:
```js
module.exports = {
  extends: ['@commitlint/config-conventional'],
  parserPreset: {
    parserOpts: {
      headerPattern: new RegExp(`^(?<emoji>.*\\s)?(?<type>\\w*)(?<scope>\\(.+\\))?:\\s(?<subject>.*)$`, 'u'),
      headerCorrespondence: ['emoji', 'type', 'scope', 'subject'],
    },
  },
  rules: {
    // We don't need to enforce the subject to be in a specific case.
    'subject-case': [0],
    // Sometimes Jira ticket title would be quite long.
    'header-max-length': [0],
  },
};
```
## Usage
Once everything is set up, you can start committing with:
```bash
git commit -m "feat(homepage): achieve UI revamp 2.0"
// Output: ✨ feat(homepage): achieve UI revamp 2.0
```
If you need to work with a ticket system and have enough of typing this number, you can enable the `--branch` option in your `package.json` file:
```json
{
  "scripts": {
    "commit-prettier": "commit-prettier --branch",
  }
}
```
Then `commit-prettier` will do this for you! 💅
```bash
git commit -m "style: add confetti animation on the login page"
// Output: 🌈 style(JA-1234): add confetti animation on the login page
```

If your team does not require members to follow conventional commits, but you still want formatted commits, this plugin is what you need.
```bash
git commit -m "Achieve UI revamp 2.0"
// Output: ✨ feat(homepage): Achieve UI revamp 2.0
```

