videoplayer = {}

############################################################
defaultOptions = 
    elements: "video"
    mode: "regular"
    randostart: false
    initialVolume: 0.2

allPlayers = []
nextIndex = 0

############################################################
class Player
    constructor: (options) ->
        @index = nextIndex
        allPlayers[@index] = this
        nextIndex++
        writeOptions(options, this)
        initializeElements(this)
        return

    pauseAll: ->
        el.pause() for el in @elements
        return

    playAll: ->
        el.play() for el in @elements
        return

    destroy: ->
        nextIndex--
        if @index != nextIndex
            movedPlayer = allPlayers[nextIndex]
            allPlayers[@index] = movedPlayer
            movedPlayer.index = @index
            for el in movedPlayer.elements
                el.setAttribute("allPlayers-index", ""+@index)

        allPlayers[nextIndex] = null

        ## Destroy Content
        for el in @elements
            clearElement(el)
            if @mode == "autoplay" then el.removeEventListener("loadedmetadata", setRandomCurrentTime)
            if @mode == "regular" then el.removeEventListener("play", onPlay)
        
        @elements = null
        @mode = null
        @randostart = null
        @initialVolume = null
        return

############################################################
#region internalFunctions
writeOptions = (o, p) ->
    o = {} unless o?
    ## fill missing options with default
    for key,value of defaultOptions when !o[key]?
        o[key] = defaultOptions[key]

    ## fill class properties with the options
    p.elements = o.elements
    p.mode = o.mode.toLowerCase()
    p.randostart = o.randostart
    p.initialVolume = o.initialVolume
    if p.mode == "regular" then p.randostart = false
    return

initializeElements = (p) ->
    ## make sure we have an Array of the DOM Elements
    if typeof p.elements == "string" then p.elements = document.querySelectorAll(p.elements)
    else if (!Array.isArray(p.elements)) then p.elements = [p.elements]
    
    if p.elements.length == 0 then throw new Error("No Elements Found!")
    
    ## assert they are valid Video Element Nodes
    for el in p.elements when el.nodeType != 1 or el.tagName != "VIDEO"
        throw new Error("One element wasn't a valid Video Element Node.")
    
    # now we should have an Array with Dom Element Nodes
    if p.mode == "regular" then initializeRegular(p)
    if p.mode == "autoplay" then initializeAutoplay(p)
    return
    
############################################################
initializeAutoplay = (p) ->
    initializeAutoplayElement(el, p) for el in p.elements
    return

initializeRegular = (p) ->
    initializeRegularElement(el, p) for el in p.elements
    return

############################################################
initializeAutoplayElement = (el, p) ->
    # get Attributes we need
    sourceSrc = el.getAttribute("src")
    sourceType = getVideoType(sourceSrc)
    trackSrc = el.getAttribute("vtt")
    
    clearElement(el)    
    # add desired attributes and childs
    sourceElement = document.createElement("SOURCE")
    sourceElement.setAttribute("src", sourceSrc)
    sourceElement.setAttribute("type", sourceType)
    trackElement = document.createElement("TRACK")
    trackElement.setAttribute("src", trackSrc)
    trackElement.setAttribute("default", true)

    # add new childs
    el.appendChild(sourceElement)
    el.appendChild(trackElement)

    # set Attributes
    el.muted = true
    el.loop = true
    el.autoplay =  true
    # el.setAttribute("controls", false)

    if p.randostart then el.addEventListener("loadedmetadata", setRandomCurrentTime)
    return

initializeRegularElement = (el, p) ->
    # get Attributes we need
    sourceSrc = el.getAttribute("src")
    sourceType = getVideoType(sourceSrc)
    trackSrc = el.getAttribute("vtt")
    
    clearElement(el)
    # add desired attributes and childs
    sourceElement = document.createElement("SOURCE")
    sourceElement.setAttribute("src", sourceSrc)
    sourceElement.setAttribute("type", sourceType)
    trackElement = document.createElement("TRACK")
    trackElement.setAttribute("src", trackSrc)
    trackElement.setAttribute("default", true)

    # add new childs
    el.appendChild(sourceElement)
    el.appendChild(trackElement)

    # add Event Listeners
    el.addEventListener("play", onPlay)
    # el.addEventListener("pause", onPause)

    # set Attributes
    el.setAttribute("controls", true)
    el.setAttribute("controlsList", "nodownload")
    el.setAttribute("allPlayers-index", ""+p.index)
    # el.setAttribute("preload", "none")
    el.volume = p.initialVolume
    return

############################################################
clearElement = (el) ->
    # remove all attributes and childs
    attributes = [...el.attributes]
    for attr in attributes when attr.name != "id" and attr.name != "class"
        el.removeAttribute(attr.name)

    el.innerHTML = ""
    return

############################################################
getVideoType = (source) ->
    last4 = source.slice(-4).toLowerCase()
    last5 = source.slice(-5).toLowerCase()

    if last4 == ".mp4" then return "video/mp4"
    if last4 == ".ogg" then return "video/ogg"
    if last5 == ".webm" then return "video/webm"
    
    throw new Error("Unknown sourcs type ("+last5+")")
    return "dafuck"

############################################################
onPlay = (evt) ->
    thisElement = evt.target
    index = parseInt(thisElement.getAttribute("allPlayers-index"))
    player = allPlayers[index]
    el.pause() for el in player.elements when el != thisElement
    return

setRandomCurrentTime = (evt) ->
    el = evt.target
    el.currentTime = Math.random() * el.duration
    return

#endregion

############################################################
#region exposedStuff
videoplayer.create = (options) -> new Player(options)

#endregion

module.exports = videoplayer
