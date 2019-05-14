Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  get '' => 'main#index', as: :home

  # get '/api_gemini/market_maker' => 'api_gemini#market_maker'

  get '/api_gemini/symbols' => 'api_gemini#symbols'
  get '/api_gemini/ticker/:symbol' => 'api_gemini#ticker'
  get '/api_gemini/current_order_book/:symbol' => 'api_gemini#current_order_book'
  get '/api_gemini/trade_history/:symbol' => 'api_gemini#trade_history'
  get '/api_gemini/current_auction/:symbol' => 'api_gemini#current_auction'
  get '/api_gemini/auction_history/:symbol' => 'api_gemini#auction_history'
  get '/api_gemini/get_available_balances' => 'api_gemini#get_available_balances'


  get '/api_gemini/new_order' => 'api_gemini#new_order'
  get '/api_gemini/cancel_order/:order_id' => 'api_gemini#cancel_order'


  get 'api_gemini/get_active_orders' => 'api_gemini#get_active_orders'
  get 'api_gemini/get_past_trades/:symbol' => 'api_gemini#get_past_trades'
end
