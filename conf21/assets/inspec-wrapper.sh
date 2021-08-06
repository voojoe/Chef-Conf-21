#!/bin/sh

# Render templates
erb /inspec/inspec-config.json.erb > /inspec/inspec-config.json || exit
erb /inspec/inspec-attrs.yml.erb > /inspec/inspec-attrs.yml || exit

# Execute InSpec
inspec exec /inspec/inspec-profile.tar.gz -t gcp:// \
    --config=/inspec/inspec-config.json \
    --input-file=/inspec/inspec-attrs.yml \
    --chef-license=accept-silent

# Cleanup
rm /inspec/inspec-config.json
rm /inspec/inspec-attrs.yml
