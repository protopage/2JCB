#Document Setup
document.body.style.cursor = "auto"
Framer.Extras.Hints.disable()
Framer.Extras.ShareInfo.disable()
Framer.Extras.Preloader.enable()
# Sketch
sketch = Framer.Importer.load("imported/2_JCv_B1-redesigned-2@1x")
{Artboard, tooltips, hovers, tooltipReport1, tooltipReport2, tooltipDynamic1, tooltipDynamic2, tooltipPixel, hoverReport1, hoverReport2, hoverDynamic1, hoverDynamic2, hoverPixel} = sketch
#Scroll
scroll = ScrollComponent.wrap(Artboard)
scroll.scrollVertical = true
scroll.scrollHorizontal = false
scroll.mouseWheelEnabled = true
scroll.width = document.documentElement.clientWidth
scroll.height = document.documentElement.clientHeight
scroll.content.draggable = false

# Make a scroll bar
# ------------------------------------------------------------
	
scrollBar = new Layer
	x: Align.right
	width: 24
	height: Screen.height * (Screen.height / scroll.content.height)
	backgroundColor: ""

scrollBarShape = new Layer
	parent: scrollBar
	x: 8
	y: 8
	width: scrollBar.width - 16
	height: scrollBar.height - 16
	backgroundColor: "#8A8A8A"
	borderRadius: 100


# Move scroll bar on scroll
# ------------------------------------------------------------

scroll.onMove ->
	progress = scroll.scrollY / (scroll.content.height - scroll.height)
	scrollBar.y = progress * (Screen.height - scrollBar.height)


# Make scroll bar draggable
# ------------------------------------------------------------

scrollBar.draggable.enabled = true
scrollBar.draggable.horizontal = false
scrollBar.draggable.constraints =
	height: Screen.height

scrollBar.onDrag ->
	progress = scrollBar.y / (Screen.height - scrollBar.height)
	scroll.scrollY = progress * (scroll.content.height - scroll.height)


Canvas.onResize ->
	scroll.size = Canvas.size
	scrollBar.x = Align.right
#Tooltips
hovers = [hoverReport1, hoverReport2, hoverDynamic1, hoverDynamic2, hoverPixel]

tooltipsArray = [tooltipReport1, tooltipReport2, tooltipDynamic1, tooltipDynamic2, tooltipPixel]


createHovers = (index) ->
	hovers[index].onMouseOver ->
		tooltipsArray[index].visible = true
	hovers[index].onMouseOut ->
		tooltipsArray[index].visible = false

for i in [0...hovers.length]
	tooltipsArray[i].visible = false
	createHovers(i)
Artboard.x = Align.center