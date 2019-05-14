// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
$( document ).on('turbolinks:load', function() {


  $('#content_management_api_gemini').on('click', '.market_maker', function() {
    $('.market_maker').addClass('loading')

    $.ajax({
      method: "GET",
      url: '/api_gemini/market_maker'
    }).done(function(data) {
      console.log(data)
      $('.market_maker').removeClass('loading')
    })
  })


  $('#content_management_api_gemini').on('click', '.symbols', function() {
    $('.symbols').addClass('loading')

    $.ajax({
      method: "GET",
      url: '/api_gemini/symbols'
    }).done(function(data) {
      console.log(data)
      $('.symbols').removeClass('loading')
    })
  })

  $('#content_management_api_gemini').on('click', '.ticker', function() {
    console.log($(this).attr('data-value'))
    $('.ticker').addClass('loading')

    $.ajax({
      method: "GET",
      url: '/api_gemini/ticker/' + $(this).attr('data-value')
    }).done(function(data) {
      console.log(data)
      $('.ticker').removeClass('loading')
    })
  })

  var stop_refresh = false

  function refresh_current_order_book(symbol) {
    $.ajax({
      method: "GET",
      url: '/api_gemini/current_order_book/' + symbol
    }).done(function(data) {
      for(i = 0; i < 50; i++) {
        if(typeof data['asks'][i] === 'undefined') {
          $('#ask_price_' + i).text('')
          $('#ask_volume_' + i).text('')
        } else {
          $('#ask_price_' + i).text(data['asks'][i]['price'])
          $('#ask_volume_' + i).text(data['asks'][i]['amount'])
        }
        if(typeof data['bids'][i] === 'undefined') {
          $('#bid_price_' + i).text('')
          $('#bid_volume_' + i).text('')
        } else {
          $('#bid_price_' + i).text(data['bids'][i]['price'])
          $('#bid_volume_' + i).text(data['bids'][i]['amount'])
        }
      }

      if(typeof data['bids'][0] !== 'undefined' && typeof data['asks'][0] !== 'undefined') {
        $('#spread').text((data['asks'][0]['price'] - data['bids'][0]['price']).toFixed(countDecimals(data['asks'][0]['price'])))
      }

      if (stop_refresh) {
        return
      } else {
        refresh_current_order_book(symbol)
      }
    })
  }

  // Default current order book feed is btcusd
  refresh_current_order_book('btcusd')

  // Scoll table to show bid ask spread
  document.getElementById("ask_price_4").scrollIntoView();

  $('#currency_pairing_dropdown_for_current_order_book').dropdown({
    onChange: function(value, text, $selectedItem) {
      stop_refresh = true
      setTimeout(function() {
        refresh_current_order_book($('#currency_pairing_dropdown_for_current_order_book').dropdown('get value'))
        stop_refresh = false
      }, 2000)
    }
  })

  $('#content_management_api_gemini').on('click', '.current_order_book', function() {
    console.log($(this).attr('data-value'))
    $('.current_order_book').addClass('loading')

    $.ajax({
      method: "GET",
      url: '/api_gemini/current_order_book/' + $(this).attr('data-value')
    }).done(function(data) {
      console.log(data)
      $('.current_order_book').removeClass('loading')
    })
  })

  $('#content_management_api_gemini').on('click', '.trade_history', function() {
    console.log($(this).attr('data-value'))
    $('.trade_history').addClass('loading')

    $.ajax({
      method: "GET",
      url: '/api_gemini/trade_history/' + $(this).attr('data-value')
    }).done(function(data) {
      console.log(data)
      $('.trade_history').removeClass('loading')
    })
  })

  $('#content_management_api_gemini').on('click', '.current_auction', function() {
    console.log($(this).attr('data-value'))
    $('.current_auction').addClass('loading')

    $.ajax({
      method: "GET",
      url: '/api_gemini/current_auction/' + $(this).attr('data-value')
    }).done(function(data) {
      console.log(data)
      $('.current_auction').removeClass('loading')
    })
  })

  $('#content_management_api_gemini').on('click', '.auction_history', function() {
    console.log($(this).attr('data-value'))
    $('.auction_history').addClass('loading')

    $.ajax({
      method: "GET",
      url: '/api_gemini/auction_history/' + $(this).attr('data-value')
    }).done(function(data) {
      console.log(data)
      $('.auction_history').removeClass('loading')
    })
  })

  get_available_balances()

  $('#content_management_api_gemini').on('click', '.get_available_balances', function() {
    get_available_balances()
  })


  get_active_orders()

  $('#content_management_api_gemini').on('click', '.get_active_orders', function() {
    get_active_orders()
  })


  $('#content_management_api_gemini').on('click', '.cancel_order', function() {
    $.ajax({
      method: "GET",
      url: '/api_gemini/cancel_order/' + this.id
    }).done(function(data) {
      get_active_orders()
      get_available_balances()
    })
  })



  $('#side_dropdown').dropdown()

  $('#options_dropdown').dropdown()

  $('#currency_pairing_dropdown').dropdown({
    onChange: function(value, text, $selectedItem) {
      // custom action
      $('#currency_primary').text(value.substring(0,3).toUpperCase())
      $('#currency_secondary').text(value.substring(3,6).toUpperCase())
      $('#currency_secondary_two').text(value.substring(3,6).toUpperCase())
    }
  })

  $('#amount').keyup(function() {
    $('#total').val($('#amount').val() * $('#price').val())
  })

  $('#price').keyup(function() {
    $('#total').val($('#amount').val() * $('#price').val())
  })

  $('#new_order_form_container').on('click', '#submit_order_button', function() {

    $('#new_order_form_container').addClass('loading')

    input_data = {
      symbol: $('#currency_pairing_dropdown').dropdown('get value'),
      amount: $('#amount').val(),
      price: $('#price').val(),
      side: $('#side_dropdown').dropdown('get value'),
      options: $('#options_dropdown').dropdown('get value')
    }

    $.ajax({
      method: "GET",
      url: '/api_gemini/new_order',
      data: input_data
    }).done(function(data) {
      get_active_orders()
      get_available_balances()
      $('#new_order_form_container').removeClass('loading')
    })
  })






  $('#content_management_api_gemini').on('click', '.get_past_trades', function() {
    $('.get_past_trades').addClass('loading')

    $.ajax({
      method: "GET",
      url: '/api_gemini/get_past_trades/' + $(this).attr('data-value')
    }).done(function(data) {
      console.log(data)
      $('.get_past_trades').removeClass('loading')
    })
  })



})


