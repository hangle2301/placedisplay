# Import file "Contacts-Prototype-Final"
sketch = Framer.Importer.load("imported/Contacts-Prototype-Final@1x")
# CURSOR CHANGE & SCROLLING
document.body.style.cursor = "auto"
Framer.Extras.Hints.disable()
Framer.Extras.Preloader.setLogo("https://radiusintel-wpengine.netdna-ssl.com/wp-content/themes/vate/src/serve/assets/images/common/radius-logo.svg")

#Make interactive
makeInteractive = (object) ->
	object.onMouseOver ->
		document.body.style.cursor = "pointer"
	object.onMouseOut ->
		document.body.style.cursor = "auto"

# Make scroll
# Include a Layer 
scroll = ScrollComponent.wrap(sketch.everything)
scroll.width = Screen.width
scroll.height = Screen.height
scroll.mouseWheelEnabled = true
sketch.everything.draggable.enabled = false

# Project Info
# This info is presented in a widget when you share.
# http://framerjs.com/docs/#info.info

Framer.Info =
	title: ""
	author: "Hang Le"
	twitter: ""
	description: ""


# ---- LEFT SIDE ------ #
showMore = sketch.show_more
collapse = sketch.collapse
leftTopShort = sketch.Business_BG_short
leftTopExpand = sketch.Business_BG_expand
leftlist = leftTopExpand.children
leftBottom = sketch.bottom
space = 40
leftBottom.xy= leftTopShort.y + space
leftBottom.originalY = leftBottom.y
leftTopExpand.opacity = 0

makeInteractive(showMore)
makeInteractive(collapse)

for listItem in leftlist
	listItem.opacity = 0
	
showMore.onClick ->
	leftTopExpand.opacity = 1
	showMore.opacity = 0
	for listItem2,itemIndex in leftlist	
		listItem2.animate
			properties:
				opacity: 1
			time: 0.2
			delay: itemIndex * 0.05
	leftBottom.animate
		properties:
			y: leftTopExpand.y + leftTopExpand.height + space
		time: 0.3	
collapse.onClick ->
	collapse.opacity = 0
	for listItem2,itemIndex in leftlist	
		listItem2.animate
			properties:
				opacity: 0
			time: 0.2
	leftBottom.animate
		properties:
			y: leftBottom.originalY
		time: 0.2	
		delay:0.2
	showMore.animate
		properties:
			opacity: 1
		time: 0.2
		delay: 0.2

# ---- RIGHT SIDE ------ #
# Clicking 
switcher = sketch.switcher
clickLocation = sketch.locations
clickCompany = sketch.accounts
clickContact = sketch.contacts
#Associating
clickCompany.panel = sketch.accountPanel
clickLocation.panel = sketch.locationPanel
clickContact.panel = sketch.contactPanel
line = sketch.line
hoverLine = sketch.hover_line
hoverLine.opacity = 0
# Charts
clickCompany.panel.charts = [sketch.new, sketch.open, sketch.won, sketch.lost]
clickLocation.panel.charts = [sketch.new1, sketch.open1, sketch.won1, sketch.lost1]
clickContact.panel.charts = [sketch.new2, sketch.open2, sketch.won2, sketch.lost2]

makeInteractive(clickLocation)
makeInteractive(clickCompany)
makeInteractive(clickContact)
#Hovering
titles = [clickCompany, clickLocation, clickContact]
current = 0

for titleBlock in titles
	titleBlock.panel.opacity = 0
	
	for chart in titleBlock.panel.charts
		chart.originY = 1
		chart.originalHeight = chart.height
	
	titleBlock.onMouseOver ->
		if(this.panel.opacity == 0)
			hoverLine.x = this.x
			hoverLine.opacity = 0
			hoverLine.animate
				properties:
					opacity: 1
				time: 0.5
				curve: "bezier-curve"
	titleBlock.onMouseOut ->
		if(this.panel.opacity == 0)
			hoverLine.animate
				properties:
					opacity: 0
				time: 0.3
	titleBlock.onClick ->		
		# Chart animation
		for chartLine,chartIndex in titles[current].panel.charts
			chartLine.animateStop()
			chartLine.animate
				properties:
					scaleY: this.panel.charts[chartIndex].height / chartLine.height
				time: 0.5
			chartLine.animate
				properties:
					scaleY: 1
				time: 0.1
				delay: 0.5
		# Title animation
		current = titles.indexOf(this)
		for titleBlock2, indexBlock2 in titles
			if(indexBlock2 != current)
				titleBlock2.panel.animate
					properties:
						opacity: 0
					time: 0.1
					delay: 0.5
		this.panel.animate
			properties:
				opacity: 1
			time: 0.1
			delay: 0.5
		line.animate
			properties:
				x: titles[current].x
			time: 0.3	
			curve: "spring"
					
#Defaulting on Accounts
clickCompany.panel.opacity = 1	

