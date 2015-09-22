LanguageJsimView = require './language-jsim-view'
{CompositeDisposable} = require 'atom'

module.exports = LanguageJsim =
  languageJsimView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @languageJsimView = new LanguageJsimView(state.languageJsimViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @languageJsimView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'language-jsim:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @languageJsimView.destroy()

  serialize: ->
    languageJsimViewState: @languageJsimView.serialize()

  toggle: ->
    console.log 'LanguageJsim was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
