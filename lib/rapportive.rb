require "rapportive/version"
require "httpi"
require "json"
STATUS_URL = 'https://rapportive.com/login_status' #?user_email={0}
URL = 'https://profiles.rapportive.com/contacts/email' #/{0}
module Rapportive
  class Search
    attr_accessor :session_token
    def initialize
      url = URL
      request = HTTPI::Request.new
      request.url = STATUS_URL
      request.query = {:user_email => "fake_#{rand(10000)}@wadus.com"}#Fake email to get token session
      @session_token = JSON.parse(HTTPI.get(request).body)["session_token"]
    end

    def search(email=nil)
      raise "Should include an email as argument" if email.nil?
      request = HTTPI::Request.new
      request.url = "#{URL}/#{email}"
      request.headers = {'X-Session-Token' => @session_token}
      result = JSON.parse(HTTPI.get(request).body)
      if result["success"] == "nothing_useful"
        # No se ha encontrado nada
        return {error: "Not Found"}
      elsif result["error_code"] || result["error"]
        result
      else
        # data["success"] == "image_and_occupation_and_useful_membership"
        Person.new(result["contact"])
      end
    end
  end

  # 
  class Person
    attr_accessor :email, :twitter_username, :name, :location, :headline, :images, :phones, :occupations, :memberships
    def initialize(data={})
      @email = data["email"]
      @twitter_username = data["twitter_username"]
      @name = data["name"]
      @location = data["location"]
      @headline = data["headline"]
      @images = !data["images"].empty? ? data["images"].map{|a| a["url"]} : [data["image_url_raw"]]
      @phones = data["phones"]
      @occupations = data["occupations"].inject([]){|a, occ| a << Occupation.new(occ)}
      @memberships = data["memberships"].inject([]){|a, mem| a << Membership.new(mem)}

    end
  end

  class Occupation
    attr_accessor :job_title, :company

    def initialize(data={})
      @job_title = data["job_title"]
      @company = data["company"]
    end
  end

  class Membership
    attr_accessor :profile_url, :profile_id, :username, :site_name

    def initialize(data={})
      @profile_url = data["profile_url"]
      @profile_id = data["profile_id"]
      @site_name = data["site_name"]
      @username = data["username"]
    end
  end
end
