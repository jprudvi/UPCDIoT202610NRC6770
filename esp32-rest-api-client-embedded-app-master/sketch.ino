#include <Arduino.h>
#include <ArduinoJson.h>
#include <HTTPClient.h>
#include <WiFi.h>

// WiFi Credentials
#define WIFI_SSID "Wokwi-GUEST"
#define WIFI_PASSWORD ""

// Endpoint URL
#define ENDPOINT_URL "https://iot-edge-202610-1asi0572-sandbox.free.beeceptor.com/api/v1/data-records"

// HTTP Client
HTTPClient httpClient;

// HTTP Header Parameter and Value
#define CONTENT_TYPE_HEADER "Content-Type"
#define APPLICATION_JSON "application/json"

// Device Identification
#define DEVICE_ID "HC2974"

void setup() {
  // Serial Setup
  Serial.begin(115200);
  Serial.println("IoT Connectivity Sample");

  // WiFi Setup
  WiFi.mode(WIFI_STA);
  Serial.println(WiFi.scanNetworks());
  WiFi.begin(WIFI_SSID, WIFI_PASSWORD);
  Serial.println("Connecting");
  while(WiFi.status() != WL_CONNECTED) {
    Serial.print(".");
    delay(500);
  }
  Serial.println();
  Serial.println("Connected: ");
  Serial.println(WiFi.localIP());
  // Show MAC Address
  Serial.print("MAC Address is ");
  Serial.println(WiFi.macAddress());
  

  // POST Request
  // Start HTTP Request
  httpClient.begin(ENDPOINT_URL);

  // Build a Data Record
  JsonDocument dataRecord;
  dataRecord["deviceId"] = DEVICE_ID;
  dataRecord["distance"] = 250;

  // Serialize Data Record
  String dataRecordResource;
  serializeJson(dataRecord, dataRecordResource);

  // Perform POST with Data Record
  httpClient.addHeader(CONTENT_TYPE_HEADER, APPLICATION_JSON);
  httpClient.POST(dataRecordResource);

  // Check Response
  JsonDocument response;
  String responseResource;
  responseResource = httpClient.getString();
  deserializeJson(response, responseResource);
  serializeJsonPretty(response, Serial);

  // Manipulate Response Data
  Serial.println();
  Serial.print("Distance: ");
  Serial.println(response["distance"].as<long>());

  // End Request
  httpClient.end();

  // GET All Request

  // Start HTTP Request
  httpClient.begin(ENDPOINT_URL);

  // Get Data Records
  int httpResponseCode = httpClient.GET();
  Serial.print("Response Status Code: ");
  Serial.println(httpResponseCode);

  // Fetch Data
  responseResource = httpClient.getString();
  deserializeJson(response, responseResource);
  serializeJsonPretty(response, Serial);
  Serial.println();
  
  // Manipulate Data Records
  Serial.println("About to show IDs");
  JsonArray dataRecords = response.as<JsonArray>();
  if(dataRecords != NULL) {
    for(JsonVariant dataRecord : dataRecords) {
      Serial.print("ID: ");
      Serial.println(dataRecord["id"].as<String>());
    }
  }

  // End this Request
  httpClient.end();

  
  


}

void loop() {
  // put your main code here, to run repeatedly:
  delay(10); // this speeds up the simulation
}
