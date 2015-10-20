module Deductr 
  module User

    def find_user_by_affiliate_num(affiliate_num)
      r = get("/api/rest/users", query: {affiliate_num: affiliate_num})
      if Array === r 
        r.first
      else
        nil
      end
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

  end
end