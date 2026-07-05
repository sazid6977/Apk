extends Control

const GAME_ID = "6131015"
const TEST_MODE = true

var plugin = null

func _ready():
	if OS.get_name() == "Android":
		if Engine.has_singleton("UnityAdsPlugin"):
			plugin = Engine.get_singleton("UnityAdsPlugin")
			plugin.on_initialization_complete.connect(_on_init_complete)
			plugin.on_initialization_failed.connect(_on_init_failed)
			plugin.on_rewarded_loaded.connect(_on_rewarded_loaded)
			plugin.on_rewarded_show_complete.connect(_on_rewarded_complete)
			plugin.on_interstitial_loaded.connect(_on_interstitial_loaded)
			plugin.on_interstitial_show_complete.connect(_on_interstitial_complete)
			plugin.initialize(GAME_ID, TEST_MODE)
			$VBoxContainer/Status.text = "Initializing..."
		else:
			$VBoxContainer/Status.text = "Plugin not found!"
	else:
		$VBoxContainer/Status.text = "Android only!"

	$VBoxContainer/RewardedButton.pressed.connect(_on_rewarded_pressed)
	$VBoxContainer/InterstitialButton.pressed.connect(_on_interstitial_pressed)
	$VBoxContainer/RewardedButton.disabled = true
	$VBoxContainer/InterstitialButton.disabled = true

func _on_init_complete():
	$VBoxContainer/Status.text = "Ads Ready!"
	plugin.loadRewarded("rewardedVideo")
	plugin.loadInterstitial("video")

func _on_init_failed(_message):
	$VBoxContainer/Status.text = "Init Failed!"

func _on_rewarded_loaded(_id):
	$VBoxContainer/RewardedButton.disabled = false

func _on_rewarded_pressed():
	if plugin:
		plugin.showRewarded("rewardedVideo")
		$VBoxContainer/RewardedButton.disabled = true

func _on_rewarded_complete(_id, rewarded):
	if rewarded:
		$VBoxContainer/Status.text = "Reward Earned!"
	plugin.loadRewarded("rewardedVideo")

func _on_interstitial_loaded(_id):
	$VBoxContainer/InterstitialButton.disabled = false

func _on_interstitial_pressed():
	if plugin:
		plugin.showInterstitial("video")
		$VBoxContainer/InterstitialButton.disabled = true

func _on_interstitial_complete(_id):
	$VBoxContainer/Status.text = "Interstitial Done!"
	plugin.loadInterstitial("video")
