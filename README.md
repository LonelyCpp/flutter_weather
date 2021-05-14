# Flutter Weather

A Flutter application to view current weather status.

![preview](./screenshots/preview.png?raw=true "preview")

## Features

- :white_check_mark: Beautiful minimal UI
- :white_check_mark: Dark and Light themes
- :white_check_mark: Current temperature, max and min temperature, sunset, sunrise
- :white_check_mark: Custom icons for each weather condition
- :white_check_mark: 5 day forecast
- :white_check_mark: Beautifully animated transitions
- :white_check_mark: BLoC pattern for API calls
- :white_check_mark: Line graph to show temperature variance

## Getting Started

### Prerequisites

**Flutter**

- [Flutter documentation](https://flutter.dev/docs)
- [Lab: Write your first Flutter app](https://flutter.dev/docs/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://flutter.dev/docs/cookbook)

### Installing

**API Key**

Create a file called `api_keys.dart` in `lib/src/api/`

Make a class called `ApiKey` with your openweathermaps API key in it. Get it [here](https://openweathermap.org/api)

eg:

```
class ApiKey {
  static const OPEN_WEATHER_MAP = 'your_key';
}
```

## todo

- i18n support for multiple languages

## Acknowledgments

- [Weather Icon Pack](https://erikflowers.github.io/weather-icons/)
- [App Mockup](https://app-mockup.com), [photopea](http://photopea.com) (for screenshots)
