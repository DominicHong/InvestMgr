require 'spec_helper'

describe TradesController do
  render_views
  before{request.env["HTTP_REFERER"] ||= "where i came from"}

  describe "GET 'index'" do
    it "should be successful" do
      get :index
      response.should be_success
    end
  end

  describe "GET 'new'" do
    it "should be successful" do
      get :new
      response.should be_success
    end
  end

  describe "POST 'create'" do

    describe "failure" do
      before(:each) do
        @portfolio = FactoryGirl.create(:portfolio, :user => get_current_user)
        @stock = FactoryGirl.create(:stock)
        @attr = { :buy => true,
                  :trade_date => DateTime.parse("2011-07-25"),
                  :clear_date => DateTime.parse("2011-07-25"),
                  :vol => -10.00,
                  :price => 20.00,
                  :fee => 1.5,
                  :security_id => @stock.id
                  }
      end
      it "should not create a trade" do
        lambda do
          post :create, :trade => @attr
        end.should_not change(Trade, :count)
      end

      it "should render the 'new' page after failure" do
        post :create, :trade => @attr
        response.should render_template('new')
      end
    end

    describe "success" do
      before(:each) do
        @portfolio = FactoryGirl.create(:portfolio, :user => get_current_user)
        @stock = FactoryGirl.create(:stock)
        @attr = { :portfolio_id => @portfolio.id,
                  :state => 1,
                  :buy => true,
                  :trade_date => DateTime.parse("2011-07-25"),
                  :clear_date => DateTime.parse("2011-07-25"),
                  :vol => 100.00,
                  :price => 20.00,
                  :fee => 1.5,
                  :security_id => @stock.id
                  }
      end
      it "should create a trade" do
        lambda do
          post :create, :trade => @attr
        end.should change(Trade, :count).by(1)
      end
      it "should redirect to the trade index page" do
        post :create, :trade => @attr
        response.should redirect_to(trades_path)
      end
    end
  end

  describe "DELETE 'destroy' " do
    before{@trade = FactoryGirl.create(:trade)}

    it "should destroy the trade" do
      lambda do
        delete :destroy, :id => @trade
      end.should change(Trade, :count).by(-1)
    end

    it "should redirect to the previous page" do
      delete :destroy, :id => @trade
      response.should redirect_to "where i came from"
    end
  end

end
