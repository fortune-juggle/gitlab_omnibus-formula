  describe package('gitlab-ce') do
     it { should be_installed }
    end
  describe package('apt-transport-https') do
     it { should be_installed }
    end

  describe file('/etc/gitlab/gitlab.rb') do
     it { should be_file }
     it { should be_mode 0600 }
     it { should be_owned_by 'root' }
     it { should be_grouped_into 'root' }
     its('size') { should be > 1 }
     its(:content) { should match '## GitLab configuration settings' }
    end
