require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a Home page at '/'" do
    get '/'
    response.should be_success
  end
  it "should have a Trades page at '/trades'" do
    get '/trades'
    response.should be_success
  end
  it "should have a Portfolios page at '/portfolios'" do
    get '/portfolios'
    response.should be_success
  end
  it "should have a Quotes page at '/quotes'" 
  
  it "should have a About page at '/about'" do
    get '/about'
    response.should be_success
  end
  it "should have a Contact page at '/contact'" do
    get '/contact'
    response.should be_success
  end
  
  
end
