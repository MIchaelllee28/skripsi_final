# Lucky Wheel Implementation Guide

## What Was Added

### 1. Lucky Wheel Feature Structure
```
lib/modules/features/lucky_wheel/
├── bindings/
│   └── lucky_wheel_binding.dart
├── controllers/
│   └── lucky_wheel_controller.dart
├── models/
│   └── wheel_prize_model.dart
└── view/
    └── ui/
        └── lucky_wheel_view.dart
```

### 2. Key Features

**Daily Spin Limit**
- Users can spin once per day
- Last spin date is saved in Hive storage
- Button shows "Come Back Tomorrow" when already spun

**Weighted Prizes**
- 50 Coins: 30% chance
- 100 Coins: 25% chance
- 200 Coins: 20% chance
- 500 Coins: 15% chance
- 1000 Coins: 5% chance
- Better Luck: 5% chance (no reward)

**Smooth Animation**
- 4-second spin animation
- 5-7 full rotations before stopping
- Easing curve for realistic deceleration

**Auto Coin Award**
- Automatically adds coins to user's balance via IotController
- Shows result after spin completes

### 3. How to Access

**From IoT Screen:**
- Tap the coin counter in the app bar (top left)
- This opens the Lucky Wheel screen

### 4. Customization Options

**Change Prizes:**
Edit `lucky_wheel_controller.dart`:
```dart
final List<WheelPrize> prizes = [
  WheelPrize(id: '1', name: '50 Coins', value: 50, type: 'coin'),
  // Add more prizes here
];
```

**Change Probabilities:**
Edit the weights array in `_getWeightedRandomPrize()`:
```dart
final weights = [30, 25, 20, 15, 5, 5]; // Must match prize count
```

**Change Colors:**
Edit the colors array in `WheelPainter`:
```dart
final colors = [
  Colors.red.shade400,
  Colors.blue.shade400,
  // Add more colors
];
```

**Change Spin Duration:**
Edit in `lucky_wheel_view.dart`:
```dart
duration: const Duration(seconds: 4), // Change this
```

### 5. Future Enhancements

You can easily add:
- **Item prizes**: Give shop items instead of coins
- **Multipliers**: 2x coins for next water action
- **Streak bonuses**: Better odds after X-day streaks
- **Sound effects**: Add spin and win sounds
- **Particle effects**: Confetti on big wins
- **Ad-based extra spins**: Watch ad for bonus spin
- **Premium wheel**: Unlock better prizes with coins

### 6. Testing

1. Run the app
2. Navigate to IoT screen
3. Tap the coin counter
4. Spin the wheel
5. Check that coins are added
6. Try spinning again (should be blocked until tomorrow)

### 7. Storage

The wheel uses Hive to store:
- `lucky_wheel.last_spin`: ISO8601 date string of last spin

This is separate from other game data for easy management.
