# exit when any command fails
set -e
circleci config process inline-orb/config-inline.yml > inline-orb/local-config-inline.yml
circleci local execute -c inline-orb/local-config-inline.yml --job 'job-test-inline-orb'
circleci local execute -c inline-orb/local-config-inline.yml --job 'job-extract-inline-orb'
