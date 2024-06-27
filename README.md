# marvel_comics_app

A Flutter application that interacts with Marvel's REST API to fetch and display comic book data.


## Project Overview

This project serves as a starting point for building a Flutter application focused on Marvel comics. It leverages modern app development practices and architectural patterns to ensure maintainability and scalability.

### Features Implemented

### Splash Screen

- **Description**: Splash screen of the application displayed on startup before loading the main user interface.
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/splash_screen.png" width="50%" />


### Fetching Data and Search Results

- **Description**: Users can fetch results from Marvel’s REST API and see them displayed on a list. They can also search for comic book titles and see the results on a list.
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/home_screen.png" width="50%" />
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/home_screen_scrolling.png" width="50%" />
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/search_screen_results.png" width="50%" />

### No Query / No Results Found

- **Description**: Users are informed if query is not provided or there are no results for their search query.
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/no_results.png" width="50%" />
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/search_screen_empty.png" width="50%" />

### Pagination

- **Description**: Users can see more results when they scroll to the bottom of the result list (pagination).
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/pagination.png" width="50%" />

### Details Screen

- **Description**: Detailed screen where users can view comprehensive information about selected comics.
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/details_screen.png" width="50%" />
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/details_screen_2.png" width="50%" />

### Redirect to External Website

- **Description**: Allows users to click on the "Find out more" button on the details screen and be redirected to a website with additional information about the selected comic book.
- <img src="https://github.com/jtrznadel/marvel-comics-app/blob/main/screenshots/details_web_page.png" width="50%" />


### Technology Stack

- **Flutter**: A framework for building cross-platform mobile applications.
- **Flutter Bloc**: A predictable state management library for Flutter applications.

## Getting Started

To run this project locally:

1. Clone the repository: `git clone https://github.com/jtrznadel/marvel-comics-app.git`
2. Navigate into the project directory: `cd marvel-comics-app`
3. Add .env file with your own keys e.g.:
  `MARVEL_PUBLIC_KEY={your_public_key}`
  `MARVEL_PRIVATE_KEY={your_private_key}`
5. Install dependencies: `flutter pub get`
6. Run the application: `flutter run`

For more detailed instructions on Flutter development, refer to the [Flutter documentation](https://flutter.dev/docs).

