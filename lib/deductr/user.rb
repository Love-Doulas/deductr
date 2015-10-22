module Deductr 
  module User

    def find_user(deductr_user_id)
      get("/api/rest/users/#{deductr_user_id}")
    end

    def find_user_by_affiliate_num(affiliate_num)
      r = get("/api/rest/users", query: {affiliate_num: affiliate_num})
      (Array === r ) ? r.first : nil
    end

    def create_user(affiliate_num: , platform_num: , first_name: , last_name: , email: , options: {})
      options[:first_name] = first_name
      options[:last_name] = last_name
      options[:email] = email
      post("/api/rest/users", headers: {"Content-Type" => "application/json"},
                                 body: options.to_json,
                                query: {affiliate_num: affiliate_num,
                                        platform_num: platform_num})
    end

    def initialize_user(deductr_user_id, language: "en", jurisdiction: "us" )
      post("/api/rest/users/#{deductr_user_id}/initialize", headers: {"Content-Type" => "application/json"},
                                 body: {}.to_json,
                                 query: {language: language, jurisdiction: jurisdiction})
    end

    def find_user_subscription(deductr_user_id)
      r = get("/api/rest/users/#{deductr_user_id}/subscriptions")
      (Array === r ) ? r.first : nil
    end

    def create_user_subscription(deductr_user_id, options: {})
      post("/api/rest/users/#{deductr_user_id}/subscriptions", headers: {"Content-Type" => "application/json"},
                                 body: {}.to_json)
    end


  end
end