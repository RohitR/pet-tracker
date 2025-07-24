# Pet Tracker API

This project is a Ruby on Rails API-only application running on:

- **Ruby version:** 3.1.5  
- **Rails version:** 7.2

---

## Getting Started

### Prerequisites

Ensure you have Ruby 3.1.5 and Rails 7.2 installed.

### Setup and Running the App

1. Install dependencies:

bundle install

2. Start the Rails server:

rails server


---

## Running Specs

To execute the test suite, run:

bundle exec rspec spec


---

## API Endpoints

Once the server is running, the application provides the following API endpoints related to pet management:

### 1. Add a New Pet

Adds a pet record to the system by hitting the `create` action in the `PetsController`.

**Request:**

curl -X POST http://localhost:3000/api/v1/pets
-H "Content-Type: application/json"
-d '{
"type": "cat",
"tracker_type": "big",
"owner_id": 3,
"in_zone": false,
"lost_tracker": true
}'


**Response:**

{
"id": 1,
"type": "cat",
"tracker_type": "big",
"owner_id": 3,
"in_zone": false,
"errors": [],
"lost_tracker": true
}


---

### 2. Search Pets

Filters pets stored in the system by utilizing the `search` action in the `PetsController`.

**Request:**

curl -X GET http://localhost:3000/api/v1/pets/search
-H "Content-Type: application/json"
-d '{
"type": "dog"
}'


**Response:**

[
{
"id": 1,
"type": "dog",
"tracker_type": "big",
"owner_id": 3,
"in_zone": true,
"errors": []
},
{
"id": 2,
"type": "dog",
"tracker_type": "big",
"owner_id": 3,
"in_zone": false,
"errors": []
}
]


---

### 3. Pets Count Outside Power Saving Zone

Provides grouped counts of pets currently outside the power-saving zone, grouped by pet type and tracker type.

**Request:**


curl -X GET http://localhost:3000/api/v1/pets/pets_count


**Response:**

{
"["dog", "big"]": 1,
"["cat", "big"]": 3
}


---

## Notes

- The data is stored **in-memory**, so the information will reset when the server restarts.
- The API expects JSON payloads; ensure the `Content-Type` header is set to `application/json`.

---