function countDecimals(value) {
  if(Math.floor(value) === value)
    return 0
  else
    return value.toString().split(".")[1].length || 0
}

function get_available_balances() {
  $('.get_available_balances').addClass('loading')

  $.ajax({
    method: "GET",
    url: '/api_gemini/get_available_balances'
  }).done(function(data) {
    for(j = 0; j < 6; j++) {
      $('#available_balance_currency_' + j).text(data[j]['currency'])
      $('#available_balance_amount_' + j).text(data[j]['amount'])
      $('#available_balance_available_' + j).text(data[j]['available'])
      $('#available_balance_available_for_withdrawal_' + j).text(data[j]['availableForWithdrawal'])
    }
    $('.get_available_balances').removeClass('loading')
  })
}

function get_active_orders() {
  $('.get_active_orders').addClass('loading')

  $.ajax({
    method: "GET",
    url: '/api_gemini/get_active_orders'
  }).done(function(data) {
    $('#active_orders_table_body').empty()
    for(k = 0; k < data.length; k++) {
      $('#active_orders_table_body').append('<tr><td>'+data[k]['client_order_id']+'</td><td class="center aligned">'+data[k]['symbol'].toUpperCase()+'</td><td class="center aligned">'+data[k]['side'].toUpperCase()+'</td><td class="center aligned">'+data[k]['options'][0].toUpperCase()+'</td><td class="right aligned">'+data[k]['price']+'</td><td class="right aligned">'+data[k]['original_amount']+'</td><td class="right aligned">'+data[k]['price'] * data[k]['original_amount']+'</td><td class="right aligned">'+(data[k]['executed_amount']/data[k]['original_amount']*100).toFixed(0)+'% Filled</td><td class="collapsing selectable cancel_order" id="'+data[k]['order_id']+'"><div class="ui label">Cancel Order</div></td></tr>')
    }
    $('.get_active_orders').removeClass('loading')
  })
}
