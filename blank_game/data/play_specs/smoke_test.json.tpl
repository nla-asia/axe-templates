{
  "name": "__GAME_DISPLAY_NAME__ smoke test",
  "description": "Load the starter blank scene, validate it, and capture a screenshot.",
  "scene": "data/scenes/level_01.json",
  "steps": [
    {
      "type": "validate_scene"
    },
    {
      "type": "delay_seconds",
      "seconds": 0.5
    },
    {
      "type": "screenshot",
      "name": "blank_scene"
    }
  ]
}
