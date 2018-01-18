
# pre settings
storyItemNumber = 8
subItemNumber = 5
layerGap = 10
medium = 0
sub = 0
subContainer = []
subLayers = [sub1, sub2, sub3, sub4, sub5, sub6, sub7, sub8, sub9, sub10, sub11, sub12, sub13]
originalLayers =[enter, enter2, enter3, enter4, enter5]
comments = ["北航故事", "北京小风子", "潘玮柏", "周冬雨","来去之间","用户昵称"]


# device logic
TopNaviForX.opacity = 0
BottomNaviForX.opacity = 0
SpaceForiPhoneX = 0
if Screen.height == 812
	TopNaviForX.opacity = 1
	BottomNaviForX.opacity = 1
	SpaceForiPhoneX = 15
stories.y += SpaceForiPhoneX
	



# UperImage.height = 57
for layer in originalLayers
	ratio = Screen.width/375
	layer.width = Screen.width
	layer.height = ratio * 449
	
	
Framer.Defaults.Animation =
	time: .3
	curve: Bezier.easeInOut
# 	curve: "spring(300,28,1)"
# Framer.Loop.delta = 1/240
subNavi.clip = true

flow = new FlowComponent
flow.showNext($1)

scroll = new ScrollComponent
	scrollHorizontal: false
	width: Screen.width
	height: Screen.height
	backgroundColor: null
	parent: $1
	contentInset: 
		bottom: 100
		
scroll.sendToBack()
		
scroll.mouseWheelEnabled = true


scroll.onScrollStart ->
	subScroll.speedX = 0
scroll.onScrollEnd ->
	subScroll.speedX = 1

destroyhomePage = ->
	for layer in homePageItem
		layer.destroy()


homePageItem = []
homePageContent = ->
	number = 3
	homeItemNumber = Math.ceil(number)
	for i in [0...homeItemNumber]
		medium = i			
		layer = Utils.randomChoice(originalLayers).copy()
		layer.x = Align.center
		layer.parent = scroll.content
		if i < 1
			layer.y = 166
		else
			layer.y = homePageItem[medium - 1].y + homePageItem[medium - 1].height + layerGap
# 		layer.onClick ->
# 			flow.showNext($2)
		homePageItem.push(layer)
# 	homePageItem[homeItemNumber-1].opacity = 0
# 	homePageItem[homeItemNumber-2].opacity = 0
homePageContent()

storiesState = 1
refresh = ->
	destroyhomePage()
	homePageContent()
	scroll.animate
		scrollY: 103
		y: 42
		options: 
			time: 0.01
	stories.opacity = 0
	storiesState = 0

Original = ->
	homePageContent()
	scroll.animate
		scrollY: 0
		y: 0
	stories.opacity = 1
	storiesState = 1
	subNavi.animate
		y: 21

storyContainer = []
stories.parent = scroll.content
storyScroll = new ScrollComponent
	scrollVertical: false
	width: Screen.width
	height: 100
	backgroundColor: null
	parent: stories
storyScroll.mouseWheelEnabled = true
storyScroll.draggable.enabled = false
storyScroll.draggable.propagateEvents = false

for i in [0...storyItemNumber]
	layer = story.copy()
	layer.parent = storyScroll.content
	layer.x = (55 + 11) * i + layerGap
	layer.y = 16
	avatarBG.borderWidth = 2
	avatarBG.borderColor = "#FF8200"
	Text_1.text = Utils.randomChoice(comments)
	avatar.image = Utils.randomImage()
	storyContainer.push(layer)
story.parent = storyScroll.content
Text_1.text = '我的故事'
avatarBG.borderWidth = 0
storyContainer[0].opacity = 0

subScroll = new ScrollComponent
	scrollVertical: false
	width: Screen.width
	backgroundColor: null
	parent: subNavi
	contentInset: 
		right: 50
subScroll.mouseWheelEnabled = true
subScroll.draggable.enabled = false
subScroll.draggable.propagateEvents = false
subScroll.sendToBack()
subContent = ->
	for i in [0..12]
		sub = i
		layer = subLayers[i]
		layer.parent = subScroll.content
		layer.y = 12
		if i < 1
			layer.x = 14
		else
			layer.x = subContainer[sub - 1].x + subContainer[sub - 1].width + 23
# 		layer.onClick ->
# 			flow.showNext($2)
		subContainer.push(layer)

subContent()
subContainer[0].color = "#FF8200"

indexNumber = 0
for layer,i in subContainer
	layer.onClick ->
		for layer,i in subContainer
			layer.color = '#333333'
			this.color = '#FF8200'
		indexNumber = this.index - 16
# 			print this.x
		if indexNumber >= 0 and indexNumber <= 3
			subScroll.animate
				scrollX: 0
		if indexNumber > 3 and indexNumber < 10
			subScroll.animate
				scrollX: subContainer[indexNumber].x - 200 - subContainer[indexNumber].width
		if indexNumber < 13 and indexNumber >= 10
			subScroll.animate
				scrollX: subContainer[12].x
		for layer in TextLayerContainer
			layer.color = '#333333'
			TextLayerContainer[indexNumber-1].color = '#FF8200'
		refresh()
		overdrag()
		if indexNumber == 1
			Original()

