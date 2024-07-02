 ckage main

 - name: Bump version and push tag
      id: tag_version
      uses: mathieudutour/github-tag-action@v6.2
      with:
        github_token: ${{ secrets.GITHUB_TOKEN }}
        t default_bump: patch
