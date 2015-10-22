require 'httparty'

module Deductr
  class Client
    include HTTParty
    include User

    @access_token = nil
    @refresh_token = nil
    @affiliate_id = nil

    def initialize(affiliate_id: , public_key: , secret_key:, base_uri: "https://app.deductr.com/")
      @affiliate_id = affiliate_id
      self.class.base_uri base_uri 
      data = { grant_type: "client_credentials", 
                    scope: "account_write", 
                  client_id: public_key }
      result = self.class.post("/api/oauth/token", 
                                    basic_auth: {username: public_key, password: secret_key},
                                    body: data)
      #  {"access_token"=>"MDEwYjY5OGE3ZDE2NjhjYzJkYjc0NTM5MTIzYTg4NGRmYTRlMDc0NGQ2OGNkNGE3NjcwZTEwNjI5YTI1NmQ2Mw", 
      #    "expires_in"=>3600, "token_type"=>"bearer", 
      #    "scope"=>"single_sign_on account_read account_write setup_read setup_write data_read data_write banklink_read banklink_write reports_read", "refresh_token"=>"YzQyNzg1NGM0MDk0MzUwYzNlYzk5YTg0Y2YxMmZiYWU0Y2NjMDExODcwZmI1MjgyNGVkMjNjMzdmZjFjZTY4Nw"}
      @access_token = result["access_token"]
      @refresh_token = result["refresh_token"]
      raise "Unable to get access_token: got back: #{result.to_s}" if @access_token == nil
    end

    def get(endpoint, opts = {})
      _add_options(opts)
      _normalize self.class.get(endpoint, opts)
    end

    def post(endpoint, opts = {})
      _add_options(opts)
      _normalize self.class.post(endpoint, opts)
    end

    def access_token
      @access_token
    end

    def refresh_token
      @refresh_token
    end

    private
      def _add_options(opts)
        headers = (opts[:headers] ||= {})
        headers["Authorization"] ||= "Bearer " + @access_token 

        query = (opts[:query] ||= {})
        query[:affiliate] ||= @affiliate_id
        puts "\n\nDeductr::Client options: #{opts}\n\n"
      end

      def _normalize(response)
        case response.parsed_response
        when Hash
          Hashie::Mash.new response.parsed_response
        when Array 
          response.parsed_response.map{|x| Hashie::Mash.new(x) }
        else 
          response.parsed_response 
        end
      end
  end
end