require "net/http"
require "uri"
require "json"

module OpenAi
  module Http
    Result = Data.define(:json, :success?)

    def self.post(path, data, streaming: false, &callback)
      uri = URI.parse("https://api.openai.com/v1/#{path}")
      req = Net::HTTP::Post.new(uri)
      req["Content-Type"] = "application/json"
      req["Authorization"] = "Bearer #{ENV["OPEN_AI_API_KEY"]}"

      req.body = data.to_json

      Net::HTTP.start(uri.host, uri.port, use_ssl: true) do |http|
        handle_response(http, req) do |res|
          if Net::HTTPSuccess === res
            if streaming
              handle_streaming_response(res, callback)
              Result.new(json: nil, success?: true)
            else
              Result.new(json: JSON.parse(res.body), success?: true)
            end
          else
            Result.new(json: JSON.parse(res.body), success?: false)
          end
        end
      rescue
        Result.new(json: {"error" => {"message" => "Invalid JSON"}}, success?: false)
      end
    end

    # private
    def self.handle_streaming_response(res, callback)
      res.read_body do |chunk|
        callback.call(chunk)
      end
    end

    def self.handle_response(http, req)
      http.request(req) do |res|
        return yield(res)
      end
    end
  end
end
