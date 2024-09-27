Flutter News App
A Flutter application that fetches news articles using the News API and stores data locally using SQLite (sqflite).

Setup Instructions
To run this app locally, follow these steps:

Clone the Repository

git clone <repository-url>
cd flutter_news_app

Install Dependencies Ensure you have Flutter installed on your machine. Run the following command to get all the dependencies:
flutter pub get

Run the App You can start the app by running:
flutter run


Dependencies
The following dependencies are required for this app:
cupertino_icons: ^1.0.6
get: ^4.6.6
sqflite: ^2.3.3+1
http: ^1.2.2
intl: ^0.19.0
path_provider: ^2.0.12
connectivity_plus: ^6.0.5

You can find these dependencies in the pubspec.yaml file.
API Usage
This app utilizes the News API to fetch news articles. Ensure you have your API key and configure it within the application where API calls are made.

Approach to the Task
In developing this Flutter news app, I aimed to create a seamless user experience for fetching and displaying news articles. I used the http package to handle API requests to newsapi.org, retrieving data and parsing it for display.

For local storage, I implemented SQLite using the sqflite package, which allows the app to cache news articles, improving performance and providing offline access. The get package was utilized for state management, ensuring a reactive UI that updates as data is fetched or stored.