# 		subScroll.speedX = 0

subMore.draggable.propagateEvents = false
subMore.onClick ->
	flow.showOverlayTop($2)
Back.onClick ->
	flow.showPrevious()

$2.onClick ->
	flow.showPrevious()

$2.propagateEvents = true
# subScroll.onMove (event,layer) ->
# 	print subScroll.scrollX
TextLayerContainer = []
subPopupActionContainer = []
# subPopupAction = ->
for i in [0...12]
	layer = subPopup.copy()
	layer.width = subPopup.width * ratio
	Layer.height = subPopup.height * ratio
	layer.parent = $2
	subPopupActionContainer.push(layer)
	if i >= 0 && i < 4
		layer.x = 88 * i * ratio + 15
		layer.y = 83
	if i >= 4 && i < 8
		layer.x = 88 * i * ratio + 15 - 88 * 4 * ratio
		layer.y = 128
	if i >=8 && i < 12
		layer.x = 88 * i * ratio + 15 - 88 * 8 * ratio
		layer.y = 173
	TextLayer = subLayers[i].copy()
	TextLayer.fontSize = 14
	TextLayerContainer.push(TextLayer)
	TextLayer.parent = layer
	TextLayer.x = Align.center
	TextLayer.y = Align.center
# subPopupAction()

subIndexNumber = 0
for layer,i in TextLayerContainer
	layer.onClick ->
		for layer,i in TextLayerContainer
			layer.color = '#333333'
			this.color = '#FF8200'
		subIndexNumber = Math.floor((this.index - 49)/3 - 7)
# 		print subIndexNumber
		for layer,i in subContainer
			layer.color = '#333333'
			subContainer[subIndexNumber-1].color = '#FF8200'
		Utils.delay 0.1, ->
			flow.showPrevious($1)
		Utils.delay 0.1, ->
			if subIndexNumber >= 0 and subIndexNumber <= 3
				subScroll.animate
					scrollX: 0
			if subIndexNumber > 3 and subIndexNumber < 10
				subScroll.animate
					scrollX: subContainer[subIndexNumber].x - 200 - subContainer[subIndexNumber].width
			if subIndexNumber < 13 and subIndexNumber >= 10
				subScroll.animate
					scrollX: subContainer[12].x
			if subIndexNumber == 1
				Utils.delay 0.1, ->
					refresh()
					Original()
			else
				Utils.delay 0.3, ->
					refresh()
					overdrag()
# subNavi.opacity = 0
# scroll.onMove (event,layer) ->
# 	subNavi.opacity = Utils.modulate(event.y, [-103,-104], [0,1], true)
# 	subNavi.y = Utils.modulate(event.y, [-103,-113], [21,62], true)
	
LastPosition = 0
yDelta = 0

scroll.on Events.ScrollStart, (event) ->
	LastPosition = scroll.scrollY
subState = 0
scroll.on Events.Scroll, (event) ->
# scroll.onMove (event,layer) ->
	yDelta = LastPosition - scroll.scrollY
	LastPosition = scroll.scrollY
# 	print yDelta
# 	print event.y
# 	print LastPosition
	if scroll.scrollY > 120
		if storiesState == 1
			if yDelta > 3
				subState = true
				subNavi.animate
					y: 21
				Uper.animate
					shadowColor: "#dadada"

			if yDelta < -3
				subState = false
				subNavi.animate
					y: 64
				Uper.animate
					shadowColor: "#e6e6e6"

		else
			if scroll.scrollY > 180
				if yDelta > 3
					subState = true
					subNavi.animate
						y: 21
# 					Uper.animate
# 						shadowColor: "#dadada"
				if yDelta < -3
					subState = false
					subNavi.animate
						y: 64
# 					Uper.animate
# 						shadowColor: "#e6e6e6"
	if scroll.scrollY <= 120
		if storiesState == 1
			subNavi.y = Utils.modulate(-scroll.scrollY, [-12,-53], [21,64], true)
			subNavi.opacity = Utils.modulate(-scroll.scrollY, [-12,-20], [0,1], true)
		else
			subNavi.animate
				y: 64
			subNavi.opacity = 1
	
# scroll.onMove (event,layer) ->
# 	print event.y
# 	print scroll.scrollY
overdragDistance = 0
overdrag = ->
	scroll.onMove (event,layer) ->
		overdragDistance = event.y
# 		print event.y
		if overdragDistance > -103
			scroll.speedY = Utils.modulate(event.y, [-104,103], [1,0], true)
			scroll.onScrollEnd ->
				if overdragDistance > -103
					scroll.animate
						scrollY: 103
# 			subNavi.y = 63
		else
			scroll.speedY = 1#Utils.modulate(event.y, [-104,-103], [1,1], true)


		


	

	

	

	