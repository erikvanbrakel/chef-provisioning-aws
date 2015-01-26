require 'chef/provider/aws_provider'
require 'date'

class Chef::Provider::AwsInternetGateway < Chef::Provider::AwsProvider
  action :create do
    converge_by "Creating new internet gateway" do
      gateway = ec2.internet_gateways.create()
      gateway.tags['Name'] = new_resource.name
    end

    gateway.attach(new_resource.vpc)

    ec2.route_tables.main_route_table.create_route("0.0.0.0/0", { :internet_gateway => gateway.id })

    new_resource.save
  end
end
