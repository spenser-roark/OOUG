# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.onload = ->
	$('#game-list').on 'change', -> 
		console.log($(this).val())
		console.log(window.location.href.split('?')[0])
		window.location.href = window.location.href.split('?')[0] + "/" + encodeURIComponent($(this).val());

#http://ooug.net/inventory/games/1/Nintendo%20Game%20Cube