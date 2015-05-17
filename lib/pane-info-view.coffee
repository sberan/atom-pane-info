{TextEditor} = require('atom')

module.exports =
class PaneInfoView
  constructor: (pane) ->
    # Create root element
    @element = document.createElement('div')
    @element.classList.add('pane-info')

  destroy: ->
    @element.remove()

  getElement: ->
    @element

  update: (pane) ->
    activeItem = pane.getActiveItem()
    activePanes = (pane for pane in atom.workspace.getPanes() when pane.paneInfo)
    if activePanes.length > 1 and activeItem instanceof TextEditor
      @element.textContent = activeItem?.getTitle?()
      @element.hidden = false
    else
      @element.hidden = true