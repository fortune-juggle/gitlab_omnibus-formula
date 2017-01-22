require 'serverspec'

# Required by serverspec
set :backend, :exec
describe "gitlab-runsvdir Service" do
  describe service('gitlab-runsvdir') do
     it { should be_enabled   }
     it { should be_running   }
    end

  describe package('gitlab-ee') do
     it { should be_installed }
    end
  describe package('apt-transport-https') do
     it { should be_installed }
    end

  describe file('/etc/gitlab/gitlab.rb') do
     it { should be_file }
     it { should be_mode 600 }
     it { should be_owned_by 'root' }
     it { should be_grouped_into 'root' }
     its(:content) { should match /gitlab.rb.template/ }
    end

  describe file('/lib/systemd/system/gitlab-runsvdir.service') do
     it { should be_file }
     it { should be_mode 600 }
     it { should be_owned_by 'root' }
     it { should be_grouped_into 'root' }
     its(:content) { should match /Description=GitLab Runit supervision process/ }
    end
end
