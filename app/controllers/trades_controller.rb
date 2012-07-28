class TradesController < ApplicationController
  helper_method :sort_column, :sort_direction
  def index
  	@trades = Trade.includes(:portfolio).includes(:security).order(sort_column + " " + sort_direction).page(params[:page])
  end

  def create
  	begin
  		portfolio = @current_user.portfolios.find_by_id(params[:trade][:portfolio_id])
  		@trade = portfolio.trades.build
  		@trade.update_attributes(params[:trade])
  		if @trade.save
  			flash[:success] = "Successfully created a trade!"
  			redirect_to trades_path
  		else
  			flash[:failure] = "Unable to save the trade " 
  			render 'new'
  		end	
  	rescue Exception => e
  		flash[:failure] = "#{e.to_s}"
  		@trade = Trade.new
  		render 'new'
  	end
  end

  def update
  end

  def destroy
    @trade = Trade.find(params[:id])
    @trade.destroy
    flash[:success] = "Trade destroyed"
    redirect_to :back
  end

  def show
  end
  
  def new
  	@trade = Trade.new
  end

  private
    
  def sort_column
    column_names = ["portfolios.name"] + Trade.column_names.map { |e| "trades." + e } + Security.column_names.map { |e| "securities." + e }
    column_names.include?(params[:sort]) ? params[:sort] : "portfolios.name"
  end
  
  def sort_direction
    %w[asc desc].include?(params[:direction]) ? params[:direction] : "asc"
  end	
end
