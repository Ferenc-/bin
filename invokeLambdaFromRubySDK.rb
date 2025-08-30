#!/usr/bin/env ruby

require "aws-sdk-lambda"

credentials = Aws::Credentials.new(
  '', # aws_access_key_id
  '' # aws_secret_access_key
)

ENV['AWS_REGION'] = 'eu-central-1'
lambda_client = Aws::Lambda::Client.new(credentials: credentials)

payload = nil
params = { function_name: ''} # TODO: Fill in
params[:payload] = payload unless payload.nil?

response = lambda_client.invoke(params)
puts response
