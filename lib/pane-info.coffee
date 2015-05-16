PaneInfoView = require './pane-info-view'
{CompositeDisposable} = require 'atom'

module.exports = PaneInfo =
  paneInfoView: null
  modalPanel: null
  subscriptions: null

  activate: (state) ->
    @paneInfoView = new PaneInfoView(state.paneInfoViewState)
    @modalPanel = atom.workspace.addModalPanel(item: @paneInfoView.getElement(), visible: false)

    # Events subscribed to in atom's system can be easily cleaned up with a CompositeDisposable
    @subscriptions = new CompositeDisposable

    # Register command that toggles this view
    @subscriptions.add atom.commands.add 'atom-workspace', 'pane-info:toggle': => @toggle()

  deactivate: ->
    @modalPanel.destroy()
    @subscriptions.dispose()
    @paneInfoView.destroy()

  serialize: ->
    paneInfoViewState: @paneInfoView.serialize()

  toggle: ->
    console.log 'PaneInfo was toggled!'

    if @modalPanel.isVisible()
      @modalPanel.hide()
    else
      @modalPanel.show()
