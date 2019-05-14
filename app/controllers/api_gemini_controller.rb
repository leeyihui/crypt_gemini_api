class ApiGeminiController < ApplicationController
  def index
  end

  def symbols
    response_hash = ApiGemini.new.symbols

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def market_maker
    response_hash = ApiGemini.new.market_maker

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def ticker
    response_hash = ApiGemini.new.ticker(params[:symbol])

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def current_order_book
    response_hash = ApiGemini.new.current_order_book(params[:symbol])

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def trade_history
    response_hash = ApiGemini.new.trade_history(params[:symbol])

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def current_auction
    response_hash = ApiGemini.new.current_auction(params[:symbol])

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def auction_history
    response_hash = ApiGemini.new.auction_history(params[:symbol])

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def get_available_balances
    response_hash = ApiGemini.new.get_available_balances

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def new_order
    response_hash = ApiGemini.new.new_order(params)

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def cancel_order
    response_hash = ApiGemini.new.cancel_order(params[:order_id])

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def get_active_orders
    response_hash = ApiGemini.new.get_active_orders

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end

  def get_past_trades
    response_hash = ApiGemini.new.get_past_trades(params[:symbol])

    respond_to do |format|
      format.json { render json: response_hash }
    end
  end
end
