class PortfoliosController < ApplicationController
  def index
  	@portfolios = @current_user.portfolios.page(params[:page])
  end

  def new
  	@portfolio = @current_user.portfolios.build(:classification => 'TRADING')
  end

  def create
  	@portfolio = @current_user.portfolios.build(params[:portfolio])
  	if @portfolio.save
  		flash[:success] = "Successfully created a portfolio!"
  		redirect_to portfolios_path
  	else
  		render 'new'
  	end
  end

  def show
    @portfolio = @current_user.portfolios.find(params[:id])
    @trades = @portfolio.trades
    @positions = @portfolio.position(DateTime.now)
  end
  def edit
	@portfolio = Portfolio.find(params[:id])
  end
  def update
  	@portfolio = Portfolio.find(params[:id])
  	if @portfolio.update_attributes(params[:portfolio])
  		flash[:success] = "Portfolio updated."
  		redirect_to @portfolio
  	else
  		render 'edit'
  	end
  end

  def destroy
	@portfolio = Portfolio.find(params[:id])
  	@portfolio.destroy
  	flash[:success] = "Portfolio destroyed"
  	redirect_to :back
  end

end