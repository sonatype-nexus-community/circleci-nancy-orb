<!--

    Sonatype Nexus (TM) Open Source Version
    Copyright (c) 2020-present Sonatype, Inc.
    All rights reserved. Includes the third-party code listed at http://links.sonatype.com/products/nexus/oss/attributions.

    Sonatype Nexus (TM) Professional Version is available from Sonatype, Inc. "Sonatype" and "Sonatype Nexus" are trademarks
    of Sonatype, Inc. Apache Maven is a trademark of the Apache Software Foundation. M2eclipse is a trademark of the
    Eclipse Foundation. All other trademarks are the property of their respective owners.

-->

# test-circleci-nancy-orb

The existence of this sub-folder README.md is evidence of "room for improvement" in the Orb development process,
and/or my ignorance of a "better way" to do it. 

If you use a "real" orb (not-inline, but rather imported via the `orbs` section of
a config.yml), this requires publishing your changes to a "development" orb version
(e.g.: my-orb@dev:alpha). Even after publishing that dev:alpha orb, the 
version of the dev:alpha orb exercised by a CI build is one step out of date. Blech!

In short, to have a manageable code/test/change
cycle when developing a CircleCI Orb, you pretty much need to have an [inline orb](https://circleci.com/docs/2.0/orb-author/#writing-inline-orbs)
to use with local testing. An "inline orb" will always be up-to-date while running tests locally.

Now comes the ugly part: When you feel good about a set of changes made to your inline-orb,
you then export the inline orb using the command below. Then copy/paste the exported inline-orb
source onto the 'real' orb source (`src/orb.yml`). (Feel dirty yet? You should.) 

Previously I created an entirely separate github project to house the inline-orb.
Instead, now I'm attempting to stash the inline-orb madness in the same project as the 
'real' orb. So it's getting better right?

I'm totally open to better solutions, so please reach out with ideas!

### Development Process

1. Edit the inline-orb (my-inline-orb) contained in the file: [config-inline.yml](config-inline.yml)
1. Process the inline config into a locally executable config, and run a local CircleCI build via the command below:

       circleci config process inline-orb/config-inline.yml > inline-orb/local-config-inline.yml && circleci local execute -c inline-orb/local-config-inline.yml --job 'job-test-inline-orb' 

   The last argument specifies which 'job' to run from the generated file: `inline-orb/local-config-inline.yml`.
   
   If the local build completes successfully, you should see a happy yellow `Success!` message at the end.

1. When you feel good and saucy about your new inline-orb changes, you can extract that orb using the commands below:

       circleci config process inline-orb/config-inline.yml > inline-orb/local-config-inline.yml && circleci local execute -c inline-orb/local-config-inline.yml --job 'job-extract-inline-orb' 

   If the local build completes successfully, you should see a happy yellow `Success!` message at the end.

   You can then copy the output (from after the first `version 2.1` snippet, to before the last `jobs:` snippet)
   onto your [real orb](../src/orb.yml).
   
   The following script will execute both commands above, and will error out if something fails.
   
   [inline-orb/runcircle-local-inline.sh](../inline-orb/runcircle-local-inline.sh)
   
Wash, rinse, repeat.
