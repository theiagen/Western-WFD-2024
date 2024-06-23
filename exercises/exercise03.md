# Exercise 3: GitHub Actions & Static Releases
## GitHub Actions
1. Navigate to the [.github/workflows/test.yml](https://github.com/theiagen/Western-WFD-2024/blob/main/.github/workflows/test.yml) file to understand the automated tests implemented for this repository.
  - Based on this file, consider if the changes we made to add gc-calculation and reporting to fastq-peak.sh would pass this test.
    
2. Navigate to the pull request made in the [Week 2 Exercise](https://github.com/theiagen/Western-WFD-2024/blob/main/exercises/exercise02.md) and see if these changes pass the automated test defined in [.github/workflows/test.yml](https://github.com/theiagen/Western-WFD-2024/blob/main/.github/workflows/test.yml)
  - If the checks have failed, click "Details" to investigate further.
<p align="center">
  <img src="../images/e3-2.png" width="1000" class="center">
</p>
4. Propose solutions to resolve these failed tests and implement your proposed solution on your dev branch.

**NOTE**: Workflow files within GitHub require elevated authentication to modify. If you're using a personal access token (PAT), ensure that you have the required workflow scope to modify files in the [.github/workflows/](https://github.com/theiagen/Western-WFD-2024/blob/main/.github/workflows/) directory:
   - **Solution**: Generate a new PAT with the necessary scopes (`repo` and `workflow`).
     - Go to GitHub and generate a new token with `repo` and `workflow` scopes.
     - Update your Git remote URL to use the new token:
       ```bash
       git remote set-url origin https://<your-token>@github.com/theiagen/Western-WFD-2024.git
       ```
     - Replace `<your-token>` with your new PAT.

4. Commit any changes you've made to resolve these issues. If done correctly, you should see that all automated checks now pass:
<p align="center">
  <img src="../images/e3-4.png" width="1000" class="center">
</p>
