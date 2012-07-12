require 'spec_helper'

describe "LayoutLinks" do
  
  it "should have a Home page at '/'" do
    visit '/'
  end
  it "should have a Trades page at '/trades'" do
    visit '/trades'
  end
  it "should have a Portfolios page at '/portfolios'" do
    visit '/portfolios'
  end
  it "should have a Quotes page at '/quotes'" 

  it "should have a About page at '/about'" do
    visit '/about'
  end
  it "should have a Contact page at '/contact'" do
    visit '/contact'
  end
  
  
end
