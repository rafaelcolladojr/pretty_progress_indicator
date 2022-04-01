<div align="center">

# Pretty Progress Indicator

This progress indicator is intended as a stylized alternative to the other progress indicators floating around the web. Feel free to fork or PR!
    
<img height="500" src="https://user-images.githubusercontent.com/7101404/160982328-8a587ffa-beb3-4ee7-8981-f4ed538ac014.gif" />

</div>

## Features

Choose from a radial progress indicator or its more traditional linear counterpart.

<!-- Include gifs -->

## Getting started

Too use this package in your projects, simply clone this repository and copy the `pretty_progress_indicator.dart` file to your project.

<!-- Add this package to your Flutter project by including the following line under the `dependencies` section of its `pubspec.yaml`:
```yaml
pretty_progress_indicator: ^0.0.1
```

or run the following command from the project's root folder:
```bash
flutter pub add pretty_progress_indicator
``` -->

## Usage

Add a Pretty Progress Indicator to your application with one of the provided widgets:

```dart
@override
void build(BuildContext context) {
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(24.0),
            child:  PrettyProgressIndicator(
                indicatorType: IndicatorType.radial,
                progress: 0.63,
                barWidth: 20.0,
                textColor: Colors.red.shade200,
                barColors: [
                    Colors.red.shade200,
                    Colors.pink.shade800,
                ],
            ),
        ),
    );
}
```
