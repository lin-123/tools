require './utils/service'

new Vue
  el: 'body'
  data: ->
    currentView: 'home'
    params: {}

  components:
    home: require './components/home'