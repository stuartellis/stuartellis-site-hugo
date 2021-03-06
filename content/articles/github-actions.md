+++
Title = "Using GitHub Actions"
Slug = "github-actions"
Date = "2021-02-17T21:53:00+00:00"
Description = ""
Categories = ["automation", "devops"]
Tags = ["github", "automation", "devops"]
Type = "article"
Toc = true

+++

[GitHub Actions](https://docs.github.com/en/actions) provides continuous integration and deployment on GitHub repositories. Use it in conjunction with [GitHub artifact storage](https://docs.github.com/en/actions/guides/storing-workflow-data-as-artifacts) and [Dependabot](https://docs.github.com/en/github/administering-a-repository/keeping-your-dependencies-updated-automatically) to maintain your projects. 

<!--more-->

## Summary

GitHub Actions uses YAML syntax to define the events, jobs, and steps. These YAML files are stored in your code repository, in a directory called *.github/workflows*.

Each time that you push a change to the code repository, GitHub automatically processes the workflows files. You can also trigger actions [manually or by API call](https://github.com/actions/starter-workflows/blob/main/automation/manual.yml).

> GitHub Actions configures shells to "fail fast" whenever possible, which stops a script immediately if one of the commands in that script exits with an error code.

## Runners

[GitHub provides Linux, Windows and macOS runners](https://docs.github.com/en/actions/reference/specifications-for-github-hosted-runners). These are preloaded with popular tools and programming languages.

The Linux runners use LTS versions of Ubuntu, and the macOS runners offer current versions of macOS. The Linux and macOS virtual machines both run using passwordless sudo.

Windows virtual machines are configured to run as administrators with User Account Control (UAC) disabled. Windows runners use PowerShell as the default shell.

You can also use [service containers](https://docs.github.com/en/actions/guides/about-service-containers) alongside the main GitHub runner.

> If your workflows use Docker container actions or service containers, then you must use a Linux runner.

You can get details and build code for the current runners from the [virtual-environments GitHub repository](https://github.com/actions/virtual-environments).

If you wish, you can also [host your own runners](https://docs.github.com/en/actions/hosting-your-own-runners).

## Artifacts

By default, GitHub stores build logs and artifacts for 90 days, and this retention period can be customized:

https://docs.github.com/en/actions/guides/storing-workflow-data-as-artifacts

## Caching

The cache action will attempt to restore a cache based on the key you provide. When the action finds a cache, the action restores the cached files to the path you configure.

You can optionally provide a list of restore keys to use when the key doesn't match an existing cache. A list of restore keys is useful when you are restoring a cache from another branch because restore keys can partially match cache keys.

```yaml
      - name: Cache Node.js modules
        uses: actions/cache@v2
        env:
          cache-name: cache-node-modules
        with:
          path: ~/.npm
          key: ${{ runner.os }}-build-${{ env.cache-name }}-${{ hashFiles('**/package-lock.json') }}
          restore-keys: |
            ${{ runner.os }}-build-${{ env.cache-name }}-
            ${{ runner.os }}-build-
```

A workflow can access and restore a cache created in the current branch, the base branch (including base branches of forked repositories), or the default branch (usually main).

> See the [actions/cache repository](https://github.com/actions/cache) for examples with popular languages.

## Updating Dependencies with Dependabot

[Dependabot is now integrated with GitHub](https://docs.github.com/en/github/administering-a-repository/keeping-your-dependencies-updated-automatically). You enable Dependabot updates by checking a *dependabot.yml* configuration file in to your repository's *.github/* directory.

When Dependabot identifies an outdated dependency, it raises a pull request to update the manifest to the latest version of the dependency. For vendored dependencies, Dependabot raises a pull request to directly replace the outdated dependency with the new version. You check that your tests pass, review the changelog and release notes included in the pull request summary, and then merge it.

If you enable security updates, Dependabot also raises pull requests to update vulnerable dependencies. By default, it breaks these up into up to five pull requests.

Dependabot checks for manifest files on the default branch and raises pull requests for version updates against this branch. Use *target-branch* to specify a different branch for manifest files and for pull requests.

By default, Dependabot checks for new versions at 05:00 UTC.

### Enabling Version Updates

>  Dependabot version updates are currently in beta and subject to change.

After you enable version updates, you'll see a new Dependabot tab in the dependency graph for the repository. This tab shows which package managers Dependabot is configured to monitor and when Dependabot last checked for new versions.

### Dependabot for GitHub Actions

Always configure Dependabot to check your GitHub Actions:

```yaml
version: 2
updates:

  # Enable version updates for GitHub Actions
  - package-ecosystem: "github-actions"
  directory: "/"
  schedule:
    # Check for updates to GitHub Actions every weekday
    interval: "daily"
```

### Dependabot for Docker Images

Dependabot can check the Docker images that you use:

```yaml
# Enable version updates for Docker
- package-ecosystem: "docker"
  # Look for a `Dockerfile` in the `root` directory
  directory: "/"
  schedule:
    # Check for updates once a week
    interval: "weekly"
```

### Dependabot for Node.js

Dependabot can check the npm packages that you use:

```yaml
# Enable version updates for Node.js
- package-ecosystem: "npm"
  # Look for a `package.json` in the `root` directory
  directory: "/"
  schedule:
    # Check for updates every weekday
    interval: "daily"
```

### Dependabot for Python

Dependabot can check the Python packages that you use:

```yaml
# Enable version updates for Python
- package-ecosystem: "pip"
  # Look in the `root` directory
  directory: "/"
  schedule:
    # Check for updates every weekday
    interval: "daily"
```

> Dependabot requires [recent versions of pip, Poetry, or pip-tools](https://docs.github.com/en/github/administering-a-repository/configuration-options-for-dependency-updates#package-ecosystem).

## Pricing

[GitHub pricing](https://github.com/pricing) provides a free tier for public repositories, and 2,000 Actions minutes/month.

## Best Practices

- [Security Hardening Documentation](https://docs.github.com/en/actions/learn-github-actions/security-hardening-for-github-actions)
- [Caching](https://docs.github.com/en/actions/guides/caching-dependencies-to-speed-up-workflows)
- [Keeping Actions Upto Date with Dependabot](https://docs.github.com/en/github/administering-a-repository/keeping-your-actions-up-to-date-with-dependabot)

## Other Resources

- [Node.js Support](https://github.com/marketplace/actions/setup-node-js-environment)
- [Python Support](https://github.com/marketplace/actions/setup-python)
- [Official AWS Actions](https://github.com/aws-actions)
- [Starter Workflows](https://github.com/actions/starter-workflows)
- [Migrating from Azure Pipelines](https://docs.github.com/en/actions/learn-github-actions/migrating-from-azure-pipelines-to-github-actions)
- [Act](https://github.com/nektos/act) - A tool that runs GitHub Actions locally
