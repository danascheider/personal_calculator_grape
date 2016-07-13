require "rambo_helper"

RSpec.describe "Personal Calculator", type: :rambo do

  # Delete output files from previous test run prior to running tests again
  before(:all) do
    Dir.foreach("spec/contract/output") do |file|
      next unless file.match(/\.json$/)

      File.delete(File.join("spec/contract/output", file))
    end
  end

  describe "/age" do
    let(:route) { "/age" }

    describe "POST" do
      let(:headers) do 
        {
          "Content-Type" => "application/json"
        }
      end
      
      let(:request_body) do
        File.read("spec/support/examples/age_post_request_body.json")
      end

      let(:response_schema) do
        File.read("spec/support/examples/age_post_response_schema.json")
      end

      let(:output_file) do
        "spec/contract/output/age_post_response.json"
      end

      it "calculate age given a birthdate" do
        post route, request_body, headers

        File.open(output_file, "w+") {|file| file.puts JSON.pretty_generate(JSON.parse(last_response.body)) }

        expect(last_response.body).to match_schema response_schema
      end

      it "returns status 200" do
        post route, request_body, headers
        expect(last_response.status).to eql 200
      end
    end
  end
end
