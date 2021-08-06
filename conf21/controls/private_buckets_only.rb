gcp_project_id = input('gcp_project_id')

control 'private_buckets_only' do
  title 'Private buckets only'

  desc <<-DESC
  Ensure there are only private buckets in an account
  DESC

  google_storage_buckets(project: gcp_project_id).bucket_names.each do |bucket_name|
     google_storage_bucket_iam_policy(bucket: bucket_name).bindings.each_with_index do |binding, i|
      describe "Bucket IamPolicy #{bucket_name} IamPolicyBindings[#{i}] members allAuthenticatedUsers or allUsers" do
        subject { binding.members.select { |b| b.match(/allAuthenticatedUsers|allUsers/) } }
        its('count') { should eq 0 }
      end
    end
  end

end