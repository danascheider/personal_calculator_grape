require "grape"

module PersonalCalculator
  class API < Grape::API

    helpers do 
      def get_age(birthdate_in_iso8601_format)
        today     = Date.today
        birthdate = Date.parse(birthdate_in_iso8601_format)
        age       = today.year - birthdate.year

        age -= 1 if birthdate.yday > today.yday

        age
      end
    end

    desc "Get an age given a birthdate"
    post :age do 
      @request_body = JSON.parse(request.body.read)

      status 200
      {
        request: @request_body,
        age:     get_age(@request_body.fetch("data").fetch("birthdate"))
      }.to_json
    end
  end
end