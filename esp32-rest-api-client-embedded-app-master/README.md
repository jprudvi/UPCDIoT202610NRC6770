# ESP32 REST API Client Embedded App

## Overview
This project is a sample embedded application for the ESP32 microcontroller, showcasing WiFi connectivity and REST API client interactions. It demonstrates JSON serialization/deserialization, HTTP POST and GET requests, and basic IoT functionality using the Arduino framework. The project is designed to run on the ESP32 DevKit-C V4 board and is simulated on the Wokwi platform.

### Features
- Connects to a WiFi network using predefined credentials.
- Sends a POST request with a JSON payload to a REST API endpoint.
- Retrieves data via a GET request and processes the JSON response.
- Displays connection details and API responses via the serial monitor.
- Simulated on Wokwi for easy testing and development.

## Prerequisites
To run this project, you need:
- An ESP32 DevKit-C V4 board (for hardware deployment) or access to [Wokwi](https://wokwi.com) for simulation.
- [Arduino IDE](https://www.arduino.cc/en/software) or a compatible development environment.
- The following Arduino libraries:
  - `ArduinoJson`
  - `WiFi`
  - `HTTPClient`
- A stable internet connection for WiFi and API communication.