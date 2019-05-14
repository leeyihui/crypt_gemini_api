class ApiGemini
  def initialize
    @timestamp = DateTime.now.strftime('%Q')

    # ACTUAL ACCOUNT DETAILS
    @api_gemini_url = ENV["API_GEMINI_URL"]
    @gemini_api_key = ENV["GEMINI_API_KEY"]
    @gemini_api_secret = ENV["GEMINI_API_SECRET"]

    # SANDBOX ACCOUNT DETAILS
    # @api_gemini_url = ENV["SANDBOX_API_GEMINI_URL"]
    # @gemini_api_key = ENV["SANDBOX_GEMINI_API_KEY"]
    # @gemini_api_secret = ENV["SANDBOX_GEMINI_API_SECRET"]

  end

  def market_maker
    # Get current bid ask
    request_type = 'get'
    api_path = '/v1/pubticker/' + 'btcusd'

    payload = {
    }

    response_hashes = []

    response = send_api_request(api_path, payload, request_type)

    bid_price = response['bid']
    ask_price = response['ask']
    response_hashes.push(response)


    request_type = 'post'
    api_path = '/v1/order/new'

    payload_1 = {
      'request' => api_path,
      'nonce' => @timestamp,
      'client_order_id' => DateTime.now.strftime('%d %b %Y, %a, %H:%M:%S'),
      'symbol' => 'btcusd',
      'amount' => '0.1',
      'price' => (bid_price.to_f).round(2).to_s,
      'side' => 'buy',
      'type' => 'exchange limit',
      'options' => ['maker-or-cancel']
    }

    puts payload_1

    request_type = 'post'
    api_path = '/v1/order/new'

    payload_2 = {
      'request' => api_path,
      'nonce' => (@timestamp.to_i+1).to_i,
      'client_order_id' => DateTime.now.strftime('%d %b %Y, %a, %H:%M:%S'),
      'symbol' => 'btcusd',
      'amount' => '0.1',
      'price' => (ask_price.to_f - 0.01).round(2).to_s,
      'side' => 'sell',
      'type' => 'exchange limit',
      'options' => ['maker-or-cancel']
    }

    puts payload_2

    response_hashes.push(send_api_request(api_path, payload_1, request_type))
    response_hashes.push(send_api_request(api_path, payload_2, request_type))

    return response_hashes
  end

  def symbols
    request_type = 'get'
    api_path = '/v1/symbols'

    payload = {
    }

    return send_api_request(api_path, payload, request_type)
  end

  def ticker (symbol)
    request_type = 'get'
    api_path = '/v1/pubticker/' + symbol

    payload = {
    }

    return send_api_request(api_path, payload, request_type)
  end

  def current_order_book (symbol)
    request_type = 'get'
    api_path = '/v1/book/' + symbol

    payload = {
    }

    return send_api_request(api_path, payload, request_type)
  end

  def trade_history (symbol)
    request_type = 'get'
    api_path = '/v1/trades/' + symbol

    payload = {
    }

    return send_api_request(api_path, payload, request_type)
  end

  def current_auction (symbol)
    request_type = 'get'
    api_path = '/v1/auction/' + symbol

    payload = {
    }

    return send_api_request(api_path, payload, request_type)
  end

  def auction_history (symbol)
    request_type = 'get'
    api_path = '/v1/auction/' + symbol + '/history'

    payload = {
    }

    return send_api_request(api_path, payload, request_type)
  end

  def get_available_balances
    request_type = 'post'
    api_path = '/v1/balances'

    payload = {
      'request' => api_path,
      'nonce' => @timestamp
    }

    return send_api_request(api_path, payload, request_type)
  end




  def new_order(params)
    request_type = 'post'
    api_path = '/v1/order/new'

    payload = {
      'request' => api_path,
      'nonce' => @timestamp,
      'client_order_id' => DateTime.now.strftime('%d %b %Y, %a, %H:%M:%S'),
      'symbol' => params[:symbol],
      'amount' => params[:amount],
      'price' => params[:price],
      'side' => params[:side],
      'type' => 'exchange limit',
      'options' => [params[:options]]
    }

    return send_api_request(api_path, payload, request_type)
  end


  def cancel_order(order_id)
    request_type = 'post'
    api_path = '/v1/order/cancel'

    payload = {
      'request' => api_path,
      'nonce' => @timestamp,
      'order_id' => order_id
    }

    return send_api_request(api_path, payload, request_type)
  end


  def get_active_orders
    request_type = 'post'
    api_path = '/v1/orders'

    payload = {
      'request' => api_path,
      'nonce' => @timestamp
    }

    return send_api_request(api_path, payload, request_type)
  end

  def get_past_trades (symbol)
    request_type = 'post'
    api_path = '/v1/mytrades'

    # Should be user input (max = 500)
    no_of_trades = 100

    payload = {
      'request' => api_path,
      'nonce' => @timestamp,
      'symbol' => symbol,
      'limit_trades' => no_of_trades
      # Can indicate timestamp to find trades after indicated timestamp
      # 'timestamp' => timestamp
    }

    return send_api_request(api_path, payload, request_type)
  end



  def send_api_request (url_end_point, payload, request_type)
    url = @api_gemini_url + url_end_point
    values = ""

    b64_encoded_json_payload = Base64.strict_encode64(payload.to_json)
    digest = OpenSSL::Digest.new('sha384')
    signature = OpenSSL::HMAC.hexdigest(digest, @gemini_api_secret, b64_encoded_json_payload)

    headers = {
      'Content_Length' => "0",
      'Content_Type' => "text/plain",
      'X-GEMINI-APIKEY' => @gemini_api_key,
      'X-GEMINI-PAYLOAD' => b64_encoded_json_payload,
      'X-GEMINI-SIGNATURE' => signature,
      'Cache-Control': 'no-cache'
    }

    if request_type == 'post'
      response = RestClient.post url, values.to_json, headers
    else
      response = RestClient.get url, headers
    end
    response_hash = JSON.parse(response)

    return response_hash
  end
end
