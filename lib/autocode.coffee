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
      for path in atom.project.getPaths()
        project = new autocode path
        project.build()
  
  update: ->
    allowUnsafeNewFunction ->
      for path in atom.project.getPaths()
        project = new autocode path
        project.update()