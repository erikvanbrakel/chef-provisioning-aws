require 'chef/resource/aws_resource'
require 'chef/provisioning/aws_driver'

class Chef::Resource::AwsInternetGateway < Chef::Resource::AwsResource
  self.resource_name = 'aws_internet_gateway'
  self.databag_name = 'aws_internet_gateway'

  actions :create, :delete, :nothing
  default_action :create

  attribute :name, :kind_of => String, :name_attribute => true
  attribute :vpc_name, :kind_of => String

  def initialize(*args)
    super
  end

  def after_created
    super
  end
end
