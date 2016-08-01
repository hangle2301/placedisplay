# Import file "Chart7"
sketch = Framer.Importer.load("imported/Chart7@1x")
# Use desktop cursor
document.body.style.cursor = "auto"

leftSelection = [sketch.LeftNewSelection, sketch.LeftOpenSelection, sketch.LeftWonSelection, sketch.LeftLostSelection]
rightSelection = [sketch.RightNewSelection, sketch.RightOpenSelection, sketch.RightWonSelection, sketch.RightLostSelection]

leftShowGroup = [sketch.NewGroup, sketch.OpenGroup, sketch.WonGroup, sketch.LostGroup]
leftHover = sketch.MyBreakdown
rightHover = sketch.PartnerBreakdown

currentShow = leftShowGroup[0].children[0]
#Preparing 
for group in leftShowGroup
	for layer in group.children[0..3]
		layer.opacity = 0
		console.log("Layer " + layer.name)
currentShow.opacity = 1
leftSelected = 0
rightSelected = 0
#Interaction
hover = false
leftHover.opacity = 0
rightHover.opacity = 0

for layer,index in leftSelection
	layer.onClick ->
		leftSelected = leftSelection.indexOf(this)
		doShow()
	layer.onMouseOver ->
		document.body.style.cursor = "pointer"
	layer.onMouseOut ->
		document.body.style.cursor = "auto"
	
for layer,index in rightSelection
	layer.onClick ->
		rightSelected = rightSelection.indexOf(this)
		doShow()
	layer.onMouseOver ->
		document.body.style.cursor = "pointer"
	layer.onMouseOut ->
		document.body.style.cursor = "auto"

#Figuring out which layer to turn on
doShow = () ->
	console.log(leftSelected + " " + rightSelected)
	#Going Out
	currentShow.animate
		properties:
			opacity: 0
		time: 0.5
	#Going In
	currentShow = leftShowGroup[leftSelected].children[rightSelected]
	currentShow.animate
		properties:
			opacity:1
		time: 0.5
		curve: "spring"

# Do the hovering
sketch.MyBreakdownHover.onMouseOver ->
	leftHover.animate
		properties: 
			opacity: 1
		time: 0.5
sketch.MyBreakdownHover.onMouseOut ->
	leftHover.animate
			properties: 
				opacity: 0
			time: 0.5

sketch.PartnerBreakdownHover.onMouseOver ->
	rightHover.animate
		properties: 
			opacity: 1
		time: 0.5
sketch.PartnerBreakdownHover.onMouseOut ->	
	rightHover.animate
		properties: 
			opacity: 0
		time: 0.5
		