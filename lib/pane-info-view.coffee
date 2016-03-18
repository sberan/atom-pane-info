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
    visiblePanes = (p for p in atom.workspace.getPanes() when p.paneInfo)
    if visiblePanes.length > 1 and activeItem instanceof TextEditor
      path = activeItem?.getPath().split('/').slice(-atom.config.get('pane-info.depth'))
      @element.innerHTML = "<div>" + path.join('</div><div>')  + "</div>"
      @element.hidden = false
      if pane.isActive()
        @element.classList.add('active')
      else
        @element.classList.remove('active')
    else
      @element.hidden = true
