<!--

    Sonatype Nexus (TM) Open Source Version
    Copyright (c) 2020-present Sonatype, Inc.
    All rights reserved. Includes the third-party code listed at http://links.sonatype.com/products/nexus/oss/attributions.

    Sonatype Nexus (TM) Professional Version is available from Sonatype, Inc. "Sonatype" and "Sonatype Nexus" are trademarks
    of Sonatype, Inc. Apache Maven is a trademark of the Apache Software Foundation. M2eclipse is a trademark of the
    Eclipse Foundation. All other trademarks are the property of their respective owners.

-->

CI Debug Notes
================
To validate some circleci stuff, I was able to run a “build locally” using the steps below.
The local build runs in a docker container.

  * (Once) Install circleci client (`brew install circleci`)

  * Convert the “real” config.yml into a self contained (non-workspace) config via:

        circleci config process .circleci/config.yml > .circleci/local-config.yml

  * Run a local build with the following command:
          
        circleci local execute -c .circleci/local-config.yml --job 'circleci-nancy-orb/job-test-run-default'

    With the above command, operations that cannot occur during a local build will show an error like this:
     
      ```
      ... Error: FAILED with error not supported
      ```
    
      However, the build will proceed and can complete “successfully”, which allows you to verify scripts in your config, etc.
      
      If the build does complete successfully, you should see a happy yellow `Success!` message.
