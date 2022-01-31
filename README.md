# Newsletter for the SCS community

This repository contains a [Jekyll](https://jekyllrb.com/)-powered blog for the SCS community digest newsletter.
The generated static site is automatically deployed to GitHub pages on every push: https://sovereigncloudstack.github.io/newsletter/digest/4/

## How do I create a new issue?

Simply create a new `yml`-File under `/digest/` and follow the template of the existing issues.
The recent issue can then be found at `https://sovereigncloudstack.github.io/newsletter/digest/{issue}`

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
