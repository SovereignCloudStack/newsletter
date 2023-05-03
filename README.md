# Newsletter for the SCS community

This repository contains a [Jekyll](https://jekyllrb.com/)-powered blog for the SCS community digest newsletter.
The generated static site is automatically deployed to GitHub pages on every push: https://sovereigncloudstack.github.io/newsletter/digest/4/

## How do I create a new issue?

Simply create a new `yml`-File under `/digest/` and follow the template of the existing issues.
The recent issue can then be found at `https://sovereigncloudstack.github.io/newsletter/digest/{issue}`

    - The repository must be checked out
    - A new branch has to be created (VS Code > Source Control > Branch > Create Branch)
    - In the folder _digest there are numbered Markdown files which stand for the respective digest. 
    - For a new digest, create a new .md file in the _digest folder with the new number. (Tip: It is best to copy the previous one and change the name. This way you have taken over the layout/structure directly and can change text and links to images). 
    - In the assets folder there are numbered folders which stand for the respective digest. In this folder are all images for the respective digest. 
    - All changes have to be checked in (VS Code > Source Control > Commit & Push).
    - GitHub Homepage > Pull Requests > New Pull Request
    - select previously created branch in "compare:xyz
    - Review changes again, then Create Pull Request
    - Add comment if necessary
    - Create Pull Request
    - Resolve conflicts if necessary
    - Check the "Merge without waiting..." checkbox
    - Squash and merge > Confirm squash and merge 
    - Once the PR is merged, start a gh-action and build an .eml (email) and .html (good for a preview if everything fits) to this address: https://sovereigncloudstack.github.io/newsletter/digest/${number} Replace the variable ${number} with the corresponding digest number. 

## How can I send out the mailing?

The generated `eml`-File can be found at `https://sovereigncloudstack.github.io/newsletter/digest/{issue}/mailing.eml`.
For sending out the mailing to the mailing list, you can use [swaks](http://www.jetmore.org/john/code/swaks/) for instance.

Create a configuration file `.swaksrc` in your home directory and add the following content:
```
--from john.doe@acme.org
-tls
--server smtp.acme.org
--port 587
--auth-user john.doe
--h-Message-ID %MESSAGEID%
```
Use `swaks -d mailing.eml` to send out the downloaded newsletter to a given address.
If you then download the .eml from https://sovereigncloudstack.github.io/newsletter/digest/${number}/mailing.eml you can send it. How to send a mail is described here: https://sovereigncloudstack.github.io/newsletter/digest/ 

GitHub - SovereignCloudStack/newsletter: Newsletter for the SCS community - GitHub
Newsletter for the SCS community. Contribute to SovereignCloudStack/newsletter development by creating an account on GitHub.

scs-member@lists.scs.community
