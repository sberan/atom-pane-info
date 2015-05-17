PaneInfoView = require './pane-info-view'
{CompositeDisposable} = require 'atom'

module.exports =
  subscriptions: null

  activate: (state) ->
    @subscriptions = new CompositeDisposable
    
    @subscriptions.add = atom.workspace.observePanes (pane) =>
      pane.paneInfo = paneInfo = new PaneInfoView(state)
      atom.views.getView(pane).appendChild(paneInfo.getElement())
      pane.onDidDestroy =>
        pane.paneInfo.destroy()
        pane.paneInfo = null
        @updatePanes()

    @subscriptions.add = atom.workspace.observeActivePaneItem () =>
      @updatePanes()

  deactivate: ->
    @subscriptions.dispose()

  updatePanes: ->
    atom.workspace.getPanes().forEach (pane) ->
      pane.paneInfo?.update(pane);

