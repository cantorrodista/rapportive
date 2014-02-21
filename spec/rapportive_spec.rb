require 'rapportive'
describe Rapportive::Search do
  it "should create a new Rapportive client with a valid token" do
    client = Rapportive::Search.new
    client.should_not be_nil
    client.session_token.should_not be_nil
  end

  it "should search for an email" do
    client = Rapportive::Search.new
    client.should_not be_nil
    client.session_token.should_not be_nil
    result = client.search('cantorrodista@gmail.com')
    result.should_not be_nil
    result.twitter_username.should == "cantorrodista"
    result.name.should == "Alfredo Solano Rodrigo"
    result.occupations.first.should_not be_nil
    result.memberships.first.should_not be_nil
  end

  it "should return no result for a not valid email" do
    client = Rapportive::Search.new
    client.should_not be_nil
    client.session_token.should_not be_nil
    result = client.search('xxxx@ddddddddd.com')
    result.should_not be_nil
    result[:error].should == "Not Found"
  end

end