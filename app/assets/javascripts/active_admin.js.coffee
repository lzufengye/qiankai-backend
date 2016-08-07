#= require active_admin/base
#= require rich
#= require_tree .
#= require dashboard

$(() ->
  controller = $('body').data('controller')
  action = $('body').data('action')
  ActiveAdmin[controller][action]() if ActiveAdmin[controller]? && ActiveAdmin[controller][action]?
)
