control_group 'aws cli compliance' do
  control 'AWS CLI Installation & Cleanup' do
    describe command('/usr/local/bin/aws --version') do
      it 'reports the correct version as 1.7.43' do
        expect(subject.stdout).to match(/1\.7\.43/)
      end
    end
    describe file '/tmp/aws-cli' do
      it 'deletes the /tmp/aws-cli directory' do
        expect(subject).to_not be_a_directory
      end
    end
  end
end
