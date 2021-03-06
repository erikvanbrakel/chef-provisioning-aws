require 'chef/provider/aws_provider'
require 'date'

class Chef::Provider::AwsInternetGateway < Chef::Provider::AwsProvider
  action :create do

    if existing_gateway == nil
      converge_by "Creating new internet gateway" do
        gateway = ec2.internet_gateways.create()
        gateway.tags['Name'] = new_resource.name

        existing_vpc = ec2.vpcs.with_tag('Name', new_resource.vpc_name).first

        gateway.attach(existing_vpc)

        existing_vpc.route_tables.main_route_table.create_route("0.0.0.0/0", { :internet_gateway => gateway.id })

        new_resource.save
      end
    end
  end

  def existing_gateway
    @existing_vpc ||= begin
      ec2.internet_gateways.with_tag('Name', new_resource.name).first
    rescue
      nil
    end    
  end
end
