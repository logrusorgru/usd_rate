App.push_rate = App.cable.subscriptions.create "PushRateChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # {"mantissa":98,"fraction":1974,"overwrite":"2019-09-27T01:17:35.000Z"}
    console.log "received data: #{JSON.stringify data}"
    value = "Загружается..."
    if data.mantissa != 0 && data.fraction != 0
      value = "#{data.mantissa}.#{data.fraction}"
    document.getElementById("rate").textContent = value
