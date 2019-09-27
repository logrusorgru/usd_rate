App.push_rate = App.cable.subscriptions.create "PushRateChannel",
  connected: ->
    # Called when the subscription is ready for use on the server

  disconnected: ->
    # Called when the subscription has been terminated by the server

  received: (data) ->
    # {"rate":98.1974,overwrite":"2019-09-27T01:17:35.000Z"}
    console.log "received data: #{JSON.stringify data}"
    content = document.getElementById 'rate-content'     # textContent
    loading = content.querySelector '#rate-is-loading'
    value = content.querySelector '#rate-value'
    if data.rate == 0 || data.rate == 0.0 || data.rate == null
      value.classList.add 'd-none'
      loading.classList.remove 'd-none'
    else
      value.textContent = "#{data.rate}"
      loading.classList.add 'd-none'
      value.classList.remove 'd-none'
