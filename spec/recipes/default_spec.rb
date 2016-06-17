require 'spec_helper'

describe 'delphic_aws::default' do
  subject { default_chef_run }

  before :each do
    stub_command(/.*/).and_return true
  end

  let(:res) { subject.remote_file('aws cli') }
  it { is_expected.to install_package 'unzip' }
  it { is_expected.to create_remote_file 'aws cli' }
  it { expect(res).to notify('directory[/tmp/aws-cli]').to(:create).immediately }
  it { expect(res).to notify('remote_file[cp aws cli]').to(:create).immediately }
  it { expect(res).to notify('execute[unzip cli]').to(:run).immediately }
  it { expect(res).to notify('execute[install cli]').to(:run).immediately }

  it { expect(subject.directory('/tmp/aws-cli')).to do_nothing }
  it { expect(subject.remote_file('cp aws cli')).to do_nothing }
  it { expect(subject.execute('unzip cli')).to do_nothing }
  it { expect(subject.execute('install cli')).to do_nothing }

  it do
    is_expected.to delete_directory('aws build delete').with(
      recursive: true
    )
  end

  it { is_expected.to include_recipe 'delphic_aws::audit' }
end
