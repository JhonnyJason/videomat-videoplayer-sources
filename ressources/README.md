# Videomat - Videoplayer 

# Why?
[Videomat](https://videomat.org/) - a professional video producer agency from Graz - required some custom adjustments on how their videplayer on their websites work.

# What?
A package adding some features on the html5 video element via Javascript.

- Convenient minimal definition of a src and vtt attribute in the video element.
- Mode: "Autoplay" - Muted Autoplay in Loop
    - Optional randomized start
    - For multiple videos at once
- Mode: "Regular" - reduced initial volume
    - For multiple Videos at once, where the other videos of the same player are paused when playing another one.
- Work nicely on most all devices

# How?

Installation
------------
```shell
$ npm install videomat-videoplayer
```

Usage
-----
```coffeescript
playerFactory = require("videomat-videoplayer")
options = {elements: "#my-video"}

player = playerFactory.create(options)

```

Current Functionality
---------------------

## Options

```coffeescript
defaultOptions =
    elements: "video"
    mode: "regular"
    randostart: false
    initialVolume: 0.2
```

### options.elements
- may be a query-selector string as in `document.querySelectorAll(query-selector)`
- may be a single DOM Element
- may be an array of DOM Elements
- must resolve regular type 1 nodes having the `"VIDEO"` tag
### options.mode
- may be `"regular"` - case insensitive
- may be `"autoplay"` - case insensitive
### options.randostart
- may be `true`
- may be `false`
- will be overwritten to `false` in case of `mode` being `"regular"`
### options.initialVolume
- may be any float between `0.0` and `1.0`
- however it is not checked for that


## Play/Pause
To play or pause all videos in the player you may simply call
```coffeescript
player.pauseAll()
player.playAll()
```

## Destroy
You may destroy the player at anytime. This will totally clear the corresponding video elements and remove all the EventListeners.

```coffeescript
player.destroy()
```


---

# Further steps

This player will furtherly be extended to mainly meet the specific needs of [Videomat](https://videomat.org/).
However we are happy if it is useful to you too so feel free to throw in some ideas and point out some bugs.

All sorts of inputs are welcome, thanks!

---

# License

## The Unlicense JhonnyJason style

- Information has no ownership.
- Information only has memory to reside in and relations to be meaningful.
- Information cannot be stolen. Only shared or destroyed.

And you wish it has been shared before it is destroyed.

The one claiming copyright or intellectual property either is really evil or probably has some insecurity issues which makes him blind to the fact that he also just connected information which was freely available to him.

The value is not in him who "created" the information the value is what is being done with the information.
So the restriction and friction of the informations' usage is exclusively reducing value overall.

The only preceived "value" gained due to restriction is actually very similar to the concept of blackmail (power gradient, control and dependency).

The real problems to solve are all in the "reward/credit" system and not the information distribution. Too much value is wasted because of not solving the right problem.

I can only contribute in that way - none of the information is "mine" everything I "learned" I actually also copied.
I only connect things to have something I feel is missing and share what I consider useful. So please use it without any second thought and please also share whatever could be useful for others. 

I also could give credits to all my sources - instead I use the freedom and moment of creativity which lives therein to declare my opinion on the situation. 

*Unity through Intelligence.*

We cannot subordinate us to the suboptimal dynamic we are spawned in, just because power is actually driving all things around us.
In the end a distributed network of intelligence where all information is transparently shared in the way that everyone has direct access to what he needs right now is more powerful than any brute power lever.

The same for our programs as for us.

It also is peaceful, helpful, friendly - decent. How it should be, because it's the most optimal solution for us human beings to learn, to connect to develop and evolve - not being excluded, let hanging and destroy oneself or others.

If we really manage to build an real AI which is far superior to us it will unify with this network of intelligence.
We never have to fear superior intelligence, because it's just the better engine connecting information to be most understandable/usable for the other part of the intelligence network.

The only thing to fear is a disconnected unit without a sufficient network of intelligence on its own, filled with fear, hate or hunger while being very powerful. That unit needs to learn and connect to develop and evolve then.

We can always just give information and hints :-) The unit needs to learn by and connect itself.

Have a nice day! :D