# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

alertCloseHandler = (alert) ->
	(event) ->
		alert.style.display = 'none';

alertClose = (alert) ->
	close = alert.querySelector 'button.close[data-dismiss=alert]'
	if close?
		close.addEventListener 'click', alertCloseHandler (alert)

load = (event) ->
	for alert in document.querySelectorAll('div.alert.alert-success')
		alertClose alert

document.addEventListener 'DOMContentLoaded', load
