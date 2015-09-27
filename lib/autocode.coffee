{CompositeDisposable} = require 'atom'
autocode = require 'autocode-js'
{allowUnsafeNewFunction} = require 'loophole'

module.exports = Autocode =
  autocodeView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'autocode:build': => @build()
    @subscriptions.add atom.commands.add 'atom-workspace', 'autocode:update': => @update()

  deactivate: ->
    @subscriptions.dispose()

  build: ->
    allowUnsafeNewFunction ->
      project = new autocode '/Users/ctate/.autocode/dev/autocode-atom'
      project.build()
  
  update: ->
    allowUnsafeNewFunction ->
      project = new autocode '/Users/ctate/.autocode/dev/autocode-atom'
      project.update()