require 'spec_helper'

## see http://serverspec.org/
describe command '/usr/local/bin/aws --version 2>&1' do
  its(:exit_status) { should eq 0 }
  its(:stdout) { should match /.*(1\.7\.43).*/ }
end

cmd = '/usr/local/bin/aws ec2 describe-instances ' \
               '--instance-id '\
               '$(curl -sq http://169.254.169.254/latest/meta-data/instance-id/) ' \
               '--region us-east-1'

describe command cmd do
  its(:exit_status) { should eq 255 }
end

describe file '/tmp/aws-cli' do
  it { should_not be_a_directory }
end

