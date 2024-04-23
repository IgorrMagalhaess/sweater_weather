# README

# Whether, Sweater? Project

Whether, Sweater? Project is a Rails API application designed to provide back-end functionality for a road trip planning application. The application facilitates users in planning road trips by providing accurate weather information at their destination. It follows a service-oriented architecture, allowing the front-end team to interact with various endpoints through HTTP requests.

## Setup

### Prerequisites
- Ruby (version >= 3.0.0)
- Rails (version >= 7.0.0)
- PostgreSQL
- Bundler

### Installation
1. Clone the repository:

    ```bash
    git clone <repository_url>
    ```

2. Install dependencies:

    ```bash
    bundle install
    ```

3. Set up the database:

    ```bash
    rails db:{drop,create,migrate}
    ```

## Usage
- Start the server:

    ```bash
    rails server
    ```

- Access the API endpoints via `http://localhost:3000`.

## Endpoints

### 1. Retrieve Weather for a City

**Endpoint:**
```
GET /api/v0/forecast?location=<location>
```
- If location is a country, forecast will be returned for the capital of the country.

**Request:**
```
GET /api/v0/forecast?location=atlanta,ga
Content-Type: application/json
Accept: application/json
```
- Requirements: Valid Location.
**Response:**
```json
{
  "data": {
    "id": null,
    "type": "forecast",
    "attributes": {
      "current_weather": {
        "last_updated": "2024-04-23 13:30",
        "temperature": 66.9,
        "feels_like": 66.9,
        "humidity": 45,
        "uvi": 6.0,
        "visibility": 9.0,
        "condition": "Partly cloudy",
        "icon": "//cdn.weatherapi.com/weather/64x64/day/116.png"},
      "daily_weather": [
        {
          "date": "2024-04-23",
          "sunrise": "06:57 AM",
          "sunset": "08:15 PM",
          "max_temp": 73.2,
          "min_temp": 49.4,
          "condition": "Sunny",
          "icon": "//cdn.weatherapi.com/weather/64x64/day/113.png"
        },
        { "daily weather for the next 5 days" },
        {...},
        {...}],
      "hourly_weather": [
        {
          "time": "00:00",
          "temperature": 55.5,
          "condition": "Clear",
          "icon": "//cdn.weatherapi.com/weather/64x64/night/113.png"
        },
        { "hourly weather for the entire day" },
        {...},
        {...}
      ]
    }
  }
}
```

### 2. User Registration

**Endpoint:**
```
POST /api/v0/users
```

**Request:**
```json
{
  "email": "example@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```
- Requirements: email, password, and password_confirmation.

**Response:**
```json
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "example@example.com",
      "api_key": "generated_api_key"
    }
  }
}
```

### 3. Login

**Endpoint:**
```
POST /api/v0/sessions
```

**Request:**
```json
{
  "email": "example@example.com",
  "password": "password"
}
```
- Requirements: valid email and password.

**Response:**
```json
{
  "data": {
    "type": "users",
    "id": "1",
    "attributes": {
      "email": "example@example.com",
      "api_key": "generated_api_key"
    }
  }
}
```

### 4. Road Trip Planning

**Endpoint:**
```
POST /api/v0/road_trip
```

**Request:**
```json
{
  "origin": "Cincinnati, OH",
  "destination": "Chicago, IL",
  "api_key": "user_api_key"
}
```
- Requirements: valid origin location, valid destination location, and valid api key.

**Response:**
```json
{
  "data": {
    "id": null,
    "type": "roadtrip",
    "attributes": {
      "start_city": "Cincinnati, OH",
      "end_city": "Chicago, IL",
      "travel_time": "04:40:45",
      "weather_at_eta": {
        "datetime": "2023-04-07 23:00",
        "temperature": 44.2,
        "condition": "Cloudy with a chance of rain"
      }
    }
  }
}
```

## Testing
This project includes automated tests to ensure functionality and reliability of the API. To run the tests, execute the following command:

```bash
bundle exec rspec
```

## Contributing
Contributions are welcome! Feel free to open issues or pull requests.

## License
This project is licensed under the [MIT License](LICENSE).

